#ifndef __c2_kamasample1_h__
#define __c2_kamasample1_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_kamasample1InstanceStruct
#define typedef_SFc2_kamasample1InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_isStable;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_kamasample1;
  real_T *c2_x1;
  real_T *c2_x2;
  real_T *c2_u;
  real_T *c2_r;
  real_T *c2_h;
  real_T *c2_u1;
} SFc2_kamasample1InstanceStruct;

#endif                                 /*typedef_SFc2_kamasample1InstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c2_kamasample1_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_kamasample1_get_check_sum(mxArray *plhs[]);
extern void c2_kamasample1_method_dispatcher(SimStruct *S, int_T method, void
  *data);

#endif
