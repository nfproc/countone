// Hardware-oriented implementation of the "count the ones" test
// 2022-04-13 Naoki F., AIT
// See LICENSE.txt for license information.

#include <stdio.h>
#include "define.hpp"
#define NUM_DATA 52

unsigned char rand_data[NUM_WORDS + 4];
// please replace this string according to the location of random number data
char files_template[] = "../../../../rand_data/param%d.dat";
int param_no[NUM_DATA] = {1, 16, 17, 20, 65, 80, 84, 85, 148, 149, 196, 212, 213, 256, 257, 260,
                          261, 268, 272, 273, 276, 277, 281, 284, 285, 320, 324, 325, 329, 332,
                          333, 337, 340, 341, 342, 345, 348, 349, 356, 357, 372, 373, 385,
                          400, 401, 404, 405, 452, 453, 464, 465, 468};
double chsq_dbl[NUM_DATA] = { 3377.247277,  4271.588035,  4083.027511,  2614.531455,
                              3040.928626,  5540.716557,  2507.067685,  2431.404938,
                              3332.515561, 12148.250289,  9554.843110,  3803.582999,
                              2945.446478,  3888.720428,  5502.496566,  2442.183926,
                              2523.728342,  2734.481672,  3357.887554,  2452.568393,
                              2480.060297,  2490.896360,  3402.699916,  3698.822160,
                              3988.941842,  4878.708373,  2614.380813,  2470.254440,
                             11738.846003,  3298.987310,  3133.622647,  2549.735304,
                              2719.376800,  2893.957391,  3786.423079,  5550.422302,
                              3967.579305,  4154.260268,  2884.053929,  3106.746122,
                              3106.296470,  3080.349602,  3632.954079,  3541.377670,
                              4251.168622,  2375.837301,  2386.387452,  4294.723126,
                              2750.750886,  6287.271160,  4565.846928,  2452.582768};

unsigned int countone(unsigned char *);

int main(int argc, char **argv) {
  FILE *fp;
  int reject = 0;
  double chsq, ans, diff, diff_accum, diff_max;
  char filename[128];
  unsigned int result;
  int i;

  for (i = 0; i < NUM_DATA; i++) {
    sprintf(filename, files_template, param_no[i]);
    fp = fopen(filename, "rb");
    if (fp == NULL) {
      printf("!! failed to open file\n");
      return 1;
    }

    if (fread(rand_data, sizeof(unsigned char), NUM_WORDS + 4, fp) != NUM_WORDS + 4) {
      printf("!! failed to read file\n");
      return 1;
    }
    fclose(fp);
    result = countone(rand_data);
    if (result == 0xffffffff) {
      reject += 1;
      printf("param = %3d, rejected\n", param_no[i]);
    } else {
      chsq = result / (double) (1 << 16);
      ans  = chsq_dbl[i];
      diff = ((ans > chsq) ? ans - chsq : chsq - ans) / ans * 100;
      diff_accum += diff;
      diff_max = (diff_max > diff) ? diff_max : diff;
      printf("param = %3d, chi^2 = %8.2f, diff = %6.4f%%\n", param_no[i], chsq, diff);
    }
  }
  printf("\n# of rejection (due to overflow) = %d\n", reject);
  if (reject != NUM_DATA) {
    printf("avg. of diff = %6.4f%%\n", diff_accum / (NUM_DATA - reject));
    printf("max. of diff = %6.4f%%\n", diff_max);
  }
  return 0;
}