// Hardware-oriented implementation of the "count the ones" test
// NOTE: this file is automatically generated.
// See LICENSE.txt for license information.

#define NUM_WORDS 256000

#define CHSQ_T (CHSQ_I + CHSQ_F)
#define CHSQ_I 16
#define CHSQ_F 22
#define EV_T (EV_I + EV_F)
#define EV_I 12
#define EV_F 4
#define OF_THRES (1 << (CHSQ_I - 1))
