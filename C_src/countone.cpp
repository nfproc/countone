// Hardware-oriented implementation of the "count the ones" test
// 2022-04-13 -> 2024-09-09 Naoki F., AIT
// Contributer: Ryusei O. (as a part of his graduation thesis)
// See LICENSE.txt for license information.

#include <stdio.h>
#include <ap_int.h>
#include <ap_fixed.h>
#include <assert.h>
#include "define.hpp"

// translation table from char to letter
#define A 0
#define B 2
#define C 4
#define D 3
#define E 1

#include "prob_table.hpp"

const ap_uint<3> char2letter[256] = {
  A, A, A, A, A, A, A, B, A, A, A, B, A, B, B, C,
  A, A, A, B, A, B, B, C, A, B, B, C, B, C, C, D,
  A, A, A, B, A, B, B, C, A, B, B, C, B, C, C, D,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  A, A, A, B, A, B, B, C, A, B, B, C, B, C, C, D,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  B, C, C, D, C, D, D, E, C, D, D, E, D, E, E, E,
  A, A, A, B, A, B, B, C, A, B, B, C, B, C, C, D,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  B, C, C, D, C, D, D, E, C, D, D, E, D, E, E, E,
  A, B, B, C, B, C, C, D, B, C, C, D, C, D, D, E,
  B, C, C, D, C, D, D, E, C, D, D, E, D, E, E, E,
  B, C, C, D, C, D, D, E, C, D, D, E, D, E, E, E,
  C, D, D, E, D, E, E, E, D, E, E, E, E, E, E, E};

// translation table from char to number of ones
const ap_uint<4> char2ones[256] = {
  0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
  4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8};

// body of the test
//   rand_in must be an array of 256,004 bytes
#if defined(MONOBIT_TEST)
void countone (unsigned char *rand_in, unsigned int *rslt_out, unsigned short *freq_out)
{
#pragma HLS interface axis port=rand_in
#pragma HLS interface axis port=rslt_out
#pragma HLS interface axis port=freq_out
#pragma HLS interface ap_ctrl_none port=return

#elif defined(RESULT_STREAM)
void countone (unsigned char *rand_in, unsigned int *rslt_out)
{
#pragma HLS interface axis port=rand_in
#pragma HLS interface axis port=rslt_out
#pragma HLS interface ap_ctrl_none port=return

#else
unsigned int countone (unsigned char *rand_in)
{
#pragma HLS interface axis port=rand_in
#pragma HLS interface s_axilite port=return bundle=ctrl

#endif

  unsigned char in_char;
  ap_uint<3> in_letter; 
  ap_uint<EV_I+1> freq4[625], freq5[3125];    // occurrence of strings
  ap_uint<12> index_buf[4] = {0};             // for index calculation
  ap_uint<12> index4, index5;                 // index corresponding to string
  ap_ufixed<CHSQ_T,CHSQ_I> chsq;              // for chi^2 calculation
  ap_ufixed<EV_T,EV_I> ov, ev;                // observed value, expected value
  ap_ufixed<CHSQ_F,0> ev_r;                   // recip. of expected value
  ap_ufixed<EV_T*2,EV_I*2> diffsq;            // (ev - ov) ^ 2
  ap_ufixed<(EV_T*2)+CHSQ_F,EV_I*2> chsq_inc; // (ev - ov) ^ 2 / ev
  ap_uint<3> letters[5];                      // index of expected value table
  ap_uint<10> pattern;
#if defined(MONOBIT_TEST)
  unsigned char last_char[4] = {0};
  ap_uint<4> in_ones; 
  ap_uint<14> monobit_one = 0;                // number of ones in 16kb (2kB) block
  ap_uint<12> monobit_cnt = 0;                // number of bytes read in the block
  ap_uint<7> monobit_blk = 0;                 // current 16kb block
#endif
  
  // count the occurrence of strings
  for (ap_uint<12> i = 0; i < 3125; i++) {
    if (i < 625)
      freq4[i] = 0;
    freq5[i] = 0;
  }

  for (ap_uint<18> i = 0; i < NUM_WORDS + 4; i++) {
#pragma HLS pipeline II=3
    in_char      = rand_in[i];
    in_letter    = char2letter[in_char];
    index4       = index_buf[3];
    index5       = index_buf[3] * 5 + in_letter;
    index_buf[3] = index_buf[2] * 5 + in_letter;
    index_buf[2] = index_buf[1] * 5 + in_letter;
    index_buf[1] = index_buf[0] * 5 + in_letter;
    index_buf[0] = in_letter;

#if defined(MONOBIT_TEST)
    in_ones      = char2ones[in_char ^ last_char[3]];
    last_char[3] = last_char[2];
    last_char[2] = last_char[1];
    last_char[1] = last_char[0];
    last_char[0] = in_char;
    if (i >= 4) {
      if (monobit_cnt == 0) {
        monobit_one = in_ones;
        monobit_cnt++;
      } else if (monobit_cnt != 1999) {
        monobit_one += in_ones;
        monobit_cnt++;
      } else {
        monobit_one += in_ones;
        freq_out[monobit_blk] = monobit_one;
        monobit_blk++;
        monobit_cnt = 0;
      }
    }
#endif

    if (i >= 5) { // II of this loop is 3 because of this read-modify-write part
      freq4[index4] = (freq4[index4] >= (1 << EV_I)) ? (ap_uint<EV_I+1>) (1 << EV_I) :
                                                       (ap_uint<EV_I+1>) (freq4[index4] + 1);
      freq5[index5] = (freq5[index5] >= (1 << EV_I)) ? (ap_uint<EV_I+1>) (1 << EV_I) :
                                                       (ap_uint<EV_I+1>) (freq5[index5] + 1);
    }
  }

  // calculate chi^2
  chsq = 0;
  index4 = 0;
  index5 = 0;
  letters[0] = 0;
  letters[1] = 0;
  letters[2] = 0;
  letters[3] = 0;
  letters[4] = 0;
  for (ap_uint<12> i = 0; i < 3750; i++) {
    // get the expected value according to string
    pattern = (letters[0] / 2) * 0x100 +
              (letters[1] / 2) * 0x40 +
              (letters[2] / 2) * 0x10 +
              (letters[3] / 2) * 0x4 +
              (letters[4] / 2);
    ev = evalue[pattern];
    ev_r = evalue_rev[pattern];

    // accumulate to chi^2 value
    if (i < 3125) {
      ov = freq5[index5];
      index5 += 1;
    } else {
      ov = freq4[index4];
      index4 += 1;
    }
    ev = (ev > ov) ? ev - ov : ov - ev;
    diffsq = ev * ev;
    chsq_inc = diffsq * ev_r;
    if (chsq_inc >= OF_THRES)
      chsq_inc = OF_THRES;
    if (chsq < OF_THRES) {
      if (i < 3125)
        chsq += chsq_inc;
      else
        chsq -= chsq_inc;
    } 

    // get the next string
    letters[0] = (letters[1] == 4 && letters[2] == 4 && letters[3] == 4 && letters[4] == 4) ? 
                 ((letters[0] == 4) ? (ap_uint<3>) 6 : (ap_uint<3>)(letters[0] + 1)) : letters[0];
    letters[1] = (letters[2] == 4 && letters[3] == 4 && letters[4] == 4) ?
                 ((letters[1] == 4) ? (ap_uint<3>) 0 : (ap_uint<3>)(letters[1] + 1)) : letters[1];
    letters[2] = (letters[3] == 4 && letters[4] == 4) ?
                 ((letters[2] == 4) ? (ap_uint<3>) 0 : (ap_uint<3>)(letters[2] + 1)) : letters[2];
    letters[3] = (letters[4] == 4) ? ((letters[3] == 4) ? (ap_uint<3>) 0 : (ap_uint<3>) (letters[3] + 1)) : letters[3];
    letters[4] = (letters[4] == 4) ? (ap_uint<3>) 0 : (ap_uint<3>)(letters[4] + 1);
  }

  // return the value (or invalid value if overflow has occurred)
#if defined(RESULT_STREAM) || defined(MONOBIT_TEST)
  *rslt_out = (chsq >= OF_THRES) ? 0xffffffff :
      (unsigned int)((ap_ufixed<CHSQ_T+16,CHSQ_I+16>) chsq << 16);
#else
  return (chsq >= OF_THRES) ? 0xffffffff :
         (unsigned int)((ap_ufixed<CHSQ_T+16,CHSQ_I+16>) chsq << 16);
#endif
}
