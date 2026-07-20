; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_b2_two_pow_23 0
  %define global_b2Vec2_zero 1
  %define global_b2Rot_identity 3
  %define global_b2Transform_identity 5
  %define global_b2Mat22_zero 9
  %define global_b2_lengthUnitsPerMeter 13
  %define global_malloc_start_address 14
  %define global_malloc_end_address 15
  %define global_malloc_first_block 16
  %define global_g_baseFrame 17
  %define global_g_dt 18

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 8388608.000000
  mov [global_b2_two_pow_23], R0
  mov R0, 0.000000
  mov [global_b2Vec2_zero], R0
  mov R0, 0.000000
  mov [2], R0
  mov R0, 1.000000
  mov [global_b2Rot_identity], R0
  mov R0, 0.000000
  mov [4], R0
  mov R0, 0.000000
  mov [global_b2Transform_identity], R0
  mov R0, 0.000000
  mov [6], R0
  mov R0, 1.000000
  mov [7], R0
  mov R0, 0.000000
  mov [8], R0
  mov R0, 0.000000
  mov [global_b2Mat22_zero], R0
  mov R0, 0.000000
  mov [10], R0
  mov R0, 0.000000
  mov [11], R0
  mov R0, 0.000000
  mov [12], R0
  mov R0, 1.000000
  mov [global_b2_lengthUnitsPerMeter], R0
  mov R0, 1048576
  mov [global_malloc_start_address], R0
  mov R0, 3145727
  mov [global_malloc_end_address], R0
  mov R0, -1
  mov [global_malloc_first_block], R0
  mov R0, 0
  mov [global_g_baseFrame], R0
  mov R0, 0.000000
  mov [global_g_dt], R0
  mov SP, BP
  pop BP
  ret

__function_select_texture:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedTexture, R0
__function_select_texture_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_texture:
  push BP
  mov BP, SP
  in R0, GPU_SelectedTexture
__function_get_selected_texture_return:
  mov SP, BP
  pop BP
  ret

__function_select_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedRegion, R0
__function_select_region_return:
  mov SP, BP
  pop BP
  ret

__function_define_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP+6]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+7]
  out GPU_RegionHotSpotY, R0
__function_define_region_return:
  mov SP, BP
  pop BP
  ret

__function_set_multiply_color:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_MultiplyColor, R0
__function_set_multiply_color_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_point:
  push BP
  mov BP, SP
  push R1
  in R0, GPU_DrawingPointX
  mov R1, [BP+2]
  mov [R1], R0
  in R0, GPU_DrawingPointY
  mov R1, [BP+3]
  mov [R1], R0
__function_get_drawing_point_return:
  mov SP, BP
  pop BP
  ret

__function_clear_screen:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_ClearColor, R0
  out GPU_Command, GPUCommand_ClearScreen
__function_clear_screen_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_region_at_return:
  mov SP, BP
  pop BP
  ret

__function_print_at:
  push BP
  mov BP, SP
  isub SP, 4
  call __function_get_selected_texture
  mov [BP-1], R0
  mov R1, -1
  mov [SP], R1
  call __function_select_texture
  mov R0, [BP+2]
  mov [BP-2], R0
__while_361_start:
__while_361_continue:
  mov R0, [BP+4]
  mov R0, [R0]
  cib R0
  jf R0, __while_361_end
  mov R1, [BP+4]
  mov R1, [R1]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  mov R0, [BP+2]
  iadd R0, 10
  mov [BP+2], R0
__if_374_start:
  mov R0, [BP+4]
  mov R0, [R0]
  ieq R0, 10
  jf R0, __if_374_end
  mov R0, [BP-2]
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 20
  mov [BP+3], R0
__if_374_end:
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP+4], R0
  jmp __while_361_start
__while_361_end:
  mov R1, [BP-1]
  mov [SP], R1
  call __function_select_texture
__function_print_at_return:
  mov SP, BP
  pop BP
  ret

__function_get_cycle_counter:
  push BP
  mov BP, SP
  in R0, TIM_CycleCounter
__function_get_cycle_counter_return:
  mov SP, BP
  pop BP
  ret

__function_get_frame_counter:
  push BP
  mov BP, SP
  in R0, TIM_FrameCounter
__function_get_frame_counter_return:
  mov SP, BP
  pop BP
  ret

__function_end_frame:
  push BP
  mov BP, SP
  wait
__function_end_frame_return:
  mov SP, BP
  pop BP
  ret

__function_min:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imin R0, R1
  pop R1
__function_min_return:
  mov SP, BP
  pop BP
  ret

__function_max:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imax R0, R1
  pop R1
__function_max_return:
  mov SP, BP
  pop BP
  ret

__function_abs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  iabs R0
__function_abs_return:
  mov SP, BP
  pop BP
  ret

__function_fmin:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmin R0, R1
  pop R1
__function_fmin_return:
  mov SP, BP
  pop BP
  ret

__function_fmax:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmax R0, R1
  pop R1
__function_fmax_return:
  mov SP, BP
  pop BP
  ret

__function_fabs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fabs R0
__function_fabs_return:
  mov SP, BP
  pop BP
  ret

__function_round:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  round R0
__function_round_return:
  mov SP, BP
  pop BP
  ret

__function_sin:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  sin R0
__function_sin_return:
  mov SP, BP
  pop BP
  ret

__function_cos:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fadd R0, 1.570796
  sin R0
__function_cos_return:
  mov SP, BP
  pop BP
  ret

__function_atan2:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  atan2 R0, R1
  pop R1
__function_atan2_return:
  mov SP, BP
  pop BP
  ret

__function_sqrt:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, 0.5
  pow R0, R1
  pop R1
__function_sqrt_return:
  mov SP, BP
  pop BP
  ret

__function_islower:
  push BP
  mov BP, SP
  push R1
__if_770_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_775
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_775:
  jf R0, __if_770_end
  mov R0, 1
  jmp __function_islower_return
__if_770_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_786
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_786:
  jf R0, __LogicalAnd_ShortCircuit_790
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_790:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_795_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_800
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_800:
  jf R0, __if_795_end
  mov R0, 1
  jmp __function_isupper_return
__if_795_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_811
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_811:
  jf R0, __LogicalAnd_ShortCircuit_815
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_815:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_946_start:
__while_946_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_946_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_946_start
__while_946_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcpy_return:
  mov SP, BP
  pop BP
  ret

__function_strcat:
  push BP
  mov BP, SP
__while_999_start:
__while_999_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_999_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_999_start
__while_999_end:
__while_1004_start:
__while_1004_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1004_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1004_start
__while_1004_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcat_return:
  mov SP, BP
  pop BP
  ret

__function_itoa:
  push BP
  mov BP, SP
  isub SP, 65
  lea DR, [BP-17]
  mov SR, __literal_string_1068
  mov CR, 17
  movs
  lea R0, [BP-50]
  mov [BP-51], R0
__if_1077_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_1082
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_1082:
  jf R0, __if_1077_end
  jmp __function_itoa_return
__if_1077_end:
__if_1086_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_1091
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_1091:
  jf R0, __if_1086_else
__if_1095_start:
  mov R0, [BP+2]
  ieq R0, 0x80000000
  jf R0, __if_1095_end
  lea DR, [BP-63]
  mov SR, __literal_string_1105
  mov CR, 12
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_strcpy
  jmp __function_itoa_return
__if_1095_end:
  mov R0, 45
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+2]
  isgn R0
  mov [BP+2], R0
  jmp __if_1086_end
__if_1086_else:
__if_1120_start:
  mov R0, [BP+2]
  ilt R0, 0
  jf R0, __if_1120_end
  mov R0, [BP+2]
  and R0, 2147483647
  mov [BP+2], R0
  mov R0, 1073741824
  mov [BP-52], R0
  mov R0, 1073741824
  mov R1, [BP+4]
  imod R0, R1
  mov [BP-53], R0
  mov R0, [BP-53]
  imul R0, 2
  mov R1, [BP+2]
  mov R2, [BP+4]
  imod R1, R2
  iadd R0, R1
  mov [BP-54], R0
  mov R0, [BP-54]
  mov R1, [BP+4]
  imod R0, R1
  mov [BP-55], R0
  lea R0, [BP-17]
  mov R1, [BP-55]
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-51]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-51]
  iadd R0, 1
  mov [BP-51], R0
  mov R0, [BP-52]
  mov R1, [BP+4]
  idiv R0, R1
  imul R0, 2
  mov R1, [BP+2]
  mov R2, [BP+4]
  idiv R1, R2
  iadd R0, R1
  mov R1, [BP-54]
  mov R2, [BP+4]
  idiv R1, R2
  iadd R0, R1
  mov [BP+2], R0
__if_1176_start:
  mov R0, [BP+2]
  bnot R0
  jf R0, __if_1176_end
  jmp __label_1196_digits_stored
__if_1176_end:
__if_1120_end:
__if_1086_end:
__do_1180_start:
  lea R0, [BP-17]
  mov R1, [BP+2]
  mov R2, [BP+4]
  imod R1, R2
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-51]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-51]
  iadd R0, 1
  mov [BP-51], R0
  mov R0, [BP+2]
  mov R1, [BP+4]
  idiv R0, R1
  mov [BP+2], R0
__do_1180_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_1180_start
__do_1180_end:
__label_1196_digits_stored:
__do_1197_start:
  mov R0, [BP-51]
  isub R0, 1
  mov [BP-51], R0
  mov R0, [BP-51]
  mov R0, [R0]
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
__do_1197_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_1197_start
__do_1197_end:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__function_itoa_return:
  mov SP, BP
  pop BP
  ret

__function_b2MinInt:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_min
__function_b2MinInt_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MaxInt:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_max
__function_b2MaxInt_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MinFloat:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_fmin
__function_b2MinFloat_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MaxFloat:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_fmax
__function_b2MaxFloat_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2AbsFloat:
  push BP
  mov BP, SP
  push R1
  isub SP, 1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_fabs
__function_b2AbsFloat_return:
  iadd SP, 1
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ClampFloat:
  push BP
  mov BP, SP
  push R1
__if_1375_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  flt R0, R1
  jf R0, __if_1375_end
  mov R0, [BP+3]
  jmp __function_b2ClampFloat_return
__if_1375_end:
__if_1381_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  fgt R0, R1
  jf R0, __if_1381_end
  mov R0, [BP+4]
  jmp __function_b2ClampFloat_return
__if_1381_end:
  mov R0, [BP+2]
__function_b2ClampFloat_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Dot:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
__function_b2Dot_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Cross:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
__function_b2Cross_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2LengthSquared:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
__function_b2LengthSquared_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Length:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  isub SP, 1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  mov R2, [R3]
  fmul R1, R2
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
__function_b2Length_return:
  iadd SP, 1
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DistanceSquared:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP-2]
  mov R2, [BP-2]
  fmul R1, R2
  fadd R0, R1
__function_b2DistanceSquared_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Distance:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  push R3
  isub SP, 1
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov [BP-2], R0
  mov R1, [BP-1]
  mov R2, [BP-1]
  fmul R1, R2
  mov R2, [BP-2]
  mov R3, [BP-2]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
__function_b2Distance_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Add:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fadd R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fadd R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2Add_return:
  mov SP, BP
  pop BP
  ret

__function_b2Sub:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fsub R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2Sub_return:
  mov SP, BP
  pop BP
  ret

__function_b2Neg:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  fsgn R0
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  fsgn R0
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2Neg_return:
  mov SP, BP
  pop BP
  ret

__function_b2MulSV:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+2]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2MulSV_return:
  mov SP, BP
  pop BP
  ret

__function_b2MulAdd:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+4]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+5]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+4]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
__function_b2MulAdd_return:
  mov SP, BP
  pop BP
  ret

__function_b2MulSub:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+4]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+5]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+4]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
__function_b2MulSub_return:
  mov SP, BP
  pop BP
  ret

__function_b2LeftPerp:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, [BP-2]
  fsgn R0
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2LeftPerp_return:
  mov SP, BP
  pop BP
  ret

__function_b2RightPerp:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, [BP-2]
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-1]
  fsgn R0
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2RightPerp_return:
  mov SP, BP
  pop BP
  ret

__function_b2CrossVS:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, [BP+3]
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+3]
  fsgn R0
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2CrossVS_return:
  mov SP, BP
  pop BP
  ret

__function_b2CrossSV:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, [BP+2]
  fsgn R0
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2CrossSV_return:
  mov SP, BP
  pop BP
  ret

__function_b2IsNormalized:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-1], R0
  mov R2, [BP-1]
  fsgn R2
  fadd R2, 1.000000
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fmul R2, 100.000000
  flt R1, R2
  mov R0, R1
__function_b2IsNormalized_return:
  iadd SP, 2
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Normalize:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  mov R2, [R3]
  fmul R1, R2
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-1], R0
__if_1768_start:
  mov R0, [BP-1]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_1768_end
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Normalize_return
__if_1768_end:
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
  mov R0, [BP-2]
  mov R2, [BP+2]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2Normalize_return:
  mov SP, BP
  pop BP
  ret

__function_b2NormalizeRot:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  mov R3, [BP+2]
  mov R2, [R3]
  mov R4, [BP+2]
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-1], R0
  mov R0, 0.000000
  mov [BP-2], R0
__if_1837_start:
  mov R0, [BP-1]
  fgt R0, 0.000000
  jf R0, __if_1837_end
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
__if_1837_end:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2NormalizeRot_return:
  mov SP, BP
  pop BP
  ret

__function_b2MulRot:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  mov [R1], R0
__function_b2MulRot_return:
  mov SP, BP
  pop BP
  ret

__function_b2InvMulRot:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  mov [R1], R0
__function_b2InvMulRot_return:
  mov SP, BP
  pop BP
  ret

__function_b2RotateVector:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2RotateVector_return:
  mov SP, BP
  pop BP
  ret

__function_b2InvRotateVector:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  fsgn R0
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2InvRotateVector_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransformPoint:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  fadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2TransformPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2InvTransformPoint:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-2]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-1]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-2]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2InvTransformPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2InvMulTransforms:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2InvMulRot
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__function_b2InvMulTransforms_return:
  mov SP, BP
  pop BP
  ret

__function_b2Lerp:
  push BP
  mov BP, SP
  mov R0, [BP+4]
  fsgn R0
  fadd R0, 1.000000
  mov R2, [BP+2]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+5]
  mov [R1], R0
  mov R0, [BP+4]
  fsgn R0
  fadd R0, 1.000000
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
__function_b2Lerp_return:
  mov SP, BP
  pop BP
  ret

__function_b2Abs:
  push BP
  mov BP, SP
  isub SP, 1
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_fabs
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_fabs
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2Abs_return:
  mov SP, BP
  pop BP
  ret

__function_b2Min:
  push BP
  mov BP, SP
  isub SP, 2
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov R2, [BP+4]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2Min_return:
  mov SP, BP
  pop BP
  ret

__function_b2Max:
  push BP
  mov BP, SP
  isub SP, 2
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov R2, [BP+4]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2Max_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetLengthAndNormalize:
  push BP
  mov BP, SP
  isub SP, 2
  mov R3, [BP+3]
  mov R2, [R3]
  mov R4, [BP+3]
  mov R3, [R4]
  fmul R2, R3
  mov R4, [BP+3]
  iadd R4, 1
  mov R3, [R4]
  mov R5, [BP+3]
  iadd R5, 1
  mov R4, [R5]
  fmul R3, R4
  fadd R2, R3
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  lea R2, [BP+2]
  mov R2, [R2]
  mov [R2], R1
  mov R0, R1
__if_2330_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2330_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2GetLengthAndNormalize_return
__if_2330_end:
  mov R0, 1.000000
  mov R1, [BP+2]
  mov R1, [R1]
  fdiv R0, R1
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2GetLengthAndNormalize_return:
  mov SP, BP
  pop BP
  ret

__function_b2Atan2:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
__if_2371_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_2376
  mov R1, [BP+3]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_2376:
  jf R0, __if_2371_end
  mov R0, 0.000000
  jmp __function_b2Atan2_return
__if_2371_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_atan2
__function_b2Atan2_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Rot_GetAngle:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Atan2
__function_b2Rot_GetAngle_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RelativeAngle:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  push R3
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Atan2
__function_b2RelativeAngle_return:
  iadd SP, 2
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2UnwindAngle:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  isub SP, 1
  mov R0, 6.283185
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R2, [BP-1]
  fdiv R1, R2
  mov [SP], R1
  call __function_round
  mov [BP-2], R0
  mov R0, [BP+2]
  mov R1, [BP-2]
  mov R2, [BP-1]
  fmul R1, R2
  fsub R0, R1
__function_b2UnwindAngle_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IntegrateRotation:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+3]
  mov R3, [BP+2]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-2]
  mov R2, [BP-2]
  fmul R1, R2
  mov R2, [BP-1]
  mov R3, [BP-1]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-3], R0
  mov R0, 0.000000
  mov [BP-4], R0
__if_2507_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_2507_end
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
__if_2507_end:
  mov R0, [BP-1]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2IntegrateRotation_return:
  mov SP, BP
  pop BP
  ret

__function_b2NLerp:
  push BP
  mov BP, SP
  isub SP, 6
  mov R0, [BP+4]
  fsgn R0
  fadd R0, 1.000000
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R2, [BP+2]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-3], R0
  mov R1, [BP-3]
  mov R2, [BP-3]
  fmul R1, R2
  mov R2, [BP-2]
  mov R3, [BP-2]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-4], R0
  mov R0, 0.000000
  mov [BP-5], R0
__if_2592_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_2592_end
  mov R0, 1.000000
  mov R1, [BP-4]
  fdiv R0, R1
  mov [BP-5], R0
__if_2592_end:
  mov R0, [BP-2]
  mov R1, [BP-5]
  fmul R0, R1
  mov R1, [BP+5]
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  fmul R0, R1
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
__function_b2NLerp_return:
  mov SP, BP
  pop BP
  ret

__function_b2IsNormalizedRot:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-1], R0
  mov R0, [BP-1]
  fgt R0, 0.999400
  jf R0, __LogicalAnd_ShortCircuit_2635
  mov R1, [BP-1]
  flt R1, 1.000600
  and R0, R1
__LogicalAnd_ShortCircuit_2635:
__function_b2IsNormalizedRot_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MulMV:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2MulMV_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetInverse22:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, [BP-1]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP-2]
  mov R2, [BP-3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
__if_2727_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2727_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2727_end:
  mov R0, [BP-5]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-5]
  fsgn R0
  mov R1, [BP-3]
  fmul R0, R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-5]
  fsgn R0
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP+3]
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
__function_b2GetInverse22_return:
  mov SP, BP
  pop BP
  ret

__function_b2Solve22:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, [BP-1]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP-2]
  mov R2, [BP-3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
__if_2799_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2799_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2799_end:
  mov R0, [BP-5]
  mov R1, [BP-4]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  mov R2, [BP-2]
  mov R4, [BP+3]
  iadd R4, 1
  mov R3, [R4]
  fmul R2, R3
  fsub R1, R2
  fmul R0, R1
  mov [BP-6], R0
  mov R0, [BP-5]
  mov R1, [BP-1]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  mov R2, [BP-3]
  mov R4, [BP+3]
  mov R3, [R4]
  fmul R2, R3
  fsub R1, R2
  fmul R0, R1
  mov [BP-7], R0
  mov R0, [BP-6]
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2Solve22_return:
  mov SP, BP
  pop BP
  ret

__function_b2AABB_Contains:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  mov R0, 1
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2856
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2856:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2867
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2867:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2878
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2878:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2889
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2889:
  mov [BP-1], R0
  mov R0, [BP-1]
__function_b2AABB_Contains_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2AABB_Center:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2AABB_Center_return:
  mov SP, BP
  pop BP
  ret

__function_b2AABB_Extents:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fsub R0, R1
  fmul R0, 0.500000
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  fmul R0, 0.500000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__function_b2AABB_Extents_return:
  mov SP, BP
  pop BP
  ret

__function_b2AABB_Union:
  push BP
  mov BP, SP
  isub SP, 2
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov R2, [BP+4]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 2
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 2
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 2
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 2
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2AABB_Union_return:
  mov SP, BP
  pop BP
  ret

__function_b2AABB_Overlaps:
  push BP
  mov BP, SP
  push R1
  push R2
__if_3005_start:
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3005_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3005_end:
__if_3015_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3015_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3015_end:
__if_3025_start:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3025_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3025_end:
__if_3035_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3035_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3035_end:
  mov R0, 1
__function_b2AABB_Overlaps_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IsValidFloat:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
__if_3106_start:
  mov R0, [BP+2]
  mov R1, [BP+2]
  fne R0, R1
  jf R0, __if_3106_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3106_end:
  mov R0, 1000000000.000000
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP-1]
  fmul R0, R1
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP-1]
  fmul R0, R1
  mov [BP-1], R0
__if_3125_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fgt R0, R1
  jf R0, __if_3125_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3125_end:
__if_3131_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fsgn R1
  flt R0, R1
  jf R0, __if_3131_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3131_end:
  mov R0, 1
__function_b2IsValidFloat_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IsValidVec2:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  isub SP, 1
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_3146
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_b2IsValidFloat
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_3146:
  mov R0, R1
__function_b2IsValidVec2_return:
  iadd SP, 1
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IsValidRotation:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 1
__if_3152_start:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3152_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3152_end:
__if_3159_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3159_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3159_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2IsNormalizedRot
__function_b2IsValidRotation_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2GetLengthUnitsPerMeter:
  push BP
  mov BP, SP
  mov R0, [global_b2_lengthUnitsPerMeter]
__function_b2GetLengthUnitsPerMeter_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransformWorldPoint:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP-1]
  fadd R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  fadd R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__function_b2TransformWorldPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2RoundDownFloat:
  push BP
  mov BP, SP
  mov R0, [BP+2]
__function_b2RoundDownFloat_return:
  mov SP, BP
  pop BP
  ret

__function_b2RoundUpFloat:
  push BP
  mov BP, SP
  mov R0, [BP+2]
__function_b2RoundUpFloat_return:
  mov SP, BP
  pop BP
  ret

__function_b2Perimeter:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP-2]
  fadd R0, R1
  fmul R0, 2.000000
__function_b2Perimeter_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_memset:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  sets
__function_memset_return:
  mov SP, BP
  pop BP
  ret

__function_memcpy:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  movs
__function_memcpy_return:
  mov SP, BP
  pop BP
  ret

__function_merge_free_malloc_blocks:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_4239_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4241
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4241:
  jf R0, __if_4239_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_4250_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4250_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4250_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_4239_end:
__if_4269_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4271
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4271:
  jf R0, __if_4269_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_4279_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_4279_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_4279_end:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
__if_4269_end:
__function_merge_free_malloc_blocks_return:
  mov SP, BP
  pop BP
  ret

__function_reduce_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-1], R0
__if_4301_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_4301_end
  jmp __function_reduce_malloc_block_return
__if_4301_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov R1, [BP+3]
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP+2]
  mov R1, [BP-2]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  isub R0, 4
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_4344_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4344_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4344_end:
  mov R1, [BP-2]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_reduce_malloc_block_return:
  mov SP, BP
  pop BP
  ret

__function_expand_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  isub R0, R1
  mov [BP-1], R0
__if_4363_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_4363_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_4363_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_4373_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_4376
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_4376:
  jf R0, __if_4373_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4373_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_4388_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_4388_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4388_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_4403_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4403_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4403_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, 1
__function_expand_malloc_block_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_malloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
__if_4418_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_4418_end
  mov R0, [global_malloc_start_address]
  mov [global_malloc_first_block], R0
  mov R0, [global_malloc_end_address]
  mov R1, [global_malloc_start_address]
  isub R0, R1
  iadd R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 4
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 3
  mov [R1], R0
__if_4418_end:
__if_4453_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_4453_end
  mov R0, -1
  jmp __function_malloc_return
__if_4453_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_4462_start:
__while_4462_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_4462_end
__if_4465_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_4468
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4468:
  jf R0, __if_4465_end
  jmp __while_4462_end
__if_4465_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_4462_start
__while_4462_end:
__if_4478_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_4478_end
  mov R0, -1
  jmp __function_malloc_return
__if_4478_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_4488_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_4488_else
  mov R0, [BP-1]
  iadd R0, 4
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  iadd R0, R1
  mov R1, [BP-2]
  isub R0, R1
  mov [BP-3], R0
  mov R0, [BP+2]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  isub R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_4533_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4533_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4533_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_4488_end
__if_4488_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_4488_end:
__function_malloc_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_free:
  push BP
  mov BP, SP
  isub SP, 2
__if_4558_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_4558_end
  jmp __function_free_return
__if_4558_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_free_return:
  mov SP, BP
  pop BP
  ret

__function_calloc:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 3
  mov R0, [BP+2]
  mov R1, [BP+3]
  imul R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_malloc
  mov [BP-2], R0
__if_4586_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_4586_end
  mov R0, -1
  jmp __function_calloc_return
__if_4586_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP-2]
__function_calloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_realloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 3
__if_4600_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_4600_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_4600_end:
__if_4606_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_4606_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_4606_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_4625_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_4625_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_4625_end:
__if_4631_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_4631_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4631_end
__if_4631_else:
__if_4642_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_4642_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4642_end
__if_4642_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_4653_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_4653_end
  mov R0, -1
  jmp __function_realloc_return
__if_4653_end:
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  call __function_memcpy
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, [BP-3]
  jmp __function_realloc_return
__if_4642_end:
__if_4631_end:
__function_realloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2SegmentDistance:
  push BP
  mov BP, SP
  isub SP, 19
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-7], R0
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-9], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-10], R0
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R0, R1
  mov [BP-11], R0
__if_4740_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_4745
  mov R1, [BP-8]
  mov R2, [BP-11]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_4745:
  jf R0, __if_4740_else
__if_4749_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4749_else
  mov R2, [BP-9]
  fsgn R2
  mov R3, [BP-7]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP+6]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
  jmp __if_4749_end
__if_4749_else:
__if_4768_start:
  mov R0, [BP-8]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4768_else
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R2, [BP-10]
  mov R3, [BP-8]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP+6]
  iadd R2, 5
  mov [R2], R1
  mov R0, R1
  jmp __if_4768_end
__if_4768_else:
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4768_end:
__if_4749_end:
  jmp __if_4740_end
__if_4740_else:
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-12], R0
  mov R0, [BP-7]
  mov R1, [BP-8]
  fmul R0, R1
  mov R1, [BP-12]
  mov R2, [BP-12]
  fmul R1, R2
  fsub R0, R1
  mov [BP-13], R0
  mov R0, 0.000000
  mov [BP-14], R0
__if_4815_start:
  mov R0, [BP-13]
  fne R0, 0.000000
  jf R0, __if_4815_end
  mov R2, [BP-12]
  mov R3, [BP-10]
  fmul R2, R3
  mov R3, [BP-9]
  mov R4, [BP-8]
  fmul R3, R4
  fsub R2, R3
  mov R3, [BP-13]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
__if_4815_end:
  mov R0, [BP-12]
  mov R1, [BP-14]
  fmul R0, R1
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-8]
  fdiv R0, R1
  mov [BP-15], R0
__if_4845_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jf R0, __if_4845_else
  mov R0, 0.000000
  mov [BP-15], R0
  mov R2, [BP-9]
  fsgn R2
  mov R3, [BP-7]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
  jmp __if_4845_end
__if_4845_else:
__if_4862_start:
  mov R0, [BP-15]
  fgt R0, 1.000000
  jf R0, __if_4862_end
  mov R0, 1.000000
  mov [BP-15], R0
  mov R2, [BP-12]
  mov R3, [BP-9]
  fsub R2, R3
  mov R3, [BP-7]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
__if_4862_end:
__if_4845_end:
  mov R0, [BP-14]
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-15]
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4740_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+6]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP+6]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R1, [BP+4]
  mov [SP], R1
  mov R2, [BP+6]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP+6]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R2, [BP+6]
  mov [SP], R2
  mov R2, [BP+6]
  iadd R2, 2
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  mov R2, [BP+6]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
__function_b2SegmentDistance_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeProxy:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, 8
  mov [SP+1], R2
  call __function_b2MinInt
  mov R1, R0
  mov [BP+3], R1
  mov R0, R1
  mov R0, 0
  mov [BP-1], R0
__for_4927_start:
  mov R0, [BP-1]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_4927_end
  mov R13, [BP+5]
  mov R1, [BP-1]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+2]
  mov R1, [BP-1]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
__for_4927_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4927_start
__for_4927_end:
  mov R0, [BP+3]
  mov R1, [BP+5]
  iadd R1, 16
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+5]
  iadd R1, 17
  mov [R1], R0
__function_b2MakeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2SimplexVertexPtr:
  push BP
  mov BP, SP
__if_5008_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_5008_end
  mov R0, [BP+2]
  jmp __function_b2SimplexVertexPtr_return
__if_5008_end:
__if_5016_start:
  mov R0, [BP+3]
  ieq R0, 1
  jf R0, __if_5016_end
  mov R0, [BP+2]
  iadd R0, 9
  jmp __function_b2SimplexVertexPtr_return
__if_5016_end:
  mov R0, [BP+2]
  iadd R0, 18
__function_b2SimplexVertexPtr_return:
  mov SP, BP
  pop BP
  ret

__function_b2Weight2:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+5]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+6]
  mov [R1], R0
  mov R0, [BP+2]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+5]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+6]
  iadd R1, 1
  mov [R1], R0
__function_b2Weight2_return:
  mov SP, BP
  pop BP
  ret

__function_b2Weight3:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+5]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+6]
  mov R3, [BP+7]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+8]
  mov [R1], R0
  mov R0, [BP+2]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+4]
  mov R3, [BP+5]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+6]
  mov R3, [BP+7]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+8]
  iadd R1, 1
  mov [R1], R0
__function_b2Weight3_return:
  mov SP, BP
  pop BP
  ret

__function_b2FindSupport:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-3], R0
  mov R0, 1
  mov [BP-4], R0
__for_5119_start:
  mov R0, [BP-4]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_5119_end
  mov R1, [BP+2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-5], R0
__if_5138_start:
  mov R0, [BP-5]
  mov R1, [BP-3]
  fgt R0, R1
  jf R0, __if_5138_end
  mov R0, [BP-4]
  mov [BP-2], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_5138_end:
__for_5119_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_5119_start
__for_5119_end:
  mov R0, [BP-2]
__function_b2FindSupport_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MakeSimplexFromCache:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP+5]
  iadd R1, 27
  mov [R1], R0
  mov R0, 0
  mov [BP-1], R0
__for_5161_start:
  mov R0, [BP-1]
  mov R2, [BP+5]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5161_end
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2SimplexVertexPtr
  mov [BP-2], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-2]
  iadd R1, 7
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 4
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-2]
  iadd R1, 8
  mov [R1], R0
  mov R13, [BP-2]
  mov R12, [BP+3]
  mov R2, [BP-2]
  iadd R2, 7
  mov R1, [R2]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 2
  mov R12, [BP+4]
  mov R2, [BP-2]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-2]
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-2]
  iadd R1, 4
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, -1.000000
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__for_5161_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5161_start
__for_5161_end:
__if_5222_start:
  mov R1, [BP+5]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_5222_end
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  call __function_b2SimplexVertexPtr
  mov [BP-1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R13, [BP-1]
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R13, [BP-1]
  iadd R13, 2
  mov R12, [BP+4]
  mov CR, 2
  movs
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 4
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, 1.000000
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 27
  mov [R1], R0
__if_5222_end:
__function_b2MakeSimplexFromCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeSimplexCache:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0
  mov [BP-1], R0
__for_5281_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5281_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2SimplexVertexPtr
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 1
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 4
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
__for_5281_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5281_start
__for_5281_end:
__function_b2MakeSimplexCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeWitnessPoints:
  push BP
  mov BP, SP
  isub SP, 7
__if_5315_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_5315_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  mov CR, 2
  movs
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_5315_end
__if_5315_else:
__if_5333_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_5333_else
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 9
  iadd R2, 6
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+2]
  iadd R1, 9
  mov [SP+3], R1
  mov R1, [BP+3]
  mov [SP+4], R1
  call __function_b2Weight2
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 9
  iadd R2, 6
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 2
  mov [SP+3], R1
  mov R1, [BP+4]
  mov [SP+4], R1
  call __function_b2Weight2
  jmp __if_5333_end
__if_5333_else:
__if_5371_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_5371_else
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 9
  iadd R2, 6
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+2]
  iadd R1, 9
  mov [SP+3], R1
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 6
  mov R1, [R2]
  mov [SP+4], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+5], R1
  mov R1, [BP+3]
  mov [SP+6], R1
  call __function_b2Weight3
  lea R13, [BP+4]
  mov R13, [R13]
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 2
  movs
  jmp __if_5371_end
__if_5371_else:
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_5371_end:
__if_5333_end:
__if_5315_end:
__function_b2ComputeWitnessPoints_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveSimplex2:
  push BP
  mov BP, SP
  isub SP, 15
  mov R12, [BP+2]
  iadd R12, 4
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 9
  iadd R12, 4
  lea DR, [BP-4]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-2]
  mov [SP], R2
  lea R2, [BP-6]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fsgn R1
  mov R0, R1
  mov [BP-7], R0
__if_5444_start:
  mov R0, [BP-7]
  fle R0, 0.000000
  jf R0, __if_5444_end
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __function_b2SolveSimplex2_return
__if_5444_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_5470_start:
  mov R0, [BP-8]
  fle R0, 0.000000
  jf R0, __if_5470_end
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  mov R13, [BP+2]
  mov R12, [BP+2]
  iadd R12, 9
  mov CR, 9
  movs
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __function_b2SolveSimplex2_return
__if_5470_end:
  mov R0, 1.000000
  mov R1, [BP-8]
  mov R2, [BP-7]
  fadd R1, R2
  fdiv R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-9]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-9]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-12], R0
  mov R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2CrossSV
__function_b2SolveSimplex2_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveSimplex3:
  push BP
  mov BP, SP
  isub SP, 39
  mov R12, [BP+2]
  iadd R12, 4
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 9
  iadd R12, 4
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 18
  iadd R12, 4
  lea DR, [BP-6]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-9], R0
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-10], R0
  mov R0, [BP-10]
  mov [BP-11], R0
  mov R0, [BP-9]
  fsgn R0
  mov [BP-12], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-15], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-16], R0
  mov R0, [BP-16]
  mov [BP-17], R0
  mov R0, [BP-15]
  fsgn R0
  mov [BP-18], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-21], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-22], R0
  mov R0, [BP-22]
  mov [BP-23], R0
  mov R0, [BP-21]
  fsgn R0
  mov [BP-24], R0
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-25], R0
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-26], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-27], R0
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-28], R0
  mov R0, [BP-25]
  mov R1, [BP-26]
  fmul R0, R1
  mov [BP-29], R0
  mov R0, [BP-25]
  mov R1, [BP-27]
  fmul R0, R1
  mov [BP-30], R0
  mov R0, [BP-25]
  mov R1, [BP-28]
  fmul R0, R1
  mov [BP-31], R0
__if_5692_start:
  mov R0, [BP-12]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5697
  mov R1, [BP-18]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5697:
  jf R0, __if_5692_end
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __function_b2SolveSimplex3_return
__if_5692_end:
__if_5715_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5720
  mov R1, [BP-12]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5720:
  jf R0, __LogicalAnd_ShortCircuit_5724
  mov R1, [BP-31]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5724:
  jf R0, __if_5715_end
  mov R0, 1.000000
  mov R1, [BP-11]
  mov R2, [BP-12]
  fadd R1, R2
  fdiv R0, R1
  mov [BP-33], R0
  mov R0, [BP-11]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-36], R0
  mov R1, [BP-36]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2CrossSV
  jmp __function_b2SolveSimplex3_return
__if_5715_end:
__if_5776_start:
  mov R0, [BP-17]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5781
  mov R1, [BP-18]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5781:
  jf R0, __LogicalAnd_ShortCircuit_5785
  mov R1, [BP-30]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5785:
  jf R0, __if_5776_end
  mov R0, 1.000000
  mov R1, [BP-17]
  mov R2, [BP-18]
  fadd R1, R2
  fdiv R0, R1
  mov [BP-33], R0
  mov R0, [BP-17]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-18]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 6
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  mov R13, [BP+2]
  iadd R13, 9
  mov R12, [BP+2]
  iadd R12, 18
  mov CR, 9
  movs
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-36], R0
  mov R1, [BP-36]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2CrossSV
  jmp __function_b2SolveSimplex3_return
__if_5776_end:
__if_5842_start:
  mov R0, [BP-11]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5847
  mov R1, [BP-24]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5847:
  jf R0, __if_5842_end
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  mov R13, [BP+2]
  mov R12, [BP+2]
  iadd R12, 9
  mov CR, 9
  movs
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __function_b2SolveSimplex3_return
__if_5842_end:
__if_5870_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5875
  mov R1, [BP-23]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5875:
  jf R0, __if_5870_end
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 6
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  mov R13, [BP+2]
  mov R12, [BP+2]
  iadd R12, 18
  mov CR, 9
  movs
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __function_b2SolveSimplex3_return
__if_5870_end:
__if_5898_start:
  mov R0, [BP-23]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5903
  mov R1, [BP-24]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5903:
  jf R0, __LogicalAnd_ShortCircuit_5907
  mov R1, [BP-29]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5907:
  jf R0, __if_5898_end
  mov R0, 1.000000
  mov R1, [BP-23]
  mov R2, [BP-24]
  fadd R1, R2
  fdiv R0, R1
  mov [BP-33], R0
  mov R0, [BP-23]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-24]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 6
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  mov R13, [BP+2]
  mov R12, [BP+2]
  iadd R12, 18
  mov CR, 9
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-36], R0
  mov R1, [BP-36]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2CrossSV
  jmp __function_b2SolveSimplex3_return
__if_5898_end:
  mov R0, 1.000000
  mov R1, [BP-29]
  mov R2, [BP-30]
  fadd R1, R2
  mov R2, [BP-31]
  fadd R1, R2
  fdiv R0, R1
  mov [BP-32], R0
  mov R0, [BP-29]
  mov R1, [BP-32]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-30]
  mov R1, [BP-32]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-31]
  mov R1, [BP-32]
  fmul R0, R1
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 6
  mov [R1], R0
  mov R0, 3
  mov R1, [BP+2]
  iadd R1, 27
  mov [R1], R0
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__function_b2SolveSimplex3_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeDistance:
  push BP
  mov BP, SP
  isub SP, 73
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 9
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 16
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 17
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-61], R0
__for_6030_start:
  mov R0, [BP-61]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_6030_end
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov R2, [BP-61]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-19]
  mov R2, [BP-61]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2TransformPoint
__for_6030_continue:
  mov R0, [BP-61]
  mov R1, R0
  iadd R1, 1
  mov [BP-61], R1
  jmp __for_6030_start
__for_6030_end:
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  lea R1, [BP-47]
  mov [SP+3], R1
  call __function_b2MakeSimplexFromCache
  mov R12, global_b2Vec2_zero
  lea DR, [BP-49]
  mov CR, 2
  movs
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R0, R1
  mov [BP-56], R0
  mov R0, 20
  mov [BP-57], R0
  mov R0, 0
  mov [BP-58], R0
__while_6090_start:
__while_6090_continue:
  mov R0, [BP-58]
  mov R1, [BP-57]
  ilt R0, R1
  jf R0, __while_6090_end
  mov R0, [BP-20]
  mov [BP-61], R0
  mov R0, 0
  mov [BP-68], R0
__for_6099_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6099_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP-68]
  mov [SP+1], R1
  call __function_b2SimplexVertexPtr
  mov [BP-69], R0
  mov R1, [BP-69]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-69]
  iadd R1, 8
  mov R0, [R1]
  lea R1, [BP-55]
  mov R2, [BP-68]
  iadd R1, R2
  mov [R1], R0
__for_6099_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6099_start
__for_6099_end:
  mov R0, 0.000000
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-62], R0
__if_6137_start:
  mov R0, [BP-20]
  ieq R0, 1
  jf R0, __if_6137_else
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __if_6137_end
__if_6137_else:
__if_6149_start:
  mov R0, [BP-20]
  ieq R0, 2
  jf R0, __if_6149_else
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex2
  jmp __if_6149_end
__if_6149_else:
__if_6159_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6159_end
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex3
__if_6159_end:
__if_6149_end:
__if_6137_end:
__if_6169_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6169_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6169_end:
__if_6185_start:
  lea R2, [BP-63]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-56]
  flt R1, R2
  mov R0, R1
  jf R0, __if_6185_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6185_end:
  lea R13, [BP-49]
  lea R12, [BP-63]
  mov CR, 2
  movs
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP-20]
  mov [SP+1], R1
  call __function_b2SimplexVertexPtr
  mov [BP-64], R0
  mov R2, [BP-1]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  mov R2, [BP-64]
  iadd R2, 7
  mov [R2], R1
  mov R0, R1
  mov R13, [BP-64]
  mov R12, [BP-1]
  mov R2, [BP-64]
  iadd R2, 7
  mov R1, [R2]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  lea R1, [BP-63]
  mov [SP], R1
  lea R1, [BP-66]
  mov [SP+1], R1
  call __function_b2Neg
  lea R2, [BP-19]
  mov [SP], R2
  lea R2, [BP-66]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  mov R2, [BP-64]
  iadd R2, 8
  mov [R2], R1
  mov R0, R1
  mov R13, [BP-64]
  iadd R13, 2
  lea R12, [BP-19]
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R1, [BP-64]
  mov [SP], R1
  mov R1, [BP-64]
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-64]
  iadd R1, 4
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-58]
  mov R1, R0
  iadd R1, 1
  mov [BP-58], R1
  mov R0, 0
  mov [BP-67], R0
  mov R0, 0
  mov [BP-68], R0
__for_6267_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6267_end
__if_6277_start:
  mov R1, [BP-64]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov R1, [R1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_6286
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  lea R2, [BP-55]
  mov R3, [BP-68]
  iadd R2, R3
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6286:
  jf R0, __if_6277_end
  mov R0, 1
  mov [BP-67], R0
  jmp __for_6267_end
__if_6277_end:
__for_6267_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6267_start
__for_6267_end:
__if_6296_start:
  mov R0, [BP-67]
  jf R0, __if_6296_end
  jmp __while_6090_end
__if_6296_end:
  mov R0, [BP-20]
  iadd R0, 1
  mov [BP-20], R0
  jmp __while_6090_start
__while_6090_end:
  lea R1, [BP-49]
  mov [SP], R1
  lea R1, [BP-60]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  mov R13, [BP+4]
  iadd R13, 4
  lea R12, [BP-60]
  mov CR, 2
  movs
  mov R2, [BP+4]
  mov [SP], R2
  mov R2, [BP+4]
  iadd R2, 2
  mov [SP+1], R2
  call __function_b2Distance
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-58]
  mov R1, [BP+4]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 8
  mov [R1], R0
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2MakeSimplexCache
__if_6345_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  jf R0, __if_6345_end
  mov R1, [BP+2]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-61], R0
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 17
  mov R0, [R1]
  mov [BP-62], R0
  mov R2, 0.000000
  mov [SP], R2
  mov R3, [BP+4]
  iadd R3, 6
  mov R2, [R3]
  mov R3, [BP-61]
  fsub R2, R3
  mov R3, [BP-62]
  fsub R2, R3
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP+4]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP-61]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP-62]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2MulSub
__if_6345_end:
__function_b2ShapeDistance_return:
  mov SP, BP
  pop BP
  ret

__function_b2PointInPolygon:
  push BP
  mov BP, SP
  isub SP, 57
  push R1
  push R2
  isub SP, 4
  lea R1, [BP-41]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 41
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-41]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-5]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-1], R0
  mov R0, 0
  mov [BP-48], R0
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  call __function_b2ShapeDistance
  mov R0, [BP-51]
  mov R2, [BP+2]
  iadd R2, 34
  mov R1, [R2]
  fle R0, R1
__function_b2PointInPolygon_return:
  iadd SP, 4
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCast:
  push BP
  mov BP, SP
  isub SP, 74
  mov R13, [BP+3]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+3]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  mov R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 17
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 17
  mov R1, [R2]
  fadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov R2, [BP-1]
  fsub R1, R2
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-3], R0
  mov R0, [BP-1]
  fmul R0, 0.250000
  mov [BP-4], R0
  mov R0, 0
  mov [BP-11], R0
  mov R0, 0.000000
  mov [BP-12], R0
  lea R13, [BP-53]
  mov R12, [BP+2]
  mov CR, 18
  movs
  lea R13, [BP-35]
  mov R12, [BP+2]
  iadd R12, 18
  mov CR, 18
  movs
  lea R13, [BP-17]
  mov R12, [BP+2]
  iadd R12, 36
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-13], R0
  mov R12, [BP+2]
  iadd R12, 40
  lea DR, [BP-55]
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-56], R0
__for_6531_start:
  mov R0, [BP-56]
  ilt R0, 20
  jf R0, __for_6531_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  lea R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-65]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_6557_start:
  mov R0, [BP-59]
  mov R1, [BP-3]
  mov R2, [BP-4]
  fadd R1, R2
  flt R0, R1
  jf R0, __if_6557_end
__if_6565_start:
  mov R0, [BP-56]
  ieq R0, 0
  jf R0, __if_6565_else
__if_6570_start:
  mov R1, [BP+2]
  iadd R1, 43
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_6573
  mov R1, [BP-59]
  mov R2, [BP-1]
  fmul R2, 2.000000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6573:
  jf R0, __if_6570_else
  mov R0, [BP-59]
  mov R1, [BP-1]
  fsub R0, R1
  mov [BP-3], R0
  jmp __if_6570_end
__if_6570_else:
  mov R0, 1
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  lea R1, [BP-65]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-61]
  mov [SP+2], R1
  lea R1, [BP-68]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-63]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 17
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-61]
  mov [SP+2], R1
  lea R1, [BP-70]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-70]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __function_b2ShapeCast_return
__if_6570_end:
  jmp __if_6565_end
__if_6565_else:
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  lea R1, [BP-65]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-61]
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+3]
  lea R12, [BP-61]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  jmp __function_b2ShapeCast_return
__if_6565_end:
__if_6557_end:
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
__if_6667_start:
  mov R0, [BP-66]
  fge R0, 0.000000
  jf R0, __if_6667_end
  jmp __function_b2ShapeCast_return
__if_6667_end:
  mov R0, [BP-12]
  mov R1, [BP-3]
  mov R2, [BP-59]
  fsub R1, R2
  mov R2, [BP-66]
  fdiv R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_6683_start:
  mov R0, [BP-12]
  mov R2, [BP+2]
  iadd R2, 42
  mov R1, [R2]
  fge R0, R1
  jf R0, __if_6683_end
  jmp __function_b2ShapeCast_return
__if_6683_end:
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-17]
  mov [SP+3], R1
  call __function_b2MulAdd
__for_6531_continue:
  mov R0, [BP-56]
  iadd R0, 1
  mov [BP-56], R0
  jmp __for_6531_start
__for_6531_end:
__function_b2ShapeCast_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetSweepTransform:
  push BP
  mov BP, SP
  isub SP, 13
  mov R1, [BP+3]
  fsgn R1
  fadd R1, 1.000000
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, [BP+3]
  fsgn R0
  fadd R0, 1.000000
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+3]
  mov R3, [BP+2]
  iadd R3, 8
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-6], R0
  mov R0, [BP+3]
  fsgn R0
  fadd R0, 1.000000
  mov R2, [BP+2]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP+3]
  mov R3, [BP+2]
  iadd R3, 8
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-5], R0
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+1], R1
  call __function_b2NormalizeRot
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  mov R13, [BP+4]
  lea R12, [BP-10]
  mov CR, 2
  movs
__function_b2GetSweepTransform_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeSeparationFunction:
  push BP
  mov BP, SP
  isub SP, 50
  mov R0, [BP+3]
  mov R1, [BP+8]
  mov [R1], R0
  mov R0, [BP+5]
  mov R1, [BP+8]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R13, [BP+8]
  iadd R13, 2
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 10
  movs
  mov R13, [BP+8]
  iadd R13, 12
  lea R12, [BP+6]
  mov R12, [R12]
  mov CR, 10
  movs
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+7]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  mov R1, [BP+6]
  mov [SP], R1
  mov R1, [BP+7]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
__if_6859_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_6859_end
  mov R0, 0
  mov R1, [BP+8]
  iadd R1, 26
  mov [R1], R0
  mov R12, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-29]
  mov CR, 2
  movs
  mov R12, [BP+5]
  mov R1, [BP+2]
  iadd R1, 4
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-31]
  mov CR, 2
  movs
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-9]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-37]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP+1], R1
  call __function_b2Normalize
  mov R13, [BP+8]
  iadd R13, 22
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  jmp __function_b2MakeSeparationFunction_return
__if_6859_end:
__if_6924_start:
  mov R0, [BP+2]
  iadd R0, 1
  mov R0, [R0]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  ieq R0, R1
  jf R0, __if_6924_end
  mov R0, 2
  mov R1, [BP+8]
  iadd R1, 26
  mov [R1], R0
  mov R12, [BP+5]
  mov R1, [BP+2]
  iadd R1, 4
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-29]
  mov CR, 2
  movs
  mov R12, [BP+5]
  mov R1, [BP+2]
  iadd R1, 4
  iadd R1, 1
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-31]
  mov CR, 2
  movs
  lea R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-33]
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2CrossVS
  lea R1, [BP-35]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-7]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R0, [BP-29]
  mov R1, [BP-31]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+8]
  iadd R1, 22
  mov [R1], R0
  mov R0, [BP-28]
  mov R1, [BP-30]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+8]
  iadd R1, 22
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-9]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R12, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-41]
  mov CR, 2
  movs
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-39]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
__if_7052_start:
  lea R2, [BP-45]
  mov [SP], R2
  lea R2, [BP-37]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7052_end
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Neg
  mov R13, [BP+8]
  iadd R13, 24
  lea R12, [BP-47]
  mov CR, 2
  movs
__if_7052_end:
  jmp __function_b2MakeSeparationFunction_return
__if_6924_end:
  mov R0, 1
  mov R1, [BP+8]
  iadd R1, 26
  mov [R1], R0
  mov R12, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-11]
  mov CR, 2
  movs
  mov R12, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-13]
  mov CR, 2
  movs
  lea R1, [BP-13]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-15]
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2CrossVS
  lea R1, [BP-17]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R0, [BP-11]
  mov R1, [BP-13]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+8]
  iadd R1, 22
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP-12]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+8]
  iadd R1, 22
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+8]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R12, [BP+5]
  mov R1, [BP+2]
  iadd R1, 4
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-23]
  mov CR, 2
  movs
  lea R1, [BP-9]
  mov [SP], R1
  lea R1, [BP-23]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-25]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-27]
  mov [SP+2], R1
  call __function_b2Sub
__if_7191_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-19]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7191_end
  mov R1, [BP+8]
  iadd R1, 24
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  call __function_b2Neg
  mov R13, [BP+8]
  iadd R13, 24
  lea R12, [BP-29]
  mov CR, 2
  movs
__if_7191_end:
__function_b2MakeSeparationFunction_return:
  mov SP, BP
  pop BP
  ret

__function_b2FindMinSeparation:
  push BP
  mov BP, SP
  isub SP, 24
  push R1
  push R2
  push R3
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  mov R1, [BP+2]
  iadd R1, 12
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
__if_7235_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7235_else
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2InvRotateVector
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2Neg
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2InvRotateVector
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  lea R2, [BP-10]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  lea R2, [BP+3]
  mov R2, [R2]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  lea R2, [BP-14]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  lea R2, [BP+4]
  mov R2, [R2]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 1
  mov R12, [R1]
  mov R1, [BP+4]
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-18]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2FindMinSeparation_return
  jmp __if_7235_end
__if_7235_else:
__if_7336_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7336_else
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Neg
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2InvRotateVector
  mov R0, -1
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  lea R2, [BP-16]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  lea R2, [BP+4]
  mov R2, [R2]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 1
  mov R12, [R1]
  mov R1, [BP+4]
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-18]
  mov CR, 2
  movs
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2FindMinSeparation_return
  jmp __if_7336_end
__if_7336_else:
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Neg
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2InvRotateVector
  mov R0, -1
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  lea R2, [BP-16]
  mov [SP+1], R2
  call __function_b2FindSupport
  mov R1, R0
  lea R2, [BP+3]
  mov R2, [R2]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  mov R1, [R1]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-18]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2FindMinSeparation_return
__if_7336_end:
__if_7235_end:
__function_b2FindMinSeparation_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2EvaluateSeparation:
  push BP
  mov BP, SP
  isub SP, 18
  push R1
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  mov R1, [BP+2]
  iadd R1, 12
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
__if_7532_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7532_else
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-10]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 1
  mov R12, [R1]
  mov R1, [BP+4]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-12]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2EvaluateSeparation_return
  jmp __if_7532_end
__if_7532_else:
__if_7586_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7586_else
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP+2]
  iadd R1, 1
  mov R12, [R1]
  mov R1, [BP+4]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-14]
  mov CR, 2
  movs
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2EvaluateSeparation_return
  jmp __if_7586_end
__if_7586_else:
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 24
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 22
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-14]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2Dot
  jmp __function_b2EvaluateSeparation_return
__if_7586_end:
__if_7532_end:
__function_b2EvaluateSeparation_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2TimeOfImpact:
  push BP
  mov BP, SP
  isub SP, 153
  mov R0, 0
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 56
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R13, [BP+3]
  iadd R13, 1
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+3]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 36
  lea DR, [BP-10]
  mov CR, 10
  movs
  mov R12, [BP+2]
  iadd R12, 46
  lea DR, [BP-20]
  mov CR, 10
  movs
  mov R0, [BP+2]
  mov [BP-21], R0
  mov R0, [BP+2]
  iadd R0, 18
  mov [BP-22], R0
  mov R1, [BP+2]
  iadd R1, 56
  mov R0, [R1]
  mov [BP-23], R0
  mov R1, [BP-21]
  iadd R1, 17
  mov R0, [R1]
  mov R2, [BP-22]
  iadd R2, 17
  mov R1, [R2]
  fadd R0, R1
  mov [BP-24], R0
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fsub R1, R2
  mov [BP-145], R1
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  mov [BP-146], R1
  mov R1, [BP-146]
  mov [SP], R1
  mov R1, [BP-145]
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-25], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 0.250000
  mov R0, R1
  mov [BP-26], R0
  mov R0, 0.000000
  mov [BP-27], R0
  mov R0, 20
  mov [BP-28], R0
  mov R0, 0
  mov [BP-29], R0
  mov R0, 0
  mov [BP-36], R0
  lea R13, [BP-77]
  mov R12, [BP+2]
  mov CR, 18
  movs
  lea R13, [BP-59]
  mov R12, [BP+2]
  iadd R12, 18
  mov CR, 18
  movs
  mov R0, 0
  mov [BP-37], R0
  mov R0, 1
  mov [BP-78], R0
__while_7801_start:
__while_7801_continue:
  mov R0, [BP-78]
  jf R0, __while_7801_end
  lea R1, [BP-10]
  mov [SP], R1
  mov R1, [BP-27]
  mov [SP+1], R1
  lea R1, [BP-82]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  lea R1, [BP-20]
  mov [SP], R1
  mov R1, [BP-27]
  mov [SP+1], R1
  lea R1, [BP-86]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  lea R1, [BP-82]
  mov [SP], R1
  lea R1, [BP-86]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2InvMulTransforms
  lea R1, [BP-77]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  lea R1, [BP-95]
  mov [SP+2], R1
  call __function_b2ShapeDistance
  lea R1, [BP-80]
  mov [SP], R1
  lea R1, [BP-91]
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-82]
  mov [SP], R1
  lea R1, [BP-95]
  mov [SP+1], R1
  lea R1, [BP-99]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-82]
  mov [SP], R1
  lea R1, [BP-93]
  mov [SP+1], R1
  lea R1, [BP-101]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R0, [BP-29]
  iadd R0, 1
  mov [BP-29], R0
__if_7873_start:
  mov R0, [BP-89]
  fle R0, 0.000000
  jf R0, __if_7873_end
  mov R0, 2
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_7873_end:
__if_7888_start:
  mov R0, [BP-89]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_7888_end
  mov R0, 3
  mov R1, [BP+3]
  mov [R1], R0
  lea R1, [BP-99]
  mov [SP], R1
  mov R2, [BP-21]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-134]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-101]
  mov [SP], R1
  mov R2, [BP-22]
  iadd R2, 17
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-136]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-134]
  mov [SP], R1
  lea R1, [BP-136]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [SP+3], R1
  call __function_b2Lerp
  mov R13, [BP+3]
  iadd R13, 3
  lea R12, [BP-97]
  mov CR, 2
  movs
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_7888_end:
  lea R1, [BP-36]
  mov [SP], R1
  mov R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  mov R1, [BP-22]
  mov [SP+3], R1
  lea R1, [BP-20]
  mov [SP+4], R1
  mov R1, [BP-27]
  mov [SP+5], R1
  lea R1, [BP-128]
  mov [SP+6], R1
  call __function_b2MakeSeparationFunction
  mov R0, 0
  mov [BP-129], R0
  mov R0, [BP-23]
  mov [BP-130], R0
  mov R0, 0
  mov [BP-131], R0
  mov R0, 1
  mov [BP-132], R0
__while_7967_start:
__while_7967_continue:
  mov R0, [BP-132]
  jf R0, __while_7967_end
  lea R1, [BP-128]
  mov [SP], R1
  lea R1, [BP-133]
  mov [SP+1], R1
  lea R1, [BP-134]
  mov [SP+2], R1
  mov R1, [BP-130]
  mov [SP+3], R1
  call __function_b2FindMinSeparation
  mov [BP-135], R0
__if_7984_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_7984_end
  mov R0, 4
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-23]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_7967_end
__if_7984_end:
__if_8003_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  fgt R0, R1
  jf R0, __if_8003_end
  mov R0, [BP-130]
  mov [BP-27], R0
  jmp __while_7967_end
__if_8003_end:
  lea R1, [BP-128]
  mov [SP], R1
  mov R1, [BP-133]
  mov [SP+1], R1
  mov R1, [BP-134]
  mov [SP+2], R1
  mov R1, [BP-27]
  mov [SP+3], R1
  call __function_b2EvaluateSeparation
  mov [BP-136], R0
__if_8022_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  flt R0, R1
  jf R0, __if_8022_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_7967_end
__if_8022_end:
__if_8041_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8041_end
  mov R0, 3
  mov R1, [BP+3]
  mov [R1], R0
  lea R1, [BP-99]
  mov [SP], R1
  mov R2, [BP-21]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-142]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-101]
  mov [SP], R1
  mov R2, [BP-22]
  iadd R2, 17
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-144]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-142]
  mov [SP], R1
  lea R1, [BP-144]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [SP+3], R1
  call __function_b2Lerp
  mov R13, [BP+3]
  iadd R13, 3
  lea R12, [BP-97]
  mov CR, 2
  movs
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_7967_end
__if_8041_end:
  mov R0, 0
  mov [BP-137], R0
  mov R0, [BP-27]
  mov [BP-138], R0
  mov R0, [BP-130]
  mov [BP-139], R0
  mov R0, 1
  mov [BP-140], R0
__while_8108_start:
__while_8108_continue:
  mov R0, [BP-140]
  jf R0, __while_8108_end
__if_8113_start:
  mov R0, [BP-137]
  and R0, 1
  ine R0, 0
  jf R0, __if_8113_else
  mov R0, [BP-138]
  mov R1, [BP-25]
  mov R2, [BP-136]
  fsub R1, R2
  mov R2, [BP-139]
  mov R3, [BP-138]
  fsub R2, R3
  fmul R1, R2
  mov R2, [BP-135]
  mov R3, [BP-136]
  fsub R2, R3
  fdiv R1, R2
  fadd R0, R1
  mov [BP-141], R0
  jmp __if_8113_end
__if_8113_else:
  mov R0, [BP-138]
  mov R1, [BP-139]
  fadd R0, R1
  fmul R0, 0.500000
  mov [BP-141], R0
__if_8113_end:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  lea R1, [BP-128]
  mov [SP], R1
  mov R1, [BP-133]
  mov [SP+1], R1
  mov R1, [BP-134]
  mov [SP+2], R1
  mov R1, [BP-141]
  mov [SP+3], R1
  call __function_b2EvaluateSeparation
  mov [BP-142], R0
__if_8159_start:
  mov R2, [BP-142]
  mov R3, [BP-25]
  fsub R2, R3
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, [BP-26]
  flt R1, R2
  mov R0, R1
  jf R0, __if_8159_end
  mov R0, [BP-141]
  mov [BP-130], R0
  jmp __while_8108_end
__if_8159_end:
__if_8171_start:
  mov R0, [BP-142]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_8171_else
  mov R0, [BP-141]
  mov [BP-138], R0
  mov R0, [BP-142]
  mov [BP-136], R0
  jmp __if_8171_end
__if_8171_else:
  mov R0, [BP-141]
  mov [BP-139], R0
  mov R0, [BP-142]
  mov [BP-135], R0
__if_8171_end:
__if_8189_start:
  mov R0, [BP-137]
  ieq R0, 50
  jf R0, __if_8189_end
  jmp __while_8108_end
__if_8189_end:
  jmp __while_8108_start
__while_8108_end:
  mov R0, [BP-131]
  iadd R0, 1
  mov [BP-131], R0
__if_8199_start:
  mov R0, [BP-131]
  ieq R0, 8
  jf R0, __if_8199_end
  jmp __while_7967_end
__if_8199_end:
  jmp __while_7967_start
__while_7967_end:
__if_8204_start:
  mov R0, [BP-129]
  jf R0, __if_8204_end
  jmp __while_7801_end
__if_8204_end:
__if_8207_start:
  mov R0, [BP-29]
  mov R1, [BP-28]
  ieq R0, R1
  jf R0, __if_8207_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  lea R1, [BP-99]
  mov [SP], R1
  mov R2, [BP-21]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-134]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-101]
  mov [SP], R1
  mov R2, [BP-22]
  iadd R2, 17
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-97]
  mov [SP+2], R1
  lea R1, [BP-136]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-134]
  mov [SP], R1
  lea R1, [BP-136]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 1
  mov [SP+3], R1
  call __function_b2Lerp
  mov R13, [BP+3]
  iadd R13, 3
  lea R12, [BP-97]
  mov CR, 2
  movs
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __while_7801_end
__if_8207_end:
  jmp __while_7801_start
__while_7801_end:
__function_b2TimeOfImpact_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeBox:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 36
  mov [SP+2], R1
  call __function_memset
  mov R0, 4
  mov R1, [BP+4]
  iadd R1, 35
  mov [R1], R0
  mov R0, [BP+2]
  fsgn R0
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP+3]
  fsgn R0
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  fsgn R0
  mov R1, [BP+4]
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 4
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  fsgn R0
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 16
  mov [R1], R0
  mov R0, -1.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 1
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 4
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 4
  iadd R1, 1
  mov [R1], R0
  mov R0, -1.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 16
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 34
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 32
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 32
  iadd R1, 1
  mov [R1], R0
__function_b2MakeBox_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeSquare:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2MakeBox
__function_b2MakeSquare_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputePolygonCentroid:
  push BP
  mov BP, SP
  isub SP, 19
  mov R0, 0.000000
  mov [BP-2], R0
  mov R0, 0.000000
  mov [BP-1], R0
  mov R0, 0.000000
  mov [BP-3], R0
  mov R12, [BP+2]
  lea DR, [BP-5]
  mov CR, 2
  movs
  mov R0, 0.333333
  mov [BP-6], R0
  mov R0, 1
  mov [BP-8], R0
__for_8641_start:
  mov R0, [BP-8]
  mov R1, [BP+3]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_8641_end
  mov R1, [BP+2]
  mov R2, [BP-8]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  mov R2, [BP-8]
  iadd R2, 1
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-10]
  mov [SP], R2
  lea R2, [BP-12]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  fmul R1, 0.500000
  mov R0, R1
  mov [BP-13], R0
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-13]
  mov R2, [BP-6]
  fmul R1, R2
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  lea R1, [BP-2]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-3]
  mov R1, [BP-13]
  fadd R0, R1
  mov [BP-3], R0
__for_8641_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_8641_start
__for_8641_end:
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-2]
  mov R1, [BP-7]
  fmul R0, R1
  mov [BP-2], R0
  mov R0, [BP-1]
  mov R1, [BP-7]
  fmul R0, R1
  mov [BP-1], R0
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2Add
__function_b2ComputePolygonCentroid_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeOffsetRoundedPolygon:
  push BP
  mov BP, SP
  isub SP, 13
__if_8844_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_8844_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakeOffsetRoundedPolygon_return
__if_8844_end:
  lea R13, [BP-4]
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 2
  movs
  lea R13, [BP-2]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R1, [BP+6]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 36
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP+6]
  iadd R1, 35
  mov [R1], R0
  mov R0, [BP+5]
  mov R1, [BP+6]
  iadd R1, 34
  mov [R1], R0
  mov R0, 0
  mov [BP-5], R0
__for_8879_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8879_end
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  mov R1, [BP+6]
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2TransformPoint
__for_8879_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8879_start
__for_8879_end:
  mov R0, 0
  mov [BP-5], R0
__for_8902_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8902_end
  mov R0, 0
  mov [BP-6], R0
__if_8916_start:
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_8916_end
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-6], R0
__if_8916_end:
  mov R1, [BP+6]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+6]
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2CrossVS
  lea R1, [BP-10]
  mov [SP], R1
  mov R1, [BP+6]
  iadd R1, 16
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2Normalize
__for_8902_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8902_start
__for_8902_end:
  mov R1, [BP+6]
  mov [SP], R1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+6]
  iadd R1, 32
  mov [SP+2], R1
  call __function_b2ComputePolygonCentroid
__function_b2MakeOffsetRoundedPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransformPolygon:
  push BP
  mov BP, SP
  isub SP, 10
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 36
  mov [SP+2], R1
  call __function_memcpy
  mov R0, 0
  mov [BP-3], R0
__for_8986_start:
  mov R0, [BP-3]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8986_end
  mov R12, [BP+4]
  mov R1, [BP-3]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-5]
  mov CR, 2
  movs
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov R2, [BP-3]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R12, [BP+4]
  iadd R12, 16
  mov R1, [BP-3]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-7]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 16
  mov R2, [BP-3]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2RotateVector
__for_8986_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_8986_start
__for_8986_end:
  mov R12, [BP+4]
  iadd R12, 32
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 32
  mov [SP+2], R1
  call __function_b2TransformPoint
__function_b2TransformPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCircleMass:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fmul R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  fmul R0, 3.141593
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 1
  mov R12, [BP+2]
  mov CR, 2
  movs
  mov R1, [BP+4]
  mov R0, [R1]
  fmul R0, 0.500000
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
__function_b2ComputeCircleMass_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCapsuleMass:
  push BP
  mov BP, SP
  isub SP, 19
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP-1]
  fmul R0, R1
  mov [BP-2], R0
  mov R12, [BP+2]
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-6]
  mov CR, 2
  movs
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-8]
  mov [SP], R1
  call __function_b2Length
  mov [BP-9], R0
  mov R0, [BP-9]
  mov R1, [BP-9]
  fmul R0, R1
  mov [BP-10], R0
  mov R0, [BP+3]
  mov R1, [BP-1]
  fmul R1, 3.141593
  mov R2, [BP-1]
  fmul R1, R2
  fmul R0, R1
  mov [BP-11], R0
  mov R0, [BP+3]
  mov R1, [BP-1]
  fmul R1, 2.000000
  mov R2, [BP-9]
  fmul R1, R2
  fmul R0, R1
  mov [BP-12], R0
  mov R0, [BP-11]
  mov R1, [BP-12]
  fadd R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-4]
  mov R1, [BP-6]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  fadd R0, R1
  fmul R0, 0.500000
  mov R1, [BP+4]
  iadd R1, 1
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  fmul R0, 4.000000
  fdiv R0, 9.424778
  mov [BP-13], R0
  mov R0, [BP-9]
  fmul R0, 0.500000
  mov [BP-14], R0
  mov R0, [BP-11]
  mov R1, [BP-2]
  fmul R1, 0.500000
  mov R2, [BP-14]
  mov R3, [BP-14]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-14]
  fmul R2, 2.000000
  mov R3, [BP-13]
  fmul R2, R3
  fadd R1, R2
  fmul R0, R1
  mov [BP-15], R0
  mov R0, [BP-12]
  mov R1, [BP-2]
  fmul R1, 4.000000
  mov R2, [BP-10]
  fadd R1, R2
  fmul R0, R1
  fdiv R0, 12.000000
  mov [BP-16], R0
  mov R0, [BP-15]
  mov R1, [BP-16]
  fadd R0, R1
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
__function_b2ComputeCapsuleMass_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputePolygonMass:
  push BP
  mov BP, SP
  isub SP, 45
__if_9218_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_9218_end
  lea R13, [BP-29]
  mov R12, [BP+2]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-27], R0
  lea R1, [BP-29]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleMass
  jmp __function_b2ComputePolygonMass_return
__if_9218_end:
__if_9244_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_9244_end
  lea R13, [BP-31]
  mov R12, [BP+2]
  mov CR, 2
  movs
  lea R13, [BP-29]
  mov R12, [BP+2]
  iadd R12, 2
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-27], R0
  lea R1, [BP-31]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleMass
  jmp __function_b2ComputePolygonMass_return
__if_9244_end:
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 16
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-17], R0
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-18], R0
__if_9293_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_9293_else
  mov R0, 1.412000
  mov [BP-27], R0
  mov R0, 0
  mov [BP-28], R0
__for_9301_start:
  mov R0, [BP-28]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9301_end
  mov R0, [BP-28]
  isub R0, 1
  mov [BP-29], R0
__if_9316_start:
  mov R0, [BP-28]
  ieq R0, 0
  jf R0, __if_9316_end
  mov R0, [BP-17]
  isub R0, 1
  mov [BP-29], R0
__if_9316_end:
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-29]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-31]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-28]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-33]
  mov CR, 2
  movs
  lea R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R1, [BP+2]
  mov R2, [BP-28]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-27]
  mov R2, [BP-18]
  fmul R1, R2
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  lea R1, [BP-16]
  mov R2, [BP-28]
  imul R2, 2
  iadd R1, R2
  mov [SP+3], R1
  call __function_b2MulAdd
__for_9301_continue:
  mov R0, [BP-28]
  mov R1, R0
  iadd R1, 1
  mov [BP-28], R1
  jmp __for_9301_start
__for_9301_end:
  jmp __if_9293_end
__if_9293_else:
  mov R0, 0
  mov [BP-27], R0
__for_9369_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9369_end
  lea R13, [BP-16]
  mov R1, [BP-27]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+2]
  mov R1, [BP-27]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
__for_9369_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9369_start
__for_9369_end:
__if_9293_end:
  mov R0, 0.000000
  mov [BP-20], R0
  mov R0, 0.000000
  mov [BP-19], R0
  mov R0, 0.000000
  mov [BP-21], R0
  mov R0, 0.000000
  mov [BP-22], R0
  lea R12, [BP-16]
  lea DR, [BP-24]
  mov CR, 2
  movs
  mov R0, 0.333333
  mov [BP-25], R0
  mov R0, 1
  mov [BP-27], R0
__for_9412_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_9412_end
  lea R1, [BP-16]
  mov R2, [BP-27]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-29]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-16]
  mov R2, [BP-27]
  iadd R2, 1
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-31]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-32], R0
  mov R0, [BP-32]
  fmul R0, 0.500000
  mov [BP-33], R0
  mov R0, [BP-21]
  mov R1, [BP-33]
  fadd R0, R1
  mov [BP-21], R0
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-20]
  mov [SP], R1
  mov R1, [BP-33]
  mov R2, [BP-25]
  fmul R1, R2
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  lea R1, [BP-20]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-29]
  mov [BP-36], R0
  mov R0, [BP-28]
  mov [BP-37], R0
  mov R0, [BP-31]
  mov [BP-38], R0
  mov R0, [BP-30]
  mov [BP-39], R0
  mov R0, [BP-36]
  mov R1, [BP-36]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-36]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fadd R0, R1
  mov [BP-40], R0
  mov R0, [BP-37]
  mov R1, [BP-37]
  fmul R0, R1
  mov R1, [BP-39]
  mov R2, [BP-37]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-39]
  mov R2, [BP-39]
  fmul R1, R2
  fadd R0, R1
  mov [BP-41], R0
  mov R0, [BP-22]
  mov R1, [BP-25]
  fmul R1, 0.250000
  mov R2, [BP-32]
  fmul R1, R2
  mov R2, [BP-40]
  mov R3, [BP-41]
  fadd R2, R3
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__for_9412_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9412_start
__for_9412_end:
  mov R0, [BP+3]
  mov R1, [BP-21]
  fmul R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP-21]
  fdiv R0, R1
  mov [BP-26], R0
  mov R0, [BP-20]
  mov R1, [BP-26]
  fmul R0, R1
  mov [BP-20], R0
  mov R0, [BP-19]
  mov R1, [BP-26]
  fmul R0, R1
  mov [BP-19], R0
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [SP+2], R1
  call __function_b2Add
  mov R0, [BP+3]
  mov R1, [BP-22]
  fmul R0, R1
  mov R1, [BP+4]
  iadd R1, 3
  mov [R1], R0
  mov R2, [BP+4]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP+4]
  mov R2, [R3]
  lea R4, [BP-20]
  mov [SP], R4
  lea R4, [BP-20]
  mov [SP+1], R4
  call __function_b2Dot
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R2, [BP+4]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
__function_b2ComputePolygonMass_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCircleFatAABB:
  push BP
  mov BP, SP
  isub SP, 6
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+4]
  fadd R0, R1
  mov [BP-3], R0
  mov R2, [BP-2]
  mov R3, [BP-3]
  fsub R2, R3
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov R3, [BP-3]
  fsub R2, R3
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-2]
  mov R3, [BP-3]
  fadd R2, R3
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-1]
  mov R3, [BP-3]
  fadd R2, R3
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2ComputeCircleFatAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCapsuleFatAABB:
  push BP
  mov BP, SP
  isub SP, 9
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  fadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-2]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_fmin
  mov R2, R0
  mov R3, [BP-5]
  fsub R2, R3
  mov [BP-6], R2
  mov R2, [BP-6]
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  mov [SP], R3
  mov R3, [BP-3]
  mov [SP+1], R3
  call __function_fmin
  mov R2, R0
  mov R3, [BP-5]
  fsub R2, R3
  mov [BP-6], R2
  mov R2, [BP-6]
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-2]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_fmax
  mov R2, R0
  mov R3, [BP-5]
  fadd R2, R3
  mov [BP-6], R2
  mov R2, [BP-6]
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  mov [SP], R3
  mov R3, [BP-3]
  mov [SP+1], R3
  call __function_fmax
  mov R2, R0
  mov R3, [BP-5]
  fadd R2, R3
  mov [BP-6], R2
  mov R2, [BP-6]
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2ComputeCapsuleFatAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputePolygonFatAABB:
  push BP
  mov BP, SP
  isub SP, 11
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
  mov R0, [BP-2]
  mov [BP-5], R0
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-8], R0
__for_9746_start:
  mov R0, [BP-8]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9746_end
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov R2, [BP-8]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-5]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-5], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-6]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-6], R1
  mov R0, R1
__for_9746_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_9746_start
__for_9746_end:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov R1, [BP+4]
  fadd R0, R1
  mov [BP-7], R0
  mov R2, [BP-3]
  mov R3, [BP-7]
  fsub R2, R3
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-4]
  mov R3, [BP-7]
  fsub R2, R3
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-5]
  mov R3, [BP-7]
  fadd R2, R3
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-6]
  mov R3, [BP-7]
  fadd R2, R3
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2ComputePolygonFatAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeSegmentFatAABB:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R3, [BP-2]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_fmin
  mov R2, R0
  mov R3, [BP+4]
  fsub R2, R3
  mov [BP-5], R2
  mov R2, [BP-5]
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  mov [SP], R3
  mov R3, [BP-3]
  mov [SP+1], R3
  call __function_fmin
  mov R2, R0
  mov R3, [BP+4]
  fsub R2, R3
  mov [BP-5], R2
  mov R2, [BP-5]
  mov [SP], R2
  call __function_b2RoundDownFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-2]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_fmax
  mov R2, R0
  mov R3, [BP+4]
  fadd R2, R3
  mov [BP-5], R2
  mov R2, [BP-5]
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  mov [SP], R3
  mov R3, [BP-3]
  mov [SP+1], R3
  call __function_fmax
  mov R2, R0
  mov R3, [BP+4]
  fadd R2, R3
  mov [BP-5], R2
  mov R2, [BP-5]
  mov [SP], R2
  call __function_b2RoundUpFloat
  mov R1, R0
  mov R2, [BP+5]
  iadd R2, 2
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2ComputeSegmentFatAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCircleAABB:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  call __function_b2ComputeCircleFatAABB
__function_b2ComputeCircleAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeCapsuleAABB:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  call __function_b2ComputeCapsuleFatAABB
__function_b2ComputeCapsuleAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputePolygonAABB:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  call __function_b2ComputePolygonFatAABB
__function_b2ComputePolygonAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeSegmentAABB:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  call __function_b2ComputeSegmentFatAABB
__function_b2ComputeSegmentAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2PointInCircle:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  isub SP, 2
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov R4, [BP+2]
  iadd R4, 2
  mov R3, [R4]
  fmul R2, R3
  fle R1, R2
  mov R0, R1
__function_b2PointInCircle_return:
  iadd SP, 2
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2PointInCapsule:
  push BP
  mov BP, SP
  isub SP, 13
  push R1
  push R2
  isub SP, 4
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  fmul R0, R1
  mov [BP-1], R0
  mov R12, [BP+2]
  lea DR, [BP-3]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-5]
  mov CR, 2
  movs
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-7]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_9984_start:
  mov R0, [BP-8]
  feq R0, 0.000000
  jf R0, __if_9984_end
  mov R2, [BP+3]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  mov R2, [BP-1]
  fle R1, R2
  mov R0, R1
  jmp __function_b2PointInCapsule_return
__if_9984_end:
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-10]
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-8]
  fdiv R1, R2
  mov R0, R1
  mov [BP-11], R0
  mov R2, [BP-11]
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-11], R1
  mov R0, R1
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  lea R1, [BP-13]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R2, [BP+3]
  mov [SP], R2
  lea R2, [BP-13]
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  mov R2, [BP-1]
  fle R1, R2
  mov R0, R1
__function_b2PointInCapsule_return:
  iadd SP, 4
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RayCastCircle:
  push BP
  mov BP, SP
  isub SP, 21
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, [BP-5]
  mov R1, [BP-5]
  fmul R0, R1
  mov [BP-6], R0
  lea R1, [BP-7]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
__if_10095_start:
  mov R0, [BP-7]
  feq R0, 0.000000
  jf R0, __if_10095_end
__if_10100_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10100_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10100_end:
  jmp __function_b2RayCastCircle_return
__if_10095_end:
  lea R2, [BP-4]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fsgn R1
  mov R0, R1
  mov [BP-10], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  lea R1, [BP-12]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-13], R0
__if_10142_start:
  mov R0, [BP-13]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __if_10142_end
  jmp __function_b2RayCastCircle_return
__if_10142_end:
  mov R1, [BP-6]
  mov R2, [BP-13]
  fsub R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-14], R0
  mov R0, [BP-10]
  mov R1, [BP-14]
  fsub R0, R1
  mov [BP-15], R0
__if_10158_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10164
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-15]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10164:
  jf R0, __if_10158_end
__if_10170_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10170_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10170_end:
  jmp __function_b2RayCastCircle_return
__if_10158_end:
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  lea R1, [BP-17]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-15]
  mov R1, [BP-7]
  fdiv R0, R1
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  lea R1, [BP-17]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__function_b2RayCastCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2RayCastCapsule:
  push BP
  mov BP, SP
  isub SP, 44
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-4]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-7]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
__if_10276_start:
  mov R0, [BP-7]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_10276_end
  lea R13, [BP-39]
  lea R12, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-37], R0
  lea R1, [BP-39]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __function_b2RayCastCapsule_return
__if_10276_end:
  mov R12, [BP+3]
  lea DR, [BP-11]
  mov CR, 2
  movs
  mov R12, [BP+3]
  iadd R12, 2
  lea DR, [BP-13]
  mov CR, 2
  movs
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-9]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-16], R0
  lea R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-16]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  lea R1, [BP-18]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-19], R0
__if_10340_start:
  lea R2, [BP-18]
  mov [SP], R2
  lea R2, [BP-18]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-19]
  mov R3, [BP-19]
  fmul R2, R3
  flt R1, R2
  mov R0, R1
  jf R0, __if_10340_end
__if_10351_start:
  mov R0, [BP-16]
  flt R0, 0.000000
  jf R0, __if_10351_end
  lea R13, [BP-39]
  lea R12, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-37], R0
  lea R1, [BP-39]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __function_b2RayCastCapsule_return
__if_10351_end:
__if_10373_start:
  mov R0, [BP-16]
  mov R1, [BP-7]
  fgt R0, R1
  jf R0, __if_10373_end
  lea R13, [BP-39]
  lea R12, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-37], R0
  lea R1, [BP-39]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __function_b2RayCastCapsule_return
__if_10373_end:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  jmp __function_b2RayCastCapsule_return
__if_10340_end:
  mov R0, [BP-8]
  mov [BP-21], R0
  mov R0, [BP-9]
  fsgn R0
  mov [BP-20], R0
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  mov R0, [BP-9]
  fsgn R0
  mov R1, [BP-23]
  fmul R0, R1
  mov R1, [BP-24]
  mov R2, [BP-8]
  fmul R1, R2
  fadd R0, R1
  mov [BP-25], R0
__if_10443_start:
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  fsgn R0
  mov R1, [BP-25]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_10452
  mov R1, [BP-25]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_10452:
  jf R0, __if_10443_end
  jmp __function_b2RayCastCapsule_return
__if_10443_end:
  lea R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  lea R1, [BP-27]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  lea R1, [BP-29]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, 1.000000
  mov R1, [BP-25]
  fdiv R0, R1
  mov [BP-30], R0
  mov R0, [BP-9]
  mov R1, [BP-26]
  fmul R0, R1
  mov R1, [BP-27]
  mov R2, [BP-8]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP-30]
  fmul R0, R1
  mov [BP-31], R0
  mov R0, [BP-9]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-29]
  mov R2, [BP-8]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP-30]
  fmul R0, R1
  mov [BP-32], R0
__if_10520_start:
  mov R0, [BP-31]
  mov R1, [BP-32]
  flt R0, R1
  jf R0, __if_10520_else
  mov R0, [BP-31]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-27]
  mov CR, 2
  movs
  jmp __if_10520_end
__if_10520_else:
  mov R0, [BP-32]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-29]
  mov CR, 2
  movs
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  call __function_b2Neg
__if_10520_end:
__if_10543_start:
  mov R0, [BP-33]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10549
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-22]
  fmul R1, R2
  mov R2, [BP-33]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10549:
  jf R0, __if_10543_end
  jmp __function_b2RayCastCapsule_return
__if_10543_end:
  mov R0, [BP-35]
  fsgn R0
  mov R1, [BP-23]
  fmul R0, R1
  mov R1, [BP-24]
  mov R2, [BP-34]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-30]
  fmul R0, R1
  mov [BP-36], R0
__if_10572_start:
  mov R0, [BP-36]
  flt R0, 0.000000
  jf R0, __if_10572_else
  lea R13, [BP-39]
  lea R12, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-37], R0
  lea R1, [BP-39]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __function_b2RayCastCapsule_return
  jmp __if_10572_end
__if_10572_else:
__if_10594_start:
  mov R0, [BP-7]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __if_10594_else
  lea R13, [BP-39]
  lea R12, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-37], R0
  lea R1, [BP-39]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __function_b2RayCastCapsule_return
  jmp __if_10594_end
__if_10594_else:
  mov R0, [BP-33]
  mov R1, [BP-22]
  fdiv R0, R1
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP-36]
  mov R2, [BP-7]
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-38]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-38]
  mov [SP], R1
  lea R1, [BP-40]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2Add
  mov R13, [BP+4]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10594_end:
__if_10572_end:
__function_b2RayCastCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2RayCastSegment:
  push BP
  mov BP, SP
  isub SP, 33
  mov R13, [BP+5]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+5]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+5]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 6
  mov [R1], R0
__if_10685_start:
  mov R0, [BP+4]
  jf R0, __if_10685_end
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-27]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-29]
  mov [SP+2], R1
  call __function_b2Sub
__if_10710_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-29]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_10710_end
  jmp __function_b2RayCastSegment_return
__if_10710_end:
__if_10685_end:
  mov R12, [BP+3]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+3]
  iadd R12, 2
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R12, [BP+2]
  lea DR, [BP-6]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-8]
  mov CR, 2
  movs
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
__if_10755_start:
  mov R0, [BP-11]
  feq R0, 0.000000
  jf R0, __if_10755_end
  jmp __function_b2RayCastSegment_return
__if_10755_end:
  lea R1, [BP-13]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2RightPerp
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-18], R0
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-19], R0
__if_10790_start:
  mov R0, [BP-19]
  feq R0, 0.000000
  jf R0, __if_10790_end
  jmp __function_b2RayCastSegment_return
__if_10790_end:
  mov R0, [BP-18]
  mov R1, [BP-19]
  fdiv R0, R1
  mov [BP-20], R0
__if_10800_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10806
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-20]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10806:
  jf R0, __if_10800_end
  jmp __function_b2RayCastSegment_return
__if_10800_end:
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-20]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  lea R1, [BP-22]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-25], R0
__if_10836_start:
  mov R0, [BP-25]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10841
  mov R1, [BP-11]
  mov R2, [BP-25]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10841:
  jf R0, __if_10836_end
  jmp __function_b2RayCastSegment_return
__if_10836_end:
__if_10845_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_10845_end
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Neg
__if_10845_end:
  mov R0, [BP-20]
  mov R1, [BP+5]
  iadd R1, 4
  mov [R1], R0
  mov R13, [BP+5]
  iadd R13, 2
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R13, [BP+5]
  lea R12, [BP-15]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 6
  mov [R1], R0
__function_b2RayCastSegment_return:
  mov SP, BP
  pop BP
  ret

__function_b2RayCastPolygon:
  push BP
  mov BP, SP
  isub SP, 58
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10894_start:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  fne R0, 0.000000
  jf R0, __if_10894_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-54]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-36]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-18]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  lea R13, [BP-14]
  mov R12, [BP+3]
  iadd R12, 2
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, 0
  mov [BP-11], R0
  lea R1, [BP-54]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2ShapeCast
  jmp __function_b2RayCastPolygon_return
__if_10894_end:
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, [BP+3]
  iadd R12, 2
  lea DR, [BP-6]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-7], R0
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-8], R0
  mov R0, -1
  mov [BP-9], R0
  mov R0, 0
  mov [BP-10], R0
__for_10977_start:
  mov R0, [BP-10]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_10977_end
  mov R12, [BP+2]
  mov R1, [BP-10]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-12]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-10]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-14]
  mov CR, 2
  movs
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-19], R0
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-20], R0
__if_11032_start:
  mov R0, [BP-20]
  feq R0, 0.000000
  jf R0, __if_11032_else
__if_11037_start:
  mov R0, [BP-19]
  flt R0, 0.000000
  jf R0, __if_11037_end
  jmp __function_b2RayCastPolygon_return
__if_11037_end:
  jmp __if_11032_end
__if_11032_else:
__if_11043_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11048
  mov R1, [BP-19]
  mov R2, [BP-7]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11048:
  jf R0, __if_11043_else
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-10]
  mov [BP-9], R0
  jmp __if_11043_end
__if_11043_else:
__if_11062_start:
  mov R0, [BP-20]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11067
  mov R1, [BP-19]
  mov R2, [BP-8]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11067:
  jf R0, __if_11062_end
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-8], R0
__if_11062_end:
__if_11043_end:
__if_11032_end:
__if_11078_start:
  mov R0, [BP-8]
  mov R1, [BP-7]
  flt R0, R1
  jf R0, __if_11078_end
  jmp __function_b2RayCastPolygon_return
__if_11078_end:
__for_10977_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_10977_start
__for_10977_end:
__if_11083_start:
  mov R0, [BP-9]
  ige R0, 0
  jf R0, __if_11083_else
  mov R0, [BP-7]
  mov R1, [BP+4]
  iadd R1, 4
  mov [R1], R0
  mov R13, [BP+4]
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-9]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  jmp __if_11083_end
__if_11083_else:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_11083_end:
__function_b2RayCastPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastCircle:
  push BP
  mov BP, SP
  isub SP, 48
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-44]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-26]
  mov R12, [BP+3]
  mov CR, 18
  movs
  lea R13, [BP-8]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  lea R13, [BP-4]
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-44]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2ShapeCast
__function_b2ShapeCastCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastCapsule:
  push BP
  mov BP, SP
  isub SP, 48
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-44]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-26]
  mov R12, [BP+3]
  mov CR, 18
  movs
  lea R13, [BP-8]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  lea R13, [BP-4]
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-44]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2ShapeCast
__function_b2ShapeCastCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastSegment:
  push BP
  mov BP, SP
  isub SP, 48
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-44]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-26]
  mov R12, [BP+3]
  mov CR, 18
  movs
  lea R13, [BP-8]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  lea R13, [BP-4]
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-44]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2ShapeCast
__function_b2ShapeCastSegment_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastPolygon:
  push BP
  mov BP, SP
  isub SP, 48
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-44]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-26]
  mov R12, [BP+3]
  mov CR, 18
  movs
  lea R13, [BP-8]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  lea R13, [BP-4]
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-44]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2ShapeCast
__function_b2ShapeCastPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideMoverAndCircle:
  push BP
  mov BP, SP
  isub SP, 62
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-41]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-5]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fadd R0, R1
  mov [BP-42], R0
  mov R0, 0
  mov [BP-49], R0
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_11371_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11371_end
  mov R13, [BP+4]
  lea R12, [BP-54]
  mov CR, 2
  movs
  mov R0, [BP-42]
  mov R1, [BP-52]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
__if_11371_end:
__function_b2CollideMoverAndCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideMoverAndCapsule:
  push BP
  mov BP, SP
  isub SP, 62
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-41]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-5]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  fadd R0, R1
  mov [BP-42], R0
  mov R0, 0
  mov [BP-49], R0
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_11473_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11473_end
  mov R13, [BP+4]
  lea R12, [BP-54]
  mov CR, 2
  movs
  mov R0, [BP-42]
  mov R1, [BP-52]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
__if_11473_end:
__function_b2CollideMoverAndCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideMoverAndPolygon:
  push BP
  mov BP, SP
  isub SP, 62
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-41]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-5]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 34
  mov R1, [R2]
  fadd R0, R1
  mov [BP-42], R0
  mov R0, 0
  mov [BP-49], R0
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_11576_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11576_end
  mov R13, [BP+4]
  lea R12, [BP-54]
  mov CR, 2
  movs
  mov R0, [BP-42]
  mov R1, [BP-52]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
__if_11576_end:
__function_b2CollideMoverAndPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideMoverAndSegment:
  push BP
  mov BP, SP
  isub SP, 62
  mov R13, [BP+4]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-41]
  mov [SP+3], R1
  call __function_b2MakeProxy
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-5]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-42], R0
  mov R0, 0
  mov [BP-49], R0
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_11675_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11675_end
  mov R13, [BP+4]
  lea R12, [BP-54]
  mov CR, 2
  movs
  mov R0, [BP-42]
  mov R1, [BP-52]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 3
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 5
  mov [R1], R0
__if_11675_end:
__function_b2CollideMoverAndSegment_return:
  mov SP, BP
  pop BP
  ret

__function_b2RecurseHull:
  push BP
  mov BP, SP
  isub SP, 68
  mov R0, 0
  mov R1, [BP+6]
  iadd R1, 16
  mov [R1], R0
__if_11720_start:
  mov R0, [BP+5]
  ieq R0, 0
  jf R0, __if_11720_end
  jmp __function_b2RecurseHull_return
__if_11720_end:
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R0, 0
  mov [BP-21], R0
  mov R0, 0
  mov [BP-22], R0
  mov R1, [BP+4]
  mov R2, [BP-22]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-25], R0
__if_11765_start:
  mov R0, [BP-25]
  fgt R0, 0.000000
  jf R0, __if_11765_end
  lea R13, [BP-20]
  mov R1, [BP-21]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+4]
  mov R1, [BP-22]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-21]
  mov R1, R0
  iadd R1, 1
  mov [BP-21], R1
__if_11765_end:
  mov R0, 1
  mov [BP-62], R0
__for_11779_start:
  mov R0, [BP-62]
  mov R1, [BP+5]
  ilt R0, R1
  jf R0, __for_11779_end
  mov R1, [BP+4]
  mov R2, [BP-62]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-63], R0
__if_11804_start:
  mov R0, [BP-63]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_11804_end
  mov R0, [BP-62]
  mov [BP-22], R0
  mov R0, [BP-63]
  mov [BP-25], R0
__if_11804_end:
__if_11815_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_11815_end
  lea R13, [BP-20]
  mov R1, [BP-21]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+4]
  mov R1, [BP-62]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-21]
  mov R1, R0
  iadd R1, 1
  mov [BP-21], R1
__if_11815_end:
__for_11779_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11779_start
__for_11779_end:
__if_11829_start:
  mov R1, [BP-25]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 2.000000
  flt R1, R2
  mov R0, R1
  jf R0, __if_11829_end
  jmp __function_b2RecurseHull_return
__if_11829_end:
  mov R12, [BP+4]
  mov R1, [BP-22]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-27]
  mov CR, 2
  movs
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  mov R1, [BP-21]
  mov [SP+3], R1
  lea R1, [BP-44]
  mov [SP+4], R1
  call __function_b2RecurseHull
  lea R1, [BP-27]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  mov R1, [BP-21]
  mov [SP+3], R1
  lea R1, [BP-61]
  mov [SP+4], R1
  call __function_b2RecurseHull
  mov R0, 0
  mov [BP-62], R0
__for_11864_start:
  mov R0, [BP-62]
  mov R1, [BP-28]
  ilt R0, R1
  jf R0, __for_11864_end
  mov R13, [BP+6]
  mov R2, [BP+6]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-44]
  mov R1, [BP-62]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R2, [BP+6]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_11864_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11864_start
__for_11864_end:
  mov R13, [BP+6]
  mov R2, [BP+6]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-27]
  mov CR, 2
  movs
  mov R2, [BP+6]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, 0
  mov [BP-62], R0
__for_11898_start:
  mov R0, [BP-62]
  mov R1, [BP-45]
  ilt R0, R1
  jf R0, __for_11898_end
  mov R13, [BP+6]
  mov R2, [BP+6]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-61]
  mov R1, [BP-62]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R2, [BP+6]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_11898_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11898_start
__for_11898_end:
__function_b2RecurseHull_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideCircles:
  push BP
  mov BP, SP
  isub SP, 21
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-7]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-11], R0
  mov R0, [BP-7]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-11]
  fsub R0, R1
  mov [BP-12], R0
__if_12813_start:
  mov R1, [BP-12]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_12813_end
  jmp __function_b2CollideCircles_return
__if_12813_end:
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  lea R1, [BP-14]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-11]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  lea R1, [BP-16]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-9]
  mov CR, 2
  movs
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-17], R0
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-12]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-17]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__function_b2CollideCircles_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideCapsuleAndCircle:
  push BP
  mov BP, SP
  isub SP, 34
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R12, [BP+2]
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-6]
  mov CR, 2
  movs
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-11], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-13]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-14], R0
__if_12946_start:
  mov R0, [BP-11]
  flt R0, 0.000000
  jf R0, __if_12946_else
  lea R13, [BP-16]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_12946_end
__if_12946_else:
__if_12954_start:
  mov R0, [BP-14]
  flt R0, 0.000000
  jf R0, __if_12954_else
  lea R13, [BP-16]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_12954_end
__if_12954_else:
  mov R1, [BP-11]
  lea R3, [BP-8]
  mov [SP], R3
  lea R3, [BP-8]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  fdiv R1, R2
  mov R0, R1
  mov [BP-30], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  lea R1, [BP-16]
  mov [SP+3], R1
  call __function_b2MulAdd
__if_12954_end:
__if_12946_end:
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-22], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-23], R0
  mov R0, [BP-19]
  mov R1, [BP-22]
  fsub R0, R1
  mov R1, [BP-23]
  fsub R0, R1
  mov [BP-24], R0
__if_13015_start:
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_13015_end
  jmp __function_b2CollideCapsuleAndCircle_return
__if_13015_end:
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  lea R1, [BP-26]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-23]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  lea R1, [BP-28]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-29], R0
  lea R1, [BP-26]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-29]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-24]
  mov R1, [BP-29]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-29]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__function_b2CollideCapsuleAndCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollidePolygonAndCircle:
  push BP
  mov BP, SP
  isub SP, 41
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, [BP-4]
  mov R1, [BP-5]
  fadd R0, R1
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-8], R0
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-9], R0
  mov R0, 0
  mov [BP-10], R0
__for_13135_start:
  mov R0, [BP-10]
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __for_13135_end
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+2]
  mov R2, [BP-10]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 16
  mov R2, [BP-10]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-29], R0
__if_13167_start:
  mov R0, [BP-29]
  mov R1, [BP-8]
  fgt R0, R1
  jf R0, __if_13167_end
  mov R0, [BP-29]
  mov [BP-8], R0
  mov R0, [BP-10]
  mov [BP-7], R0
__if_13167_end:
__for_13135_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_13135_start
__for_13135_end:
__if_13178_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13178_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13178_end:
  mov R0, [BP-7]
  mov [BP-11], R0
__if_13190_start:
  mov R0, [BP-11]
  iadd R0, 1
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __if_13190_else
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-12], R0
  jmp __if_13190_end
__if_13190_else:
  mov R0, 0
  mov [BP-12], R0
__if_13190_end:
  mov R12, [BP+2]
  mov R1, [BP-11]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-14]
  mov CR, 2
  movs
  mov R12, [BP+2]
  mov R1, [BP-12]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-16]
  mov CR, 2
  movs
  lea R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-21], R0
  lea R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-23]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-26], R0
__if_13266_start:
  mov R0, [BP-21]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13271
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13271:
  jf R0, __if_13266_else
  lea R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R2, [BP-28]
  mov [SP], R2
  lea R2, [BP-30]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-8], R1
  mov R0, R1
__if_13301_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13301_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13301_end:
  lea R1, [BP-14]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  lea R1, [BP-32]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  lea R1, [BP-34]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP+5]
  lea R12, [BP-30]
  mov CR, 2
  movs
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-35], R0
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-35]
  mov [SP+3], R1
  call __function_b2Lerp
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-37]
  mov [SP], R2
  lea R2, [BP-30]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-35]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R0, 0
  mov R1, [BP-35]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  jmp __if_13266_end
__if_13266_else:
__if_13373_start:
  mov R0, [BP-26]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13378
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13378:
  jf R0, __if_13373_else
  lea R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R2, [BP-28]
  mov [SP], R2
  lea R2, [BP-30]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-8], R1
  mov R0, R1
__if_13408_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13408_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13408_end:
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  lea R1, [BP-32]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  lea R1, [BP-34]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP+5]
  lea R12, [BP-30]
  mov CR, 2
  movs
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-35], R0
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-35]
  mov [SP+3], R1
  call __function_b2Lerp
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-37]
  mov [SP], R2
  lea R2, [BP-30]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-35]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R0, 0
  mov R1, [BP-35]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  jmp __if_13373_end
__if_13373_else:
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-7]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-28]
  mov CR, 2
  movs
  mov R13, [BP+5]
  lea R12, [BP-28]
  mov CR, 2
  movs
  lea R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-4]
  lea R3, [BP-30]
  mov [SP], R3
  lea R3, [BP-28]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  fsub R1, R2
  mov R0, R1
  mov [BP-31], R0
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  lea R1, [BP-33]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  lea R1, [BP-35]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-36], R0
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-36]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-8]
  mov R1, [BP-6]
  fsub R0, R1
  mov R1, [BP-36]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-36]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_13373_end:
__if_13266_end:
__function_b2CollidePolygonAndCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideCapsules:
  push BP
  mov BP, SP
  isub SP, 70
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  lea R13, [BP-4]
  mov R12, [BP+4]
  iadd R12, 2
  mov CR, 2
  movs
  mov R12, global_b2Vec2_zero
  lea DR, [BP-8]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-19], R0
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-20], R0
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R0, R1
  mov [BP-21], R0
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-23]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-24], R0
  lea R1, [BP-23]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-25], R0
  lea R1, [BP-16]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-26], R0
  mov R0, [BP-19]
  mov R1, [BP-20]
  fmul R0, R1
  mov R1, [BP-26]
  mov R2, [BP-26]
  fmul R1, R2
  fsub R0, R1
  mov [BP-27], R0
  mov R0, 0.000000
  mov [BP-28], R0
__if_13706_start:
  mov R0, [BP-27]
  fne R0, 0.000000
  jf R0, __if_13706_end
  mov R2, [BP-26]
  mov R3, [BP-25]
  fmul R2, R3
  mov R3, [BP-24]
  mov R4, [BP-20]
  fmul R3, R4
  fsub R2, R3
  mov R3, [BP-27]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-28], R1
  mov R0, R1
__if_13706_end:
  mov R0, [BP-26]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-25]
  fadd R0, R1
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-29], R0
__if_13735_start:
  mov R0, [BP-29]
  flt R0, 0.000000
  jf R0, __if_13735_else
  mov R0, 0.000000
  mov [BP-29], R0
  mov R2, [BP-24]
  fsgn R2
  mov R3, [BP-19]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-28], R1
  mov R0, R1
  jmp __if_13735_end
__if_13735_else:
__if_13752_start:
  mov R0, [BP-29]
  fgt R0, 1.000000
  jf R0, __if_13752_end
  mov R0, 1.000000
  mov [BP-29], R0
  mov R2, [BP-26]
  mov R3, [BP-24]
  fsub R2, R3
  mov R3, [BP-19]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-28], R1
  mov R0, R1
__if_13752_end:
__if_13735_end:
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, [BP-28]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  lea R1, [BP-31]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  lea R1, [BP-33]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-34], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-35], R0
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-36], R0
  mov R0, [BP-35]
  mov R1, [BP-36]
  fadd R0, R1
  mov [BP-37], R0
  mov R1, [BP-37]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fadd R1, R2
  mov R0, R1
  mov [BP-38], R0
__if_13822_start:
  mov R0, [BP-34]
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fgt R0, R1
  jf R0, __if_13822_end
  jmp __function_b2CollideCapsules_return
__if_13822_end:
  mov R1, [BP-34]
  mov [SP], R1
  call __function_sqrt
  mov [BP-39], R0
  lea R1, [BP-40]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-49], R0
  mov R0, [BP-48]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13891
  mov R1, [BP-49]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13891:
  jt R0, __LogicalOr_ShortCircuit_13894
  mov R1, [BP-48]
  mov R2, [BP-40]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_13900
  mov R2, [BP-49]
  mov R3, [BP-40]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_13900:
  or R0, R1
__LogicalOr_ShortCircuit_13894:
  mov [BP-50], R0
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-51], R0
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-52], R0
  mov R0, [BP-51]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13938
  mov R1, [BP-52]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13938:
  jt R0, __LogicalOr_ShortCircuit_13941
  mov R1, [BP-51]
  mov R2, [BP-41]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_13947
  mov R2, [BP-52]
  mov R3, [BP-41]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_13947:
  or R0, R1
__LogicalOr_ShortCircuit_13941:
  mov [BP-53], R0
__if_13950_start:
  mov R0, [BP-50]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_13955
  mov R1, [BP-53]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_13955:
  jf R0, __if_13950_end
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-60], R0
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-61], R0
  mov R1, [BP-60]
  mov [SP], R1
  mov R1, [BP-61]
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-62], R0
  mov R1, [BP-60]
  fsgn R1
  mov [SP], R1
  mov R1, [BP-61]
  fsgn R1
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-63], R0
__if_14009_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14009_else
  mov R0, [BP-62]
  mov [BP-56], R0
  jmp __if_14009_end
__if_14009_else:
  mov R0, [BP-63]
  mov [BP-56], R0
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Neg
__if_14009_end:
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-60], R0
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-61], R0
  mov R1, [BP-60]
  mov [SP], R1
  mov R1, [BP-61]
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-62], R0
  mov R1, [BP-60]
  fsgn R1
  mov [SP], R1
  mov R1, [BP-61]
  fsgn R1
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-63], R0
__if_14076_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14076_else
  mov R0, [BP-62]
  mov [BP-59], R0
  jmp __if_14076_end
__if_14076_else:
  mov R0, [BP-63]
  mov [BP-59], R0
  lea R1, [BP-58]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Neg
__if_14076_end:
__if_14093_start:
  mov R1, [BP-56]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 0.100000
  fadd R1, R2
  mov R2, [BP-59]
  fge R1, R2
  mov R0, R1
  jf R0, __if_14093_else
  mov R13, [BP+5]
  lea R12, [BP-55]
  mov CR, 2
  movs
  lea R12, [BP-12]
  lea DR, [BP-61]
  mov CR, 2
  movs
  lea R12, [BP-14]
  lea DR, [BP-63]
  mov CR, 2
  movs
__if_14115_start:
  mov R0, [BP-48]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14120
  mov R1, [BP-49]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14120:
  jf R0, __if_14115_else
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-48]
  fsgn R1
  fadd R1, 0.000000
  mov R2, [BP-49]
  mov R3, [BP-48]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_14115_end
__if_14115_else:
__if_14139_start:
  mov R0, [BP-49]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14144
  mov R1, [BP-48]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14144:
  jf R0, __if_14139_end
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-49]
  fsgn R1
  fadd R1, 0.000000
  mov R2, [BP-48]
  mov R3, [BP-49]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2Lerp
__if_14139_end:
__if_14115_end:
__if_14163_start:
  mov R0, [BP-48]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14168
  mov R1, [BP-49]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14168:
  jf R0, __if_14163_else
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-48]
  mov R2, [BP-40]
  fsub R1, R2
  mov R2, [BP-48]
  mov R3, [BP-49]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_14163_end
__if_14163_else:
__if_14187_start:
  mov R0, [BP-49]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14192
  mov R1, [BP-48]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14192:
  jf R0, __if_14187_end
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-49]
  mov R2, [BP-40]
  fsub R1, R2
  mov R2, [BP-49]
  mov R3, [BP-48]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2Lerp
__if_14187_end:
__if_14163_end:
  lea R1, [BP-61]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-64], R0
  lea R1, [BP-63]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-65], R0
__if_14239_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14249
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14249:
  mov R0, R1
  jf R0, __if_14239_end
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-66], R0
  lea R1, [BP-61]
  mov [SP], R1
  mov R1, [BP-35]
  mov R2, [BP-36]
  fsub R1, R2
  mov R2, [BP-64]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  mov R1, [BP-66]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-64]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-66]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-66]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+5]
  iadd R0, 2
  iadd R0, 4
  mov [BP-66], R0
  lea R1, [BP-63]
  mov [SP], R1
  mov R1, [BP-35]
  mov R2, [BP-36]
  fsub R1, R2
  mov R2, [BP-65]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  mov R1, [BP-66]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-65]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-66]
  iadd R1, 2
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-66]
  iadd R1, 3
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_14239_end:
  jmp __if_14093_end
__if_14093_else:
  lea R1, [BP-58]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_b2Neg
  lea R12, [BP-8]
  lea DR, [BP-61]
  mov CR, 2
  movs
  lea R12, [BP-10]
  lea DR, [BP-63]
  mov CR, 2
  movs
__if_14371_start:
  mov R0, [BP-51]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14376
  mov R1, [BP-52]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14376:
  jf R0, __if_14371_else
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP-51]
  fsgn R1
  fadd R1, 0.000000
  mov R2, [BP-52]
  mov R3, [BP-51]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_14371_end
__if_14371_else:
__if_14395_start:
  mov R0, [BP-52]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14400
  mov R1, [BP-51]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14400:
  jf R0, __if_14395_end
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP-52]
  fsgn R1
  fadd R1, 0.000000
  mov R2, [BP-51]
  mov R3, [BP-52]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2Lerp
__if_14395_end:
__if_14371_end:
__if_14419_start:
  mov R0, [BP-51]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14424
  mov R1, [BP-52]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14424:
  jf R0, __if_14419_else
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP-51]
  mov R2, [BP-41]
  fsub R1, R2
  mov R2, [BP-51]
  mov R3, [BP-52]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_14419_end
__if_14419_else:
__if_14443_start:
  mov R0, [BP-52]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14448
  mov R1, [BP-51]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14448:
  jf R0, __if_14443_end
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP-52]
  mov R2, [BP-41]
  fsub R1, R2
  mov R2, [BP-52]
  mov R3, [BP-51]
  fsub R2, R3
  fdiv R1, R2
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2Lerp
__if_14443_end:
__if_14419_end:
  lea R1, [BP-61]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-64], R0
  lea R1, [BP-63]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-65], R0
__if_14495_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14505
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14505:
  mov R0, R1
  jf R0, __if_14495_end
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-66], R0
  lea R1, [BP-61]
  mov [SP], R1
  mov R1, [BP-36]
  mov R2, [BP-35]
  fsub R1, R2
  mov R2, [BP-64]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  mov R1, [BP-66]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-64]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-66]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-66]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+5]
  iadd R0, 2
  iadd R0, 4
  mov [BP-66], R0
  lea R1, [BP-63]
  mov [SP], R1
  mov R1, [BP-36]
  mov R2, [BP-35]
  fsub R1, R2
  mov R2, [BP-65]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  mov R1, [BP-66]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP-65]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-66]
  iadd R1, 2
  mov [R1], R0
  mov R0, 256
  mov R1, [BP-66]
  iadd R1, 3
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_14495_end:
__if_14093_end:
__if_13950_end:
__if_14614_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_14614_end
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
__if_14629_start:
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-21]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_14629_else
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Normalize
  jmp __if_14629_end
__if_14629_else:
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
__if_14629_end:
  lea R1, [BP-31]
  mov [SP], R1
  mov R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-57]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-33]
  mov [SP], R1
  mov R1, [BP-36]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-59]
  mov [SP+3], R1
  call __function_b2MulAdd
__if_14670_start:
  mov R0, [BP-28]
  feq R0, 0.000000
  jf R0, __if_14670_else
  mov R0, 0
  mov [BP-60], R0
  jmp __if_14670_end
__if_14670_else:
  mov R0, 1
  mov [BP-60], R0
__if_14670_end:
__if_14682_start:
  mov R0, [BP-29]
  feq R0, 0.000000
  jf R0, __if_14682_else
  mov R0, 0
  mov [BP-61], R0
  jmp __if_14682_end
__if_14682_else:
  mov R0, 1
  mov [BP-61], R0
__if_14682_end:
  mov R13, [BP+5]
  lea R12, [BP-55]
  mov CR, 2
  movs
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-62], R0
  lea R1, [BP-57]
  mov [SP], R1
  lea R1, [BP-59]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP-62]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R2, [BP-34]
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov R2, [BP-37]
  fsub R1, R2
  mov R2, [BP-62]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-60]
  and R0, 255
  shl R0, 8
  mov R1, [BP-61]
  and R1, 255
  or R0, R1
  mov R1, [BP-62]
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_14614_end:
__if_14741_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_14741_end
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-54], R0
  mov R1, [BP-54]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-54]
  mov [SP+2], R1
  call __function_b2Add
__if_14741_end:
__if_14763_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_14763_end
  mov R0, [BP+5]
  iadd R0, 2
  iadd R0, 4
  mov [BP-54], R0
  mov R1, [BP-54]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-54]
  mov [SP+2], R1
  call __function_b2Add
__if_14763_end:
__function_b2CollideCapsules_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideSegmentAndCircle:
  push BP
  mov BP, SP
  isub SP, 9
  lea R13, [BP-5]
  mov R12, [BP+2]
  mov CR, 2
  movs
  lea R13, [BP-3]
  mov R12, [BP+2]
  iadd R12, 2
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-1], R0
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsuleAndCircle
__function_b2CollideSegmentAndCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideSegmentAndCapsule:
  push BP
  mov BP, SP
  isub SP, 9
  lea R13, [BP-5]
  mov R12, [BP+2]
  mov CR, 2
  movs
  lea R13, [BP-3]
  mov R12, [BP+2]
  iadd R12, 2
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-1], R0
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsules
__function_b2CollideSegmentAndCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideChainSegmentAndCircle:
  push BP
  mov BP, SP
  isub SP, 41
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  iadd R12, 2
  lea DR, [BP-6]
  mov CR, 2
  movs
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2RightPerp
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-13], R0
__if_14899_start:
  mov R0, [BP-13]
  flt R0, 0.000000
  jf R0, __if_14899_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14899_end:
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-16], R0
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-17], R0
__if_14929_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __if_14929_else
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-35], R0
__if_14951_start:
  mov R0, [BP-35]
  fle R0, 0.000000
  jf R0, __if_14951_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14951_end:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_14929_end
__if_14929_else:
__if_14959_start:
  mov R0, [BP-16]
  fle R0, 0.000000
  jf R0, __if_14959_else
  mov R1, [BP+2]
  iadd R1, 6
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-36]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-37], R0
__if_14990_start:
  mov R0, [BP-37]
  fgt R0, 0.000000
  jf R0, __if_14990_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14990_end:
  lea R13, [BP-19]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_14959_end
__if_14959_else:
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-33], R0
  mov R0, [BP-16]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP-17]
  mov R2, [BP-6]
  fmul R1, R2
  fadd R0, R1
  mov [BP-35], R0
  mov R0, [BP-16]
  mov R1, [BP-3]
  fmul R0, R1
  mov R1, [BP-17]
  mov R2, [BP-5]
  fmul R1, R2
  fadd R0, R1
  mov [BP-34], R0
__if_15032_start:
  mov R0, [BP-33]
  fgt R0, 0.000000
  jf R0, __if_15032_else
  mov R1, 1.000000
  mov R2, [BP-33]
  fdiv R1, R2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_15032_end
__if_15032_else:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
__if_15032_end:
__if_14959_end:
__if_14929_end:
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2GetLengthAndNormalize
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-25], R0
  mov R0, [BP-20]
  mov R1, [BP-25]
  fsub R0, R1
  mov [BP-26], R0
__if_15076_start:
  mov R1, [BP-26]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_15076_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15076_end:
  lea R12, [BP-19]
  lea DR, [BP-28]
  mov CR, 2
  movs
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-25]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  lea R1, [BP-30]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-24]
  mov CR, 2
  movs
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  lea R1, [BP-32]
  mov [SP+3], R1
  call __function_b2Lerp
  mov R13, [BP+5]
  iadd R13, 2
  lea R12, [BP-32]
  mov CR, 2
  movs
  mov R0, [BP-26]
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__function_b2CollideChainSegmentAndCircle_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeCapsulePolygon:
  push BP
  mov BP, SP
  isub SP, 10
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 36
  mov [SP+2], R1
  call __function_memset
  mov R13, [BP+5]
  lea R12, [BP+2]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R13, [BP+5]
  iadd R13, 2
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+5]
  iadd R1, 32
  mov [SP+3], R1
  call __function_b2Lerp
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2RightPerp
  mov R13, [BP+5]
  iadd R13, 16
  lea R12, [BP-6]
  mov CR, 2
  movs
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+5]
  iadd R1, 16
  iadd R1, 2
  mov [SP+1], R1
  call __function_b2Neg
  mov R0, 2
  mov R1, [BP+5]
  iadd R1, 35
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP+5]
  iadd R1, 34
  mov [R1], R0
__function_b2MakeCapsulePolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2FindMaxSeparation:
  push BP
  mov BP, SP
  isub SP, 14
  push R1
  push R2
  push R3
  mov R1, [BP+3]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+4]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-4], R0
  mov R0, 0
  mov [BP-5], R0
__for_15237_start:
  mov R0, [BP-5]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_15237_end
  mov R12, [BP+3]
  iadd R12, 16
  mov R1, [BP-5]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-7]
  mov CR, 2
  movs
  mov R12, [BP+3]
  mov R1, [BP-5]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-9]
  mov CR, 2
  movs
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-10], R0
  mov R0, 0
  mov [BP-11], R0
__for_15267_start:
  mov R0, [BP-11]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_15267_end
  mov R12, [BP+4]
  mov R1, [BP-11]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, [BP-7]
  mov R1, [BP-13]
  mov R2, [BP-9]
  fsub R1, R2
  fmul R0, R1
  mov R1, [BP-6]
  mov R2, [BP-12]
  mov R3, [BP-8]
  fsub R2, R3
  fmul R1, R2
  fadd R0, R1
  mov [BP-14], R0
__if_15304_start:
  mov R0, [BP-14]
  mov R1, [BP-10]
  flt R0, R1
  jf R0, __if_15304_end
  mov R0, [BP-14]
  mov [BP-10], R0
__if_15304_end:
__for_15267_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_15267_start
__for_15267_end:
__if_15311_start:
  mov R0, [BP-10]
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_15311_end
  mov R0, [BP-10]
  mov [BP-4], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_15311_end:
__for_15237_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_15237_start
__for_15237_end:
  mov R0, [BP-3]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-4]
__function_b2FindMaxSeparation_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ClipPolygons:
  push BP
  mov BP, SP
  isub SP, 38
  mov R0, 0
  mov R1, [BP+7]
  iadd R1, 10
  mov [R1], R0
__if_15349_start:
  mov R0, [BP+6]
  jf R0, __if_15349_else
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+2]
  mov [BP-4], R0
  mov R0, [BP+5]
  mov [BP-2], R0
__if_15361_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15361_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15361_end
__if_15361_else:
  mov R0, 0
  mov [BP-3], R0
__if_15361_end:
  mov R0, [BP+4]
  mov [BP-5], R0
__if_15379_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15379_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15379_end
__if_15379_else:
  mov R0, 0
  mov [BP-6], R0
__if_15379_end:
  jmp __if_15349_end
__if_15349_else:
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-4], R0
  mov R0, [BP+4]
  mov [BP-2], R0
__if_15404_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15404_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15404_end
__if_15404_else:
  mov R0, 0
  mov [BP-3], R0
__if_15404_end:
  mov R0, [BP+5]
  mov [BP-5], R0
__if_15422_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15422_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15422_end
__if_15422_else:
  mov R0, 0
  mov [BP-6], R0
__if_15422_end:
__if_15349_end:
  mov R12, [BP-1]
  iadd R12, 16
  mov R1, [BP-2]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-8]
  mov CR, 2
  movs
  mov R12, [BP-1]
  mov R1, [BP-2]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-10]
  mov CR, 2
  movs
  mov R12, [BP-1]
  mov R1, [BP-3]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-12]
  mov CR, 2
  movs
  mov R12, [BP-4]
  mov R1, [BP-5]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-14]
  mov CR, 2
  movs
  mov R12, [BP-4]
  mov R1, [BP-6]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, [BP-7]
  fsgn R0
  mov [BP-18], R0
  mov R0, [BP-8]
  mov [BP-17], R0
  mov R0, 0.000000
  mov [BP-19], R0
  mov R0, [BP-12]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-18]
  fmul R0, R1
  mov R1, [BP-11]
  mov R2, [BP-9]
  fsub R1, R2
  mov R2, [BP-17]
  fmul R1, R2
  fadd R0, R1
  mov [BP-20], R0
  mov R0, [BP-14]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-18]
  fmul R0, R1
  mov R1, [BP-13]
  mov R2, [BP-9]
  fsub R1, R2
  mov R2, [BP-17]
  fmul R1, R2
  fadd R0, R1
  mov [BP-21], R0
  mov R0, [BP-16]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-18]
  fmul R0, R1
  mov R1, [BP-15]
  mov R2, [BP-9]
  fsub R1, R2
  mov R2, [BP-17]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_15546_start:
  mov R0, [BP-21]
  mov R1, [BP-19]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_15551
  mov R1, [BP-20]
  mov R2, [BP-22]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_15551:
  jf R0, __if_15546_end
  jmp __function_b2ClipPolygons_return
__if_15546_end:
__if_15557_start:
  mov R0, [BP-22]
  mov R1, [BP-19]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15562
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15562:
  jf R0, __if_15557_else
  mov R0, [BP-19]
  mov R1, [BP-22]
  fsub R0, R1
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  fdiv R0, R1
  mov [BP-38], R0
  mov R0, [BP-38]
  fsgn R0
  fadd R0, 1.000000
  mov R1, [BP-16]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-14]
  fmul R1, R2
  fadd R0, R1
  mov [BP-24], R0
  mov R0, [BP-38]
  fsgn R0
  fadd R0, 1.000000
  mov R1, [BP-15]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-23], R0
  jmp __if_15557_end
__if_15557_else:
  lea R13, [BP-24]
  lea R12, [BP-16]
  mov CR, 2
  movs
__if_15557_end:
__if_15617_start:
  mov R0, [BP-21]
  mov R1, [BP-20]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15622
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15622:
  jf R0, __if_15617_else
  mov R0, [BP-20]
  mov R1, [BP-22]
  fsub R0, R1
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  fdiv R0, R1
  mov [BP-38], R0
  mov R0, [BP-38]
  fsgn R0
  fadd R0, 1.000000
  mov R1, [BP-16]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-14]
  fmul R1, R2
  fadd R0, R1
  mov [BP-26], R0
  mov R0, [BP-38]
  fsgn R0
  fadd R0, 1.000000
  mov R1, [BP-15]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-25], R0
  jmp __if_15617_end
__if_15617_else:
  lea R13, [BP-26]
  lea R12, [BP-14]
  mov CR, 2
  movs
__if_15617_end:
  mov R0, [BP-24]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-8]
  fmul R0, R1
  mov R1, [BP-23]
  mov R2, [BP-9]
  fsub R1, R2
  mov R2, [BP-7]
  fmul R1, R2
  fadd R0, R1
  mov [BP-27], R0
  mov R0, [BP-26]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-8]
  fmul R0, R1
  mov R1, [BP-25]
  mov R2, [BP-9]
  fsub R1, R2
  mov R2, [BP-7]
  fmul R1, R2
  fadd R0, R1
  mov [BP-28], R0
  mov R1, [BP-1]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-29], R0
  mov R1, [BP-4]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-30], R0
  mov R0, [BP-29]
  mov R1, [BP-30]
  fsub R0, R1
  mov R1, [BP-27]
  fsub R0, R1
  fmul R0, 0.500000
  mov [BP-31], R0
  mov R0, [BP-24]
  mov R1, [BP-31]
  mov R2, [BP-8]
  fmul R1, R2
  fadd R0, R1
  mov [BP-33], R0
  mov R0, [BP-23]
  mov R1, [BP-31]
  mov R2, [BP-7]
  fmul R1, R2
  fadd R0, R1
  mov [BP-32], R0
  mov R0, [BP-29]
  mov R1, [BP-30]
  fsub R0, R1
  mov R1, [BP-28]
  fsub R0, R1
  fmul R0, 0.500000
  mov [BP-34], R0
  mov R0, [BP-26]
  mov R1, [BP-34]
  mov R2, [BP-8]
  fmul R1, R2
  fadd R0, R1
  mov [BP-36], R0
  mov R0, [BP-25]
  mov R1, [BP-34]
  mov R2, [BP-7]
  fmul R1, R2
  fadd R0, R1
  mov [BP-35], R0
  mov R0, [BP-29]
  mov R1, [BP-30]
  fadd R0, R1
  mov [BP-37], R0
__if_15794_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_15794_else
  mov R13, [BP+7]
  lea R12, [BP-8]
  mov CR, 2
  movs
  mov R0, [BP+7]
  iadd R0, 2
  mov [BP-38], R0
  mov R13, [BP-38]
  lea R12, [BP-33]
  mov CR, 2
  movs
  mov R0, [BP-27]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-38]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-2]
  and R0, 255
  shl R0, 8
  mov R1, [BP-6]
  and R1, 255
  or R0, R1
  mov R1, [BP-38]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+7]
  iadd R0, 2
  iadd R0, 4
  mov [BP-38], R0
  mov R13, [BP-38]
  lea R12, [BP-36]
  mov CR, 2
  movs
  mov R0, [BP-28]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-38]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-3]
  and R0, 255
  shl R0, 8
  mov R1, [BP-5]
  and R1, 255
  or R0, R1
  mov R1, [BP-38]
  iadd R1, 3
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+7]
  iadd R1, 10
  mov [R1], R0
  jmp __if_15794_end
__if_15794_else:
  mov R0, [BP-8]
  fsgn R0
  mov R1, [BP+7]
  mov [R1], R0
  mov R0, [BP-7]
  fsgn R0
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+7]
  iadd R0, 2
  mov [BP-38], R0
  mov R13, [BP-38]
  lea R12, [BP-36]
  mov CR, 2
  movs
  mov R0, [BP-28]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-38]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  and R0, 255
  shl R0, 8
  mov R1, [BP-3]
  and R1, 255
  or R0, R1
  mov R1, [BP-38]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP+7]
  iadd R0, 2
  iadd R0, 4
  mov [BP-38], R0
  mov R13, [BP-38]
  lea R12, [BP-33]
  mov CR, 2
  movs
  mov R0, [BP-27]
  mov R1, [BP-37]
  fsub R0, R1
  mov R1, [BP-38]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-6]
  and R0, 255
  shl R0, 8
  mov R1, [BP-2]
  and R1, 255
  or R0, R1
  mov R1, [BP-38]
  iadd R1, 3
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+7]
  iadd R1, 10
  mov [R1], R0
__if_15794_end:
__function_b2ClipPolygons_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollidePolygons:
  push BP
  mov BP, SP
  isub SP, 124
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  mov R0, R1
  mov [BP-3], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-4], R0
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R13, [BP-6]
  mov R12, [BP+4]
  iadd R12, 2
  mov CR, 2
  movs
  lea R0, [BP-44]
  mov [BP-45], R0
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  mov R1, [BP-45]
  iadd R1, 35
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  mov R1, [BP-45]
  iadd R1, 34
  mov [R1], R0
  mov R13, [BP-45]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-45]
  iadd R13, 16
  mov R12, [BP+2]
  iadd R12, 16
  mov CR, 2
  movs
  mov R0, 1
  mov [BP-46], R0
__for_16045_start:
  mov R0, [BP-46]
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16045_end
  mov R1, [BP+2]
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-45]
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2Sub
  mov R13, [BP-45]
  iadd R13, 16
  mov R1, [BP-46]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+2]
  iadd R12, 16
  mov R1, [BP-46]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
__for_16045_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16045_start
__for_16045_end:
  lea R0, [BP-82]
  mov [BP-83], R0
  mov R1, [BP+3]
  iadd R1, 35
  mov R0, [R1]
  mov R1, [BP-83]
  iadd R1, 35
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 34
  mov R0, [R1]
  mov R1, [BP-83]
  iadd R1, 34
  mov [R1], R0
  mov R0, 0
  mov [BP-46], R0
__for_16094_start:
  mov R0, [BP-46]
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16094_end
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, [BP+3]
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  mov R1, [BP-83]
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 16
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  mov R1, [BP-83]
  iadd R1, 16
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2RotateVector
__for_16094_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16094_start
__for_16094_end:
  mov R0, 0
  mov [BP-84], R0
  lea R1, [BP-84]
  mov [SP], R1
  mov R1, [BP-45]
  mov [SP+1], R1
  mov R1, [BP-83]
  mov [SP+2], R1
  call __function_b2FindMaxSeparation
  mov [BP-85], R0
  mov R0, 0
  mov [BP-86], R0
  lea R1, [BP-86]
  mov [SP], R1
  mov R1, [BP-83]
  mov [SP+1], R1
  mov R1, [BP-45]
  mov [SP+2], R1
  call __function_b2FindMaxSeparation
  mov [BP-87], R0
  mov R1, [BP-45]
  iadd R1, 34
  mov R0, [R1]
  mov R2, [BP-83]
  iadd R2, 34
  mov R1, [R2]
  fadd R0, R1
  mov [BP-88], R0
__if_16159_start:
  mov R0, [BP-85]
  mov R1, [BP-4]
  mov R2, [BP-88]
  fadd R1, R2
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16166
  mov R1, [BP-87]
  mov R2, [BP-4]
  mov R3, [BP-88]
  fadd R2, R3
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16166:
  jf R0, __if_16159_end
  jmp __function_b2CollidePolygons_return
__if_16159_end:
__if_16174_start:
  mov R0, [BP-85]
  mov R1, [BP-87]
  fge R0, R1
  jf R0, __if_16174_else
  mov R0, 0
  mov [BP-89], R0
  mov R12, [BP-45]
  iadd R12, 16
  mov R1, [BP-84]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-91]
  mov CR, 2
  movs
  mov R1, [BP-83]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-92], R0
  mov R0, 0
  mov [BP-86], R0
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-93], R0
  mov R0, 0
  mov [BP-46], R0
__for_16201_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16201_end
  lea R1, [BP-91]
  mov [SP], R1
  mov R1, [BP-83]
  iadd R1, 16
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-94], R0
__if_16221_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16221_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-86], R0
__if_16221_end:
__for_16201_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16201_start
__for_16201_end:
  jmp __if_16174_end
__if_16174_else:
  mov R0, 1
  mov [BP-89], R0
  mov R12, [BP-83]
  iadd R12, 16
  mov R1, [BP-86]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-91]
  mov CR, 2
  movs
  mov R1, [BP-45]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-92], R0
  mov R0, 0
  mov [BP-84], R0
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-93], R0
  mov R0, 0
  mov [BP-46], R0
__for_16255_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16255_end
  lea R1, [BP-91]
  mov [SP], R1
  mov R1, [BP-45]
  iadd R1, 16
  mov R2, [BP-46]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-94], R0
__if_16275_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16275_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-84], R0
__if_16275_end:
__for_16255_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16255_start
__for_16255_end:
__if_16174_end:
__if_16286_start:
  mov R0, [BP-85]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16293
  mov R1, [BP-87]
  mov R2, [BP-3]
  fmul R2, 0.100000
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16293:
  jf R0, __if_16286_else
  mov R0, [BP-84]
  mov [BP-90], R0
__if_16304_start:
  mov R0, [BP-84]
  iadd R0, 1
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16304_else
  mov R0, [BP-84]
  iadd R0, 1
  mov [BP-91], R0
  jmp __if_16304_end
__if_16304_else:
  mov R0, 0
  mov [BP-91], R0
__if_16304_end:
  mov R0, [BP-86]
  mov [BP-92], R0
__if_16324_start:
  mov R0, [BP-86]
  iadd R0, 1
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16324_else
  mov R0, [BP-86]
  iadd R0, 1
  mov [BP-93], R0
  jmp __if_16324_end
__if_16324_else:
  mov R0, 0
  mov [BP-93], R0
__if_16324_end:
  mov R12, [BP-45]
  mov R1, [BP-90]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-95]
  mov CR, 2
  movs
  mov R12, [BP-45]
  mov R1, [BP-91]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-97]
  mov CR, 2
  movs
  mov R12, [BP-83]
  mov R1, [BP-92]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-99]
  mov CR, 2
  movs
  mov R12, [BP-83]
  mov R1, [BP-93]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-101]
  mov CR, 2
  movs
  lea R1, [BP-95]
  mov [SP], R1
  lea R1, [BP-97]
  mov [SP+1], R1
  lea R1, [BP-99]
  mov [SP+2], R1
  lea R1, [BP-101]
  mov [SP+3], R1
  lea R1, [BP-108]
  mov [SP+4], R1
  call __function_b2SegmentDistance
  mov R1, [BP-102]
  mov [SP], R1
  call __function_sqrt
  mov [BP-109], R0
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov [BP-110], R0
__if_16386_start:
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_16386_end
  jmp __function_b2CollidePolygons_return
__if_16386_end:
  mov R1, [BP-45]
  mov [SP], R1
  mov R1, [BP-83]
  mov [SP+1], R1
  mov R1, [BP-84]
  mov [SP+2], R1
  mov R1, [BP-86]
  mov [SP+3], R1
  mov R1, [BP-89]
  mov [SP+4], R1
  mov R1, [BP+5]
  mov [SP+5], R1
  call __function_b2ClipPolygons
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-111], R0
__if_16406_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16406_end
  mov R2, [BP-111]
  mov [SP], R2
  mov R3, [BP+5]
  iadd R3, 2
  iadd R3, 2
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-111], R1
  mov R0, R1
__if_16406_end:
__if_16420_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16420_end
  mov R2, [BP-111]
  mov [SP], R2
  mov R3, [BP+5]
  iadd R3, 2
  iadd R3, 4
  iadd R3, 2
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-111], R1
  mov R0, R1
__if_16420_end:
__if_16434_start:
  mov R0, [BP-110]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fadd R0, R1
  mov R1, [BP-111]
  flt R0, R1
  jf R0, __if_16434_end
  mov R0, 1.000000
  mov R1, [BP-109]
  fdiv R0, R1
  mov [BP-112], R0
__if_16448_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16455
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16455:
  jf R0, __if_16448_else
  lea R1, [BP-99]
  mov [SP], R1
  lea R1, [BP-95]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-114]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-114], R0
  mov R0, [BP-113]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-113], R0
  lea R1, [BP-95]
  mov [SP], R1
  mov R2, [BP-45]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-116]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-99]
  mov [SP], R1
  mov R2, [BP-83]
  iadd R2, 34
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-118]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-114]
  mov CR, 2
  movs
  lea R1, [BP-116]
  mov [SP], R1
  lea R1, [BP-118]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+5]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-90]
  and R0, 255
  shl R0, 8
  mov R1, [BP-92]
  and R1, 255
  or R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  jmp __if_16448_end
__if_16448_else:
__if_16555_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16562
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16562:
  jf R0, __if_16555_else
  lea R1, [BP-101]
  mov [SP], R1
  lea R1, [BP-95]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-114]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-114], R0
  mov R0, [BP-113]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-113], R0
  lea R1, [BP-95]
  mov [SP], R1
  mov R2, [BP-45]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-116]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-101]
  mov [SP], R1
  mov R2, [BP-83]
  iadd R2, 34
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-118]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-114]
  mov CR, 2
  movs
  lea R1, [BP-116]
  mov [SP], R1
  lea R1, [BP-118]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+5]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-90]
  and R0, 255
  shl R0, 8
  mov R1, [BP-93]
  and R1, 255
  or R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  jmp __if_16555_end
__if_16555_else:
__if_16662_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16669
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16669:
  jf R0, __if_16662_else
  lea R1, [BP-99]
  mov [SP], R1
  lea R1, [BP-97]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-114]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-114], R0
  mov R0, [BP-113]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-113], R0
  lea R1, [BP-97]
  mov [SP], R1
  mov R2, [BP-45]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-116]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-99]
  mov [SP], R1
  mov R2, [BP-83]
  iadd R2, 34
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-118]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-114]
  mov CR, 2
  movs
  lea R1, [BP-116]
  mov [SP], R1
  lea R1, [BP-118]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+5]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-91]
  and R0, 255
  shl R0, 8
  mov R1, [BP-92]
  and R1, 255
  or R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
  jmp __if_16662_end
__if_16662_else:
__if_16769_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16776
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16776:
  jf R0, __if_16769_end
  lea R1, [BP-101]
  mov [SP], R1
  lea R1, [BP-97]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-114]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-114], R0
  mov R0, [BP-113]
  mov R1, [BP-112]
  fmul R0, R1
  mov [BP-113], R0
  lea R1, [BP-97]
  mov [SP], R1
  mov R2, [BP-45]
  iadd R2, 34
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-116]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-101]
  mov [SP], R1
  mov R2, [BP-83]
  iadd R2, 34
  mov R1, [R2]
  fsgn R1
  mov [SP+1], R1
  lea R1, [BP-114]
  mov [SP+2], R1
  lea R1, [BP-118]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP+5]
  lea R12, [BP-114]
  mov CR, 2
  movs
  lea R1, [BP-116]
  mov [SP], R1
  lea R1, [BP-118]
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+5]
  iadd R1, 2
  mov [SP+3], R1
  call __function_b2Lerp
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-91]
  and R0, 255
  shl R0, 8
  mov R1, [BP-93]
  and R1, 255
  or R0, R1
  mov R1, [BP+5]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_16769_end:
__if_16662_end:
__if_16555_end:
__if_16448_end:
__if_16434_end:
  jmp __if_16286_end
__if_16286_else:
  mov R1, [BP-45]
  mov [SP], R1
  mov R1, [BP-83]
  mov [SP+1], R1
  mov R1, [BP-84]
  mov [SP+2], R1
  mov R1, [BP-86]
  mov [SP+3], R1
  mov R1, [BP-89]
  mov [SP+4], R1
  mov R1, [BP+5]
  mov [SP+5], R1
  call __function_b2ClipPolygons
__if_16286_end:
__if_16884_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16884_end
  mov R0, [BP+5]
  iadd R0, 2
  mov [BP-90], R0
  mov R1, [BP-90]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-90]
  mov [SP+2], R1
  call __function_b2Add
__if_16884_end:
__if_16906_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16906_end
  mov R0, [BP+5]
  iadd R0, 2
  iadd R0, 4
  mov [BP-90], R0
  mov R1, [BP-90]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-90]
  mov [SP+2], R1
  call __function_b2Add
__if_16906_end:
__function_b2CollidePolygons_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollidePolygonAndCapsule:
  push BP
  mov BP, SP
  isub SP, 40
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-36]
  mov [SP+3], R1
  call __function_b2MakeCapsulePolygon
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygons
__function_b2CollidePolygonAndCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideSegmentAndPolygon:
  push BP
  mov BP, SP
  isub SP, 40
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-36]
  mov [SP+3], R1
  call __function_b2MakeCapsulePolygon
  lea R1, [BP-36]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygons
__function_b2CollideSegmentAndPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2ClassifyNormal:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 2
  mov R0, 0.010000
  mov [BP-1], R0
__if_16992_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fle R1, 0.000000
  mov R0, R1
  jf R0, __if_16992_else
__if_17001_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jf R0, __if_17001_end
__if_17005_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 2
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  mov R2, [BP-1]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_17005_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17005_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17001_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
  jmp __if_16992_end
__if_16992_else:
__if_17020_start:
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  jf R0, __if_17020_end
__if_17024_start:
  mov R2, [BP+2]
  iadd R2, 4
  mov [SP], R2
  mov R2, [BP+3]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  mov R2, [BP-1]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_17024_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17024_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17020_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
__if_16992_end:
__function_b2ClassifyNormal_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ClipSegments:
  push BP
  mov BP, SP
  isub SP, 32
  mov R0, 0
  mov R1, [BP+11]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP+6]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2LeftPerp
  mov R0, 0.000000
  mov [BP-3], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-6], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-9], R0
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-12], R0
__if_17104_start:
  mov R0, [BP-9]
  mov R1, [BP-3]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_17109
  mov R1, [BP-6]
  mov R2, [BP-12]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_17109:
  jf R0, __if_17104_end
  jmp __function_b2ClipSegments_return
__if_17104_end:
__if_17115_start:
  mov R0, [BP-12]
  mov R1, [BP-3]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17120
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17120:
  jf R0, __if_17115_else
  mov R0, [BP-3]
  mov R1, [BP-12]
  fsub R0, R1
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  fdiv R0, R1
  mov [BP-28], R0
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP-28]
  mov [SP+2], R1
  lea R1, [BP-14]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_17115_end
__if_17115_else:
  lea R13, [BP-14]
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17115_end:
__if_17152_start:
  mov R0, [BP-9]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17157
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17157:
  jf R0, __if_17152_else
  mov R0, [BP-6]
  mov R1, [BP-12]
  fsub R0, R1
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  fdiv R0, R1
  mov [BP-28], R0
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP-28]
  mov [SP+2], R1
  lea R1, [BP-16]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_17152_end
__if_17152_else:
  lea R13, [BP-16]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17152_end:
  lea R1, [BP-14]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-19], R0
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-22], R0
  lea R1, [BP-14]
  mov [SP], R1
  mov R1, [BP+7]
  mov R2, [BP+8]
  fsub R1, R2
  mov R2, [BP-19]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  mov R1, [BP+6]
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, [BP+7]
  mov R2, [BP+8]
  fsub R1, R2
  mov R2, [BP-22]
  fsub R1, R2
  fmul R1, 0.500000
  mov [SP+1], R1
  mov R1, [BP+6]
  mov [SP+2], R1
  lea R1, [BP-26]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R0, [BP+7]
  mov R1, [BP+8]
  fadd R0, R1
  mov [BP-27], R0
  mov R13, [BP+11]
  lea R12, [BP+6]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R13, [BP+11]
  iadd R13, 2
  lea R12, [BP-24]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-27]
  fsub R0, R1
  mov R1, [BP+11]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+9]
  mov R1, [BP+11]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R13, [BP+11]
  iadd R13, 2
  iadd R13, 4
  lea R12, [BP-26]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-27]
  fsub R0, R1
  mov R1, [BP+11]
  iadd R1, 2
  iadd R1, 4
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+10]
  mov R1, [BP+11]
  iadd R1, 2
  iadd R1, 4
  iadd R1, 3
  mov [R1], R0
  mov R0, 2
  mov R1, [BP+11]
  iadd R1, 10
  mov [R1], R0
__function_b2ClipSegments_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideChainSegmentAndPolygon:
  push BP
  mov BP, SP
  isub SP, 171
  mov R0, 0
  mov R1, [BP+6]
  iadd R1, 10
  mov [R1], R0
  lea R0, [BP-36]
  mov [BP-37], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP-37]
  mov [SP+2], R1
  call __function_b2TransformPolygon
  mov R12, [BP-37]
  iadd R12, 32
  lea DR, [BP-39]
  mov CR, 2
  movs
  mov R1, [BP-37]
  iadd R1, 34
  mov R0, [R1]
  mov [BP-40], R0
  mov R1, [BP-37]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-41], R0
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-43]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  iadd R12, 2
  lea DR, [BP-45]
  mov CR, 2
  movs
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R13, [BP-57]
  lea R12, [BP-49]
  mov CR, 2
  movs
  mov R0, 0.010000
  mov [BP-58], R0
  lea R1, [BP-43]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-60]
  mov [SP], R1
  lea R1, [BP-62]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-62]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2RightPerp
  lea R2, [BP-62]
  mov [SP], R2
  lea R2, [BP-49]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  mov R2, [BP-58]
  fge R1, R2
  mov [BP-51], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 6
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-64]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-64]
  mov [SP], R1
  lea R1, [BP-66]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-66]
  mov [SP], R1
  lea R1, [BP-53]
  mov [SP+1], R1
  call __function_b2RightPerp
  lea R2, [BP-49]
  mov [SP], R2
  lea R2, [BP-66]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  mov R2, [BP-58]
  fge R1, R2
  mov [BP-50], R1
  mov R0, R1
  lea R1, [BP-49]
  mov [SP], R1
  lea R1, [BP-68]
  mov [SP+1], R1
  call __function_b2RightPerp
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-70]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-68]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  mov [BP-71], R0
  mov R0, 1
  mov [BP-72], R0
  mov R0, 1
  mov [BP-73], R0
__if_17471_start:
  mov R0, [BP-51]
  jf R0, __if_17471_end
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-72], R1
  mov R0, R1
__if_17471_end:
__if_17484_start:
  mov R0, [BP-50]
  jf R0, __if_17484_end
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-137]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-53]
  mov [SP], R2
  lea R2, [BP-137]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-73], R1
  mov R0, R1
__if_17484_end:
__if_17507_start:
  mov R0, [BP-71]
  jf R0, __LogicalAnd_ShortCircuit_17509
  mov R1, [BP-72]
  and R0, R1
__LogicalAnd_ShortCircuit_17509:
  jf R0, __LogicalAnd_ShortCircuit_17512
  mov R1, [BP-73]
  and R0, R1
__LogicalAnd_ShortCircuit_17512:
  jf R0, __if_17507_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17507_end:
  lea R13, [BP-114]
  lea R12, [BP-43]
  mov CR, 2
  movs
  lea R13, [BP-112]
  lea R12, [BP-45]
  mov CR, 2
  movs
  mov R0, 2
  mov [BP-98], R0
  mov R0, 0.000000
  mov [BP-97], R0
  mov R1, [BP-37]
  mov [SP], R1
  mov R1, [BP-41]
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-96]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-78]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 0
  mov [BP-74], R0
  lea R1, [BP-114]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-123]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_17564_start:
  mov R1, [BP-117]
  mov R2, [BP-40]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 4.000000
  fadd R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_17564_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17564_end:
  lea R12, [BP-68]
  lea DR, [BP-125]
  mov CR, 2
  movs
__if_17581_start:
  mov R0, [BP-51]
  jf R0, __if_17581_end
  lea R13, [BP-125]
  lea R12, [BP-55]
  mov CR, 2
  movs
__if_17581_end:
  lea R12, [BP-68]
  lea DR, [BP-127]
  mov CR, 2
  movs
__if_17591_start:
  mov R0, [BP-50]
  jf R0, __if_17591_end
  lea R13, [BP-127]
  lea R12, [BP-53]
  mov CR, 2
  movs
__if_17591_end:
  mov R0, -1
  mov [BP-128], R0
  mov R0, -1
  mov [BP-129], R0
__if_17606_start:
  mov R1, [BP-71]
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_17612
  mov R2, [BP-117]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 0.100000
  fgt R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_17612:
  mov R0, R1
  jf R0, __if_17606_else
__if_17621_start:
  mov R1, [BP+5]
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_17621_else
  lea R12, [BP-123]
  lea DR, [BP-137]
  mov CR, 2
  movs
  lea R12, [BP-121]
  lea DR, [BP-139]
  mov CR, 2
  movs
  lea R1, [BP-139]
  mov [SP], R1
  lea R1, [BP-137]
  mov [SP+1], R1
  lea R1, [BP-141]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-57]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  call __function_b2ClassifyNormal
  mov [BP-144], R0
__if_17658_start:
  mov R0, [BP-144]
  ieq R0, 0
  jf R0, __if_17658_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17658_end:
__if_17663_start:
  mov R0, [BP-144]
  ieq R0, 1
  jf R0, __if_17663_end
  mov R13, [BP+6]
  lea R12, [BP-143]
  mov CR, 2
  movs
  mov R13, [BP+6]
  iadd R13, 2
  lea R12, [BP-137]
  mov CR, 2
  movs
  mov R0, [BP-117]
  mov R1, [BP-40]
  fsub R0, R1
  mov R1, [BP+6]
  iadd R1, 2
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+5]
  iadd R0, 1
  mov R0, [R0]
  and R0, 255
  shl R0, 8
  mov R1, [BP+5]
  iadd R1, 4
  mov R1, [R1]
  and R1, 255
  or R0, R1
  mov R1, [BP+6]
  iadd R1, 2
  iadd R1, 3
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+6]
  iadd R1, 10
  mov [R1], R0
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17663_end:
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-128], R0
  jmp __if_17621_end
__if_17621_else:
  mov R0, [BP+5]
  iadd R0, 1
  mov R0, [R0]
  mov [BP-136], R0
  mov R0, [BP+5]
  iadd R0, 1
  iadd R0, 1
  mov R0, [R0]
  mov [BP-137], R0
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-138], R0
  mov R0, [BP+5]
  iadd R0, 4
  iadd R0, 1
  mov R0, [R0]
  mov [BP-139], R0
__if_17752_start:
  mov R0, [BP-136]
  mov R1, [BP-137]
  ieq R0, R1
  jf R0, __if_17752_else
  lea R1, [BP-123]
  mov [SP], R1
  lea R1, [BP-121]
  mov [SP+1], R1
  lea R1, [BP-141]
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-138]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-143]
  mov CR, 2
  movs
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-139]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-145]
  mov CR, 2
  movs
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-146], R0
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-145]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-147], R0
  mov R0, [BP-139]
  mov [BP-148], R0
__if_17797_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  fgt R0, R1
  jf R0, __if_17797_end
  mov R0, [BP-138]
  mov [BP-148], R0
__if_17797_end:
  lea R13, [BP-141]
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-148]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-150]
  mov [SP+1], R1
  call __function_b2Neg
  lea R1, [BP-57]
  mov [SP], R1
  lea R1, [BP-150]
  mov [SP+1], R1
  call __function_b2ClassifyNormal
  mov [BP-151], R0
__if_17824_start:
  mov R0, [BP-151]
  ieq R0, 0
  jf R0, __if_17824_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17824_end:
__if_17829_start:
  mov R0, [BP-151]
  ieq R0, 1
  jf R0, __if_17829_end
  mov R0, [BP-148]
  mov [BP-138], R0
__if_17837_start:
  mov R0, [BP-148]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17837_else
  mov R0, [BP-148]
  iadd R0, 1
  mov [BP-139], R0
  jmp __if_17837_end
__if_17837_else:
  mov R0, 0
  mov [BP-139], R0
__if_17837_end:
  mov R12, [BP-37]
  mov R1, [BP-138]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-153]
  mov CR, 2
  movs
  mov R12, [BP-37]
  mov R1, [BP-139]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-155]
  mov CR, 2
  movs
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-153]
  mov [SP+1], R1
  lea R1, [BP-157]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-153]
  mov [SP+1], R1
  lea R1, [BP-159]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-141]
  mov [SP], R2
  lea R2, [BP-157]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-146], R1
  mov R0, R1
  lea R2, [BP-141]
  mov [SP], R2
  lea R2, [BP-159]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-147], R1
  mov R0, R1
__if_17895_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  flt R0, R1
  jf R0, __if_17895_else
__if_17900_start:
  lea R2, [BP-125]
  mov [SP], R2
  lea R2, [BP-141]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  lea R3, [BP-68]
  mov [SP], R3
  lea R3, [BP-141]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_17900_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17900_end:
  jmp __if_17895_end
__if_17895_else:
__if_17914_start:
  lea R2, [BP-127]
  mov [SP], R2
  lea R2, [BP-141]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  lea R3, [BP-68]
  mov [SP], R3
  lea R3, [BP-141]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_17914_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17914_end:
__if_17895_end:
  lea R1, [BP-153]
  mov [SP], R1
  lea R1, [BP-155]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  lea R1, [BP-45]
  mov [SP+3], R1
  lea R1, [BP-141]
  mov [SP+4], R1
  mov R1, [BP-40]
  mov [SP+5], R1
  mov R1, 0.000000
  mov [SP+6], R1
  mov R1, [BP-138]
  and R1, 255
  shl R1, 8
  or R1, 1
  mov [SP+7], R1
  mov R1, [BP-139]
  and R1, 255
  shl R1, 8
  or R1, 0
  mov [SP+8], R1
  mov R1, [BP+6]
  mov [SP+9], R1
  call __function_b2ClipSegments
__if_17971_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_17971_end
  lea R1, [BP-141]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_17971_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17829_end:
  mov R0, [BP-148]
  mov [BP-129], R0
  jmp __if_17752_end
__if_17752_else:
  mov R12, [BP-37]
  mov R1, [BP-138]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-141]
  mov CR, 2
  movs
  mov R12, [BP-37]
  mov R1, [BP-139]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-143]
  mov CR, 2
  movs
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-145]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-143]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-147]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-145]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-148], R0
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-147]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-149], R0
__if_18031_start:
  mov R0, [BP-148]
  mov R1, [BP-149]
  flt R0, R1
  jf R0, __if_18031_else
  mov R0, [BP-138]
  mov [BP-128], R0
  jmp __if_18031_end
__if_18031_else:
  mov R0, [BP-139]
  mov [BP-128], R0
__if_18031_end:
__if_17752_end:
__if_17621_end:
  jmp __if_17606_end
__if_17606_else:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-136], R0
  mov R0, 0
  mov [BP-137], R0
__for_18050_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18050_end
  mov R12, [BP-37]
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-141]
  mov CR, 2
  movs
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-143]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-144], R0
__if_18082_start:
  mov R0, [BP-144]
  mov R1, [BP-136]
  flt R0, R1
  jf R0, __if_18082_end
  mov R0, [BP-144]
  mov [BP-136], R0
  mov R0, [BP-137]
  mov [BP-128], R0
__if_18082_end:
__for_18050_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18050_start
__for_18050_end:
__if_18093_start:
  mov R0, [BP-51]
  jf R0, __if_18093_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18103_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18103_end
  mov R12, [BP-37]
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-142]
  mov CR, 2
  movs
  lea R1, [BP-142]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-144]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-144]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-145], R0
__if_18136_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18136_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18136_end:
__for_18103_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18103_start
__for_18103_end:
__if_18143_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18143_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18143_end:
__if_18093_end:
__if_18155_start:
  mov R0, [BP-50]
  jf R0, __if_18155_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18165_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18165_end
  mov R12, [BP-37]
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-142]
  mov CR, 2
  movs
  lea R1, [BP-142]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-144]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-144]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-145], R0
__if_18198_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18198_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18198_end:
__for_18165_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18165_start
__for_18165_end:
__if_18205_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18205_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18205_end:
__if_18155_end:
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-138], R0
  mov R0, -1
  mov [BP-139], R0
  mov R0, 0
  mov [BP-137], R0
__for_18228_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18228_end
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-141]
  mov CR, 2
  movs
  lea R1, [BP-141]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  call __function_b2Neg
__if_18251_start:
  lea R2, [BP-57]
  mov [SP], R2
  lea R2, [BP-143]
  mov [SP+1], R2
  call __function_b2ClassifyNormal
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __if_18251_end
  jmp __for_18228_continue
__if_18251_end:
  mov R12, [BP-37]
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-145]
  mov CR, 2
  movs
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-145]
  mov [SP+1], R1
  lea R1, [BP-147]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-145]
  mov [SP+1], R1
  lea R1, [BP-149]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-141]
  mov [SP], R2
  lea R2, [BP-149]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-160], R1
  lea R2, [BP-141]
  mov [SP], R2
  lea R2, [BP-147]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-161], R1
  mov R1, [BP-161]
  mov [SP], R1
  mov R1, [BP-160]
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-150], R0
__if_18297_start:
  mov R0, [BP-150]
  mov R1, [BP-138]
  fgt R0, R1
  jf R0, __if_18297_end
  mov R0, [BP-150]
  mov [BP-138], R0
  mov R0, [BP-137]
  mov [BP-139], R0
__if_18297_end:
__for_18228_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18228_start
__for_18228_end:
__if_18308_start:
  mov R0, [BP-138]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18308_end
  mov R0, [BP-139]
  mov [BP-140], R0
__if_18318_start:
  mov R0, [BP-140]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18318_else
  mov R0, [BP-140]
  iadd R0, 1
  mov [BP-141], R0
  jmp __if_18318_end
__if_18318_else:
  mov R0, 0
  mov [BP-141], R0
__if_18318_end:
  mov R12, [BP-37]
  mov R1, [BP-140]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-143]
  mov CR, 2
  movs
  mov R12, [BP-37]
  mov R1, [BP-141]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-145]
  mov CR, 2
  movs
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-140]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-147]
  mov CR, 2
  movs
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  lea R1, [BP-149]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  lea R1, [BP-151]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-147]
  mov [SP], R1
  lea R1, [BP-149]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-152], R0
  lea R1, [BP-147]
  mov [SP], R1
  lea R1, [BP-151]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-153], R0
__if_18382_start:
  mov R0, [BP-152]
  mov R1, [BP-153]
  flt R0, R1
  jf R0, __if_18382_else
__if_18387_start:
  lea R2, [BP-125]
  mov [SP], R2
  lea R2, [BP-147]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  lea R3, [BP-68]
  mov [SP], R3
  lea R3, [BP-147]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_18387_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18387_end:
  jmp __if_18382_end
__if_18382_else:
__if_18401_start:
  lea R2, [BP-127]
  mov [SP], R2
  lea R2, [BP-147]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  lea R3, [BP-68]
  mov [SP], R3
  lea R3, [BP-147]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_18401_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18401_end:
__if_18382_end:
  lea R1, [BP-143]
  mov [SP], R1
  lea R1, [BP-145]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  lea R1, [BP-45]
  mov [SP+3], R1
  lea R1, [BP-147]
  mov [SP+4], R1
  mov R1, [BP-40]
  mov [SP+5], R1
  mov R1, 0.000000
  mov [SP+6], R1
  mov R1, [BP-140]
  and R1, 255
  shl R1, 8
  or R1, 1
  mov [SP+7], R1
  mov R1, [BP-141]
  and R1, 255
  shl R1, 8
  or R1, 0
  mov [SP+8], R1
  mov R1, [BP+6]
  mov [SP+9], R1
  call __function_b2ClipSegments
__if_18458_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18458_end
  lea R1, [BP-147]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18458_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18308_end:
__if_18470_start:
  mov R0, [BP-128]
  ieq R0, -1
  jf R0, __if_18470_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18470_end:
__if_17606_end:
__if_18480_start:
  mov R0, [BP-129]
  ine R0, -1
  jf R0, __if_18480_else
  mov R0, [BP-129]
  mov [BP-130], R0
__if_18489_start:
  mov R0, [BP-130]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18489_else
  mov R0, [BP-130]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18489_end
__if_18489_else:
  mov R0, 0
  mov [BP-131], R0
__if_18489_end:
  jmp __if_18480_end
__if_18480_else:
  mov R0, [BP-128]
  mov [BP-136], R0
__if_18509_start:
  mov R0, [BP-136]
  igt R0, 0
  jf R0, __if_18509_else
  mov R0, [BP-136]
  isub R0, 1
  mov [BP-137], R0
  jmp __if_18509_end
__if_18509_else:
  mov R0, [BP-41]
  isub R0, 1
  mov [BP-137], R0
__if_18509_end:
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-137]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-139]
  mov CR, 2
  movs
  mov R12, [BP-37]
  iadd R12, 16
  mov R1, [BP-136]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-141]
  mov CR, 2
  movs
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-139]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-142], R0
  lea R1, [BP-68]
  mov [SP], R1
  lea R1, [BP-141]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-143], R0
__if_18549_start:
  mov R0, [BP-142]
  mov R1, [BP-143]
  flt R0, R1
  jf R0, __if_18549_else
  mov R0, [BP-137]
  mov [BP-130], R0
  mov R0, [BP-136]
  mov [BP-131], R0
  jmp __if_18549_end
__if_18549_else:
  mov R0, [BP-136]
  mov [BP-130], R0
__if_18564_start:
  mov R0, [BP-136]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18564_else
  mov R0, [BP-136]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18564_end
__if_18564_else:
  mov R0, 0
  mov [BP-131], R0
__if_18564_end:
__if_18549_end:
__if_18480_end:
  mov R12, [BP-37]
  mov R1, [BP-130]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-133]
  mov CR, 2
  movs
  mov R12, [BP-37]
  mov R1, [BP-131]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-135]
  mov CR, 2
  movs
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-133]
  mov [SP+2], R1
  lea R1, [BP-135]
  mov [SP+3], R1
  lea R1, [BP-68]
  mov [SP+4], R1
  mov R1, 0.000000
  mov [SP+5], R1
  mov R1, [BP-40]
  mov [SP+6], R1
  mov R1, [BP-131]
  and R1, 255
  or R1, 0
  mov [SP+7], R1
  mov R1, [BP-130]
  and R1, 255
  or R1, 256
  mov [SP+8], R1
  mov R1, [BP+6]
  mov [SP+9], R1
  call __function_b2ClipSegments
__function_b2CollideChainSegmentAndPolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideChainSegmentAndCapsule:
  push BP
  mov BP, SP
  isub SP, 41
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  lea R1, [BP-36]
  mov [SP+3], R1
  call __function_b2MakeCapsulePolygon
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  call __function_b2CollideChainSegmentAndPolygon
__function_b2CollideChainSegmentAndCapsule_return:
  mov SP, BP
  pop BP
  ret

__function_b2CLZ32:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
__if_18693_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_18693_end
  mov R0, 32
  jmp __function_b2CLZ32_return
__if_18693_end:
  mov R0, 0
  mov [BP-1], R0
  mov R0, 31
  mov [BP-2], R0
__for_18704_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_18704_end
__if_18714_start:
  mov R0, [BP+2]
  mov R1, [BP-2]
  isgn R1
  shl R0, R1
  and R0, 1
  ine R0, 0
  jf R0, __if_18714_end
  mov R0, [BP-1]
  jmp __function_b2CLZ32_return
__if_18714_end:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__for_18704_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_18704_start
__for_18704_end:
  mov R0, [BP-1]
__function_b2CLZ32_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RoundUpPowerOf2:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 1
__if_18762_start:
  mov R0, [BP+2]
  ile R0, 1
  jf R0, __if_18762_end
  mov R0, 1
  jmp __function_b2RoundUpPowerOf2_return
__if_18762_end:
  mov R1, 1
  mov R3, [BP+2]
  isub R3, 1
  mov [SP], R3
  call __function_b2CLZ32
  mov R2, R0
  isgn R2
  iadd R2, 32
  shl R1, R2
  mov R0, R1
__function_b2RoundUpPowerOf2_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Alloc:
  push BP
  mov BP, SP
  push R1
  isub SP, 1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_malloc
__function_b2Alloc_return:
  iadd SP, 1
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Free:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
__function_b2Free_return:
  mov SP, BP
  pop BP
  ret

__function_b2GrowAlloc:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_realloc
__function_b2GrowAlloc_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2GrowArray:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  push R3
  isub SP, 3
  mov R0, [BP+3]
  mov R0, [R0]
  mov [BP-1], R0
__if_18811_start:
  mov R0, [BP-1]
  mov R1, [BP+4]
  ige R0, R1
  jf R0, __if_18811_end
  mov R0, [BP+2]
  jmp __function_b2GrowArray_return
__if_18811_end:
  mov R0, 8
  mov [BP-2], R0
__if_18820_start:
  mov R0, [BP-1]
  ine R0, 0
  jf R0, __if_18820_end
  mov R0, [BP-1]
  imul R0, 2
  mov [BP-2], R0
__if_18820_end:
__if_18829_start:
  mov R0, [BP-2]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __if_18829_end
  mov R0, [BP+4]
  mov [BP-2], R0
__if_18829_end:
__if_18838_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_18838_else
  mov R2, [BP-2]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  jmp __if_18838_end
__if_18838_else:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-1]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP+1], R2
  mov R2, [BP-2]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP+2], R2
  call __function_b2GrowAlloc
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
__if_18838_end:
  mov R0, [BP-2]
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-3]
__function_b2GrowArray_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IsLeaf:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  and R0, 4
  ine R0, 0
__function_b2IsLeaf_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2SetDefaultTreeNode:
  push BP
  mov BP, SP
  mov R0, 0.000000
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 5
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 10
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  mov [R1], R0
__function_b2SetDefaultTreeNode_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_Create:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 16
  mov [SP+1], R1
  call __function_b2MaxInt
  mov [BP-1], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 11
  mov [SP+2], R1
  call __function_memset
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  imul R0, 2
  isub R0, 1
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R3, [BP+3]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 12
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+3]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 12
  mov [SP+2], R1
  call __function_memset
  mov R0, 0
  mov [BP-2], R0
__for_19051_start:
  mov R0, [BP-2]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19051_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R2, [BP+3]
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19051_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_19051_start
__for_19051_end:
  mov R0, -1
  mov R2, [BP+3]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 3
  mov R2, [R3]
  isub R2, 1
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 7
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__function_b2DynamicTree_Create_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_Destroy:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 12
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 11
  mov [SP+2], R1
  call __function_memset
__function_b2DynamicTree_Destroy_return:
  mov SP, BP
  pop BP
  ret

__function_b2AllocateNode:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  push R3
  isub SP, 3
__if_19127_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19127_end
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-4]
  shl R1, -1
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R3, [BP+2]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 12
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 12
  mov [SP+2], R1
  call __function_memcpy
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  imul R2, 12
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  isub R1, R2
  imul R1, 12
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-4]
  imul R1, 12
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
__for_19191_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19191_end
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19191_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_19191_start
__for_19191_end:
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 3
  mov R2, [R3]
  isub R2, 1
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
__if_19127_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 12
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP-2]
  mov [SP], R1
  call __function_b2SetDefaultTreeNode
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
__function_b2AllocateNode_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2FreeNode:
  push BP
  mov BP, SP
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 11
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__function_b2FreeNode_return:
  mov SP, BP
  pop BP
  ret

__function_b2FindBestSibling:
  push BP
  mov BP, SP
  isub SP, 54
  push R1
  push R2
  push R3
  push R4
  isub SP, 3
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2AABB_Center
  mov R1, [BP+3]
  mov [SP], R1
  call __function_b2Perimeter
  mov [BP-3], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-5], R0
  mov R12, [BP-4]
  mov R1, [BP-5]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-9]
  mov CR, 4
  movs
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2Perimeter
  mov [BP-10], R0
  lea R1, [BP-9]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2AABB_Union
  lea R1, [BP-14]
  mov [SP], R1
  call __function_b2Perimeter
  mov [BP-15], R0
  mov R0, 0.000000
  mov [BP-16], R0
  mov R0, [BP-5]
  mov [BP-17], R0
  mov R0, [BP-15]
  mov [BP-18], R0
  mov R0, [BP-5]
  mov [BP-19], R0
__while_19342_start:
__while_19342_continue:
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __while_19342_end
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-20], R0
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-21], R0
  mov R0, [BP-15]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-22], R0
__if_19369_start:
  mov R0, [BP-22]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19369_end
  mov R0, [BP-19]
  mov [BP-17], R0
  mov R0, [BP-22]
  mov [BP-18], R0
__if_19369_end:
  mov R0, [BP-16]
  mov R1, [BP-15]
  mov R2, [BP-10]
  fsub R1, R2
  fadd R0, R1
  mov [BP-16], R0
  mov R1, [BP-4]
  mov R2, [BP-20]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  mov [BP-23], R0
  mov R1, [BP-4]
  mov R2, [BP-21]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  mov [BP-24], R0
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-25], R0
  mov R12, [BP-4]
  mov R1, [BP-20]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-29]
  mov CR, 4
  movs
  lea R1, [BP-29]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2AABB_Union
  lea R1, [BP-33]
  mov [SP], R1
  call __function_b2Perimeter
  mov [BP-34], R0
  mov R0, 0.000000
  mov [BP-35], R0
__if_19432_start:
  mov R0, [BP-23]
  jf R0, __if_19432_else
  mov R0, [BP-34]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_19440_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19440_end
  mov R0, [BP-20]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_19440_end:
  jmp __if_19432_end
__if_19432_else:
  lea R2, [BP-29]
  mov [SP], R2
  call __function_b2Perimeter
  mov R1, R0
  mov [BP-35], R1
  mov R0, R1
  mov R1, [BP-16]
  mov R2, [BP-34]
  fadd R1, R2
  mov R3, [BP-3]
  mov R4, [BP-35]
  fsub R3, R4
  mov [SP], R3
  mov R3, 0.000000
  mov [SP+1], R3
  call __function_b2MinFloat
  mov R2, R0
  fadd R1, R2
  mov [BP-25], R1
  mov R0, R1
__if_19432_end:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-36], R0
  mov R12, [BP-4]
  mov R1, [BP-21]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-40]
  mov CR, 4
  movs
  lea R1, [BP-40]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-44]
  mov [SP+2], R1
  call __function_b2AABB_Union
  lea R1, [BP-44]
  mov [SP], R1
  call __function_b2Perimeter
  mov [BP-45], R0
  mov R0, 0.000000
  mov [BP-46], R0
__if_19496_start:
  mov R0, [BP-24]
  jf R0, __if_19496_else
  mov R0, [BP-45]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_19504_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19504_end
  mov R0, [BP-21]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_19504_end:
  jmp __if_19496_end
__if_19496_else:
  lea R2, [BP-40]
  mov [SP], R2
  call __function_b2Perimeter
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R1, [BP-16]
  mov R2, [BP-45]
  fadd R1, R2
  mov R3, [BP-3]
  mov R4, [BP-46]
  fsub R3, R4
  mov [SP], R3
  mov R3, 0.000000
  mov [SP+1], R3
  call __function_b2MinFloat
  mov R2, R0
  fadd R1, R2
  mov [BP-36], R1
  mov R0, R1
__if_19496_end:
__if_19532_start:
  mov R0, [BP-23]
  jf R0, __LogicalAnd_ShortCircuit_19534
  mov R1, [BP-24]
  and R0, R1
__LogicalAnd_ShortCircuit_19534:
  jf R0, __if_19532_end
  jmp __while_19342_end
__if_19532_end:
__if_19537_start:
  mov R0, [BP-18]
  mov R1, [BP-25]
  fle R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19542
  mov R1, [BP-18]
  mov R2, [BP-36]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_19542:
  jf R0, __if_19537_end
  jmp __while_19342_end
__if_19537_end:
__if_19546_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  feq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19551
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_19551:
  jf R0, __if_19546_end
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-40]
  mov [SP], R1
  lea R1, [BP-50]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-48]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-52]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-50]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-54]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-52]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov [BP-25], R1
  mov R0, R1
  lea R2, [BP-54]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov [BP-36], R1
  mov R0, R1
__if_19546_end:
__if_19597_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19602
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_19602:
  jf R0, __if_19597_else
  mov R0, [BP-20]
  mov [BP-19], R0
  mov R0, [BP-35]
  mov [BP-10], R0
  mov R0, [BP-34]
  mov [BP-15], R0
  jmp __if_19597_end
__if_19597_else:
  mov R0, [BP-21]
  mov [BP-19], R0
  mov R0, [BP-46]
  mov [BP-10], R0
  mov R0, [BP-45]
  mov [BP-15], R0
__if_19597_end:
  jmp __while_19342_start
__while_19342_end:
  mov R0, [BP-17]
__function_b2FindBestSibling_return:
  iadd SP, 3
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2InsertLeaf:
  push BP
  mov BP, SP
  isub SP, 14
__if_19631_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19631_end
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
  jmp __function_b2InsertLeaf_return
__if_19631_end:
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-4]
  mov CR, 4
  movs
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2FindBestSibling
  mov [BP-5], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-6], R0
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocateNode
  mov [BP-7], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-8], R0
  mov R0, [BP-6]
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 7
  mov [R1], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-8]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  mov [SP+1], R1
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2AABB_Union
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-8]
  mov R3, [BP-5]
  imul R3, 12
  iadd R2, R3
  iadd R2, 4
  mov R1, [R2]
  or R0, R1
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP-8]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP-8]
  mov R2, [BP-7]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
__if_19758_start:
  mov R0, [BP-6]
  ine R0, -1
  jf R0, __if_19758_else
__if_19765_start:
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  ieq R0, R1
  jf R0, __if_19765_else
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_19765_end
__if_19765_else:
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_19765_end:
  jmp __if_19758_end
__if_19758_else:
  mov R0, [BP-7]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_19758_end:
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-9], R0
__while_19798_start:
__while_19798_continue:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __while_19798_end
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  mov R2, [BP-10]
  imul R2, 12
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-8]
  mov R2, [BP-11]
  imul R2, 12
  iadd R1, R2
  mov [SP+1], R1
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2AABB_Union
  mov R1, [BP-8]
  mov R2, [BP-10]
  imul R2, 12
  iadd R1, R2
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-8]
  mov R3, [BP-11]
  imul R3, 12
  iadd R2, R3
  iadd R2, 4
  mov R1, [R2]
  or R0, R1
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 4
  mov [R1], R0
  mov R3, [BP-8]
  mov R4, [BP-10]
  imul R4, 12
  iadd R3, R4
  iadd R3, 10
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP-8]
  mov R4, [BP-11]
  imul R4, 12
  iadd R3, R4
  iadd R3, 10
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MaxInt
  mov R1, R0
  iadd R1, 1
  mov R2, [BP-8]
  mov R3, [BP-9]
  imul R3, 12
  iadd R2, R3
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-8]
  mov R3, [BP-10]
  imul R3, 12
  iadd R2, R3
  iadd R2, 11
  mov R1, [R2]
  mov R3, [BP-8]
  mov R4, [BP-11]
  imul R4, 12
  iadd R3, R4
  iadd R3, 11
  mov R2, [R3]
  or R1, R2
  and R1, 2
  or R0, R1
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-8]
  mov R2, [BP-9]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-9], R0
  jmp __while_19798_start
__while_19798_end:
__function_b2InsertLeaf_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveLeaf:
  push BP
  mov BP, SP
  isub SP, 11
__if_19897_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_19897_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2RemoveLeaf_return
__if_19897_end:
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-3], R0
__if_19928_start:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_19928_else
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  jmp __if_19928_end
__if_19928_else:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__if_19928_end:
__if_19950_start:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __if_19950_else
__if_19957_start:
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_19957_else
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_19957_end
__if_19957_else:
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_19957_end:
  mov R0, [BP-3]
  mov R1, [BP-1]
  mov R2, [BP-4]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2FreeNode
  mov R0, [BP-3]
  mov [BP-5], R0
__while_19991_start:
__while_19991_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_19991_end
  mov R0, [BP-1]
  mov R1, [BP-5]
  imul R1, 12
  iadd R0, R1
  mov [BP-6], R0
  mov R0, [BP-1]
  mov R2, [BP-6]
  iadd R2, 5
  mov R1, [R2]
  imul R1, 12
  iadd R0, R1
  mov [BP-7], R0
  mov R0, [BP-1]
  mov R2, [BP-6]
  iadd R2, 5
  iadd R2, 1
  mov R1, [R2]
  imul R1, 12
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2AABB_Union
  mov R1, [BP-7]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-8]
  iadd R2, 4
  mov R1, [R2]
  or R0, R1
  mov R1, [BP-6]
  iadd R1, 4
  mov [R1], R0
  mov R3, [BP-7]
  iadd R3, 10
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP-8]
  iadd R3, 10
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MaxInt
  mov R1, R0
  iadd R1, 1
  mov R2, [BP-6]
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-6]
  iadd R1, 8
  mov R0, [R1]
  mov [BP-5], R0
  jmp __while_19991_start
__while_19991_end:
  jmp __if_19950_end
__if_19950_else:
  mov R0, [BP-4]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-4]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2FreeNode
__if_19950_end:
__function_b2RemoveLeaf_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_CreateProxy:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocateNode
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 12
  iadd R0, R1
  mov [BP-2], R0
  mov R13, [BP-2]
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 4
  movs
  mov R0, [BP+5]
  mov R1, [BP-2]
  iadd R1, 7
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-2]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 10
  mov [R1], R0
  mov R0, 5
  mov R1, [BP-2]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2InsertLeaf
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 5
  mov [R1], R0
  mov R0, [BP-1]
__function_b2DynamicTree_CreateProxy_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_DestroyProxy:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2RemoveLeaf
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2FreeNode
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 5
  mov [R1], R0
__function_b2DynamicTree_DestroyProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_MoveProxy:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2RemoveLeaf
  mov R1, [BP+2]
  mov R13, [R1]
  mov R1, [BP+3]
  imul R1, 12
  iadd R13, R1
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 4
  movs
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2InsertLeaf
__function_b2DynamicTree_MoveProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_GetAABB:
  push BP
  mov BP, SP
  lea R13, [BP+4]
  mov R13, [R13]
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP+3]
  imul R1, 12
  iadd R12, R1
  mov CR, 4
  movs
__function_b2DynamicTree_GetAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_GetUserData:
  push BP
  mov BP, SP
  push R1
  push R2
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 7
  mov R0, [R1]
__function_b2DynamicTree_GetUserData_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_QueryAll:
  push BP
  mov BP, SP
  isub SP, 263
  mov R0, 0
  mov R1, [BP+6]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+6]
  iadd R1, 1
  mov [R1], R0
__if_20210_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20210_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20210_end:
  mov R0, 0
  mov [BP-257], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-256]
  mov R2, [BP-257]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-257]
  iadd R0, 1
  mov [BP-257], R0
__while_20233_start:
__while_20233_continue:
  mov R0, [BP-257]
  igt R0, 0
  jf R0, __while_20233_end
  mov R0, [BP-257]
  isub R0, 1
  mov [BP-257], R0
  lea R0, [BP-256]
  mov R1, [BP-257]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-258], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov R1, [BP-258]
  imul R1, 12
  iadd R0, R1
  mov [BP-259], R0
  mov R1, [BP+6]
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+6]
  mov [R1], R0
__if_20261_start:
  mov R1, [BP-259]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2AABB_Overlaps
  jf R0, __if_20261_end
__if_20268_start:
  mov R1, [BP-259]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20268_else
  mov R1, [BP-258]
  mov [SP], R1
  mov R2, [BP-259]
  iadd R2, 7
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  mov R2, [BP+4]
  call R2
  mov [BP-260], R0
  mov R1, [BP+6]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+6]
  iadd R1, 1
  mov [R1], R0
__if_20287_start:
  mov R0, [BP-260]
  ieq R0, 0
  jf R0, __if_20287_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20287_end:
  jmp __if_20268_end
__if_20268_else:
__if_20293_start:
  mov R0, [BP-257]
  ilt R0, 255
  jf R0, __if_20293_end
  mov R1, [BP-259]
  iadd R1, 5
  mov R0, [R1]
  lea R1, [BP-256]
  mov R2, [BP-257]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-257]
  iadd R0, 1
  mov [BP-257], R0
  mov R1, [BP-259]
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-256]
  mov R2, [BP-257]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-257]
  iadd R0, 1
  mov [BP-257], R0
__if_20293_end:
__if_20268_end:
__if_20261_end:
  jmp __while_20233_start
__while_20233_end:
__function_b2DynamicTree_QueryAll_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_RayCast:
  push BP
  mov BP, SP
  isub SP, 311
  mov R0, 0
  mov R1, [BP+7]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
__if_20339_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20339_end
  jmp __function_b2DynamicTree_RayCast_return
__if_20339_end:
  mov R12, [BP+3]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+3]
  iadd R12, 2
  lea DR, [BP-4]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R1, 1.000000
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  call __function_b2Abs
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-11], R0
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  lea R1, [BP-13]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-13]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-17], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-12]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-16], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-13]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-15], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-12]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
  mov R0, 0
  mov [BP-274], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-273]
  mov R2, [BP-274]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-274]
  iadd R0, 1
  mov [BP-274], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-275], R0
  lea R12, [BP+3]
  mov R12, [R12]
  lea DR, [BP-280]
  mov CR, 5
  movs
__while_20452_start:
__while_20452_continue:
  mov R0, [BP-274]
  igt R0, 0
  jf R0, __while_20452_end
  mov R0, [BP-274]
  isub R0, 1
  mov [BP-274], R0
  lea R0, [BP-273]
  mov R1, [BP-274]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-281], R0
__if_20467_start:
  mov R0, [BP-281]
  ieq R0, -1
  jf R0, __if_20467_end
  jmp __while_20452_continue
__if_20467_end:
  mov R0, [BP-275]
  mov R1, [BP-281]
  imul R1, 12
  iadd R0, R1
  mov [BP-282], R0
  mov R1, [BP+7]
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+7]
  mov [R1], R0
  mov R12, [BP-282]
  lea DR, [BP-286]
  mov CR, 4
  movs
__if_20490_start:
  mov R1, [BP-282]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_20490_end
  jmp __while_20452_continue
__if_20490_end:
__if_20499_start:
  lea R2, [BP-286]
  mov [SP], R2
  lea R2, [BP-17]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_20499_end
  jmp __while_20452_continue
__if_20499_end:
  lea R1, [BP-286]
  mov [SP], R1
  lea R1, [BP-288]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-286]
  mov [SP], R1
  lea R1, [BP-290]
  mov [SP+1], R1
  call __function_b2AABB_Extents
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-288]
  mov [SP+1], R1
  lea R1, [BP-292]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-8]
  mov [SP], R2
  lea R2, [BP-292]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-307], R1
  mov R1, [BP-307]
  mov [SP], R1
  call __function_b2AbsFloat
  mov [BP-293], R0
  lea R1, [BP-10]
  mov [SP], R1
  lea R1, [BP-290]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-294], R0
__if_20546_start:
  mov R0, [BP-294]
  mov R1, [BP-293]
  flt R0, R1
  jf R0, __if_20546_end
  jmp __while_20452_continue
__if_20546_end:
__if_20551_start:
  mov R1, [BP-282]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20551_else
  mov R0, [BP-11]
  mov [BP-276], R0
  lea R1, [BP-280]
  mov [SP], R1
  mov R1, [BP-281]
  mov [SP+1], R1
  mov R2, [BP-282]
  iadd R2, 7
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+6]
  mov [SP+3], R1
  mov R2, [BP+5]
  call R2
  mov [BP-295], R0
  mov R1, [BP+7]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
__if_20576_start:
  mov R0, [BP-295]
  feq R0, 0.000000
  jf R0, __if_20576_end
  jmp __function_b2DynamicTree_RayCast_return
__if_20576_end:
__if_20581_start:
  mov R0, [BP-295]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_20586
  mov R1, [BP-295]
  mov R2, [BP-11]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_20586:
  jf R0, __if_20581_end
  mov R0, [BP-295]
  mov [BP-11], R0
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  lea R1, [BP-13]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-13]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-17], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-12]
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-16], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-13]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-15], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-12]
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-14], R1
  mov R0, R1
__if_20581_end:
  jmp __if_20551_end
__if_20551_else:
__if_20638_start:
  mov R0, [BP-274]
  ilt R0, 255
  jf R0, __if_20638_end
  mov R12, [BP-275]
  mov R2, [BP-282]
  iadd R2, 5
  mov R1, [R2]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-298]
  mov CR, 4
  movs
  mov R12, [BP-275]
  mov R2, [BP-282]
  iadd R2, 5
  iadd R2, 1
  mov R1, [R2]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-302]
  mov CR, 4
  movs
  lea R1, [BP-298]
  mov [SP], R1
  lea R1, [BP-304]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-302]
  mov [SP], R1
  lea R1, [BP-306]
  mov [SP+1], R1
  call __function_b2AABB_Center
__if_20675_start:
  lea R2, [BP-304]
  mov [SP], R2
  lea R2, [BP-2]
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  lea R3, [BP-306]
  mov [SP], R3
  lea R3, [BP-2]
  mov [SP+1], R3
  call __function_b2DistanceSquared
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_20675_else
  mov R1, [BP-282]
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-273]
  mov R2, [BP-274]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-274]
  iadd R0, 1
  mov [BP-274], R0
  mov R1, [BP-282]
  iadd R1, 5
  mov R0, [R1]
  lea R1, [BP-273]
  mov R2, [BP-274]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-274]
  iadd R0, 1
  mov [BP-274], R0
  jmp __if_20675_end
__if_20675_else:
  mov R1, [BP-282]
  iadd R1, 5
  mov R0, [R1]
  lea R1, [BP-273]
  mov R2, [BP-274]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-274]
  iadd R0, 1
  mov [BP-274], R0
  mov R1, [BP-282]
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-273]
  mov R2, [BP-274]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-274]
  iadd R0, 1
  mov [BP-274], R0
__if_20675_end:
__if_20638_end:
__if_20551_end:
  jmp __while_20452_start
__while_20452_end:
__function_b2DynamicTree_RayCast_return:
  mov SP, BP
  pop BP
  ret

__function_b2DynamicTree_BoxCast:
  push BP
  mov BP, SP
  isub SP, 319
  mov R0, 0
  mov R1, [BP+7]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
__if_20752_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20752_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_20752_end:
  mov R12, [BP+3]
  lea DR, [BP-4]
  mov CR, 4
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  call __function_b2AABB_Extents
  mov R12, [BP+3]
  iadd R12, 4
  lea DR, [BP-10]
  mov CR, 2
  movs
  mov R1, 1.000000
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-12]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-12]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  call __function_b2Abs
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-15], R0
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R2, [BP-4]
  mov [SP], R2
  mov R2, [BP-4]
  mov R3, [BP-17]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-21], R1
  mov R0, R1
  mov R2, [BP-3]
  mov [SP], R2
  mov R2, [BP-3]
  mov R3, [BP-16]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-2]
  mov R3, [BP-17]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-19], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-1]
  mov R3, [BP-16]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-18], R1
  mov R0, R1
  mov R0, 0
  mov [BP-278], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-277]
  mov R2, [BP-278]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-278]
  iadd R0, 1
  mov [BP-278], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-279], R0
  lea R12, [BP+3]
  mov R12, [R12]
  lea DR, [BP-286]
  mov CR, 7
  movs
__while_20891_start:
__while_20891_continue:
  mov R0, [BP-278]
  igt R0, 0
  jf R0, __while_20891_end
  mov R0, [BP-278]
  isub R0, 1
  mov [BP-278], R0
  lea R0, [BP-277]
  mov R1, [BP-278]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-287], R0
__if_20906_start:
  mov R0, [BP-287]
  ieq R0, -1
  jf R0, __if_20906_end
  jmp __while_20891_continue
__if_20906_end:
  mov R0, [BP-279]
  mov R1, [BP-287]
  imul R1, 12
  iadd R0, R1
  mov [BP-288], R0
  mov R1, [BP+7]
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+7]
  mov [R1], R0
  mov R12, [BP-288]
  lea DR, [BP-292]
  mov CR, 4
  movs
__if_20929_start:
  mov R1, [BP-288]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_20929_end
  jmp __while_20891_continue
__if_20929_end:
__if_20938_start:
  lea R2, [BP-292]
  mov [SP], R2
  lea R2, [BP-21]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_20938_end
  jmp __while_20891_continue
__if_20938_end:
  lea R1, [BP-292]
  mov [SP], R1
  lea R1, [BP-294]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-292]
  mov [SP], R1
  lea R1, [BP-296]
  mov [SP+1], R1
  call __function_b2AABB_Extents
  lea R1, [BP-296]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-298]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-294]
  mov [SP+1], R1
  lea R1, [BP-300]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-12]
  mov [SP], R2
  lea R2, [BP-300]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-315], R1
  mov R1, [BP-315]
  mov [SP], R1
  call __function_b2AbsFloat
  mov [BP-301], R0
  lea R1, [BP-14]
  mov [SP], R1
  lea R1, [BP-298]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-302], R0
__if_20994_start:
  mov R0, [BP-302]
  mov R1, [BP-301]
  flt R0, R1
  jf R0, __if_20994_end
  jmp __while_20891_continue
__if_20994_end:
__if_20999_start:
  mov R1, [BP-288]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20999_else
  mov R0, [BP-15]
  mov [BP-280], R0
  lea R1, [BP-286]
  mov [SP], R1
  mov R1, [BP-287]
  mov [SP+1], R1
  mov R2, [BP-288]
  iadd R2, 7
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+6]
  mov [SP+3], R1
  mov R2, [BP+5]
  call R2
  mov [BP-303], R0
  mov R1, [BP+7]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
__if_21024_start:
  mov R0, [BP-303]
  feq R0, 0.000000
  jf R0, __if_21024_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21024_end:
__if_21029_start:
  mov R0, [BP-303]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21034
  mov R1, [BP-303]
  mov R2, [BP-15]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21034:
  jf R0, __if_21029_end
  mov R0, [BP-303]
  mov [BP-15], R0
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R2, [BP-4]
  mov [SP], R2
  mov R2, [BP-4]
  mov R3, [BP-17]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-21], R1
  mov R0, R1
  mov R2, [BP-3]
  mov [SP], R2
  mov R2, [BP-3]
  mov R3, [BP-16]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmin
  mov R1, R0
  mov [BP-20], R1
  mov R0, R1
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-2]
  mov R3, [BP-17]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-19], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  mov R2, [BP-1]
  mov R3, [BP-16]
  fadd R2, R3
  mov [SP+1], R2
  call __function_fmax
  mov R1, R0
  mov [BP-18], R1
  mov R0, R1
__if_21029_end:
  jmp __if_20999_end
__if_20999_else:
__if_21105_start:
  mov R0, [BP-278]
  ilt R0, 255
  jf R0, __if_21105_end
  mov R12, [BP-279]
  mov R2, [BP-288]
  iadd R2, 5
  mov R1, [R2]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-306]
  mov CR, 4
  movs
  mov R12, [BP-279]
  mov R2, [BP-288]
  iadd R2, 5
  iadd R2, 1
  mov R1, [R2]
  imul R1, 12
  iadd R12, R1
  lea DR, [BP-310]
  mov CR, 4
  movs
  lea R1, [BP-306]
  mov [SP], R1
  lea R1, [BP-312]
  mov [SP+1], R1
  call __function_b2AABB_Center
  lea R1, [BP-310]
  mov [SP], R1
  lea R1, [BP-314]
  mov [SP+1], R1
  call __function_b2AABB_Center
__if_21142_start:
  lea R2, [BP-312]
  mov [SP], R2
  lea R2, [BP-6]
  mov [SP+1], R2
  call __function_b2DistanceSquared
  mov R1, R0
  lea R3, [BP-314]
  mov [SP], R3
  lea R3, [BP-6]
  mov [SP+1], R3
  call __function_b2DistanceSquared
  mov R2, R0
  flt R1, R2
  mov R0, R1
  jf R0, __if_21142_else
  mov R1, [BP-288]
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-277]
  mov R2, [BP-278]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-278]
  iadd R0, 1
  mov [BP-278], R0
  mov R1, [BP-288]
  iadd R1, 5
  mov R0, [R1]
  lea R1, [BP-277]
  mov R2, [BP-278]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-278]
  iadd R0, 1
  mov [BP-278], R0
  jmp __if_21142_end
__if_21142_else:
  mov R1, [BP-288]
  iadd R1, 5
  mov R0, [R1]
  lea R1, [BP-277]
  mov R2, [BP-278]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-278]
  iadd R0, 1
  mov [BP-278], R0
  mov R1, [BP-288]
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP-277]
  mov R2, [BP-278]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-278]
  iadd R0, 1
  mov [BP-278], R0
__if_21142_end:
__if_21105_end:
__if_20999_end:
  jmp __while_20891_start
__while_20891_end:
__function_b2DynamicTree_BoxCast_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateIdPool:
  push BP
  mov BP, SP
  isub SP, 1
  mov R0, 32
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  imul R2, 1
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
__function_b2CreateIdPool_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyIdPool:
  push BP
  mov BP, SP
  isub SP, 2
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
  mov R0, -1
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
__function_b2DestroyIdPool_return:
  mov SP, BP
  pop BP
  ret

__function_b2AllocId:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
__if_21262_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_21262_end
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  mov R0, [R2]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R0, R1
  mov R0, [R0]
  jmp __function_b2AllocId_return
__if_21262_end:
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
__function_b2AllocId_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2FreeId:
  push BP
  mov BP, SP
  isub SP, 4
__if_21297_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_21297_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP-1]
  shl R1, -1
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__if_21317_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __if_21317_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__if_21317_end:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-1]
  imul R2, 1
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  imul R2, 1
  mov [SP+2], R2
  call __function_b2GrowAlloc
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
__if_21297_end:
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2FreeId_return:
  mov SP, BP
  pop BP
  ret

__function_b2DefaultShapeDef:
  push BP
  mov BP, SP
  mov R0, 1.000000
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0.600000
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 9
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 10
  mov [R1], R0
__function_b2DefaultShapeDef_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShouldShapesCollide:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
__if_21790_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_21798
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21798:
  jf R0, __if_21790_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jmp __function_b2ShouldShapesCollide_return
__if_21790_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_21821
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21821:
__function_b2ShouldShapesCollide_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShouldQueryCollide:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_21858
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21858:
__function_b2ShouldQueryCollide_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ComputeShapeAABB:
  push BP
  mov BP, SP
  isub SP, 3
__if_21872_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21872_else
  mov R1, [BP+2]
  iadd R1, 28
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleAABB
  jmp __if_21872_end
__if_21872_else:
__if_21883_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_21883_else
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleAABB
  jmp __if_21883_end
__if_21883_else:
__if_21894_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_21894_else
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputePolygonAABB
  jmp __if_21894_end
__if_21894_else:
__if_21905_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_21905_else
  mov R1, [BP+2]
  iadd R1, 72
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_21905_end
__if_21905_else:
__if_21916_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_21916_else
  mov R1, [BP+2]
  iadd R1, 76
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_21916_end
__if_21916_else:
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
__if_21916_end:
__if_21905_end:
__if_21894_end:
__if_21883_end:
__if_21872_end:
__function_b2ComputeShapeAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastShape:
  push BP
  mov BP, SP
  isub SP, 30
  mov R13, [BP+5]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+5]
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+5]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 6
  mov [R1], R0
__if_22023_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22023_end
  jmp __function_b2ShapeCastShape_return
__if_22023_end:
  lea R12, [BP+2]
  mov R12, [R12]
  lea DR, [BP-22]
  mov CR, 22
  movs
  mov R0, [BP+2]
  mov [BP-23], R0
  lea R0, [BP-22]
  mov [BP-24], R0
  mov R0, 0
  mov [BP-25], R0
__for_22046_start:
  mov R0, [BP-25]
  mov R2, [BP-23]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22046_end
  mov R12, [BP-23]
  mov R1, [BP-25]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-27]
  mov CR, 2
  movs
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  mov R1, [BP-24]
  mov R2, [BP-25]
  imul R2, 2
  iadd R1, R2
  mov [SP+2], R1
  call __function_b2InvTransformPoint
__for_22046_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_22046_start
__for_22046_end:
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__if_22082_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22082_else
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCircle
  jmp __if_22082_end
__if_22082_else:
__if_22094_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22094_else
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCapsule
  jmp __if_22094_end
__if_22094_else:
__if_22106_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22106_else
  mov R1, [BP+3]
  iadd R1, 36
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastPolygon
  jmp __if_22106_end
__if_22106_else:
__if_22118_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22118_else
  mov R1, [BP+3]
  iadd R1, 72
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
  jmp __if_22118_end
__if_22118_else:
__if_22130_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22130_end
  mov R1, [BP+3]
  iadd R1, 76
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
__if_22130_end:
__if_22118_end:
__if_22106_end:
__if_22094_end:
__if_22082_end:
__function_b2ShapeCastShape_return:
  mov SP, BP
  pop BP
  ret

__function_b2CollideMover:
  push BP
  mov BP, SP
  isub SP, 10
  mov R13, [BP+5]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+5]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP+5]
  iadd R13, 3
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
__if_22189_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22189_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCircle
  jmp __if_22189_end
__if_22189_else:
__if_22201_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22201_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCapsule
  jmp __if_22201_end
__if_22201_else:
__if_22213_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22213_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 36
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndPolygon
  jmp __if_22213_end
__if_22213_else:
__if_22225_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22225_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 72
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22225_end
__if_22225_else:
__if_22237_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22237_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 76
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22237_end
__if_22237_else:
  jmp __function_b2CollideMover_return
__if_22237_end:
__if_22225_end:
__if_22213_end:
__if_22201_end:
__if_22189_end:
__if_22251_start:
  mov R1, [BP+5]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22251_end
  jmp __function_b2CollideMover_return
__if_22251_end:
  mov R12, [BP+5]
  lea DR, [BP-7]
  mov CR, 2
  movs
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2RotateVector
__function_b2CollideMover_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeShapeProxy:
  push BP
  mov BP, SP
  isub SP, 4
__if_22275_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22275_else
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 31
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22275_end
__if_22275_else:
__if_22290_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22290_else
  mov R1, [BP+2]
  iadd R1, 28
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 28
  iadd R2, 2
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22290_end
__if_22290_else:
__if_22305_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22305_else
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 36
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 36
  iadd R2, 34
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22305_end
__if_22305_else:
__if_22321_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22321_else
  mov R1, [BP+2]
  iadd R1, 72
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22321_end
__if_22321_else:
__if_22334_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22334_else
  mov R1, [BP+2]
  iadd R1, 76
  iadd R1, 2
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22334_end
__if_22334_else:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 16
  mov [R1], R0
__if_22334_end:
__if_22321_end:
__if_22305_end:
__if_22290_end:
__if_22275_end:
__function_b2MakeShapeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeShapeMass:
  push BP
  mov BP, SP
  isub SP, 3
__if_22355_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22355_else
  mov R1, [BP+2]
  iadd R1, 28
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputeCircleMass
  jmp __if_22355_end
__if_22355_else:
__if_22367_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22367_else
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleMass
  jmp __if_22367_end
__if_22367_else:
__if_22379_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22379_else
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputePolygonMass
  jmp __if_22379_end
__if_22379_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
__if_22379_end:
__if_22367_end:
__if_22355_end:
__function_b2ComputeShapeMass_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeShapeExtent:
  push BP
  mov BP, SP
  isub SP, 16
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
__if_22422_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22422_else
  mov R1, [BP+2]
  iadd R1, 31
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 31
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Sub
  lea R4, [BP-5]
  mov [SP], R4
  call __function_b2LengthSquared
  mov R3, R0
  mov [BP-12], R3
  lea R4, [BP-3]
  mov [SP], R4
  call __function_b2LengthSquared
  mov R3, R0
  mov [BP-13], R3
  mov R3, [BP-13]
  mov [SP], R3
  mov R3, [BP-12]
  mov [SP+1], R3
  call __function_b2MaxFloat
  mov R2, R0
  mov [BP-12], R2
  mov R2, [BP-12]
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov R2, [BP-1]
  fadd R1, R2
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_22422_end
__if_22422_else:
__if_22470_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22470_else
  mov R1, [BP+2]
  iadd R1, 28
  iadd R1, 2
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 28
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-3]
  mov [SP], R2
  call __function_b2Length
  mov R1, R0
  mov R2, [BP-1]
  fadd R1, R2
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_22470_end
__if_22470_else:
__if_22503_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22503_end
  mov R0, [BP+2]
  iadd R0, 36
  mov [BP-1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R0, R1
  mov [BP-2], R0
  mov R0, 0.000000
  mov [BP-3], R0
  mov R1, [BP-1]
  iadd R1, 35
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, 0
  mov [BP-5], R0
__for_22529_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_22529_end
  mov R1, [BP-1]
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 32
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-1]
  iadd R1, 16
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
  mov R2, [BP-2]
  mov [SP], R2
  mov R2, [BP-8]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R1, [BP-1]
  mov R2, [BP-5]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-10]
  mov [SP], R1
  call __function_b2LengthSquared
  mov [BP-11], R0
  mov R2, [BP-3]
  mov [SP], R2
  mov R2, [BP-11]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
__for_22529_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_22529_start
__for_22529_end:
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 34
  mov R1, [R2]
  fadd R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R2, [BP-3]
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov R3, [BP-1]
  iadd R3, 34
  mov R2, [R3]
  fadd R1, R2
  mov R2, [BP+4]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_22503_end:
__if_22470_end:
__if_22422_end:
__function_b2ComputeShapeExtent_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateBitSet:
  push BP
  mov BP, SP
  isub SP, 3
  mov R0, [BP+2]
  iadd R0, 32
  isub R0, 1
  idiv R0, 32
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 1
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+3]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 1
  mov [SP+2], R1
  call __function_memset
__function_b2CreateBitSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyBitSet:
  push BP
  mov BP, SP
  isub SP, 2
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  mov [R1], R0
__function_b2DestroyBitSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2SetBitCountAndClear:
  push BP
  mov BP, SP
  isub SP, 5
  mov R0, [BP+3]
  iadd R0, 32
  isub R0, 1
  idiv R0, 32
  mov [BP-1], R0
__if_22678_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_22678_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2DestroyBitSet
  mov R0, [BP+3]
  mov R1, [BP+3]
  shl R1, -1
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_b2CreateBitSet
__if_22678_end:
  mov R0, [BP-1]
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 1
  mov [SP+2], R1
  call __function_memset
__function_b2SetBitCountAndClear_return:
  mov SP, BP
  pop BP
  ret

__function_b2GrowBitSet:
  push BP
  mov BP, SP
  isub SP, 5
__if_22712_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_22712_end
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+3]
  idiv R1, 2
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 1
  mov [SP], R1
  call __function_b2Alloc
  mov [BP-2], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 1
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP-2]
  mov [SP], R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-1]
  imul R1, 1
  mov [SP+2], R1
  call __function_memcpy
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP-1]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov [R1], R0
__if_22712_end:
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__function_b2GrowBitSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2SetBitGrow:
  push BP
  mov BP, SP
  isub SP, 3
  mov R0, [BP+3]
  idiv R0, 32
  mov [BP-1], R0
__if_22830_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_22830_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  call __function_b2GrowBitSet
__if_22830_end:
  mov R2, [BP+2]
  mov R0, [R2]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, 1
  mov R2, [BP+3]
  imod R2, 32
  shl R1, R2
  or R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
__function_b2SetBitGrow_return:
  mov SP, BP
  pop BP
  ret

__function_b2ClearBit:
  push BP
  mov BP, SP
  isub SP, 1
  mov R0, [BP+3]
  idiv R0, 32
  mov [BP-1], R0
__if_22865_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_22865_end
  jmp __function_b2ClearBit_return
__if_22865_end:
  mov R2, [BP+2]
  mov R0, [R2]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, 1
  mov R2, [BP+3]
  imod R2, 32
  shl R1, R2
  not R1
  and R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
__function_b2ClearBit_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetBit:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  mov R0, [BP+3]
  idiv R0, 32
  mov [BP-1], R0
__if_22898_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_22898_end
  mov R0, 0
  jmp __function_b2GetBit_return
__if_22898_end:
  mov R2, [BP+2]
  mov R0, [R2]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, 1
  mov R2, [BP+3]
  imod R2, 32
  shl R1, R2
  and R0, R1
  ine R0, 0
__function_b2GetBit_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MixU32:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+2]
  shl R1, -16
  xor R0, R1
  mov [BP+2], R0
  mov R0, [BP+2]
  imul R0, -2048144789
  mov [BP+2], R0
  mov R0, [BP+2]
  mov R1, [BP+2]
  shl R1, -13
  xor R0, R1
  mov [BP+2], R0
  mov R0, [BP+2]
  imul R0, -1028477387
  mov [BP+2], R0
  mov R0, [BP+2]
  mov R1, [BP+2]
  shl R1, -16
  xor R0, R1
  mov [BP+2], R0
  mov R0, [BP+2]
__function_b2MixU32_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2KeyHash:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  isub SP, 1
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2MixU32
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R3, [BP+3]
  mov [SP], R3
  call __function_b2MixU32
  mov R2, R0
  xor R1, R2
  mov [BP-1], R1
  mov R0, R1
  mov R2, [BP-1]
  mov [SP], R2
  call __function_b2MixU32
  mov R1, R0
  mov [BP-1], R1
  mov R0, R1
  mov R0, [BP-1]
__function_b2KeyHash_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2SlotOccupied:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ine R0, 0
  jt R0, __LogicalOr_ShortCircuit_23050
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+3]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ine R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_23050:
__function_b2SlotOccupied_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2FindSlot:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  push R3
  push R4
  push R5
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP+5]
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
__while_23070_start:
__while_23070_continue:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_23074
  mov R4, [BP+2]
  mov R3, [R4]
  mov R4, [BP-2]
  imul R4, 2
  iadd R3, R4
  mov R2, [R3]
  mov R3, [BP+3]
  ieq R2, R3
  jf R2, __LogicalAnd_ShortCircuit_23089
  mov R5, [BP+2]
  mov R4, [R5]
  mov R5, [BP-2]
  imul R5, 2
  iadd R4, R5
  iadd R4, 1
  mov R3, [R4]
  mov R4, [BP+4]
  ieq R3, R4
  and R2, R3
__LogicalAnd_ShortCircuit_23089:
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_23074:
  mov R0, R1
  jf R0, __while_23070_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
  jmp __while_23070_start
__while_23070_end:
  mov R0, [BP-2]
__function_b2FindSlot_return:
  iadd SP, 2
  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateSet:
  push BP
  mov BP, SP
  isub SP, 3
__if_23109_start:
  mov R0, [BP+2]
  igt R0, 16
  jf R0, __if_23109_else
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2RoundUpPowerOf2
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_23109_end
__if_23109_else:
  mov R0, 16
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_23109_end:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+3]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 2
  mov [SP+2], R1
  call __function_memset
__function_b2CreateSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroySet:
  push BP
  mov BP, SP
  isub SP, 2
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
  mov R0, -1
  mov R1, [BP+2]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2DestroySet_return:
  mov SP, BP
  pop BP
  ret

__function_b2AddKeyHaveCapacity:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2FindSlot
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__function_b2AddKeyHaveCapacity_return:
  mov SP, BP
  pop BP
  ret

__function_b2GrowTable:
  push BP
  mov BP, SP
  isub SP, 10
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  imul R0, 2
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 2
  mov [SP+2], R1
  call __function_memset
  mov R0, 0
  mov [BP-3], R0
__for_23258_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_23258_end
  mov R1, [BP-2]
  mov R2, [BP-3]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP-2]
  mov R2, [BP-3]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-5], R0
__if_23280_start:
  mov R0, [BP-4]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23285
  mov R1, [BP-5]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23285:
  jf R0, __if_23280_end
  jmp __for_23258_continue
__if_23280_end:
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2KeyHash
  mov [BP-6], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP-5]
  mov [SP+2], R1
  mov R1, [BP-6]
  mov [SP+3], R1
  call __function_b2AddKeyHaveCapacity
__for_23258_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_23258_start
__for_23258_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__function_b2GrowTable_return:
  mov SP, BP
  pop BP
  ret

__function_b2CanonPair:
  push BP
  mov BP, SP
__if_23309_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __if_23309_else
  mov R0, [BP+2]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_23309_end
__if_23309_else:
  mov R0, [BP+3]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
__if_23309_end:
__function_b2CanonPair_return:
  mov SP, BP
  pop BP
  ret

__function_b2ContainsKey:
  push BP
  mov BP, SP
  isub SP, 4
  push R1
  push R2
  push R3
  isub SP, 4
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-1]
  mov [SP+2], R1
  lea R1, [BP-2]
  mov [SP+3], R1
  call __function_b2CanonPair
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2KeyHash
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_b2FindSlot
  mov [BP-4], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_23371
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-4]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_23371:
__function_b2ContainsKey_return:
  iadd SP, 4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2AddKey:
  push BP
  mov BP, SP
  isub SP, 4
  push R1
  push R2
  isub SP, 4
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-1]
  mov [SP+2], R1
  lea R1, [BP-2]
  mov [SP+3], R1
  call __function_b2CanonPair
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2KeyHash
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_b2FindSlot
  mov [BP-4], R0
__if_23401_start:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2SlotOccupied
  jf R0, __if_23401_end
  mov R0, 1
  jmp __function_b2AddKey_return
__if_23401_end:
__if_23407_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23407_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2GrowTable
__if_23407_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_b2AddKeyHaveCapacity
  mov R0, 0
__function_b2AddKey_return:
  iadd SP, 4
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RemoveKey:
  push BP
  mov BP, SP
  isub SP, 8
  push R1
  push R2
  push R3
  isub SP, 4
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-1]
  mov [SP+2], R1
  lea R1, [BP-2]
  mov [SP+3], R1
  call __function_b2CanonPair
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2KeyHash
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_b2FindSlot
  mov [BP-4], R0
__if_23451_start:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_23451_end
  mov R0, 0
  jmp __function_b2RemoveKey_return
__if_23451_end:
  mov R0, 0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, 0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, [BP-4]
  mov [BP-6], R0
__while_23487_start:
__while_23487_continue:
  mov R0, 1
  jf R0, __while_23487_end
  mov R0, [BP-6]
  iadd R0, 1
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-6], R0
__if_23501_start:
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23514
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23514:
  jf R0, __if_23501_end
  jmp __while_23487_end
__if_23501_end:
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2KeyHash
  mov [BP-7], R0
  mov R0, [BP-7]
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-8], R0
__if_23539_start:
  mov R0, [BP-4]
  mov R1, [BP-6]
  ile R0, R1
  jf R0, __if_23539_else
__if_23544_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_23549
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_23549:
  jf R0, __if_23544_end
  jmp __while_23487_continue
__if_23544_end:
  jmp __if_23539_end
__if_23539_else:
__if_23554_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jt R0, __LogicalOr_ShortCircuit_23559
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_23559:
  jf R0, __if_23554_end
  jmp __while_23487_continue
__if_23554_end:
__if_23539_end:
  mov R1, [BP+2]
  mov R13, [R1]
  mov R1, [BP-4]
  imul R1, 2
  iadd R13, R1
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP-6]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, 0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, 0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-6]
  mov [BP-4], R0
  jmp __while_23487_start
__while_23487_end:
  mov R0, 1
__function_b2RemoveKey_return:
  iadd SP, 4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateBroadPhase:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, 33
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R2, 9
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R0, 0
  mov [BP-1], R0
__for_23622_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_23622_end
  mov R1, 16
  mov [SP], R1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 11
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2DynamicTree_Create
  mov R1, 64
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2CreateBitSet
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, 64
  mov [SP+1], R1
  call __function_b2SetBitCountAndClear
__for_23622_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23622_start
__for_23622_end:
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
  mov R1, 32
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 5
  mov [SP+1], R1
  call __function_b2CreateSet
__function_b2CreateBroadPhase_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyBroadPhase:
  push BP
  mov BP, SP
  isub SP, 3
  mov R0, 0
  mov [BP-1], R0
__for_23674_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_23674_end
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  call __function_b2DynamicTree_Destroy
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  call __function_b2DestroyBitSet
__for_23674_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23674_start
__for_23674_end:
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  mov R1, 33
  mov [SP+1], R1
  call __function_b2Free
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  mov R1, 9
  mov [SP+1], R1
  call __function_b2Free
__if_23708_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_23708_end
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
__if_23708_end:
  mov R1, [BP+2]
  iadd R1, 5
  mov [SP], R1
  call __function_b2DestroySet
__function_b2DestroyBroadPhase_return:
  mov SP, BP
  pop BP
  ret

__function_b2BufferMove:
  push BP
  mov BP, SP
  isub SP, 6
  mov R0, [BP+3]
  and R0, 3
  mov [BP-1], R0
  mov R0, [BP+3]
  shl R0, -2
  mov [BP-2], R0
__if_23741_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2GetBit
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_23741_end
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2SetBitGrow
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 4
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 3
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 3
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
__if_23741_end:
__function_b2BufferMove_return:
  mov SP, BP
  pop BP
  ret

__function_b2UnBufferMove:
  push BP
  mov BP, SP
  isub SP, 6
  mov R0, [BP+3]
  and R0, 3
  mov [BP-1], R0
  mov R0, [BP+3]
  shl R0, -2
  mov [BP-2], R0
__if_23804_start:
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2GetBit
  jf R0, __if_23804_end
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2ClearBit
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__for_23826_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_23826_end
__if_23836_start:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_23836_end
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  isub R1, 1
  iadd R0, R1
  mov R0, [R0]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-4]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-3]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  jmp __for_23826_end
__if_23836_end:
__for_23826_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_23826_start
__for_23826_end:
__if_23804_end:
__function_b2UnBufferMove_return:
  mov SP, BP
  pop BP
  ret

__function_b2BroadPhase_ClearMoveBuffer:
  push BP
  mov BP, SP
  isub SP, 4
  mov R0, 0
  mov [BP-1], R0
__for_23866_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_23866_end
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-2], R0
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-2]
  and R2, 3
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  shl R1, -2
  mov [SP+1], R1
  call __function_b2ClearBit
__for_23866_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23866_start
__for_23866_end:
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
__function_b2BroadPhase_ClearMoveBuffer_return:
  mov SP, BP
  pop BP
  ret

__function_b2BroadPhase_CreateProxy:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  isub SP, 4
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  mov R1, [BP+6]
  mov [SP+3], R1
  call __function_b2DynamicTree_CreateProxy
  mov [BP-1], R0
  mov R0, [BP-1]
  shl R0, 2
  mov R1, [BP+3]
  or R0, R1
  mov [BP-2], R0
__if_23930_start:
  mov R0, [BP+3]
  ine R0, 0
  jf R0, __if_23930_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2BufferMove
__if_23930_end:
  mov R0, [BP-2]
__function_b2BroadPhase_CreateProxy_return:
  iadd SP, 4
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2BroadPhase_DestroyProxy:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnBufferMove
  mov R0, [BP+3]
  and R0, 3
  mov [BP-1], R0
  mov R0, [BP+3]
  shl R0, -2
  mov [BP-2], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2DynamicTree_DestroyProxy
__function_b2BroadPhase_DestroyProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2BroadPhase_MoveProxy:
  push BP
  mov BP, SP
  isub SP, 5
  mov R0, [BP+3]
  and R0, 3
  mov [BP-1], R0
  mov R0, [BP+3]
  shl R0, -2
  mov [BP-2], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DynamicTree_MoveProxy
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2BufferMove
__function_b2BroadPhase_MoveProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2ContactEdgeAt:
  push BP
  mov BP, SP
__if_24076_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_24076_end
  mov R0, [BP+2]
  jmp __function_b2ContactEdgeAt_return
__if_24076_end:
  mov R0, [BP+2]
  iadd R0, 3
__function_b2ContactEdgeAt_return:
  mov SP, BP
  pop BP
  ret

__function_b2CanCollide:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  mov R0, [BP+2]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_24102
  mov R1, [BP+2]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24102:
  mov [BP-1], R0
  mov R0, [BP+3]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_24112
  mov R1, [BP+3]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24112:
  mov [BP-2], R0
__if_24115_start:
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_24117
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_24117:
  jf R0, __if_24115_end
  mov R0, 0
  jmp __function_b2CanCollide_return
__if_24115_end:
  mov R0, 1
__function_b2CanCollide_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCollisionRank:
  push BP
  mov BP, SP
__if_24125_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_24125_end
  mov R0, 0
  jmp __function_b2ShapeCollisionRank_return
__if_24125_end:
__if_24131_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_24131_end
  mov R0, 1
  jmp __function_b2ShapeCollisionRank_return
__if_24131_end:
__if_24137_start:
  mov R0, [BP+2]
  ieq R0, 3
  jf R0, __if_24137_end
  mov R0, 2
  jmp __function_b2ShapeCollisionRank_return
__if_24137_end:
__if_24143_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_24143_end
  mov R0, 3
  jmp __function_b2ShapeCollisionRank_return
__if_24143_end:
  mov R0, 4
__function_b2ShapeCollisionRank_return:
  mov SP, BP
  pop BP
  ret

__function_b2IsPrimaryOrder:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2ShapeCollisionRank
  mov R1, R0
  mov R3, [BP+3]
  mov [SP], R3
  call __function_b2ShapeCollisionRank
  mov R2, R0
  ige R1, R2
  mov R0, R1
__function_b2IsPrimaryOrder_return:
  iadd SP, 1
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ComputeManifold:
  push BP
  mov BP, SP
  isub SP, 14
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov R1, [BP+5]
  iadd R1, 10
  mov [R1], R0
__if_24177_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_24177_else
  mov R1, [BP+2]
  iadd R1, 28
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCircles
  jmp __if_24177_end
__if_24177_else:
__if_24191_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_24191_else
__if_24196_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24196_else
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsuleAndCircle
  jmp __if_24196_end
__if_24196_else:
  mov R1, [BP+2]
  iadd R1, 31
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsules
__if_24196_end:
  jmp __if_24191_end
__if_24191_else:
__if_24218_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_24218_else
__if_24223_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24223_else
  mov R1, [BP+2]
  iadd R1, 72
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndCircle
  jmp __if_24223_end
__if_24223_else:
__if_24236_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24236_else
  mov R1, [BP+2]
  iadd R1, 72
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndCapsule
  jmp __if_24236_end
__if_24236_else:
  mov R1, [BP+2]
  iadd R1, 72
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 36
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndPolygon
__if_24236_end:
__if_24223_end:
  jmp __if_24218_end
__if_24218_else:
__if_24258_start:
  mov R0, [BP-1]
  ieq R0, 4
  jf R0, __if_24258_else
__if_24263_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24263_else
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideChainSegmentAndCircle
  jmp __if_24263_end
__if_24263_else:
__if_24276_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24276_else
  mov R0, 0
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-9]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2CollideChainSegmentAndCapsule
  jmp __if_24276_end
__if_24276_else:
  mov R0, 0
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 36
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-9]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2CollideChainSegmentAndPolygon
__if_24276_end:
__if_24263_end:
  jmp __if_24258_end
__if_24258_else:
__if_24317_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24317_else
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 28
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygonAndCircle
  jmp __if_24317_end
__if_24317_else:
__if_24330_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24330_else
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 31
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygonAndCapsule
  jmp __if_24330_end
__if_24330_else:
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 36
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygons
__if_24330_end:
__if_24317_end:
__if_24258_end:
__if_24218_end:
__if_24191_end:
__if_24177_end:
__function_b2ComputeManifold_return:
  mov SP, BP
  pop BP
  ret

__function_b2MarshalManifoldPoint:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+7]
  mov [SP+1], R1
  mov R1, [BP+3]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 11
  mov [R1], R0
__function_b2MarshalManifoldPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2MatchWarmStart:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-1], R0
__if_24439_start:
  mov R0, [BP+3]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_24444
  mov R1, [BP+4]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24444:
  jf R0, __if_24439_else
  mov R0, [BP+5]
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP+6]
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  mov [R1], R0
  jmp __if_24439_end
__if_24439_else:
__if_24460_start:
  mov R0, [BP+3]
  ige R0, 2
  jf R0, __LogicalAnd_ShortCircuit_24465
  mov R1, [BP+7]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24465:
  jf R0, __if_24460_end
  mov R0, [BP+8]
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP+9]
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  mov [R1], R0
__if_24460_end:
__if_24439_end:
__function_b2MatchWarmStart_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateContact:
  push BP
  mov BP, SP
  isub SP, 26
  push R1
  push R2
  push R3
  push R4
  push R5
  isub SP, 8
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 10
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 6
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 7
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 10
  mov R0, [R1]
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 6
  mov R0, [R1]
  mov [BP-6], R0
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 7
  mov R0, [R1]
  mov [BP-7], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+7]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2InvMulTransforms
  mov R0, 0
  mov [BP-12], R0
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  lea R1, [BP-22]
  mov [SP+3], R1
  call __function_b2ComputeManifold
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+2]
  iadd R1, 9
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R0, [BP-12]
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 27
  mov [R1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+7]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
__if_24595_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_24595_end
  lea R1, [BP-20]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  mov R1, [BP+8]
  mov [SP+5], R1
  call __function_b2MarshalManifoldPoint
__if_24595_end:
__if_24617_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_24617_end
  lea R1, [BP-16]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  mov R1, [BP+8]
  mov [SP+5], R1
  call __function_b2MarshalManifoldPoint
__if_24617_end:
__if_24639_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_24639_end
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  mov R1, [BP-4]
  mov [SP+4], R1
  mov R1, [BP-5]
  mov [SP+5], R1
  mov R1, [BP-6]
  mov [SP+6], R1
  mov R1, [BP-7]
  mov [SP+7], R1
  call __function_b2MatchWarmStart
__if_24639_end:
__if_24658_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_24658_end
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  mov R1, [BP-4]
  mov [SP+4], R1
  mov R1, [BP-5]
  mov [SP+5], R1
  mov R1, [BP-6]
  mov [SP+6], R1
  mov R1, [BP-7]
  mov [SP+7], R1
  call __function_b2MatchWarmStart
__if_24658_end:
  mov R3, 0.000000
  mov [SP], R3
  mov R4, [BP+3]
  iadd R4, 6
  mov R3, [R4]
  mov R5, [BP+6]
  iadd R5, 6
  mov R4, [R5]
  fmul R3, R4
  mov [SP+1], R3
  call __function_b2MaxFloat
  mov R2, R0
  mov [BP-26], R2
  mov R2, [BP-26]
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 37
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+3]
  iadd R3, 7
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+6]
  iadd R3, 7
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 38
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 39
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 40
  mov [R1], R0
  mov R0, [BP-12]
  igt R0, 0
  mov [BP-25], R0
__if_24710_start:
  mov R0, [BP-25]
  jf R0, __if_24710_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 65536
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_24710_end
__if_24710_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_24710_end:
__if_24727_start:
  mov R0, [BP-25]
  jf R0, __LogicalAnd_ShortCircuit_24729
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  jt R1, __LogicalOr_ShortCircuit_24733
  mov R3, [BP+6]
  iadd R3, 22
  mov R2, [R3]
  or R1, R2
__LogicalOr_ShortCircuit_24733:
  and R0, R1
__LogicalAnd_ShortCircuit_24729:
  jf R0, __if_24727_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 1048576
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_24727_end
__if_24727_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -1048577
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_24727_end:
  mov R0, [BP-25]
__function_b2UpdateContact_return:
  iadd SP, 8
  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MakeSoft:
  push BP
  mov BP, SP
  isub SP, 4
__if_24765_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __if_24765_end
  mov R0, 0.000000
  mov R1, [BP+5]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+5]
  iadd R1, 2
  mov [R1], R0
  jmp __function_b2MakeSoft_return
__if_24765_end:
  mov R0, [BP+2]
  fmul R0, 6.283185
  mov [BP-1], R0
  mov R0, [BP+3]
  fmul R0, 2.000000
  mov R1, [BP+4]
  mov R2, [BP-1]
  fmul R1, R2
  fadd R0, R1
  mov [BP-2], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  fmul R0, R1
  mov R1, [BP-2]
  fmul R0, R1
  mov [BP-3], R0
  mov R0, 1.000000
  mov R1, [BP-3]
  fadd R1, 1.000000
  fdiv R0, R1
  mov [BP-4], R0
  mov R0, [BP-1]
  mov R1, [BP-2]
  fdiv R0, R1
  mov R1, [BP+5]
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-4]
  fmul R0, R1
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-4]
  mov R1, [BP+5]
  iadd R1, 2
  mov [R1], R0
__function_b2MakeSoft_return:
  mov SP, BP
  pop BP
  ret

__function_b2JointEdgeAt:
  push BP
  mov BP, SP
__if_25181_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_25181_end
  mov R0, [BP+2]
  iadd R0, 4
  jmp __function_b2JointEdgeAt_return
__if_25181_end:
  mov R0, [BP+2]
  iadd R0, 4
  iadd R0, 3
__function_b2JointEdgeAt_return:
  mov SP, BP
  pop BP
  ret

__function_b2AddTouchEvent:
  push BP
  mov BP, SP
  isub SP, 4
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 2
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2AddTouchEvent_return:
  mov SP, BP
  pop BP
  ret

__function_b2AddHitEvent:
  push BP
  mov BP, SP
  isub SP, 4
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 7
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov R13, [R1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 7
  iadd R13, R1
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 7
  movs
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2AddHitEvent_return:
  mov SP, BP
  pop BP
  ret

__function_b2AddSensorEvent:
  push BP
  mov BP, SP
  isub SP, 4
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 2
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+4]
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2AddSensorEvent_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateWorld:
  push BP
  mov BP, SP
  isub SP, 6
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 4
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 4
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 7
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 18
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2CreateBroadPhase
  mov R1, [BP+2]
  iadd R1, 29
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 33
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 40
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 40
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 40
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 53
  mov [R1], R0
  mov R0, -10.000000
  mov R1, [BP+2]
  iadd R1, 53
  iadd R1, 1
  mov [R1], R0
  mov R0, 30.000000
  mov R1, [BP+2]
  iadd R1, 55
  mov [R1], R0
  mov R0, 10.000000
  mov R1, [BP+2]
  iadd R1, 56
  mov [R1], R0
  mov R0, 3.000000
  mov R1, [BP+2]
  iadd R1, 57
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 58
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 59
  mov [R1], R0
  mov R0, 400.000000
  mov R1, [BP+2]
  iadd R1, 60
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 61
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 62
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 63
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 64
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 64
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 64
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 67
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 67
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 67
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 70
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 70
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 70
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 73
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 73
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 73
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 76
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 76
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 76
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 79
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 80
  mov [R1], R0
  mov R0, 0
  mov [BP-1], R0
__for_25945_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_25945_end
  mov R3, [BP+2]
  iadd R3, 11
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 11
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 16
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 11
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
  mov R0, -1
  mov R1, [BP-2]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 2
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 15
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
__for_25945_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_25945_start
__for_25945_end:
  mov R1, [BP+2]
  iadd R1, 43
  mov [SP], R1
  call __function_b2CreateIdPool
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 47
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 47
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 47
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 51
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 52
  mov [R1], R0
__function_b2CreateWorld_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyWorld:
  push BP
  mov BP, SP
  isub SP, 4
  mov R0, 0
  mov [BP-1], R0
__for_26111_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26111_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
__if_26131_start:
  mov R1, [BP-2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26131_end
  mov R2, [BP-2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_26131_end:
__if_26146_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26146_end
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 3
  iadd R2, 2
  mov R1, [R2]
  imul R1, 8
  mov [SP+1], R1
  call __function_b2Free
__if_26146_end:
__if_26161_start:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26161_end
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  iadd R2, 2
  mov R1, [R2]
  imul R1, 49
  mov [SP+1], R1
  call __function_b2Free
__if_26161_end:
__if_26176_start:
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26176_end
  mov R2, [BP-2]
  iadd R2, 9
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 9
  iadd R2, 2
  mov R1, [R2]
  imul R1, 212
  mov [SP+1], R1
  call __function_b2Free
__if_26176_end:
__if_26191_start:
  mov R1, [BP-2]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26191_end
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 2
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
__if_26191_end:
__for_26111_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26111_start
__for_26111_end:
__if_26206_start:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26206_end
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 2
  mov R1, [R2]
  imul R1, 16
  mov [SP+1], R1
  call __function_b2Free
__if_26206_end:
__if_26221_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26221_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 2
  mov R1, [R2]
  imul R1, 21
  mov [SP+1], R1
  call __function_b2Free
__if_26221_end:
__if_26236_start:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26236_end
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 2
  mov R1, [R2]
  imul R1, 85
  mov [SP+1], R1
  call __function_b2Free
__if_26236_end:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2DestroyBroadPhase
__if_26255_start:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26255_end
  mov R2, [BP+2]
  iadd R2, 33
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 2
  mov R1, [R2]
  imul R1, 16
  mov [SP+1], R1
  call __function_b2Free
__if_26255_end:
__if_26270_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26270_end
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 2
  mov R1, [R2]
  imul R1, 17
  mov [SP+1], R1
  call __function_b2Free
__if_26270_end:
  mov R0, 0
  mov [BP-1], R0
__for_26285_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26285_end
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_26305_start:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26305_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26305_end:
__if_26315_start:
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26315_end
  mov R2, [BP-2]
  iadd R2, 7
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 9
  mov R1, [R2]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
__if_26315_end:
__if_26327_start:
  mov R1, [BP-2]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26327_end
  mov R2, [BP-2]
  iadd R2, 10
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
__if_26327_end:
__for_26285_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26285_start
__for_26285_end:
__if_26339_start:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26339_end
  mov R2, [BP+2]
  iadd R2, 47
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 2
  mov R1, [R2]
  imul R1, 13
  mov [SP+1], R1
  call __function_b2Free
__if_26339_end:
__if_26354_start:
  mov R1, [BP+2]
  iadd R1, 62
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26354_end
  mov R2, [BP+2]
  iadd R2, 62
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 63
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26354_end:
__if_26364_start:
  mov R1, [BP+2]
  iadd R1, 64
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26364_end
  mov R2, [BP+2]
  iadd R2, 64
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 64
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26364_end:
__if_26379_start:
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26379_end
  mov R2, [BP+2]
  iadd R2, 67
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 67
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26379_end:
__if_26394_start:
  mov R1, [BP+2]
  iadd R1, 70
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26394_end
  mov R2, [BP+2]
  iadd R2, 70
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 70
  iadd R2, 2
  mov R1, [R2]
  imul R1, 7
  mov [SP+1], R1
  call __function_b2Free
__if_26394_end:
__if_26409_start:
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26409_end
  mov R2, [BP+2]
  iadd R2, 73
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 73
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26409_end:
__if_26424_start:
  mov R1, [BP+2]
  iadd R1, 76
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26424_end
  mov R2, [BP+2]
  iadd R2, 76
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 76
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26424_end:
__if_26439_start:
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26439_end
  mov R2, [BP+2]
  iadd R2, 79
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 80
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
__if_26439_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2DestroyIdPool
  mov R1, [BP+2]
  iadd R1, 7
  mov [SP], R1
  call __function_b2DestroyIdPool
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  call __function_b2DestroyIdPool
  mov R1, [BP+2]
  iadd R1, 29
  mov [SP], R1
  call __function_b2DestroyIdPool
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  call __function_b2DestroyIdPool
  mov R1, [BP+2]
  iadd R1, 43
  mov [SP], R1
  call __function_b2DestroyIdPool
__function_b2DestroyWorld_return:
  mov SP, BP
  pop BP
  ret

__function_b2WakeBody:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
__if_26484_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_26484_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
  mov R0, 1
  jmp __function_b2WakeBody_return
__if_26484_end:
  mov R0, 0
__function_b2WakeBody_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateIsland:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  push R3
  isub SP, 4
  mov R1, [BP+2]
  iadd R1, 43
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-1], R0
__if_26507_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_26507_end
  mov R3, [BP+2]
  iadd R3, 47
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 47
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 13
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 47
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 47
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 13
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 13
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 47
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 47
  iadd R1, 1
  mov [R1], R0
__if_26507_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP+3]
  mov R1, [BP-3]
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R3, [BP-2]
  iadd R3, 12
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 12
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 12
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov R3, [BP-2]
  iadd R3, 12
  iadd R3, 1
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-3]
__function_b2CreateIsland_return:
  iadd SP, 4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DestroyIsland:
  push BP
  mov BP, SP
  isub SP, 7
__if_26662_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_26662_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_26662_end:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-1]
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_26701_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_26701_end
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-4]
  iadd R1, R2
  mov R0, [R1]
  mov [BP-5], R0
  mov R2, [BP-2]
  iadd R2, 12
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-3]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 47
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 13
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
__if_26701_end:
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
__if_26742_start:
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26742_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26742_end:
__if_26752_start:
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26752_end
  mov R2, [BP-1]
  iadd R2, 7
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 9
  mov R1, [R2]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
__if_26752_end:
__if_26764_start:
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26764_end
  mov R2, [BP-1]
  iadd R2, 10
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
__if_26764_end:
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 43
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2FreeId
__function_b2DestroyIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2MergeIslands:
  push BP
  mov BP, SP
  isub SP, 10
  push R1
  push R2
  push R3
  isub SP, 4
__if_26843_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_26843_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_26843_end:
__if_26849_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_26849_end
  mov R0, [BP+4]
  jmp __function_b2MergeIslands_return
__if_26849_end:
__if_26857_start:
  mov R0, [BP+4]
  ieq R0, -1
  jf R0, __if_26857_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_26857_end:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+4]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_26885_start:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_26885_else
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
  jmp __if_26885_end
__if_26885_else:
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__if_26885_end:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_26911_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26911_end
  mov R2, [BP-4]
  iadd R2, 4
  mov R0, [R2]
  mov R1, [BP-6]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-7], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-7]
  imul R1, 21
  iadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-5]
  mov R1, [BP-8]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 11
  mov [R1], R0
  mov R3, [BP-3]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 6
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 5
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-7]
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-3]
  iadd R3, 5
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 5
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
__for_26911_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_26911_start
__for_26911_end:
  mov R0, 0
  mov [BP-6], R0
__for_26973_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26973_end
  mov R1, [BP-4]
  iadd R1, 7
  mov R12, [R1]
  mov R1, [BP-6]
  imul R1, 3
  iadd R12, R1
  lea DR, [BP-9]
  mov CR, 3
  movs
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-9]
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R0, [BP-5]
  mov R1, [BP-10]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-10]
  iadd R1, 7
  mov [R1], R0
  mov R3, [BP-3]
  iadd R3, 7
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 9
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 8
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 7
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  iadd R1, 7
  mov R13, [R1]
  mov R2, [BP-3]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-9]
  mov CR, 3
  movs
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
__for_26973_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_26973_start
__for_26973_end:
  mov R0, 0
  mov [BP-6], R0
__for_27036_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27036_end
  mov R1, [BP-4]
  iadd R1, 10
  mov R12, [R1]
  mov R1, [BP-6]
  imul R1, 3
  iadd R12, R1
  lea DR, [BP-9]
  mov CR, 3
  movs
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-9]
  imul R1, 17
  iadd R0, R1
  mov [BP-10], R0
  mov R0, [BP-5]
  mov R1, [BP-10]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-10]
  iadd R1, 12
  mov [R1], R0
  mov R3, [BP-3]
  iadd R3, 10
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 12
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 11
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  iadd R1, 10
  mov R13, [R1]
  mov R2, [BP-3]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-9]
  mov CR, 3
  movs
  mov R1, [BP-3]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 11
  mov [R1], R0
__for_27036_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27036_start
__for_27036_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 3
  mov R1, [R2]
  iadd R0, R1
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2DestroyIsland
  mov R0, [BP-5]
__function_b2MergeIslands_return:
  iadd SP, 4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2AddContactToIsland:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+4]
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+4]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R3, [BP-1]
  iadd R3, 7
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-1]
  iadd R2, 9
  mov [SP+1], R2
  mov R3, [BP-1]
  iadd R3, 8
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 7
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-1]
  iadd R1, 7
  mov R13, [R1]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-4]
  mov CR, 3
  movs
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
__function_b2AddContactToIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2LinkContact:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 10
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP-4]
  iadd R2, 10
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2MergeIslands
  mov [BP-5], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2AddContactToIsland
__function_b2LinkContact_return:
  mov SP, BP
  pop BP
  ret

__function_b2UnlinkContact:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 7
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_27255_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27255_end
  mov R1, [BP-2]
  iadd R1, 7
  mov R13, [R1]
  mov R1, [BP-3]
  imul R1, 3
  iadd R13, R1
  mov R1, [BP-2]
  iadd R1, 7
  mov R12, [R1]
  mov R1, [BP-4]
  imul R1, 3
  iadd R12, R1
  mov CR, 3
  movs
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R3, [BP-2]
  iadd R3, 7
  mov R2, [R3]
  mov R3, [BP-3]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  iadd R1, 7
  mov [R1], R0
__if_27255_end:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__function_b2UnlinkContact_return:
  mov SP, BP
  pop BP
  ret

__function_b2AddJointToIsland:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 12
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+4]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+4]
  iadd R1, 4
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R3, [BP-1]
  iadd R3, 10
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-1]
  iadd R2, 12
  mov [SP+1], R2
  mov R3, [BP-1]
  iadd R3, 11
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-1]
  iadd R1, 10
  mov R13, [R1]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-4]
  mov CR, 3
  movs
  mov R1, [BP-1]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R1, 11
  mov [R1], R0
__function_b2AddJointToIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2LinkJoint:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 10
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP-4]
  iadd R2, 10
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2MergeIslands
  mov [BP-5], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2AddJointToIsland
__function_b2LinkJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2UnlinkJoint:
  push BP
  mov BP, SP
  isub SP, 5
__if_27431_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27431_end
  jmp __function_b2UnlinkJoint_return
__if_27431_end:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-2]
  iadd R1, 11
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_27461_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27461_end
  mov R1, [BP-2]
  iadd R1, 10
  mov R13, [R1]
  mov R1, [BP-3]
  imul R1, 3
  iadd R13, R1
  mov R1, [BP-2]
  iadd R1, 10
  mov R12, [R1]
  mov R1, [BP-4]
  imul R1, 3
  iadd R12, R1
  mov CR, 3
  movs
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-2]
  iadd R3, 10
  mov R2, [R3]
  mov R3, [BP-3]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-5], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  iadd R1, 12
  mov [R1], R0
__if_27461_end:
  mov R1, [BP-2]
  iadd R1, 11
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 11
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 11
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__function_b2UnlinkJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateIslandForBody:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2CreateIsland
  mov [BP-1], R0
  mov R3, [BP-1]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-1]
  iadd R2, 6
  mov [SP+1], R2
  mov R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+4]
  iadd R1, 17
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 11
  mov [R1], R0
__function_b2CreateIslandForBody_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveBodyFromIsland:
  push BP
  mov BP, SP
  isub SP, 7
__if_27560_start:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27560_end
  jmp __function_b2RemoveBodyFromIsland_return
__if_27560_end:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_27590_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27590_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-5], R0
  mov R0, [BP-5]
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-3]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 21
  iadd R1, R2
  iadd R1, 11
  mov [R1], R0
__if_27590_end:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 11
  mov [R1], R0
__if_27634_start:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_27634_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2DestroyIsland
__if_27634_end:
__function_b2RemoveBodyFromIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2IslandFindParent:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
__while_27645_start:
__while_27645_continue:
  mov R0, [BP+2]
  mov R1, [BP+3]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ine R0, R1
  jf R0, __while_27645_end
  mov R0, [BP+2]
  mov R1, [BP+2]
  mov R2, [BP+3]
  iadd R1, R2
  mov R1, [R1]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP+3]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-1]
  mov [BP+3], R0
  jmp __while_27645_start
__while_27645_end:
  mov R0, [BP+3]
__function_b2IslandFindParent_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2IslandUnion:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2IslandFindParent
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_b2IslandFindParent
  mov [BP-2], R0
__if_27684_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_27684_end
  jmp __function_b2IslandUnion_return
__if_27684_end:
__if_27689_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_27689_else
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  jmp __if_27689_end
__if_27689_else:
__if_27702_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  igt R0, R1
  jf R0, __if_27702_else
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  jmp __if_27702_end
__if_27702_else:
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  iadd R0, 1
  mov R1, [BP+3]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
__if_27702_end:
__if_27689_end:
__function_b2IslandUnion_return:
  mov SP, BP
  pop BP
  ret

__function_b2SplitIsland:
  push BP
  mov BP, SP
  isub SP, 25
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  mov [BP-5], R0
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov [BP-7], R0
  mov R1, [BP-1]
  iadd R1, 11
  mov R0, [R1]
  mov [BP-8], R0
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
__if_27777_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_27777_end
  jmp __function_b2SplitIsland_return
__if_27777_end:
  mov R1, [BP-2]
  mov [SP], R1
  call __function_b2Alloc
  mov [BP-11], R0
  mov R1, [BP-2]
  mov [SP], R1
  call __function_b2Alloc
  mov [BP-12], R0
  mov R0, 0
  mov [BP-13], R0
__for_27792_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_27792_end
  mov R0, [BP-13]
  mov R1, [BP-11]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-12]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_27792_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_27792_start
__for_27792_end:
  mov R0, 0
  mov [BP-13], R0
__for_27812_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_27812_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-6]
  mov R4, [BP-13]
  imul R4, 3
  iadd R3, R4
  iadd R3, 1
  mov R2, [R3]
  imul R2, 21
  iadd R1, R2
  iadd R1, 11
  mov R0, [R1]
  mov [BP-16], R0
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-6]
  mov R4, [BP-13]
  imul R4, 3
  iadd R3, R4
  iadd R3, 2
  mov R2, [R3]
  imul R2, 21
  iadd R1, R2
  iadd R1, 11
  mov R0, [R1]
  mov [BP-17], R0
__if_27844_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_27851
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_27851:
  jf R0, __if_27844_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_27844_end:
__for_27812_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_27812_start
__for_27812_end:
  mov R0, 0
  mov [BP-13], R0
__for_27861_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_27861_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-9]
  mov R4, [BP-13]
  imul R4, 3
  iadd R3, R4
  iadd R3, 1
  mov R2, [R3]
  imul R2, 21
  iadd R1, R2
  iadd R1, 11
  mov R0, [R1]
  mov [BP-16], R0
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-9]
  mov R4, [BP-13]
  imul R4, 3
  iadd R3, R4
  iadd R3, 2
  mov R2, [R3]
  imul R2, 21
  iadd R1, R2
  iadd R1, 11
  mov R0, [R1]
  mov [BP-17], R0
__if_27893_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_27900
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_27900:
  jf R0, __if_27893_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_27893_end:
__for_27861_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_27861_start
__for_27861_end:
  mov R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
__for_27916_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_27916_end
  mov R2, [BP-11]
  mov [SP], R2
  mov R2, [BP-13]
  mov [SP+1], R2
  call __function_b2IslandFindParent
  mov R1, R0
  mov R2, [BP-11]
  mov R3, [BP-13]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
__if_27933_start:
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-13]
  ieq R0, R1
  jf R0, __if_27933_end
  mov R0, [BP-14]
  iadd R0, 1
  mov [BP-14], R0
__if_27933_end:
__for_27916_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_27916_start
__for_27916_end:
__if_27944_start:
  mov R0, [BP-14]
  ieq R0, 1
  jf R0, __if_27944_end
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  jmp __function_b2SplitIsland_return
__if_27944_end:
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 12
  mov [R1], R0
  mov R0, -1
  mov [BP-1], R0
  mov R1, [BP-2]
  mov [SP], R1
  call __function_b2Alloc
  mov [BP-15], R0
  mov R0, 0
  mov [BP-13], R0
__for_28000_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28000_end
  mov R0, -1
  mov R1, [BP-15]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_28000_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28000_start
__for_28000_end:
  mov R0, 0
  mov [BP-13], R0
__for_28016_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28016_end
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
__if_28031_start:
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov R0, [R0]
  ieq R0, -1
  jf R0, __if_28031_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  call __function_b2CreateIsland
  mov [BP-17], R0
  mov R1, [BP-17]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-15]
  mov R2, [BP-16]
  iadd R1, R2
  mov [R1], R0
__if_28031_end:
__for_28016_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28016_start
__for_28016_end:
  mov R0, 0
  mov [BP-13], R0
__for_28051_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28051_end
  mov R0, [BP-3]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
  mov R0, [BP-15]
  mov R1, [BP-11]
  mov R2, [BP-13]
  iadd R1, R2
  mov R1, [R1]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-17], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-16]
  imul R1, 21
  iadd R0, R1
  mov [BP-18], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-17]
  imul R1, 13
  iadd R0, R1
  mov [BP-19], R0
  mov R0, [BP-17]
  mov R1, [BP-18]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP-19]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-18]
  iadd R1, 11
  mov [R1], R0
  mov R3, [BP-19]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-19]
  iadd R2, 6
  mov [SP+1], R2
  mov R3, [BP-19]
  iadd R3, 5
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-19]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-16]
  mov R2, [BP-19]
  iadd R2, 4
  mov R1, [R2]
  mov R3, [BP-19]
  iadd R3, 5
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-19]
  iadd R1, 5
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-19]
  iadd R1, 5
  mov [R1], R0
__for_28051_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28051_start
__for_28051_end:
  mov R0, 0
  mov [BP-13], R0
__for_28126_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28126_end
  mov R12, [BP-6]
  mov R1, [BP-13]
  imul R1, 3
  iadd R12, R1
  lea DR, [BP-18]
  mov CR, 3
  movs
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-17]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28150_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28150_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28150_end:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-18]
  imul R1, 16
  iadd R0, R1
  mov [BP-20], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-19]
  imul R1, 13
  iadd R0, R1
  mov [BP-21], R0
  mov R0, [BP-19]
  mov R1, [BP-20]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-21]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-20]
  iadd R1, 7
  mov [R1], R0
  mov R3, [BP-21]
  iadd R3, 7
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-21]
  iadd R2, 9
  mov [SP+1], R2
  mov R3, [BP-21]
  iadd R3, 8
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-21]
  iadd R2, 7
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-21]
  iadd R1, 7
  mov R13, [R1]
  mov R2, [BP-21]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-18]
  mov CR, 3
  movs
  mov R1, [BP-21]
  iadd R1, 8
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-21]
  iadd R1, 8
  mov [R1], R0
__for_28126_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28126_start
__for_28126_end:
  mov R0, 0
  mov [BP-13], R0
__for_28219_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28219_end
  mov R12, [BP-9]
  mov R1, [BP-13]
  imul R1, 3
  iadd R12, R1
  lea DR, [BP-18]
  mov CR, 3
  movs
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-17]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28243_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28243_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28243_end:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-18]
  imul R1, 17
  iadd R0, R1
  mov [BP-20], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-19]
  imul R1, 13
  iadd R0, R1
  mov [BP-21], R0
  mov R0, [BP-19]
  mov R1, [BP-20]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-21]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-20]
  iadd R1, 12
  mov [R1], R0
  mov R3, [BP-21]
  iadd R3, 10
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-21]
  iadd R2, 12
  mov [SP+1], R2
  mov R3, [BP-21]
  iadd R3, 11
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 3
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-21]
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-21]
  iadd R1, 10
  mov R13, [R1]
  mov R2, [BP-21]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 3
  iadd R13, R1
  lea R12, [BP-18]
  mov CR, 3
  movs
  mov R1, [BP-21]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-21]
  iadd R1, 11
  mov [R1], R0
__for_28219_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28219_start
__for_28219_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2DestroyIsland
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP-9]
  mov [SP], R1
  mov R1, [BP-10]
  imul R1, 3
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
__function_b2SplitIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSplitIsland:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R0, -1
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_28351_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_28351_end
  mov R2, [BP-1]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-3]
  iadd R1, R2
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 13
  iadd R0, R1
  mov [BP-5], R0
__if_28379_start:
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_28385
  mov R1, [BP-4]
  mov R2, [BP-2]
  igt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_28385:
  jf R0, __if_28379_end
  mov R0, [BP-4]
  mov [BP-2], R0
__if_28379_end:
__for_28351_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_28351_start
__for_28351_end:
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__function_b2UpdateSplitIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetBodyFullId:
  push BP
  mov BP, SP
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 21
  iadd R0, R1
__function_b2GetBodyFullId_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2GetBodyTransformQuick:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-2], R0
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, [BP-2]
  mov CR, 4
  movs
__function_b2GetBodyTransformQuick_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetBodyTransform:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
__function_b2GetBodyTransform_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetBodySim:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
__function_b2GetBodySim_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2GetBodyState:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
__if_28557_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_28557_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  jmp __function_b2GetBodyState_return
__if_28557_end:
  mov R0, -1
__function_b2GetBodyState_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DefaultBodyDef:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 22
  mov [SP+2], R1
  call __function_memset
  mov R0, 0
  mov R1, [BP+2]
  mov [R1], R0
  mov R13, [BP+2]
  iadd R13, 3
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP+2]
  iadd R2, 11
  mov [R2], R1
  mov R0, R1
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 10
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 16
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 21
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 17
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 19
  mov [R1], R0
__function_b2DefaultBodyDef_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateBody:
  push BP
  mov BP, SP
  isub SP, 12
  mov R1, [BP+3]
  iadd R1, 17
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_28630
  mov R2, [BP+3]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_28630:
  jf R0, __LogicalAnd_ShortCircuit_28635
  mov R2, [BP+3]
  iadd R2, 19
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_28635:
  mov [BP-1], R0
__if_28640_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28640_else
  mov R0, 1
  mov [BP-2], R0
  jmp __if_28640_end
__if_28640_else:
__if_28649_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28649_else
  mov R0, 0
  mov [BP-2], R0
  jmp __if_28649_end
__if_28649_else:
__if_28658_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_28658_else
  mov R0, 2
  mov [BP-2], R0
  jmp __if_28658_end
__if_28658_else:
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
__if_28673_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_28673_end
  mov R3, [BP+2]
  iadd R3, 11
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 11
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 16
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 11
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-8], R0
  mov R0, -1
  mov R1, [BP-8]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 6
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 12
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 15
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
__if_28673_end:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov [R1], R0
__if_28658_end:
__if_28649_end:
__if_28640_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__if_28815_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  jf R0, __if_28815_end
  mov R0, [BP-4]
  or R0, 1
  mov [BP-4], R0
__if_28815_end:
__if_28823_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  jf R0, __if_28823_end
  mov R0, [BP-4]
  or R0, 2
  mov [BP-4], R0
__if_28823_end:
__if_28831_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  jf R0, __if_28831_end
  mov R0, [BP-4]
  or R0, 4
  mov [BP-4], R0
__if_28831_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-5]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-5]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-5]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 24
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-5]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-5]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 24
  mov [SP+2], R1
  call __function_memset
  mov R13, [BP-6]
  mov R12, [BP+3]
  iadd R12, 1
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 2
  mov R12, [BP+3]
  iadd R12, 3
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 1
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 6
  mov R12, [BP-6]
  iadd R12, 2
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 8
  mov R12, [BP-6]
  iadd R12, 4
  mov CR, 2
  movs
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP-6]
  iadd R1, 18
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 19
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 20
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 21
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-6]
  iadd R1, 22
  mov [R1], R0
  mov R0, [BP-4]
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28950_start:
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  jf R0, __if_28950_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 16
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28950_end:
__if_28960_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_28960_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 128
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28960_end:
__if_28970_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_28970_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 512
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28970_end:
__if_28982_start:
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  jf R0, __if_28982_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 2048
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28982_end:
__if_28992_start:
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  jf R0, __if_28992_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 4096
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_28992_end:
__if_29002_start:
  mov R0, [BP-2]
  ieq R0, 2
  jf R0, __if_29002_end
  mov R3, [BP-5]
  iadd R3, 3
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-5]
  iadd R2, 3
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-5]
  iadd R3, 3
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 8
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-5]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 3
  iadd R2, 1
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-8]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 8
  mov [SP+2], R1
  call __function_memset
  mov R13, [BP-8]
  mov R12, [BP+3]
  iadd R12, 5
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP-8]
  iadd R13, 6
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 3
  mov [R1], R0
__if_29002_end:
__if_29067_start:
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29067_end
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 4
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 21
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-3]
  imul R2, 21
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 21
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 4
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 4
  iadd R1, 1
  mov [R1], R0
__if_29067_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 21
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-7]
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-7]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-7]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 20
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-7]
  iadd R1, 20
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-7]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 7
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-7]
  iadd R1, 4
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-7]
  iadd R1, 9
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 11
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-7]
  iadd R1, 16
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-7]
  iadd R1, 17
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-7]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-7]
  iadd R1, 13
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-7]
  iadd R1, 14
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-7]
  iadd R1, 15
  mov [R1], R0
  mov R1, [BP+3]
  mov R0, [R1]
  mov R1, [BP-7]
  iadd R1, 19
  mov [R1], R0
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-7]
  iadd R1, 18
  mov [R1], R0
__if_29227_start:
  mov R0, [BP-2]
  ige R0, 2
  jf R0, __if_29227_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2CreateIslandForBody
__if_29227_end:
  mov R0, [BP-3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 61
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
__function_b2CreateBody_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveBodySim:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  mov R1, [BP+2]
  mov R13, [R1]
  mov R1, [BP+4]
  imul R1, 24
  iadd R13, R1
  mov R1, [BP+2]
  mov R12, [R1]
  mov R1, [BP-1]
  imul R1, 24
  iadd R12, R1
  mov CR, 24
  movs
  mov R1, [BP+3]
  mov R0, [R1]
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+4]
  imul R3, 24
  iadd R2, R3
  iadd R2, 22
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP+4]
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__function_b2RemoveBodySim_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateBodyMassData:
  push BP
  mov BP, SP
  isub SP, 19
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-1]
  iadd R1, 15
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  mov R13, [BP-1]
  iadd R13, 10
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP-1]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP-1]
  iadd R1, 18
  mov [R1], R0
__if_29560_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_29560_end
  mov R13, [BP-1]
  iadd R13, 4
  mov R12, [BP-1]
  mov CR, 2
  movs
  mov R13, [BP-1]
  iadd R13, 8
  mov R12, [BP-1]
  iadd R12, 4
  mov CR, 2
  movs
__if_29577_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_29577_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29587_start:
__while_29587_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29587_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  mov R1, global_b2Vec2_zero
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2ComputeShapeExtent
  mov R3, [BP-1]
  iadd R3, 17
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-10]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  iadd R3, 18
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-9]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 18
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_29587_start
__while_29587_end:
__if_29577_end:
  jmp __function_b2UpdateBodyMassData_return
__if_29560_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29638_start:
__while_29638_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29638_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2ComputeShapeMass
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-12]
  fadd R0, R1
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  lea R1, [BP-14]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-4]
  lea R12, [BP-14]
  mov CR, 2
  movs
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_29638_start
__while_29638_end:
__if_29686_start:
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_29686_end
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 12
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 15
  mov [R1], R0
  mov R2, [BP-1]
  iadd R2, 15
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R13, [BP-4]
  lea R12, [BP-9]
  mov CR, 2
  movs
__if_29686_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29715_start:
__while_29715_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29715_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2ComputeShapeMass
__if_29736_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_29736_end
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-9]
  mov R2, [BP-12]
  lea R4, [BP-14]
  mov [SP], R4
  lea R4, [BP-14]
  mov [SP+1], R4
  call __function_b2Dot
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-15], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov R1, [BP-15]
  fadd R0, R1
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_29736_end:
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_29715_start
__while_29715_end:
__if_29776_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_29776_else
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 13
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  jmp __if_29776_end
__if_29776_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_29776_end:
  mov R12, [BP-1]
  iadd R12, 4
  lea DR, [BP-6]
  mov CR, 2
  movs
  mov R13, [BP-1]
  iadd R13, 10
  lea R12, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 4
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R13, [BP-1]
  iadd R13, 8
  mov R12, [BP-1]
  iadd R12, 4
  mov CR, 2
  movs
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-7], R0
__if_29820_start:
  mov R0, [BP-7]
  ine R0, -1
  jf R0, __if_29820_end
  mov R1, [BP-1]
  iadd R1, 4
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2Sub
  mov R2, [BP-7]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-9]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-7]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2Add
  mov R13, [BP-7]
  lea R12, [BP-13]
  mov CR, 2
  movs
__if_29820_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29862_start:
__while_29862_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29862_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2ComputeShapeExtent
  mov R3, [BP-1]
  iadd R3, 17
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-10]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  mov R3, [BP-1]
  iadd R3, 18
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-9]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-1]
  iadd R2, 18
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_29862_start
__while_29862_end:
__function_b2UpdateBodyMassData_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateShapeInternal:
  push BP
  mov BP, SP
  isub SP, 12
  push R1
  push R2
  push R3
  isub SP, 5
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-1], R0
__if_29917_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29917_end
  mov R3, [BP+2]
  iadd R3, 18
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 18
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 85
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 18
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 85
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 85
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 1
  mov [R1], R0
__if_29917_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 85
  iadd R0, R1
  mov [BP-2], R0
__if_29968_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_29968_else
  mov R13, [BP-2]
  iadd R13, 28
  mov R12, [BP+5]
  mov CR, 3
  movs
  jmp __if_29968_end
__if_29968_else:
__if_29978_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_29978_else
  mov R13, [BP-2]
  iadd R13, 31
  mov R12, [BP+5]
  mov CR, 5
  movs
  jmp __if_29978_end
__if_29978_else:
__if_29988_start:
  mov R0, [BP+6]
  ieq R0, 3
  jf R0, __if_29988_else
  mov R13, [BP-2]
  iadd R13, 36
  mov R12, [BP+5]
  mov CR, 36
  movs
  jmp __if_29988_end
__if_29988_else:
__if_29998_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_29998_else
  mov R13, [BP-2]
  iadd R13, 72
  mov R12, [BP+5]
  mov CR, 4
  movs
  jmp __if_29998_end
__if_29998_else:
__if_30008_start:
  mov R0, [BP+6]
  ieq R0, 4
  jf R0, __if_30008_end
  mov R13, [BP-2]
  iadd R13, 76
  mov R12, [BP+5]
  mov CR, 9
  movs
__if_30008_end:
__if_29998_end:
__if_29988_end:
__if_29978_end:
__if_29968_end:
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 17
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+6]
  mov R1, [BP-2]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+4]
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 7
  mov [R1], R0
  mov R13, [BP-2]
  iadd R13, 19
  mov R12, [BP+4]
  iadd R12, 3
  mov CR, 3
  movs
  mov R1, [BP+4]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 22
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 23
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 24
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 25
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 26
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 27
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 18
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 8
  mov [R1], R0
__if_30091_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_30091_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_30091_end
__if_30091_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_30091_end:
  mov R13, [BP-2]
  iadd R13, 9
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 9
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 13
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 13
  iadd R13, 2
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_30133_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __if_30133_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
  mov R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-11], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  fsub R0, R1
  mov R1, [BP-2]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-9]
  mov R1, [BP-11]
  fsub R0, R1
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-8]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-10]
  mov R1, [BP-12]
  fsub R0, R1
  mov R1, [BP-2]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-9]
  mov R1, [BP-12]
  fsub R0, R1
  mov R1, [BP-2]
  iadd R1, 13
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-8]
  mov R1, [BP-12]
  fadd R0, R1
  mov R1, [BP-2]
  iadd R1, 13
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-12]
  fadd R0, R1
  mov R1, [BP-2]
  iadd R1, 13
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 21
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 19
  mov R2, [R3]
  mov [SP+1], R2
  mov R2, [BP-2]
  iadd R2, 13
  mov [SP+2], R2
  mov R3, [BP-2]
  iadd R3, 19
  mov R2, [R3]
  mov [SP+3], R2
  mov R3, [BP-2]
  mov R2, [R3]
  mov [SP+4], R2
  call __function_b2BroadPhase_CreateProxy
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 8
  mov [R2], R1
  mov R0, R1
__if_30133_end:
__if_30264_start:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30264_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_30264_end:
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateShapeInternal_return:
  iadd SP, 5
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreatePolygonShape:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, 3
  mov [SP+4], R1
  call __function_b2CreateShapeInternal
  mov [BP-2], R0
__if_30370_start:
  mov R1, [BP+4]
  iadd R1, 9
  mov R0, [R1]
  jf R0, __if_30370_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30370_end:
  mov R1, [BP-2]
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+6]
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+6]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+6]
  iadd R1, 2
  mov [R1], R0
__function_b2CreatePolygonShape_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateChainSegmentShape:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, 4
  mov [SP+4], R1
  call __function_b2CreateShapeInternal
  mov [BP-2], R0
  mov R1, [BP-2]
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+6]
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+6]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+6]
  iadd R1, 2
  mov [R1], R0
__function_b2CreateChainSegmentShape_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShape:
  push BP
  mov BP, SP
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 85
  iadd R0, R1
__function_b2GetShape_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DestroyShapeInternal:
  push BP
  mov BP, SP
  isub SP, 9
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-2], R0
__if_30799_start:
  mov R0, [BP+4]
  jf R0, __if_30799_end
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_30806_start:
__while_30806_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_30806_end
  mov R0, [BP-3]
  shl R0, -1
  mov [BP-4], R0
  mov R0, [BP-3]
  and R0, 1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R3, [BP-6]
  mov [SP], R3
  mov R3, [BP-5]
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-3], R1
  mov R0, R1
__if_30837_start:
  mov R1, [BP-6]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_30844
  mov R2, [BP-6]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_30844:
  jf R0, __if_30837_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_30837_end:
  jmp __while_30806_start
__while_30806_end:
__if_30799_end:
__if_30851_start:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30851_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 2
  mov R2, [R3]
  imul R2, 85
  iadd R1, R2
  iadd R1, 3
  mov [R1], R0
__if_30851_end:
__if_30868_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30868_end
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 85
  iadd R1, R2
  iadd R1, 2
  mov [R1], R0
__if_30868_end:
__if_30885_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30885_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
__if_30885_end:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__if_30902_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30902_end
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2BroadPhase_DestroyProxy
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 8
  mov [R1], R0
__if_30902_end:
__if_30922_start:
  mov R1, [BP+3]
  iadd R1, 25
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30922_end
  mov R2, [BP+3]
  iadd R2, 25
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 27
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 25
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 26
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 27
  mov [R1], R0
__if_30922_end:
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  mov [R1], R0
__if_30958_start:
  mov R0, [BP+5]
  jf R0, __if_30958_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30958_end:
__function_b2DestroyShapeInternal_return:
  mov SP, BP
  pop BP
  ret

__function_b2OverlapFilterCallback:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  push R3
  isub SP, 3
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R2, [BP-1]
  mov R1, [R2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 85
  iadd R0, R1
  mov [BP-2], R0
__if_31844_start:
  mov R2, [BP-2]
  iadd R2, 19
  mov [SP], R2
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2ShouldQueryCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_31844_end
  mov R0, 1
  jmp __function_b2OverlapFilterCallback_return
__if_31844_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+2], R1
  mov R3, [BP-1]
  iadd R3, 2
  mov R2, [R3]
  call R2
__function_b2OverlapFilterCallback_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RayCastClosestCallback:
  push BP
  mov BP, SP
  isub SP, 18
  push R1
  push R2
  push R3
  push R4
  isub SP, 4
  mov R0, [BP+5]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+4]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_31986_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_31997
  mov R3, [BP-3]
  iadd R3, 19
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 1
  mov R3, [R4]
  mov [SP+1], R3
  call __function_b2ShouldQueryCollide
  mov R2, R0
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_31997:
  mov R0, R1
  jf R0, __if_31986_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2RayCastClosestCallback_return
__if_31986_end:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-5], R0
  mov R0, [BP-5]
  mov [BP-6], R0
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2InvRotateVector
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-7], R0
  lea R13, [BP-18]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP-16]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
  mov R0, 0
  mov [BP-12], R0
__if_32069_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_32069_else
  mov R1, [BP-3]
  iadd R1, 28
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_32069_end
__if_32069_else:
__if_32082_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_32082_else
  mov R1, [BP-3]
  iadd R1, 31
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_32082_end
__if_32082_else:
__if_32095_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_32095_else
  mov R1, [BP-3]
  iadd R1, 36
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_32095_end
__if_32095_else:
__if_32108_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_32108_end
  mov R1, [BP-3]
  iadd R1, 72
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  lea R1, [BP-18]
  mov [SP+3], R1
  call __function_b2RayCastSegment
__if_32108_end:
__if_32095_end:
__if_32082_end:
__if_32069_end:
__if_32122_start:
  mov R0, [BP-12]
  jf R0, __LogicalAnd_ShortCircuit_32125
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_32125:
  jf R0, __if_32122_end
  mov R0, [BP-14]
  mov R1, [BP-1]
  iadd R1, 2
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 2
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 2
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-14]
  jmp __function_b2RayCastClosestCallback_return
__if_32122_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
__function_b2RayCastClosestCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCastClosestCallback:
  push BP
  mov BP, SP
  isub SP, 35
  push R1
  push R2
  push R3
  push R4
  isub SP, 4
  mov R0, [BP+5]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+4]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_32339_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_32350
  mov R3, [BP-3]
  iadd R3, 19
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 1
  mov R3, [R4]
  mov [SP+1], R3
  call __function_b2ShouldQueryCollide
  mov R2, R0
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_32350:
  mov R0, R1
  jf R0, __if_32339_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2ShapeCastClosestCallback_return
__if_32339_end:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-5], R0
  mov R0, [BP-5]
  mov [BP-6], R0
  lea R13, [BP-28]
  mov R12, [BP-1]
  iadd R12, 2
  mov CR, 18
  movs
  lea R13, [BP-10]
  mov R12, [BP-1]
  iadd R12, 20
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-8], R0
  mov R0, 0
  mov [BP-7], R0
  lea R1, [BP-28]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  lea R1, [BP-35]
  mov [SP+3], R1
  call __function_b2ShapeCastShape
__if_32405_start:
  mov R0, [BP-29]
  jf R0, __LogicalAnd_ShortCircuit_32408
  mov R1, [BP-31]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_32408:
  jf R0, __if_32405_end
  mov R0, [BP-31]
  mov R1, [BP-1]
  iadd R1, 22
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 22
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 22
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 22
  iadd R1, 6
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 29
  mov [R1], R0
  mov R0, [BP-31]
  jmp __function_b2ShapeCastClosestCallback_return
__if_32405_end:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
__function_b2ShapeCastClosestCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MoverCollideCallback:
  push BP
  mov BP, SP
  isub SP, 11
  push R1
  push R2
  push R3
  push R4
  isub SP, 4
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_32782_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_32793
  mov R3, [BP-3]
  iadd R3, 19
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 1
  mov R3, [R4]
  mov [SP+1], R3
  call __function_b2ShouldQueryCollide
  mov R2, R0
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_32793:
  mov R0, R1
  jf R0, __if_32782_end
  mov R0, 1
  jmp __function_b2MoverCollideCallback_return
__if_32782_end:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-5], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-5]
  mov [SP+2], R1
  lea R1, [BP-11]
  mov [SP+3], R1
  call __function_b2CollideMover
__if_32824_start:
  mov R1, [BP-6]
  jf R1, __LogicalAnd_ShortCircuit_32827
  lea R3, [BP-11]
  mov [SP], R3
  call __function_b2IsNormalized
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_32827:
  mov R0, R1
  jf R0, __if_32824_end
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+2], R1
  mov R3, [BP-1]
  iadd R3, 7
  mov R2, [R3]
  call R2
  jmp __function_b2MoverCollideCallback_return
__if_32824_end:
  mov R0, 1
__function_b2MoverCollideCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MoverCastCallback:
  push BP
  mov BP, SP
  isub SP, 34
  push R1
  push R2
  push R3
  push R4
  isub SP, 4
  mov R0, [BP+5]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+4]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_32989_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_33000
  mov R3, [BP-3]
  iadd R3, 19
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 1
  mov R3, [R4]
  mov [SP+1], R3
  call __function_b2ShouldQueryCollide
  mov R2, R0
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_33000:
  mov R0, R1
  jf R0, __if_32989_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_32989_end:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-5], R0
  mov R12, [BP-1]
  iadd R12, 2
  lea DR, [BP-27]
  mov CR, 22
  movs
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-7], R0
  lea R1, [BP-27]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-5]
  mov [SP+2], R1
  lea R1, [BP-34]
  mov [SP+3], R1
  call __function_b2ShapeCastShape
__if_33040_start:
  mov R0, [BP-30]
  feq R0, 0.000000
  jf R0, __if_33040_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_33040_end:
  mov R0, [BP-30]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
  mov R0, [BP-30]
__function_b2MoverCastCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateContact:
  push BP
  mov BP, SP
  isub SP, 16
__if_33253_start:
  mov R3, [BP+3]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+4]
  iadd R3, 4
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2CanCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_33253_end
  jmp __function_b2CreateContact_return
__if_33253_end:
__if_33262_start:
  mov R3, [BP+3]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+4]
  iadd R3, 4
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2IsPrimaryOrder
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_33262_end
  mov R0, [BP+3]
  mov [BP-12], R0
  mov R0, [BP+4]
  mov [BP+3], R0
  mov R0, [BP-12]
  mov [BP+4], R0
__if_33262_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-2], R0
__if_33300_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_33307
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  or R0, R1
__LogicalOr_ShortCircuit_33307:
  jf R0, __if_33300_else
  mov R0, 2
  mov [BP-3], R0
  jmp __if_33300_end
__if_33300_else:
  mov R0, 1
  mov [BP-3], R0
__if_33300_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 16
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 29
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-5], R0
__if_33330_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_33330_end
  mov R3, [BP+2]
  iadd R3, 33
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 33
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 16
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 33
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 33
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 16
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 16
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 1
  mov [R1], R0
__if_33330_end:
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-6], R0
  mov R1, [BP+4]
  mov R0, [R1]
  mov [BP-7], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 16
  iadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-5]
  mov R1, [BP-8]
  iadd R1, 13
  mov [R1], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-8]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-8]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 9
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 6
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 7
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-8]
  iadd R1, 11
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-8]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_33440_start:
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  and R0, 4096
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_33453
  mov R2, [BP-2]
  iadd R2, 18
  mov R1, [R2]
  and R1, 4096
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_33453:
  jf R0, __if_33440_end
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_33440_end:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-8]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  shl R0, 1
  or R0, 0
  mov [BP-9], R0
__if_33496_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33496_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-12], R0
  mov R1, [BP-9]
  mov R4, [BP-12]
  mov [SP], R4
  mov R5, [BP-1]
  iadd R5, 3
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-12]
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 3
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_33496_end:
  mov R0, [BP-9]
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-8]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  shl R0, 1
  or R0, 1
  mov [BP-10], R0
__if_33568_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33568_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-12], R0
  mov R1, [BP-10]
  mov R4, [BP-12]
  mov [SP], R4
  mov R5, [BP-2]
  iadd R5, 3
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-12]
  mov [SP], R3
  mov R4, [BP-2]
  iadd R4, 3
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_33568_end:
  mov R0, [BP-10]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 21
  iadd R1, 5
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2AddKey
  mov R3, [BP-4]
  iadd R3, 6
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-4]
  iadd R2, 6
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-4]
  iadd R3, 6
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 49
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-4]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-4]
  iadd R1, 6
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  imul R1, 49
  iadd R0, R1
  mov [BP-11], R0
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 49
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP-5]
  mov R1, [BP-11]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-11]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-11]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-11]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-11]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-11]
  iadd R1, 42
  mov [R1], R0
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 41
  mov [R1], R0
__function_b2CreateContact_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyContact:
  push BP
  mov BP, SP
  isub SP, 14
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  mov [BP-2], R0
__if_33706_start:
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33706_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_33706_end:
  mov R1, [BP+2]
  iadd R1, 21
  iadd R1, 5
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 11
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+3]
  iadd R2, 12
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2RemoveKey
  mov R0, [BP+3]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
__if_33741_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33741_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-3]
  iadd R5, 1
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 2
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-3]
  iadd R4, 1
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_33741_end:
__if_33770_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33770_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-3]
  iadd R5, 2
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-3]
  iadd R4, 2
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_33770_end:
__if_33799_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_33799_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_33799_end:
  mov R1, [BP-4]
  iadd R1, 4
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 3
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-5]
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-6], R0
__if_33838_start:
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33838_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R2, [BP-5]
  iadd R2, 2
  mov R1, [R2]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-5]
  iadd R5, 1
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 2
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-5]
  iadd R4, 1
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_33838_end:
__if_33867_start:
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33867_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 2
  mov R1, [R2]
  shl R1, -1
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-5]
  iadd R5, 2
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2ContactEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-5]
  iadd R4, 2
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_33867_end:
__if_33896_start:
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_33896_end
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
__if_33896_end:
  mov R1, [BP-6]
  iadd R1, 4
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-6]
  iadd R1, 4
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-9], R0
__if_33939_start:
  mov R0, [BP-8]
  mov R1, [BP-9]
  ine R0, R1
  jf R0, __if_33939_end
  mov R1, [BP-7]
  iadd R1, 6
  mov R13, [R1]
  mov R1, [BP-8]
  imul R1, 49
  iadd R13, R1
  mov R1, [BP-7]
  iadd R1, 6
  mov R12, [R1]
  mov R1, [BP-9]
  imul R1, 49
  iadd R12, R1
  mov CR, 49
  movs
  mov R1, [BP-7]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-8]
  imul R1, 49
  iadd R0, R1
  mov [BP-10], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP-10]
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-11], R0
  mov R0, [BP-8]
  mov R1, [BP-11]
  iadd R1, 10
  mov [R1], R0
__if_33939_end:
  mov R1, [BP-7]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-7]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 29
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 8
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_34014_start:
  mov R0, [BP+4]
  jf R0, __LogicalAnd_ShortCircuit_34016
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_34016:
  jf R0, __if_34014_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_34014_end:
__function_b2DestroyContact_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetJointSim:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 212
  iadd R0, R1
__function_b2GetJointSim_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DestroyContactsBetweenBodies:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
__while_34081_start:
__while_34081_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_34081_end
  mov R0, [BP-2]
  shl R0, -1
  mov [BP-3], R0
  mov R0, [BP-2]
  and R0, 1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-5]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-2], R1
  mov R0, R1
__if_34112_start:
  mov R3, [BP-5]
  mov [SP], R3
  mov R3, [BP-4]
  xor R3, 1
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  mov R1, [R2]
  mov R2, [BP+4]
  ieq R1, R2
  mov R0, R1
  jf R0, __if_34112_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_34112_end:
  jmp __while_34081_start
__while_34081_end:
__function_b2DestroyContactsBetweenBodies_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShouldBodiesCollide:
  push BP
  mov BP, SP
  isub SP, 6
  push R1
  push R2
  push R3
  isub SP, 2
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  mov [BP-2], R0
__while_34141_start:
__while_34141_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_34141_end
  mov R0, [BP-2]
  shl R0, -1
  mov [BP-3], R0
  mov R0, [BP-2]
  and R0, 1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 17
  iadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-5]
  mov [SP], R3
  mov R3, [BP-4]
  xor R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  mov R1, [R2]
  mov R0, R1
  mov [BP-6], R0
__if_34174_start:
  mov R0, [BP-6]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_34180
  mov R2, [BP-5]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_34180:
  jf R0, __if_34174_end
  mov R0, 0
  jmp __function_b2ShouldBodiesCollide_return
__if_34174_end:
  mov R3, [BP-5]
  mov [SP], R3
  mov R3, [BP-4]
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-2], R1
  mov R0, R1
  jmp __while_34141_start
__while_34141_end:
  mov R0, 1
__function_b2ShouldBodiesCollide_return:
  iadd SP, 2
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateJoint:
  push BP
  mov BP, SP
  isub SP, 10
  push R1
  push R2
  push R3
  push R4
  push R5
  isub SP, 4
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  imul R1, 21
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_34226_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 1
  jt R0, __LogicalOr_ShortCircuit_34233
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 1
  or R0, R1
__LogicalOr_ShortCircuit_34233:
  jf R0, __if_34226_else
  mov R0, 1
  mov [BP-3], R0
  jmp __if_34226_end
__if_34226_else:
__if_34239_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_34246
  mov R2, [BP-2]
  iadd R2, 19
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_34246:
  jf R0, __if_34239_else
  mov R0, 0
  mov [BP-3], R0
  jmp __if_34239_end
__if_34239_else:
  mov R0, 2
  mov [BP-3], R0
__if_34239_end:
__if_34226_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 16
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-5], R0
__if_34269_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_34269_end
  mov R3, [BP+2]
  iadd R3, 40
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 40
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 17
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 40
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 17
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 17
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 40
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 40
  iadd R1, 1
  mov [R1], R0
__if_34269_end:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 17
  iadd R0, R1
  mov [BP-6], R0
  mov R0, [BP-5]
  mov R1, [BP-6]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  mov [R1], R0
  mov R1, [BP-6]
  iadd R1, 15
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-6]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-6]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  iadd R1, 11
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  iadd R1, 12
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP-6]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP+7]
  mov R1, [BP-6]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP+8]
  mov R1, [BP-6]
  iadd R1, 16
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP-6]
  iadd R1, 4
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  iadd R1, 4
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 4
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  shl R0, 1
  or R0, 0
  mov [BP-7], R0
__if_34407_start:
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34407_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-10], R0
  mov R1, [BP-7]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-1]
  iadd R5, 8
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-1]
  iadd R4, 8
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_34407_end:
  mov R0, [BP-7]
  mov R1, [BP-1]
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-6]
  iadd R1, 4
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-6]
  iadd R1, 4
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 4
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  shl R0, 1
  or R0, 1
  mov [BP-8], R0
__if_34478_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34478_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 8
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-10], R0
  mov R1, [BP-8]
  mov R4, [BP-10]
  mov [SP], R4
  mov R5, [BP-2]
  iadd R5, 8
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-10]
  mov [SP], R3
  mov R4, [BP-2]
  iadd R4, 8
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_34478_end:
  mov R0, [BP-8]
  mov R1, [BP-2]
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 9
  mov [R1], R0
  mov R3, [BP-4]
  iadd R3, 9
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-4]
  iadd R2, 9
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-4]
  iadd R3, 9
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 212
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-4]
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  imul R1, 212
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-9]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 212
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP-5]
  mov R1, [BP-9]
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP-9]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-9]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+7]
  mov R1, [BP-9]
  iadd R1, 3
  mov [R1], R0
  mov R13, [BP-9]
  iadd R13, 4
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 4
  movs
  mov R13, [BP-9]
  iadd R13, 8
  lea R12, [BP+6]
  mov R12, [R12]
  mov CR, 4
  movs
  mov R0, 60.000000
  mov R1, [BP-9]
  iadd R1, 16
  mov [R1], R0
  mov R0, 2.000000
  mov R1, [BP-9]
  iadd R1, 17
  mov [R1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP-9]
  iadd R2, 21
  mov [R2], R1
  mov R0, R1
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP-9]
  iadd R2, 22
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP-9]
  iadd R1, 18
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP-9]
  iadd R1, 18
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-9]
  iadd R1, 18
  iadd R1, 2
  mov [R1], R0
__if_34621_start:
  mov R0, [BP+8]
  ieq R0, 0
  jf R0, __if_34621_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContactsBetweenBodies
__if_34621_end:
__if_34629_start:
  mov R0, [BP-3]
  ige R0, 2
  jf R0, __if_34629_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2LinkJoint
__if_34629_end:
  mov R0, [BP-9]
  lea R1, [BP+9]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-5]
__function_b2CreateJoint_return:
  iadd SP, 4
  pop R5
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DestroyJointInternal:
  push BP
  mov BP, SP
  isub SP, 12
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-1], R0
__if_34650_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34650_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkJoint
__if_34650_end:
  mov R0, [BP+3]
  iadd R0, 4
  mov [BP-2], R0
  mov R0, [BP+3]
  iadd R0, 4
  iadd R0, 3
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-2]
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-5], R0
__if_34692_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34692_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-9], R0
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  mov R4, [BP-9]
  mov [SP], R4
  mov R5, [BP-2]
  iadd R5, 1
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 2
  mov R2, [R3]
  mov R3, [BP-9]
  mov [SP], R3
  mov R4, [BP-2]
  iadd R4, 1
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_34692_end:
__if_34721_start:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34721_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-9], R0
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov R4, [BP-9]
  mov [SP], R4
  mov R5, [BP-2]
  iadd R5, 2
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-9]
  mov [SP], R3
  mov R4, [BP-2]
  iadd R4, 2
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_34721_end:
__if_34750_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_34750_end
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
__if_34750_end:
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
__if_34773_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34773_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-9], R0
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  mov R4, [BP-9]
  mov [SP], R4
  mov R5, [BP-3]
  iadd R5, 1
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 2
  mov R2, [R3]
  mov R3, [BP-9]
  mov [SP], R3
  mov R4, [BP-3]
  iadd R4, 1
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_34773_end:
__if_34802_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34802_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  shl R1, -1
  imul R1, 17
  iadd R0, R1
  mov [BP-9], R0
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov R4, [BP-9]
  mov [SP], R4
  mov R5, [BP-3]
  iadd R5, 2
  mov R4, [R5]
  and R4, 1
  mov [SP+1], R4
  call __function_b2JointEdgeAt
  mov R3, R0
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-9]
  mov [SP], R3
  mov R4, [BP-3]
  iadd R4, 2
  mov R3, [R4]
  and R3, 1
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__if_34802_end:
__if_34831_start:
  mov R1, [BP-5]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_34831_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 8
  mov [R1], R0
__if_34831_end:
  mov R1, [BP-5]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-5]
  iadd R1, 9
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-7], R0
  mov R1, [BP-6]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-8], R0
__if_34874_start:
  mov R0, [BP-7]
  mov R1, [BP-8]
  ine R0, R1
  jf R0, __if_34874_end
  mov R1, [BP-6]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-7]
  imul R1, 212
  iadd R13, R1
  mov R1, [BP-6]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-8]
  imul R1, 212
  iadd R12, R1
  mov CR, 212
  movs
  mov R1, [BP-6]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-7]
  imul R1, 212
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R2, [BP-9]
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-10], R0
  mov R0, [BP-7]
  mov R1, [BP-10]
  iadd R1, 3
  mov [R1], R0
__if_34874_end:
  mov R1, [BP-6]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-6]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 36
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_34949_start:
  mov R0, [BP+4]
  jf R0, __if_34949_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_34949_end:
__function_b2DestroyJointInternal_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateDistanceJoint:
  push BP
  mov BP, SP
  isub SP, 4
  push R1
  push R2
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 0
  mov [SP+5], R1
  mov R1, [BP+8]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 23
  mov [BP-3], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  mov [BP-4], R2
  mov R2, [BP+7]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-3]
  mov [R2], R1
  mov R0, R1
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  fsgn R1
  mov R2, [BP-3]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP-3]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP-3]
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 25
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 26
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 27
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateDistanceJoint_return:
  iadd SP, 8
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateRevoluteJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 4
  mov [SP+5], R1
  mov R1, [BP+7]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 51
  mov [BP-3], R0
  mov R13, [BP-3]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 25
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 29
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 30
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 31
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateRevoluteJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateWeldJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 5
  mov [SP+5], R1
  mov R1, [BP+7]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 83
  mov [BP-3], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R13, [BP-3]
  iadd R13, 10
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 25
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateWeldJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreatePrismaticJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 3
  mov [SP+5], R1
  mov R1, [BP+7]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 109
  mov [BP-3], R0
  mov R13, [BP-3]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 11
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 28
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 29
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 30
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreatePrismaticJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateWheelJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 6
  mov [SP+5], R1
  mov R1, [BP+7]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 140
  mov [BP-3], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 29
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 30
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 31
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateWheelJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateMotorJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 2
  mov [SP+5], R1
  mov R1, [BP+7]
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-1]
  iadd R0, 172
  mov [BP-3], R0
  mov R13, [BP-3]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 10
  mov [R1], R0
  mov R13, [BP-3]
  iadd R13, 11
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 13
  mov [R1], R0
  mov R13, [BP-3]
  iadd R13, 14
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-3]
  iadd R1, 16
  mov [R1], R0
  mov R0, [BP-2]
__function_b2CreateMotorJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2CreateFilterJoint:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, [BP+6]
  mov [SP+4], R1
  mov R1, 1
  mov [SP+5], R1
  mov R1, 0
  mov [SP+6], R1
  lea R1, [BP-1]
  mov [SP+7], R1
  call __function_b2CreateJoint
  mov [BP-2], R0
  mov R0, [BP-2]
__function_b2CreateFilterJoint_return:
  iadd SP, 8
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MakeJointId:
  push BP
  mov BP, SP
  mov R0, [BP+3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 61
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 17
  iadd R1, R2
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
__function_b2MakeJointId_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetJointSimById:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov R2, [BP+3]
  imul R2, 17
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2GetJointSim
__function_b2GetJointSimById_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Joint_GetSim:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  mov [SP+1], R1
  call __function_b2GetJointSimById
__function_b2Joint_GetSim_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2DestroySolverSet:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
__if_37383_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_37383_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_37383_end:
__if_37398_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_37398_end
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 3
  iadd R2, 2
  mov R1, [R2]
  imul R1, 8
  mov [SP+1], R1
  call __function_b2Free
__if_37398_end:
__if_37413_start:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_37413_end
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 2
  mov R1, [R2]
  imul R1, 49
  mov [SP+1], R1
  call __function_b2Free
__if_37413_end:
__if_37428_start:
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_37428_end
  mov R2, [BP-1]
  iadd R2, 9
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 2
  mov R1, [R2]
  imul R1, 212
  mov [SP+1], R1
  call __function_b2Free
__if_37428_end:
__if_37443_start:
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_37443_end
  mov R2, [BP-1]
  iadd R2, 12
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 2
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
__if_37443_end:
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 6
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 12
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 15
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 7
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2FreeId
__function_b2DestroySolverSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2WakeSolverSet:
  push BP
  mov BP, SP
  isub SP, 11
__if_37547_start:
  mov R0, [BP+3]
  ilt R0, 3
  jf R0, __if_37547_end
  jmp __function_b2WakeSolverSet_return
__if_37547_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_37570_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_37570_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov R2, [BP-3]
  imul R2, 24
  iadd R1, R2
  iadd R1, 22
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 21
  iadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-2]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 24
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-6], R0
  mov R1, [BP-2]
  mov R13, [R1]
  mov R1, [BP-6]
  imul R1, 24
  iadd R13, R1
  mov R1, [BP-1]
  mov R12, [R1]
  mov R1, [BP-3]
  imul R1, 24
  iadd R12, R1
  mov CR, 24
  movs
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R3, [BP-2]
  iadd R3, 3
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 3
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 3
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 8
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-6]
  imul R1, 8
  iadd R0, R1
  mov [BP-7], R0
  mov R13, [BP-7]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-7]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-7]
  iadd R1, 3
  mov [R1], R0
  mov R13, [BP-7]
  iadd R13, 4
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-7]
  iadd R13, 6
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R1, [BP-2]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 2
  mov R1, [BP-5]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-5]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP-5]
  iadd R1, 15
  mov [R1], R0
__for_37570_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_37570_start
__for_37570_end:
  mov R0, 0
  mov [BP-3], R0
__for_37708_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_37708_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R3, [BP-1]
  iadd R3, 6
  mov R2, [R3]
  mov R3, [BP-3]
  imul R3, 49
  iadd R2, R3
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-4], R0
  mov R3, [BP-2]
  iadd R3, 6
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 6
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 6
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 49
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov [BP-5], R0
  mov R1, [BP-2]
  iadd R1, 6
  mov R13, [R1]
  mov R1, [BP-5]
  imul R1, 49
  iadd R13, R1
  mov R1, [BP-1]
  iadd R1, 6
  mov R12, [R1]
  mov R1, [BP-3]
  imul R1, 49
  iadd R12, R1
  mov CR, 49
  movs
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 2
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-4]
  iadd R1, 10
  mov [R1], R0
__for_37708_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_37708_start
__for_37708_end:
  mov R0, 0
  mov [BP-3], R0
__for_37784_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_37784_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-1]
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP-3]
  imul R3, 212
  iadd R2, R3
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-4], R0
  mov R3, [BP-2]
  iadd R3, 9
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 9
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 9
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 212
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-5], R0
  mov R1, [BP-2]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-5]
  imul R1, 212
  iadd R13, R1
  mov R1, [BP-1]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-3]
  imul R1, 212
  iadd R12, R1
  mov CR, 212
  movs
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, 2
  mov R1, [BP-4]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__for_37784_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_37784_start
__for_37784_end:
  mov R0, 0
  mov [BP-3], R0
__for_37860_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_37860_end
  mov R2, [BP-1]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-3]
  iadd R1, R2
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 13
  iadd R0, R1
  mov [BP-5], R0
  mov R3, [BP-2]
  iadd R3, 12
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-2]
  iadd R3, 12
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 12
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP-4]
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-6]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, 2
  mov R1, [BP-5]
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-5]
  iadd R1, 1
  mov [R1], R0
__for_37860_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_37860_start
__for_37860_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2DestroySolverSet
__function_b2WakeSolverSet_return:
  mov SP, BP
  pop BP
  ret

__function_b2Collide:
  push BP
  mov BP, SP
  isub SP, 26
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-2], R0
__for_37951_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_37951_end
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 49
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP-3]
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 85
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  imul R1, 85
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-3]
  iadd R1, 41
  mov R0, [R1]
  and R0, 65536
  ine R0, 0
  mov [BP-8], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-6]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-7]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-10], R0
__if_38030_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_38037
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_38037:
  jf R0, __if_38030_end
  jmp __for_37951_continue
__if_38030_end:
__if_38041_start:
  mov R2, [BP-6]
  iadd R2, 13
  mov [SP], R2
  mov R2, [BP-7]
  iadd R2, 13
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38041_end
__if_38052_start:
  mov R0, [BP-8]
  jf R0, __if_38052_end
  mov R1, [BP+2]
  iadd R1, 67
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2AddTouchEvent
__if_38052_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __for_37951_continue
__if_38041_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-9]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-11], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-12], R0
__if_38077_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_38077_else
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  jmp __if_38077_end
__if_38077_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_38077_end:
  mov R1, [BP-11]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP-11]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
__if_38103_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_38103_else
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  jmp __if_38103_end
__if_38103_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_38103_end:
  mov R1, [BP-12]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP-12]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-11]
  mov [BP-13], R0
  mov R0, [BP-12]
  mov [BP-14], R0
  mov R1, [BP-13]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP-11]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-14]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP-12]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
__if_38163_start:
  mov R2, [BP-6]
  iadd R2, 9
  mov [SP], R2
  mov R2, [BP-7]
  iadd R2, 9
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38163_else
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP-3]
  iadd R1, 41
  mov [R1], R0
  mov R0, 0
  mov [BP-19], R0
  jmp __if_38163_end
__if_38163_else:
  mov R2, [BP-3]
  mov [SP], R2
  mov R2, [BP-6]
  mov [SP+1], R2
  mov R2, [BP-13]
  mov [SP+2], R2
  lea R2, [BP-16]
  mov [SP+3], R2
  mov R2, [BP-7]
  mov [SP+4], R2
  mov R2, [BP-14]
  mov [SP+5], R2
  lea R2, [BP-18]
  mov [SP+6], R2
  call __function_b2UpdateContact
  mov R1, R0
  mov [BP-19], R1
  mov R0, R1
__if_38163_end:
__if_38203_start:
  mov R0, [BP-19]
  jf R0, __LogicalAnd_ShortCircuit_38205
  mov R1, [BP-8]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_38205:
  jf R0, __if_38203_else
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  or R0, 1
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 64
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2AddTouchEvent
__if_38225_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_38225_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_38225_end:
__if_38234_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_38234_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_38234_end:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 49
  iadd R0, R1
  mov [BP-3], R0
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-9]
  mov [SP+1], R2
  call __function_b2GetBodySim
  mov R1, R0
  mov [BP-11], R1
  mov R0, R1
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-10]
  mov [SP+1], R2
  call __function_b2GetBodySim
  mov R1, R0
  mov [BP-12], R1
  mov R0, R1
__if_38261_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_38261_end
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_38261_end:
__if_38271_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_38271_end
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_38271_end:
  mov R1, [BP-11]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 5
  mov [R1], R0
  mov R1, [BP-11]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-12]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP-12]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2LinkContact
  jmp __if_38203_end
__if_38203_else:
__if_38304_start:
  mov R0, [BP-19]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_38309
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_38309:
  jf R0, __if_38304_end
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  and R0, -2
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 67
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2AddTouchEvent
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_38304_end:
__if_38203_end:
__if_38330_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_38330_end
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 5
  mov [R1], R0
__if_38330_end:
__if_38349_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_38349_end
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 5
  mov [R1], R0
__if_38349_end:
__for_37951_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_37951_start
__for_37951_end:
__function_b2Collide_return:
  mov SP, BP
  pop BP
  ret

__function_b2PairQueryCallback:
  push BP
  mov BP, SP
  isub SP, 9
  push R1
  push R2
  push R3
  isub SP, 3
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, [BP-2]
  iadd R0, 21
  mov [BP-3], R0
  mov R0, [BP+2]
  shl R0, 2
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  or R0, R1
  mov [BP-4], R0
__if_38405_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_38405_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38405_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  and R0, 3
  mov [BP-5], R0
__if_38420_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_38420_else
__if_38425_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_38431
  mov R1, [BP-4]
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_38431:
  jf R0, __if_38425_end
__if_38436_start:
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_b2GetBit
  jf R0, __if_38436_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38436_end:
__if_38425_end:
  jmp __if_38420_end
__if_38420_else:
__if_38448_start:
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 3
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_b2GetBit
  jf R0, __if_38448_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38448_end:
__if_38420_end:
__if_38459_start:
  mov R1, [BP-3]
  iadd R1, 5
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2ContainsKey
  jf R0, __if_38459_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38459_end:
__if_38473_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_38473_else
  mov R0, [BP+3]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-7], R0
  jmp __if_38473_end
__if_38473_else:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP+3]
  mov [BP-7], R0
__if_38473_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-6]
  imul R1, 85
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-7]
  imul R1, 85
  iadd R0, R1
  mov [BP-9], R0
__if_38510_start:
  mov R1, [BP-8]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_38510_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38510_end:
__if_38518_start:
  mov R3, [BP-8]
  iadd R3, 4
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP-9]
  iadd R3, 4
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2CanCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38518_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38518_end:
__if_38528_start:
  mov R2, [BP-8]
  iadd R2, 19
  mov [SP], R2
  mov R2, [BP-9]
  iadd R2, 19
  mov [SP+1], R2
  call __function_b2ShouldShapesCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38528_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38528_end:
__if_38540_start:
  mov R2, [BP-2]
  mov [SP], R2
  mov R3, [BP-8]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R3, [BP-9]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+2], R2
  call __function_b2ShouldBodiesCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38540_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38540_end:
__if_38551_start:
  mov R1, [BP-8]
  iadd R1, 23
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_38554
  mov R2, [BP-9]
  iadd R2, 23
  mov R1, [R2]
  or R0, R1
__LogicalOr_ShortCircuit_38554:
  jf R0, __if_38551_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_38551_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP-9]
  mov [SP+2], R1
  call __function_b2CreateContact
  mov R0, 1
__function_b2PairQueryCallback_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2UpdateBroadPhasePairs:
  push BP
  mov BP, SP
  isub SP, 21
  mov R0, [BP+2]
  iadd R0, 21
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_38578_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_38578_end
  mov R2, [BP-1]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-4], R0
__if_38594_start:
  mov R0, [BP-4]
  ieq R0, -1
  jf R0, __if_38594_end
  jmp __for_38578_continue
__if_38594_end:
  mov R0, [BP-4]
  and R0, 3
  mov [BP-5], R0
  mov R0, [BP-4]
  shl R0, -2
  mov [BP-6], R0
  mov R0, [BP+2]
  mov [BP-10], R0
  mov R0, [BP-4]
  mov [BP-9], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2DynamicTree_GetAABB
  mov R3, [BP-1]
  mov R2, [R3]
  mov R3, [BP-5]
  imul R3, 11
  iadd R2, R3
  mov [SP], R2
  mov R2, [BP-6]
  mov [SP+1], R2
  call __function_b2DynamicTree_GetUserData
  mov R1, R0
  mov [BP-8], R1
  mov R0, R1
__if_38648_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_38648_end
  mov R0, 1
  mov [BP-7], R0
  mov R2, [BP-1]
  mov R1, [R2]
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, __function_b2PairQueryCallback
  mov [SP+2], R1
  lea R1, [BP-10]
  mov [SP+3], R1
  lea R1, [BP-16]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
  mov R0, 0
  mov [BP-7], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, __function_b2PairQueryCallback
  mov [SP+2], R1
  lea R1, [BP-10]
  mov [SP+3], R1
  lea R1, [BP-16]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
__if_38648_end:
  mov R0, 2
  mov [BP-7], R0
  mov R2, [BP-1]
  mov R1, [R2]
  iadd R1, 22
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  mov R1, __function_b2PairQueryCallback
  mov [SP+2], R1
  lea R1, [BP-10]
  mov [SP+3], R1
  lea R1, [BP-16]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
__for_38578_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_38578_start
__for_38578_end:
  mov R1, [BP-1]
  mov [SP], R1
  call __function_b2BroadPhase_ClearMoveBuffer
__function_b2UpdateBroadPhasePairs_return:
  mov SP, BP
  pop BP
  ret

__function_b2SensorQueryCallback:
  push BP
  mov BP, SP
  isub SP, 65
  push R1
  push R2
  push R3
  isub SP, 4
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
__if_38733_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_38733_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38733_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 85
  iadd R0, R1
  mov [BP-4], R0
__if_38748_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_38748_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38748_end:
__if_38757_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_38757_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38757_end:
__if_38764_start:
  mov R1, [BP-4]
  iadd R1, 23
  mov R0, [R1]
  jf R0, __if_38764_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38764_end:
__if_38769_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_38769_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38769_end:
__if_38777_start:
  mov R2, [BP-3]
  iadd R2, 19
  mov [SP], R2
  mov R2, [BP-4]
  iadd R2, 19
  mov [SP+1], R2
  call __function_b2ShouldShapesCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_38777_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_38777_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-49]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  mov R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  mov R1, [BP-1]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2InvMulTransforms
  mov R0, 1
  mov [BP-9], R0
  mov R0, 0
  mov [BP-56], R0
  lea R1, [BP-49]
  mov [SP], R1
  lea R1, [BP-56]
  mov [SP+1], R1
  lea R1, [BP-65]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_38837_start:
  mov R0, [BP-59]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R1, 10.000000
  flt R0, R1
  jf R0, __if_38837_end
  mov R3, [BP-2]
  iadd R3, 79
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 80
  mov [SP+1], R2
  mov R3, [BP-1]
  iadd R3, 6
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-2]
  iadd R2, 79
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP-2]
  iadd R2, 79
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 6
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
__if_38837_end:
  mov R0, 1
__function_b2SensorQueryCallback_return:
  iadd SP, 4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2OverlapSensors:
  push BP
  mov BP, SP
  isub SP, 30
  mov R1, [BP+2]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__for_38887_start:
  mov R0, [BP-2]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_38887_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_38905_start:
  mov R1, [BP-3]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_38905_end
  jmp __for_38887_continue
__if_38905_end:
__if_38913_start:
  mov R1, [BP-3]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_38913_end
  jmp __for_38887_continue
__if_38913_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R0, [BP+2]
  mov [BP-11], R0
  mov R0, [BP-3]
  mov [BP-10], R0
  mov R0, 0
  mov [BP-5], R0
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __LogicalAnd_ShortCircuit_38949
  mov R2, [BP-3]
  iadd R2, 24
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_38949:
  mov [BP-12], R0
__if_38952_start:
  mov R0, [BP-12]
  jf R0, __if_38952_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-9]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  mov R0, 0
  mov [BP-25], R0
__for_38974_start:
  mov R0, [BP-25]
  ilt R0, 3
  jf R0, __for_38974_end
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  mov R2, [BP-25]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, __function_b2SensorQueryCallback
  mov [SP+2], R1
  lea R1, [BP-11]
  mov [SP+3], R1
  lea R1, [BP-24]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
__for_38974_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_38974_start
__for_38974_end:
__if_38952_end:
  mov R0, [BP-5]
  mov [BP-13], R0
  mov R1, [BP-3]
  iadd R1, 25
  mov R0, [R1]
  mov [BP-14], R0
  mov R1, [BP-3]
  iadd R1, 26
  mov R0, [R1]
  mov [BP-15], R0
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  mov [BP-16], R0
  mov R0, 0
  mov [BP-17], R0
__for_39018_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_39018_end
  mov R0, [BP-16]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_39036_start:
  mov R0, [BP-18]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_39036_end
__if_39045_start:
  mov R0, [BP-14]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_39045_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_39036_end
__if_39045_end:
__for_39036_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_39036_start
__for_39036_end:
__if_39056_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_39056_end
  mov R1, [BP+2]
  iadd R1, 73
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_39056_end:
__for_39018_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_39018_start
__for_39018_end:
  mov R0, 0
  mov [BP-17], R0
__for_39067_start:
  mov R0, [BP-17]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_39067_end
  mov R0, [BP-14]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_39085_start:
  mov R0, [BP-18]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_39085_end
__if_39094_start:
  mov R0, [BP-16]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_39094_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_39085_end
__if_39094_end:
__for_39085_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_39085_start
__for_39085_end:
__if_39105_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_39105_end
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_39105_end:
__for_39067_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_39067_start
__for_39067_end:
  mov R3, [BP-3]
  iadd R3, 25
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 27
  mov [SP+1], R2
  mov R2, [BP-13]
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 25
  mov [R2], R1
  mov R0, R1
  mov R0, 0
  mov [BP-17], R0
__for_39127_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_39127_end
  mov R2, [BP+2]
  iadd R2, 79
  mov R0, [R2]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov R2, [BP-3]
  iadd R2, 25
  mov R1, [R2]
  mov R2, [BP-17]
  iadd R1, R2
  mov [R1], R0
__for_39127_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_39127_start
__for_39127_end:
  mov R0, [BP-13]
  mov R1, [BP-3]
  iadd R1, 26
  mov [R1], R0
__for_38887_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_38887_start
__for_38887_end:
__function_b2OverlapSensors_return:
  mov SP, BP
  pop BP
  ret

__function_b2IntegrateVelocities:
  push BP
  mov BP, SP
  isub SP, 28
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-1]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R12, [BP+2]
  iadd R12, 53
  lea DR, [BP-6]
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-7], R0
__for_39181_start:
  mov R0, [BP-7]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_39181_end
  mov R0, [BP-2]
  mov R1, [BP-7]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-3]
  mov R1, [BP-7]
  imul R1, 8
  iadd R0, R1
  mov [BP-9], R0
  mov R12, [BP-9]
  lea DR, [BP-11]
  mov CR, 2
  movs
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, 1.000000
  mov R1, [BP+3]
  mov R3, [BP-8]
  iadd R3, 19
  mov R2, [R3]
  fmul R1, R2
  fadd R1, 1.000000
  fdiv R0, R1
  mov [BP-13], R0
  mov R0, 1.000000
  mov R1, [BP+3]
  mov R3, [BP-8]
  iadd R3, 20
  mov R2, [R3]
  fmul R1, R2
  fadd R1, 1.000000
  fdiv R0, R1
  mov [BP-14], R0
__if_39235_start:
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_39235_else
  mov R1, [BP-8]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-15], R0
  jmp __if_39235_end
__if_39235_else:
  mov R0, 0.000000
  mov [BP-15], R0
__if_39235_end:
  mov R1, [BP+3]
  mov R3, [BP-8]
  iadd R3, 15
  mov R2, [R3]
  fmul R1, R2
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 12
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP+3]
  mov R2, [BP-15]
  fmul R1, R2
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-17]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-21]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, [BP+3]
  mov R2, [BP-8]
  iadd R2, 16
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP-8]
  iadd R2, 14
  mov R1, [R2]
  fmul R0, R1
  mov [BP-22], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-13]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-9]
  lea R12, [BP-24]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-14]
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-9]
  iadd R1, 2
  mov [R1], R0
__for_39181_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_39181_start
__for_39181_end:
__function_b2IntegrateVelocities_return:
  mov SP, BP
  pop BP
  ret

__function_b2IntegratePositions:
  push BP
  mov BP, SP
  isub SP, 21
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
  mov R0, [BP+4]
  mov R1, [BP+4]
  fmul R0, R1
  mov [BP-4], R0
  mov R0, [BP+5]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_39344_start:
  mov R0, [BP-6]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_39344_end
  mov R0, [BP-2]
  mov R1, [BP-6]
  imul R1, 8
  iadd R0, R1
  mov [BP-7], R0
  mov R12, [BP-7]
  lea DR, [BP-9]
  mov CR, 2
  movs
  mov R1, [BP-7]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-10], R0
__if_39368_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  jf R0, __if_39368_end
  mov R0, 0.000000
  mov [BP-9], R0
__if_39368_end:
__if_39380_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 2
  ine R0, 0
  jf R0, __if_39380_end
  mov R0, 0.000000
  mov [BP-8], R0
__if_39380_end:
__if_39392_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 4
  ine R0, 0
  jf R0, __if_39392_end
  mov R0, 0.000000
  mov [BP-10], R0
__if_39392_end:
__if_39403_start:
  lea R2, [BP-9]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-4]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_39403_end
  mov R1, [BP+4]
  lea R3, [BP-9]
  mov [SP], R3
  call __function_b2Length
  mov R2, R0
  fdiv R1, R2
  mov R0, R1
  mov [BP-15], R0
  mov R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-9]
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R13, [BP-9]
  lea R12, [BP-17]
  mov CR, 2
  movs
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  or R0, 32
  mov R1, [BP-7]
  iadd R1, 3
  mov [R1], R0
__if_39403_end:
__if_39437_start:
  mov R0, [BP-10]
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-5]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_39448
  mov R2, [BP-7]
  iadd R2, 3
  mov R1, [R2]
  and R1, 128
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_39448:
  jf R0, __if_39437_end
  mov R1, [BP+5]
  mov R3, [BP-10]
  mov [SP], R3
  call __function_fabs
  mov R2, R0
  fdiv R1, R2
  mov R0, R1
  mov [BP-15], R0
  mov R0, [BP-10]
  mov R1, [BP-15]
  fmul R0, R1
  mov [BP-10], R0
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  or R0, 32
  mov R1, [BP-7]
  iadd R1, 3
  mov [R1], R0
__if_39437_end:
  mov R13, [BP-7]
  lea R12, [BP-9]
  mov CR, 2
  movs
  mov R0, [BP-10]
  mov R1, [BP-7]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  lea R1, [BP-12]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-7]
  iadd R13, 4
  lea R12, [BP-12]
  mov CR, 2
  movs
  mov R1, [BP-7]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP+3]
  mov R3, [BP-7]
  iadd R3, 2
  mov R2, [R3]
  fmul R1, R2
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2IntegrateRotation
  mov R13, [BP-7]
  iadd R13, 6
  lea R12, [BP-14]
  mov CR, 2
  movs
__for_39344_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_39344_start
__for_39344_end:
__function_b2IntegratePositions_return:
  mov SP, BP
  pop BP
  ret

__function_b2ContinuousQueryCallback:
  push BP
  mov BP, SP
  isub SP, 69
  push R1
  push R2
  push R3
  isub SP, 3
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
__if_39536_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_39536_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39536_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 85
  iadd R0, R1
  mov [BP-4], R0
__if_39551_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_39551_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39551_end:
__if_39560_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_39560_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39560_end:
__if_39568_start:
  mov R1, [BP-4]
  iadd R1, 23
  mov R0, [R1]
  jf R0, __if_39568_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39568_end:
__if_39573_start:
  mov R2, [BP-3]
  iadd R2, 19
  mov [SP], R2
  mov R2, [BP-4]
  iadd R2, 19
  mov [SP+1], R2
  call __function_b2ShouldShapesCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_39573_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39573_end:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-6], R0
__if_39599_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_39599_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39599_end:
__if_39609_start:
  mov R2, [BP-2]
  mov [SP], R2
  mov R3, [BP-4]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 1
  mov R2, [R3]
  mov [SP+2], R2
  call __function_b2ShouldBodiesCollide
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_39609_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_39609_end:
  mov R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  lea R13, [BP-27]
  mov R12, [BP-6]
  iadd R12, 10
  mov CR, 2
  movs
  lea R13, [BP-25]
  mov R12, [BP-6]
  iadd R12, 4
  mov CR, 2
  movs
  lea R13, [BP-23]
  mov R12, [BP-6]
  iadd R12, 4
  mov CR, 2
  movs
  lea R13, [BP-21]
  mov R12, [BP-6]
  iadd R12, 2
  mov CR, 2
  movs
  lea R13, [BP-19]
  mov R12, [BP-6]
  iadd R12, 2
  mov CR, 2
  movs
  lea R13, [BP-17]
  mov R12, [BP-1]
  iadd R12, 3
  mov CR, 10
  movs
  mov R1, [BP-1]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-7], R0
  lea R1, [BP-63]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  call __function_b2TimeOfImpact
__if_39681_start:
  mov R0, [BP-64]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_39688
  mov R1, [BP-64]
  mov R3, [BP-1]
  iadd R3, 13
  mov R2, [R3]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_39688:
  jf R0, __if_39681_end
  mov R0, [BP-64]
  mov R1, [BP-1]
  iadd R1, 13
  mov [R1], R0
__if_39681_end:
  mov R0, 1
__function_b2ContinuousQueryCallback_return:
  iadd SP, 3
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2SolveContinuous:
  push BP
  mov BP, SP
  isub SP, 54
  lea R13, [BP-10]
  mov R12, [BP+4]
  iadd R12, 10
  mov CR, 2
  movs
  lea R13, [BP-8]
  mov R12, [BP+4]
  iadd R12, 8
  mov CR, 2
  movs
  lea R13, [BP-6]
  mov R12, [BP+4]
  iadd R12, 4
  mov CR, 2
  movs
  lea R13, [BP-4]
  mov R12, [BP+4]
  iadd R12, 6
  mov CR, 2
  movs
  lea R13, [BP-2]
  mov R12, [BP+4]
  iadd R12, 2
  mov CR, 2
  movs
  mov R0, [BP+2]
  mov [BP-24], R0
  mov R1, [BP+3]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-22], R0
  lea R13, [BP-21]
  lea R12, [BP-10]
  mov CR, 10
  movs
  mov R0, 1.000000
  mov [BP-11], R0
  mov R1, [BP+4]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  mov [BP-25], R0
  lea R1, [BP-10]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  lea R1, [BP-29]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  lea R1, [BP-10]
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2GetSweepTransform
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-34], R0
__while_39779_start:
__while_39779_continue:
  mov R0, [BP-34]
  ine R0, -1
  jf R0, __while_39779_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-34]
  imul R1, 85
  iadd R0, R1
  mov [BP-35], R0
  mov R1, [BP-35]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-34], R0
__if_39798_start:
  mov R1, [BP-35]
  iadd R1, 23
  mov R0, [R1]
  jf R0, __if_39798_end
  jmp __while_39779_continue
__if_39798_end:
  mov R0, [BP-35]
  mov [BP-23], R0
  mov R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  mov R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  mov R2, [BP-39]
  mov [SP], R2
  mov R2, [BP-43]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-47], R1
  mov R0, R1
  mov R2, [BP-38]
  mov [SP], R2
  mov R2, [BP-42]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-46], R1
  mov R0, R1
  mov R2, [BP-37]
  mov [SP], R2
  mov R2, [BP-41]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov [BP-45], R1
  mov R0, R1
  mov R2, [BP-36]
  mov [SP], R2
  mov R2, [BP-40]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov [BP-44], R1
  mov R0, R1
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  mov R1, __function_b2ContinuousQueryCallback
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  lea R1, [BP-49]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
__if_39885_start:
  mov R0, [BP-25]
  jf R0, __if_39885_end
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  mov R1, __function_b2ContinuousQueryCallback
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  lea R1, [BP-49]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  iadd R1, 22
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  mov R1, __function_b2ContinuousQueryCallback
  mov [SP+2], R1
  lea R1, [BP-24]
  mov [SP+3], R1
  lea R1, [BP-49]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
__if_39885_end:
  jmp __while_39779_start
__while_39779_end:
__if_39918_start:
  mov R0, [BP-11]
  flt R0, 1.000000
  jf R0, __if_39918_else
  mov R0, [BP-11]
  mov [BP-35], R0
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-35]
  mov [SP+2], R1
  lea R1, [BP-37]
  mov [SP+3], R1
  call __function_b2NLerp
  lea R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  mov R1, [BP-35]
  mov [SP+2], R1
  lea R1, [BP-39]
  mov [SP+3], R1
  call __function_b2Lerp
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R13, [BP+4]
  iadd R13, 2
  lea R12, [BP-37]
  mov CR, 2
  movs
  mov R0, [BP-39]
  mov R1, [BP-41]
  fsub R0, R1
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, [BP-38]
  mov R1, [BP-40]
  fsub R0, R1
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R13, [BP+4]
  iadd R13, 4
  lea R12, [BP-39]
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 6
  lea R12, [BP-37]
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 8
  lea R12, [BP-39]
  mov CR, 2
  movs
  jmp __if_39918_end
__if_39918_else:
  mov R13, [BP+4]
  iadd R13, 8
  mov R12, [BP+4]
  iadd R12, 4
  mov CR, 2
  movs
  mov R13, [BP+4]
  iadd R13, 6
  mov R12, [BP+4]
  iadd R12, 2
  mov CR, 2
  movs
__if_39918_end:
__function_b2SolveContinuous_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateBodyProxies:
  push BP
  mov BP, SP
  isub SP, 12
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_40027_start:
__while_40027_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40027_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 85
  iadd R0, R1
  mov [BP-3], R0
__if_40042_start:
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40042_end
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-8], R0
  mov R0, [BP-7]
  mov R1, [BP-8]
  fsub R0, R1
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-8]
  fsub R0, R1
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-8]
  fadd R0, R1
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-4]
  mov R1, [BP-8]
  fadd R0, R1
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
__if_40108_start:
  mov R2, [BP-3]
  iadd R2, 13
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2AABB_Contains
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_40108_end
  mov R1, [BP-3]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-9], R0
  mov R0, [BP-7]
  mov R1, [BP-9]
  fsub R0, R1
  mov R1, [BP-3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-9]
  fsub R0, R1
  mov R1, [BP-3]
  iadd R1, 13
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-9]
  fadd R0, R1
  mov R1, [BP-3]
  iadd R1, 13
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-4]
  mov R1, [BP-9]
  fadd R0, R1
  mov R1, [BP-3]
  iadd R1, 13
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP-3]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-3]
  iadd R1, 13
  mov [SP+2], R1
  call __function_b2BroadPhase_MoveProxy
__if_40108_end:
__if_40042_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_40027_start
__while_40027_end:
__function_b2UpdateBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2FinalizeBodies:
  push BP
  mov BP, SP
  isub SP, 32
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-1]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, 0
  mov [BP-5], R0
__for_40204_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_40204_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  imul R1, 8
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, -9
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
  mov R1, [BP-6]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-9]
  mov [SP+2], R1
  call __function_b2Add
  mov R13, [BP-6]
  iadd R13, 4
  lea R12, [BP-9]
  mov CR, 2
  movs
  mov R1, [BP-7]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2MulRot
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  call __function_b2NormalizeRot
  mov R13, [BP-6]
  iadd R13, 2
  lea R12, [BP-13]
  mov CR, 2
  movs
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-6]
  iadd R2, 22
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-14], R0
  mov R12, [BP-7]
  lea DR, [BP-16]
  mov CR, 2
  movs
  lea R2, [BP-16]
  mov [SP], R2
  call __function_b2Length
  mov R1, R0
  mov R4, [BP-7]
  iadd R4, 2
  mov R3, [R4]
  mov [SP], R3
  call __function_fabs
  mov R2, R0
  mov R4, [BP-6]
  iadd R4, 18
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-17], R0
  mov R12, [BP-7]
  iadd R12, 4
  lea DR, [BP-19]
  mov CR, 2
  movs
  lea R2, [BP-19]
  mov [SP], R2
  call __function_b2Length
  mov R1, R0
  mov R4, [BP-7]
  iadd R4, 6
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_fabs
  mov R2, R0
  mov R4, [BP-6]
  iadd R4, 18
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-20], R0
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, [BP+4]
  fmul R1, 0.500000
  mov R2, [BP-20]
  fmul R1, R2
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-21], R0
__if_40324_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_40334
  mov R2, [BP-6]
  iadd R2, 23
  mov R1, [R2]
  and R1, 2048
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_40334:
  jt R0, __LogicalOr_ShortCircuit_40338
  mov R1, [BP-21]
  mov R3, [BP-14]
  iadd R3, 14
  mov R2, [R3]
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_40338:
  jf R0, __if_40324_else
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
  jmp __if_40324_end
__if_40324_else:
  mov R1, [BP-14]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
__if_40324_end:
  mov R13, [BP-7]
  iadd R13, 4
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP-7]
  iadd R13, 6
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP-6]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-23]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  call __function_b2Neg
  mov R1, [BP-6]
  iadd R1, 4
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-27]
  mov [SP+2], R1
  call __function_b2Add
  mov R13, [BP-6]
  lea R12, [BP-27]
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 12
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP-6]
  iadd R1, 14
  mov [R1], R0
  mov R1, [BP-20]
  mov [SP], R1
  mov R1, [BP-17]
  mov R2, [BP+3]
  fmul R1, R2
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-28], R0
  mov R1, [BP+2]
  iadd R1, 52
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_40414
  mov R2, [BP-14]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_40414:
  jf R0, __LogicalAnd_ShortCircuit_40420
  mov R1, [BP-28]
  mov R3, [BP-6]
  iadd R3, 17
  mov R2, [R3]
  fmul R2, 0.500000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_40420:
  mov [BP-29], R0
__if_40426_start:
  mov R0, [BP-29]
  jf R0, __if_40426_else
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_40436_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_40436_end
  jmp __for_40204_continue
__if_40436_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  jmp __if_40426_end
__if_40426_else:
  mov R13, [BP-6]
  iadd R13, 8
  mov R12, [BP-6]
  iadd R12, 4
  mov CR, 2
  movs
  mov R13, [BP-6]
  iadd R13, 6
  mov R12, [BP-6]
  iadd R12, 2
  mov CR, 2
  movs
__if_40426_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_40204_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_40204_start
__for_40204_end:
  mov R0, 0
  mov [BP-5], R0
__for_40464_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_40464_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
__if_40480_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 24
  ine R0, 24
  jf R0, __if_40480_end
  jmp __for_40464_continue
__if_40480_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-6]
  iadd R2, 22
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_40464_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_40464_start
__for_40464_end:
__function_b2FinalizeBodies_return:
  mov SP, BP
  pop BP
  ret

__function_b2PreparePoint:
  push BP
  mov BP, SP
  isub SP, 25
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 8
  mov [R1], R0
  mov R12, [BP+2]
  lea DR, [BP-2]
  mov CR, 2
  movs
  mov R12, [BP+2]
  iadd R12, 2
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R13, [BP+3]
  lea R12, [BP-2]
  mov CR, 2
  movs
  mov R13, [BP+3]
  iadd R13, 2
  lea R12, [BP-4]
  mov CR, 2
  movs
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Sub
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  lea R3, [BP-6]
  mov [SP], R3
  mov R3, [BP+4]
  mov [SP+1], R3
  call __function_b2Dot
  mov R2, R0
  fsub R1, R2
  mov R2, [BP+3]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-7], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-8], R0
  mov R0, [BP+6]
  mov R1, [BP+7]
  fadd R0, R1
  mov R1, [BP+8]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-7]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+9]
  mov R2, [BP-8]
  fmul R1, R2
  mov R2, [BP-8]
  fmul R1, R2
  fadd R0, R1
  mov [BP-9], R0
__if_40651_start:
  mov R0, [BP-9]
  fgt R0, 0.000000
  jf R0, __if_40651_else
  mov R0, 1.000000
  mov R1, [BP-9]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  jmp __if_40651_end
__if_40651_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_40651_end:
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-10], R0
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-11], R0
  mov R0, [BP+6]
  mov R1, [BP+7]
  fadd R0, R1
  mov R1, [BP+8]
  mov R2, [BP-10]
  fmul R1, R2
  mov R2, [BP-10]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+9]
  mov R2, [BP-11]
  fmul R1, R2
  mov R2, [BP-11]
  fmul R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_40694_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_40694_else
  mov R0, 1.000000
  mov R1, [BP-12]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  jmp __if_40694_end
__if_40694_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_40694_end:
  mov R1, [BP+11]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-14]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP+10]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-16]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP+13]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP+12]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  mov R2, [BP+4]
  mov [SP], R2
  lea R2, [BP-22]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 5
  mov [R2], R1
  mov R0, R1
__function_b2PreparePoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareContacts:
  push BP
  mov BP, SP
  isub SP, 21
  push R1
  push R2
  isub SP, 12
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP-1]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, 0
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_40789_start:
  mov R0, [BP-6]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_40789_end
  mov R0, [BP-2]
  mov R1, [BP-6]
  imul R1, 49
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-7]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_40810_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_40810_end
  jmp __for_40789_continue
__if_40810_end:
  mov R1, [BP-7]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-10], R0
  mov R0, [BP+3]
  mov R1, [BP-5]
  imul R1, 38
  iadd R0, R1
  mov [BP-11], R0
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  mov R0, [BP-6]
  mov R1, [BP-11]
  mov [R1], R0
  mov R0, [BP-9]
  iadd R0, 1
  mov R1, [BP-11]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-10]
  iadd R0, 1
  mov R1, [BP-11]
  iadd R1, 2
  mov [R1], R0
  mov R13, [BP-11]
  iadd R13, 25
  mov R12, [BP-7]
  iadd R12, 9
  mov CR, 2
  movs
  mov R1, [BP-7]
  iadd R1, 37
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 31
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 38
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 32
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 33
  mov [R1], R0
  mov R0, [BP-8]
  mov R1, [BP-11]
  iadd R1, 37
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 27
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 29
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 28
  mov [R1], R0
  mov R1, [BP-7]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-11]
  iadd R1, 30
  mov [R1], R0
__if_40895_start:
  mov R0, [BP-9]
  ieq R0, -1
  jt R0, __LogicalOr_ShortCircuit_40902
  mov R1, [BP-10]
  ieq R1, -1
  or R0, R1
__LogicalOr_ShortCircuit_40902:
  jf R0, __if_40895_else
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 3
  movs
  jmp __if_40895_end
__if_40895_else:
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 3
  movs
__if_40895_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
__if_40923_start:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __if_40923_end
  lea R13, [BP-13]
  mov R12, [BP-3]
  mov R1, [BP-9]
  imul R1, 8
  iadd R12, R1
  mov CR, 2
  movs
  mov R1, [BP-3]
  mov R2, [BP-9]
  imul R2, 8
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  mov [BP-14], R0
__if_40923_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-17], R0
__if_40948_start:
  mov R0, [BP-10]
  ine R0, -1
  jf R0, __if_40948_end
  lea R13, [BP-16]
  mov R12, [BP-3]
  mov R1, [BP-10]
  imul R1, 8
  iadd R12, R1
  mov CR, 2
  movs
  mov R1, [BP-3]
  mov R2, [BP-10]
  imul R2, 8
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  mov [BP-17], R0
__if_40948_end:
  mov R12, [BP-11]
  iadd R12, 25
  lea DR, [BP-19]
  mov CR, 2
  movs
  lea R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  call __function_b2RightPerp
__if_40978_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_40978_end
  mov R1, [BP-7]
  iadd R1, 9
  iadd R1, 3
  mov [SP], R1
  mov R1, [BP-11]
  iadd R1, 3
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  lea R1, [BP-21]
  mov [SP+3], R1
  mov R2, [BP-11]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-11]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-11]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-11]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-13]
  mov [SP+8], R1
  mov R1, [BP-14]
  mov [SP+9], R1
  lea R1, [BP-16]
  mov [SP+10], R1
  mov R1, [BP-17]
  mov [SP+11], R1
  call __function_b2PreparePoint
__if_40978_end:
__if_41012_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_41012_end
  mov R1, [BP-7]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  mov [SP], R1
  mov R1, [BP-11]
  iadd R1, 3
  iadd R1, 11
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  lea R1, [BP-21]
  mov [SP+3], R1
  mov R2, [BP-11]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-11]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-11]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-11]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-13]
  mov [SP+8], R1
  mov R1, [BP-14]
  mov [SP+9], R1
  lea R1, [BP-16]
  mov [SP+10], R1
  mov R1, [BP-17]
  mov [SP+11], R1
  call __function_b2PreparePoint
__if_41012_end:
__for_40789_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_40789_start
__for_40789_end:
  mov R0, [BP-5]
__function_b2PrepareContacts_return:
  iadd SP, 12
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartPoint:
  push BP
  mov BP, SP
  isub SP, 6
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 7
  mov R1, [R2]
  mov R3, [BP+4]
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov R2, [BP+2]
  iadd R2, 7
  mov R1, [R2]
  mov R3, [BP+4]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+2]
  iadd R1, 8
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP+10]
  mov R0, [R0]
  mov R1, [BP+6]
  mov R2, [BP-1]
  mov R3, [BP-6]
  fmul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-5]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fsub R0, R1
  lea R1, [BP+10]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP+9]
  mov R0, [R1]
  mov R1, [BP+5]
  mov R2, [BP-5]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+9]
  mov [R1], R0
  mov R1, [BP+9]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+5]
  mov R2, [BP-6]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+9]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+12]
  mov R0, [R0]
  mov R1, [BP+8]
  mov R2, [BP-3]
  mov R3, [BP-6]
  fmul R2, R3
  mov R3, [BP-4]
  mov R4, [BP-5]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fadd R0, R1
  lea R1, [BP+12]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP+11]
  mov R0, [R1]
  mov R1, [BP+7]
  mov R2, [BP-5]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+11]
  mov [R1], R0
  mov R1, [BP+11]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+7]
  mov R2, [BP-6]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+11]
  iadd R1, 1
  mov [R1], R0
__function_b2WarmStartPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartContacts:
  push BP
  mov BP, SP
  isub SP, 37
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  lea R13, [BP-10]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-8], R0
  mov R0, 0
  mov [BP-7], R0
  lea R13, [BP-6]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP-4]
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-11], R0
__for_41223_start:
  mov R0, [BP-11]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_41223_end
  mov R0, [BP+3]
  mov R1, [BP-11]
  imul R1, 38
  iadd R0, R1
  mov [BP-12], R0
  mov R1, [BP-12]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-13], R0
  mov R1, [BP-12]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 1
  mov [BP-14], R0
__if_41253_start:
  mov R0, [BP-13]
  ieq R0, -1
  jf R0, __if_41253_else
  lea R0, [BP-10]
  mov [BP-15], R0
  jmp __if_41253_end
__if_41253_else:
  mov R0, [BP-2]
  mov R1, [BP-13]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_41253_end:
__if_41271_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_41271_else
  lea R0, [BP-10]
  mov [BP-16], R0
  jmp __if_41271_end
__if_41271_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_41271_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R12, [BP-12]
  iadd R12, 25
  lea DR, [BP-24]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov [BP-26], R0
  mov R0, [BP-24]
  fsgn R0
  mov [BP-25], R0
__if_41320_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_41320_end
  mov R1, [BP-12]
  iadd R1, 3
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  mov R2, [BP-12]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-12]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-12]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-12]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+6], R1
  lea R1, [BP-18]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-21]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  call __function_b2WarmStartPoint
__if_41320_end:
__if_41351_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_41351_end
  mov R1, [BP-12]
  iadd R1, 3
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  mov R2, [BP-12]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-12]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-12]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-12]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+6], R1
  lea R1, [BP-18]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-21]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  call __function_b2WarmStartPoint
__if_41351_end:
__if_41382_start:
  mov R0, [BP-13]
  ine R0, -1
  jf R0, __if_41382_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_41382_end:
__if_41397_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_41397_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_41397_end:
__for_41223_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_41223_start
__for_41223_end:
__function_b2WarmStartContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveNormalPoint:
  push BP
  mov BP, SP
  isub SP, 28
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+10]
  mov R0, [R1]
  mov R1, [BP-3]
  fmul R0, R1
  mov R2, [BP+10]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-4]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
  mov R1, [BP+10]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-3]
  fmul R0, R1
  mov R2, [BP+10]
  mov R1, [R2]
  mov R2, [BP-4]
  fmul R1, R2
  fadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+9]
  mov R0, [R1]
  mov R1, [BP-1]
  fmul R0, R1
  mov R2, [BP+9]
  iadd R2, 1
  mov R1, [R2]
  mov R2, [BP-2]
  fmul R1, R2
  fsub R0, R1
  mov [BP-7], R0
  mov R1, [BP+9]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  fmul R0, R1
  mov R2, [BP+9]
  mov R1, [R2]
  mov R2, [BP-2]
  fmul R1, R2
  fadd R0, R1
  mov [BP-8], R0
  mov R1, [BP+8]
  mov R0, [R1]
  mov R1, [BP-5]
  mov R2, [BP-7]
  fsub R1, R2
  fadd R0, R1
  mov [BP-9], R0
  mov R1, [BP+8]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-6]
  mov R2, [BP-8]
  fsub R1, R2
  fadd R0, R1
  mov [BP-10], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-9]
  mov R3, [BP+3]
  mov R2, [R3]
  fmul R1, R2
  mov R2, [BP-10]
  mov R4, [BP+3]
  iadd R4, 1
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  fadd R0, R1
  mov [BP-11], R0
  mov R0, 0.000000
  mov [BP-12], R0
  mov R0, 1.000000
  mov [BP-13], R0
  mov R0, 0.000000
  mov [BP-14], R0
__if_41536_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __if_41536_else
  mov R0, [BP-11]
  mov R1, [BP+12]
  fmul R0, R1
  mov [BP-12], R0
  jmp __if_41536_end
__if_41536_else:
__if_41546_start:
  mov R0, [BP+14]
  jf R0, __if_41546_end
  mov R1, [BP+11]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+11]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-11]
  fmul R0, R1
  mov [BP-26], R0
  mov R2, [BP-26]
  mov [SP], R2
  mov R2, [BP+13]
  fsgn R2
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov [BP-12], R1
  mov R0, R1
  mov R1, [BP+11]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-13], R0
  mov R1, [BP+11]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-14], R0
__if_41546_end:
__if_41536_end:
  mov R1, [BP+15]
  mov R0, [R1]
  mov R1, [BP+16]
  mov R1, [R1]
  mov R2, [BP-2]
  fmul R1, R2
  fsub R0, R1
  mov [BP-15], R0
  mov R1, [BP+15]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+16]
  mov R1, [R1]
  mov R2, [BP-1]
  fmul R1, R2
  fadd R0, R1
  mov [BP-16], R0
  mov R1, [BP+17]
  mov R0, [R1]
  mov R1, [BP+18]
  mov R1, [R1]
  mov R2, [BP-4]
  fmul R1, R2
  fsub R0, R1
  mov [BP-17], R0
  mov R1, [BP+17]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+18]
  mov R1, [R1]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-18], R0
  mov R0, [BP-17]
  mov R1, [BP-15]
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-18]
  mov R1, [BP-16]
  fsub R0, R1
  mov [BP-20], R0
  mov R0, [BP-19]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-20]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-21], R0
  mov R1, [BP+2]
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-13]
  mov R2, [BP-21]
  fmul R1, R2
  mov R2, [BP-12]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-22], R0
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-22]
  fadd R0, R1
  mov [BP-23], R0
__if_41656_start:
  mov R0, [BP-23]
  flt R0, 0.000000
  jf R0, __if_41656_end
  mov R0, 0.000000
  mov [BP-23], R0
__if_41656_end:
  mov R0, [BP-23]
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  fsub R0, R1
  mov [BP-22], R0
  mov R0, [BP-23]
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-22]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-22]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov [BP-24], R0
  mov R0, [BP-22]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov [BP-25], R0
  mov R1, [BP+15]
  mov R0, [R1]
  mov R1, [BP+4]
  mov R2, [BP-24]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+15]
  mov [R1], R0
  mov R1, [BP+15]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+4]
  mov R2, [BP-25]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+15]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+16]
  mov R0, [R0]
  mov R1, [BP+5]
  mov R2, [BP-1]
  mov R3, [BP-25]
  fmul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-24]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fsub R0, R1
  lea R1, [BP+16]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP+17]
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-24]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+17]
  mov [R1], R0
  mov R1, [BP+17]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-25]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+17]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+18]
  mov R0, [R0]
  mov R1, [BP+7]
  mov R2, [BP-3]
  mov R3, [BP-25]
  fmul R2, R3
  mov R3, [BP-4]
  mov R4, [BP-24]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fadd R0, R1
  lea R1, [BP+18]
  mov R1, [R1]
  mov [R1], R0
__function_b2SolveNormalPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveFrictionPoint:
  push BP
  mov BP, SP
  isub SP, 19
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+10]
  mov R0, [R1]
  mov R1, [BP+11]
  mov R1, [R1]
  mov R2, [BP-2]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
  mov R1, [BP+10]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+11]
  mov R1, [R1]
  mov R2, [BP-1]
  fmul R1, R2
  fadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+12]
  mov R0, [R1]
  mov R1, [BP+13]
  mov R1, [R1]
  mov R2, [BP-4]
  fmul R1, R2
  fsub R0, R1
  mov [BP-7], R0
  mov R1, [BP+12]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+13]
  mov R1, [R1]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-7]
  mov R1, [BP-5]
  fsub R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-6]
  fsub R0, R1
  mov [BP-10], R0
  mov R0, [BP-9]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-10]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+5]
  fsub R0, R1
  mov [BP-11], R0
  mov R1, [BP+2]
  iadd R1, 10
  mov R0, [R1]
  mov R1, [BP-11]
  fsgn R1
  fmul R0, R1
  mov [BP-12], R0
  mov R0, [BP+4]
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  fmul R0, R1
  mov [BP-13], R0
  mov R2, [BP+2]
  iadd R2, 7
  mov R1, [R2]
  mov R2, [BP-12]
  fadd R1, R2
  mov [SP], R1
  mov R1, [BP-13]
  fsgn R1
  mov [SP+1], R1
  mov R1, [BP-13]
  mov [SP+2], R1
  call __function_b2ClampFloat
  mov [BP-14], R0
  mov R0, [BP-14]
  mov R2, [BP+2]
  iadd R2, 7
  mov R1, [R2]
  fsub R0, R1
  mov [BP-12], R0
  mov R0, [BP-14]
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, [BP-12]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov [BP-15], R0
  mov R0, [BP-12]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov [BP-16], R0
  mov R1, [BP+10]
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-15]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+10]
  mov [R1], R0
  mov R1, [BP+10]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-16]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+10]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+11]
  mov R0, [R0]
  mov R1, [BP+7]
  mov R2, [BP-1]
  mov R3, [BP-16]
  fmul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-15]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fsub R0, R1
  lea R1, [BP+11]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP+12]
  mov R0, [R1]
  mov R1, [BP+8]
  mov R2, [BP-15]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+12]
  mov [R1], R0
  mov R1, [BP+12]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+8]
  mov R2, [BP-16]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+12]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+13]
  mov R0, [R0]
  mov R1, [BP+9]
  mov R2, [BP-3]
  mov R3, [BP-16]
  fmul R2, R3
  mov R3, [BP-4]
  mov R4, [BP-15]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fadd R0, R1
  lea R1, [BP+13]
  mov R1, [R1]
  mov [R1], R0
__function_b2SolveFrictionPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveContacts:
  push BP
  mov BP, SP
  isub SP, 50
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 57
  mov R0, [R1]
  mov [BP-3], R0
  lea R13, [BP-11]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-9], R0
  mov R0, 0
  mov [BP-8], R0
  lea R13, [BP-7]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP-5]
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-12], R0
__for_42018_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_42018_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
  mov R1, [BP-13]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-14], R0
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 1
  mov [BP-15], R0
__if_42048_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_42048_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_42048_end
__if_42048_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_42048_end:
__if_42066_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_42066_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_42066_end
__if_42066_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_42066_end:
  mov R12, [BP-16]
  lea DR, [BP-19]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-20], R0
  mov R12, [BP-17]
  lea DR, [BP-22]
  mov CR, 2
  movs
  mov R1, [BP-17]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-23], R0
  mov R12, [BP-16]
  iadd R12, 6
  lea DR, [BP-25]
  mov CR, 2
  movs
  mov R12, [BP-17]
  iadd R12, 6
  lea DR, [BP-27]
  mov CR, 2
  movs
  mov R1, [BP-17]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-16]
  iadd R2, 4
  mov R1, [R2]
  fsub R0, R1
  mov [BP-29], R0
  mov R1, [BP-17]
  iadd R1, 4
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-16]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  fsub R0, R1
  mov [BP-28], R0
  mov R12, [BP-13]
  iadd R12, 25
  lea DR, [BP-31]
  mov CR, 2
  movs
  mov R0, [BP-30]
  mov [BP-33], R0
  mov R0, [BP-31]
  fsgn R0
  mov [BP-32], R0
__if_42145_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_42145_end
  mov R1, [BP-13]
  iadd R1, 3
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+2], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+5], R1
  lea R1, [BP-29]
  mov [SP+6], R1
  lea R1, [BP-25]
  mov [SP+7], R1
  lea R1, [BP-27]
  mov [SP+8], R1
  mov R1, [BP-13]
  iadd R1, 34
  mov [SP+9], R1
  mov R1, [BP+5]
  mov [SP+10], R1
  mov R1, [BP-3]
  mov [SP+11], R1
  mov R1, [BP+6]
  mov [SP+12], R1
  lea R1, [BP-19]
  mov [SP+13], R1
  lea R1, [BP-20]
  mov [SP+14], R1
  lea R1, [BP-22]
  mov [SP+15], R1
  lea R1, [BP-23]
  mov [SP+16], R1
  call __function_b2SolveNormalPoint
__if_42145_end:
__if_42186_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_42186_end
  mov R1, [BP-13]
  iadd R1, 3
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+2], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+5], R1
  lea R1, [BP-29]
  mov [SP+6], R1
  lea R1, [BP-25]
  mov [SP+7], R1
  lea R1, [BP-27]
  mov [SP+8], R1
  mov R1, [BP-13]
  iadd R1, 34
  mov [SP+9], R1
  mov R1, [BP+5]
  mov [SP+10], R1
  mov R1, [BP-3]
  mov [SP+11], R1
  mov R1, [BP+6]
  mov [SP+12], R1
  lea R1, [BP-19]
  mov [SP+13], R1
  lea R1, [BP-20]
  mov [SP+14], R1
  lea R1, [BP-22]
  mov [SP+15], R1
  lea R1, [BP-23]
  mov [SP+16], R1
  call __function_b2SolveNormalPoint
__if_42186_end:
__if_42227_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_42227_end
__if_42232_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_42232_end
  mov R1, [BP-13]
  iadd R1, 3
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 31
  mov R1, [R2]
  mov [SP+2], R1
  mov R2, [BP-13]
  iadd R2, 33
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-20]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  lea R1, [BP-23]
  mov [SP+11], R1
  call __function_b2SolveFrictionPoint
__if_42232_end:
__if_42265_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_42265_end
  mov R1, [BP-13]
  iadd R1, 3
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 31
  mov R1, [R2]
  mov [SP+2], R1
  mov R2, [BP-13]
  iadd R2, 33
  mov R1, [R2]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-20]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  lea R1, [BP-23]
  mov [SP+11], R1
  call __function_b2SolveFrictionPoint
__if_42265_end:
__if_42227_end:
__if_42298_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_42298_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_42298_end:
__if_42313_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_42313_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_42313_end:
__for_42018_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_42018_start
__for_42018_end:
__function_b2SolveContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitutionPoint:
  push BP
  mov BP, SP
  isub SP, 17
__if_42341_start:
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+5]
  fsgn R1
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_42349
  mov R2, [BP+2]
  iadd R2, 8
  mov R1, [R2]
  feq R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_42349:
  jf R0, __if_42341_end
  jmp __function_b2ApplyRestitutionPoint_return
__if_42341_end:
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 2
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+10]
  mov R0, [R1]
  mov R1, [BP+11]
  mov R1, [R1]
  mov R2, [BP-2]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
  mov R1, [BP+10]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+11]
  mov R1, [R1]
  mov R2, [BP-1]
  fmul R1, R2
  fadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+12]
  mov R0, [R1]
  mov R1, [BP+13]
  mov R1, [R1]
  mov R2, [BP-4]
  fmul R1, R2
  fsub R0, R1
  mov [BP-7], R0
  mov R1, [BP+12]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+13]
  mov R1, [R1]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-7]
  mov R1, [BP-5]
  fsub R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-6]
  fsub R0, R1
  mov [BP-10], R0
  mov R0, [BP-9]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-10]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-11], R0
  mov R1, [BP+2]
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-11]
  mov R2, [BP+4]
  mov R4, [BP+2]
  iadd R4, 5
  mov R3, [R4]
  fmul R2, R3
  fadd R1, R2
  fmul R0, R1
  mov [BP-12], R0
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  mov R2, [BP-12]
  fadd R1, R2
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-13], R0
  mov R0, [BP-13]
  mov R2, [BP+2]
  iadd R2, 6
  mov R1, [R2]
  fsub R0, R1
  mov [BP-12], R0
  mov R0, [BP-13]
  mov R1, [BP+2]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-12]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-12]
  mov R2, [BP+3]
  mov R1, [R2]
  fmul R0, R1
  mov [BP-14], R0
  mov R0, [BP-12]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  mov [BP-15], R0
  mov R1, [BP+10]
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-14]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+10]
  mov [R1], R0
  mov R1, [BP+10]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+6]
  mov R2, [BP-15]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP+10]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+11]
  mov R0, [R0]
  mov R1, [BP+7]
  mov R2, [BP-1]
  mov R3, [BP-15]
  fmul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-14]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fsub R0, R1
  lea R1, [BP+11]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP+12]
  mov R0, [R1]
  mov R1, [BP+8]
  mov R2, [BP-14]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+12]
  mov [R1], R0
  mov R1, [BP+12]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+8]
  mov R2, [BP-15]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP+12]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+13]
  mov R0, [R0]
  mov R1, [BP+9]
  mov R2, [BP-3]
  mov R3, [BP-15]
  fmul R2, R3
  mov R3, [BP-4]
  mov R4, [BP-14]
  fmul R3, R4
  fsub R2, R3
  fmul R1, R2
  fadd R0, R1
  lea R1, [BP+13]
  mov R1, [R1]
  mov [R1], R0
__function_b2ApplyRestitutionPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitution:
  push BP
  mov BP, SP
  isub SP, 37
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 58
  mov R0, [R1]
  mov [BP-3], R0
  lea R13, [BP-11]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-9], R0
  mov R0, 0
  mov [BP-8], R0
  lea R13, [BP-7]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP-5]
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-12], R0
__for_42597_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_42597_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
__if_42613_start:
  mov R1, [BP-13]
  iadd R1, 32
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_42613_end
  jmp __for_42597_continue
__if_42613_end:
  mov R1, [BP-13]
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-14], R0
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 1
  mov [BP-15], R0
__if_42633_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_42633_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_42633_end
__if_42633_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_42633_end:
__if_42651_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_42651_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_42651_end
__if_42651_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_42651_end:
  mov R12, [BP-16]
  lea DR, [BP-19]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-20], R0
  mov R12, [BP-17]
  lea DR, [BP-22]
  mov CR, 2
  movs
  mov R1, [BP-17]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-23], R0
  mov R12, [BP-13]
  iadd R12, 25
  lea DR, [BP-25]
  mov CR, 2
  movs
__if_42687_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_42687_end
  mov R1, [BP-13]
  iadd R1, 3
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 32
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-20]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  lea R1, [BP-23]
  mov [SP+11], R1
  call __function_b2ApplyRestitutionPoint
__if_42687_end:
__if_42719_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_42719_end
  mov R1, [BP-13]
  iadd R1, 3
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  mov R2, [BP-13]
  iadd R2, 32
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  mov R2, [BP-13]
  iadd R2, 27
  mov R1, [R2]
  mov [SP+4], R1
  mov R2, [BP-13]
  iadd R2, 29
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP-13]
  iadd R2, 28
  mov R1, [R2]
  mov [SP+6], R1
  mov R2, [BP-13]
  iadd R2, 30
  mov R1, [R2]
  mov [SP+7], R1
  lea R1, [BP-19]
  mov [SP+8], R1
  lea R1, [BP-20]
  mov [SP+9], R1
  lea R1, [BP-22]
  mov [SP+10], R1
  lea R1, [BP-23]
  mov [SP+11], R1
  call __function_b2ApplyRestitutionPoint
__if_42719_end:
__if_42751_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_42751_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_42751_end:
__if_42766_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_42766_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_42766_end:
__for_42597_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_42597_start
__for_42597_end:
__function_b2ApplyRestitution_return:
  mov SP, BP
  pop BP
  ret

__function_b2StoreImpulses:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_42800_start:
  mov R0, [BP-3]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_42800_end
  mov R0, [BP+3]
  mov R1, [BP-3]
  imul R1, 38
  iadd R0, R1
  mov [BP-4], R0
  mov R0, [BP-2]
  mov R2, [BP-4]
  mov R1, [R2]
  imul R1, 49
  iadd R0, R1
  iadd R0, 9
  mov [BP-5], R0
__if_42824_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_42824_end
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 9
  mov [R1], R0
__if_42824_end:
__if_42874_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_42874_end
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 11
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 12
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 11
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 12
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 11
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 12
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 11
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov [R1], R0
__if_42874_end:
__for_42800_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_42800_start
__for_42800_end:
__function_b2StoreImpulses_return:
  mov SP, BP
  pop BP
  ret

__function_b2InitDummyBodyState:
  push BP
  mov BP, SP
  mov R13, [BP+2]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 3
  mov [R1], R0
  mov R13, [BP+2]
  iadd R13, 4
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R13, [BP+2]
  iadd R13, 6
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
__function_b2InitDummyBodyState_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareDistanceJoint:
  push BP
  mov BP, SP
  isub SP, 34
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 23
  mov [BP-13], R0
__if_43047_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_43047_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_43047_end
__if_43047_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_43047_end:
__if_43063_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_43063_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_43063_end
__if_43063_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_43063_end:
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 17
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, [BP-13]
  iadd R12, 15
  lea DR, [BP-19]
  mov CR, 2
  movs
  mov R12, [BP-13]
  iadd R12, 17
  lea DR, [BP-21]
  mov CR, 2
  movs
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-23]
  mov [SP], R1
  mov R1, [BP-13]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-25]
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-28], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-29], R0
  mov R0, [BP-9]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-10]
  mov R2, [BP-28]
  fmul R1, R2
  mov R2, [BP-28]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-12]
  mov R2, [BP-29]
  fmul R1, R2
  mov R2, [BP-29]
  fmul R1, R2
  fadd R0, R1
  mov [BP-30], R0
__if_43198_start:
  mov R0, [BP-30]
  fgt R0, 0.000000
  jf R0, __if_43198_else
  mov R0, 1.000000
  mov R1, [BP-30]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_43198_end
__if_43198_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_43198_end:
  mov R2, [BP-13]
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 21
  mov [SP+3], R1
  call __function_b2MakeSoft
__function_b2PrepareDistanceJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartDistanceJoint:
  push BP
  mov BP, SP
  isub SP, 39
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 23
  mov [BP-14], R0
__if_43261_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_43261_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_43261_end
__if_43261_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_43261_end:
__if_43281_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_43281_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_43281_end
__if_43281_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_43281_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 17
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R1, [BP-14]
  iadd R1, 9
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  fadd R0, R1
  mov [BP-31], R0
  mov R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2MulSV
__if_43388_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_43388_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  lea R1, [BP-35]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-35]
  mov CR, 2
  movs
  mov R2, [BP-15]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-12]
  lea R4, [BP-18]
  mov [SP], R4
  lea R4, [BP-33]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R2, [BP-15]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_43388_end:
__if_43424_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_43424_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  lea R1, [BP-35]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-35]
  mov CR, 2
  movs
  mov R2, [BP-16]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-13]
  lea R4, [BP-20]
  mov [SP], R4
  lea R4, [BP-33]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-16]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_43424_end:
__function_b2WarmStartDistanceJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveDistanceJoint:
  push BP
  mov BP, SP
  isub SP, 64
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 23
  mov [BP-14], R0
__if_43503_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_43503_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_43503_end
__if_43503_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_43503_end:
__if_43523_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_43523_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_43523_end
__if_43523_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_43523_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 17
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-26]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-34]
  mov [SP], R1
  call __function_b2Length
  mov [BP-35], R0
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  call __function_b2Normalize
__if_43630_start:
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_43633
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 6
  mov R2, [R3]
  flt R1, R2
  jt R1, __LogicalOr_ShortCircuit_43642
  mov R3, [BP-14]
  iadd R3, 26
  mov R2, [R3]
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_43642:
  and R0, R1
__LogicalAnd_ShortCircuit_43633:
  jf R0, __if_43630_else
__if_43646_start:
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_43646_end
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  mov R0, [BP-35]
  mov R2, [BP-14]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-49], R0
  mov R1, [BP-14]
  iadd R1, 21
  mov R0, [R1]
  mov R1, [BP-49]
  fmul R0, R1
  mov [BP-50], R0
  mov R1, [BP-14]
  iadd R1, 21
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  fmul R0, R1
  mov [BP-51], R0
  mov R1, [BP-14]
  iadd R1, 9
  mov R0, [R1]
  mov [BP-52], R0
  mov R0, [BP-51]
  fsgn R0
  mov R1, [BP-48]
  mov R2, [BP-50]
  fadd R1, R2
  fmul R0, R1
  mov R2, [BP-14]
  iadd R2, 21
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-52]
  fmul R1, R2
  fsub R0, R1
  mov [BP-53], R0
  mov R3, [BP-14]
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP-53]
  fadd R2, R3
  mov [SP], R2
  mov R3, [BP-14]
  iadd R3, 3
  mov R2, [R3]
  mov R3, [BP+4]
  fmul R2, R3
  mov [SP+1], R2
  mov R3, [BP-14]
  iadd R3, 4
  mov R2, [R3]
  mov R3, [BP+4]
  fmul R2, R3
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-52]
  fsub R0, R1
  mov [BP-53], R0
  mov R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-57]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-57]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-55]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-59]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-59]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-55]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_43646_end:
__if_43820_start:
  mov R1, [BP-14]
  iadd R1, 27
  mov R0, [R1]
  jf R0, __if_43820_end
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  mov R2, [BP-48]
  fsub R1, R2
  fmul R0, R1
  mov [BP-49], R0
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-50], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 7
  mov R1, [R2]
  fmul R0, R1
  mov [BP-51], R0
  mov R3, [BP-14]
  iadd R3, 12
  mov R2, [R3]
  mov R3, [BP-49]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-51]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-51]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 12
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-50]
  fsub R0, R1
  mov [BP-49], R0
  mov R1, [BP-49]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-53]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-53]
  mov [SP+2], R1
  lea R1, [BP-55]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-55]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-53]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-53]
  mov [SP+2], R1
  lea R1, [BP-57]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-57]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-53]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_43820_end:
__if_43967_start:
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  jf R0, __if_43967_end
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  mov R0, [BP-35]
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fsub R0, R1
  mov [BP-49], R0
  mov R0, 0.000000
  mov [BP-50], R0
  mov R0, 1.000000
  mov [BP-51], R0
  mov R0, 0.000000
  mov [BP-52], R0
__if_44037_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_44037_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_44037_end
__if_44037_else:
__if_44046_start:
  mov R0, [BP+6]
  jf R0, __if_44046_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-49]
  fmul R0, R1
  mov [BP-50], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-51], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-52], R0
__if_44046_end:
__if_44037_end:
  mov R0, [BP-51]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-48]
  mov R2, [BP-50]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-52]
  mov R3, [BP-14]
  iadd R3, 10
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-53], R0
  mov R1, 0.000000
  mov [SP], R1
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  mov R2, [BP-53]
  fadd R1, R2
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-54], R0
  mov R0, [BP-54]
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  fsub R0, R1
  mov [BP-53], R0
  mov R0, [BP-54]
  mov R1, [BP-14]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-58]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-56]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-60]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-60]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-56]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  mov R1, [BP-14]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-35]
  fsub R0, R1
  mov [BP-49], R0
  mov R0, 0.000000
  mov [BP-50], R0
  mov R0, 1.000000
  mov [BP-51], R0
  mov R0, 0.000000
  mov [BP-52], R0
__if_44223_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_44223_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_44223_end
__if_44223_else:
__if_44232_start:
  mov R0, [BP+6]
  jf R0, __if_44232_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-49]
  fmul R0, R1
  mov [BP-50], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-51], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-52], R0
__if_44232_end:
__if_44223_end:
  mov R0, [BP-51]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-48]
  mov R2, [BP-50]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-52]
  mov R3, [BP-14]
  iadd R3, 11
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-53], R0
  mov R1, 0.000000
  mov [SP], R1
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-53]
  fadd R1, R2
  mov [SP+1], R1
  call __function_b2MaxFloat
  mov [BP-54], R0
  mov R0, [BP-54]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  mov [BP-53], R0
  mov R0, [BP-54]
  mov R1, [BP-14]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-53]
  fsgn R1
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-58]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-58]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-56]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-60]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-60]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-56]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_43967_end:
  jmp __if_43630_end
__if_43630_else:
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2CrossSV
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-43]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-39]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-47]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-48], R0
  mov R0, [BP-35]
  mov R2, [BP-14]
  mov R1, [R2]
  fsub R0, R1
  mov [BP-49], R0
  mov R0, 0.000000
  mov [BP-50], R0
  mov R0, 1.000000
  mov [BP-51], R0
  mov R0, 0.000000
  mov [BP-52], R0
__if_44410_start:
  mov R0, [BP+6]
  jf R0, __if_44410_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-49]
  fmul R0, R1
  mov [BP-50], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-51], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-52], R0
__if_44410_end:
  mov R0, [BP-51]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-48]
  mov R2, [BP-50]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-52]
  mov R3, [BP-14]
  iadd R3, 9
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-53], R0
  mov R1, [BP-14]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-53]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 9
  mov [R1], R0
  mov R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-57]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-57]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-55]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  lea R1, [BP-59]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-59]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-55]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_43630_end:
__if_44510_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_44510_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_44510_end:
__if_44526_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_44526_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_44526_end:
__function_b2SolveDistanceJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareRevoluteJoint:
  push BP
  mov BP, SP
  isub SP, 22
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 51
  mov [BP-13], R0
__if_44643_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44643_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_44643_end
__if_44643_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_44643_end:
__if_44659_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44659_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_44659_end
__if_44659_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_44659_end:
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 8
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-10]
  mov R1, [BP-12]
  fadd R0, R1
  mov [BP-18], R0
__if_44762_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_44762_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_44762_end
__if_44762_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_44762_end:
  mov R2, [BP-13]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 7
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 26
  mov [SP+3], R1
  call __function_b2MakeSoft
__function_b2PrepareRevoluteJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartRevoluteJoint:
  push BP
  mov BP, SP
  isub SP, 27
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 51
  mov [BP-14], R0
__if_44825_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_44825_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_44825_end
__if_44825_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_44825_end:
__if_44845_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_44845_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_44845_end
__if_44845_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_44845_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 4
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fsub R0, R1
  mov [BP-21], R0
__if_44900_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_44900_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP-14]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-23]
  mov CR, 2
  movs
  mov R2, [BP-15]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-12]
  lea R4, [BP-18]
  mov [SP], R4
  mov R4, [BP-14]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R4, [BP-21]
  fadd R3, R4
  fmul R2, R3
  fsub R1, R2
  mov R2, [BP-15]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_44900_end:
__if_44941_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_44941_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  mov R1, [BP-14]
  mov [SP+2], R1
  lea R1, [BP-23]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-23]
  mov CR, 2
  movs
  mov R2, [BP-16]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-13]
  lea R4, [BP-20]
  mov [SP], R4
  mov R4, [BP-14]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R4, [BP-21]
  fadd R3, R4
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-16]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_44941_end:
__function_b2WarmStartRevoluteJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveRevoluteJoint:
  push BP
  mov BP, SP
  isub SP, 73
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 51
  mov [BP-14], R0
__if_45025_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_45025_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_45025_end
__if_45025_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_45025_end:
__if_45045_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_45045_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_45045_end
__if_45045_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_45045_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2MulRot
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2InvMulRot
  mov R0, [BP-12]
  mov R1, [BP-13]
  fadd R0, R1
  feq R0, 0.000000
  mov [BP-29], R0
__if_45120_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_45123
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_45123:
  jf R0, __if_45120_end
  lea R1, [BP-28]
  mov [SP], R1
  call __function_b2Rot_GetAngle
  mov [BP-62], R0
  mov R1, [BP-62]
  mov R3, [BP-14]
  iadd R3, 8
  mov R2, [R3]
  fsub R1, R2
  mov [SP], R1
  call __function_b2UnwindAngle
  mov [BP-63], R0
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  mov R1, [BP-63]
  fmul R0, R1
  mov [BP-64], R0
  mov R1, [BP-14]
  iadd R1, 26
  iadd R1, 1
  mov R0, [R1]
  mov [BP-65], R0
  mov R1, [BP-14]
  iadd R1, 26
  iadd R1, 2
  mov R0, [R1]
  mov [BP-66], R0
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov [BP-67], R0
  mov R0, [BP-65]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-67]
  mov R2, [BP-64]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-66]
  mov R3, [BP-14]
  iadd R3, 2
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-68], R0
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-68]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-68]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-68]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_45120_end:
__if_45200_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_45203
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_45203:
  jf R0, __if_45200_end
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  fsub R0, R1
  mov [BP-62], R0
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-62]
  fmul R0, R1
  mov [BP-63], R0
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-64], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 9
  mov R1, [R2]
  fmul R0, R1
  mov [BP-65], R0
  mov R3, [BP-14]
  iadd R3, 3
  mov R2, [R3]
  mov R3, [BP-63]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-65]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-65]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-64]
  fsub R0, R1
  mov [BP-63], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-63]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-63]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_45200_end:
__if_45264_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_45267
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_45267:
  jf R0, __if_45264_end
  lea R1, [BP-28]
  mov [SP], R1
  call __function_b2Rot_GetAngle
  mov [BP-62], R0
  mov R0, [BP-62]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-64], R0
  mov R0, 1.000000
  mov [BP-65], R0
  mov R0, 0.000000
  mov [BP-66], R0
__if_45293_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_45293_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_45293_end
__if_45293_else:
__if_45302_start:
  mov R0, [BP+6]
  jf R0, __if_45302_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-63]
  fmul R0, R1
  mov [BP-64], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-65], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-66], R0
__if_45302_end:
__if_45293_end:
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov [BP-67], R0
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-68], R0
  mov R0, [BP-65]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-67]
  mov R2, [BP-64]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-66]
  mov R2, [BP-68]
  fmul R1, R2
  fsub R0, R1
  mov [BP-69], R0
  mov R2, [BP-68]
  mov R3, [BP-69]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-68]
  fsub R0, R1
  mov [BP-69], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-69]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-69]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-62]
  fsub R0, R1
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-64], R0
  mov R0, 1.000000
  mov [BP-65], R0
  mov R0, 0.000000
  mov [BP-66], R0
__if_45391_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_45391_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_45391_end
__if_45391_else:
__if_45400_start:
  mov R0, [BP+6]
  jf R0, __if_45400_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-63]
  fmul R0, R1
  mov [BP-64], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-65], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-66], R0
__if_45400_end:
__if_45391_end:
  mov R0, [BP-19]
  mov R1, [BP-22]
  fsub R0, R1
  mov [BP-67], R0
  mov R1, [BP-14]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-68], R0
  mov R0, [BP-65]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-67]
  mov R2, [BP-64]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-66]
  mov R2, [BP-68]
  fmul R1, R2
  fsub R0, R1
  mov [BP-69], R0
  mov R2, [BP-68]
  mov R3, [BP-69]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 5
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-68]
  fsub R0, R1
  mov [BP-69], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-69]
  fmul R1, R2
  fadd R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-69]
  fmul R1, R2
  fsub R0, R1
  mov [BP-22], R0
__if_45264_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-31]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-37]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-39]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-37]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, global_b2Vec2_zero
  lea DR, [BP-45]
  mov CR, 2
  movs
  mov R0, 1.000000
  mov [BP-46], R0
  mov R0, 0.000000
  mov [BP-47], R0
__if_45549_start:
  mov R0, [BP+6]
  jf R0, __if_45549_end
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-63]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-65]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-63]
  mov [SP], R1
  lea R1, [BP-65]
  mov [SP+1], R1
  lea R1, [BP-67]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-67]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 23
  mov [SP+1], R1
  lea R1, [BP-69]
  mov [SP+2], R1
  call __function_b2Add
  mov R2, [BP+3]
  iadd R2, 18
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-46], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-47], R0
__if_45549_end:
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-30]
  mov R2, [BP-30]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-32]
  mov R2, [BP-32]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-51], R0
  mov R0, [BP-30]
  fsgn R0
  mov R1, [BP-31]
  fmul R0, R1
  mov R1, [BP-12]
  fmul R0, R1
  mov R1, [BP-32]
  mov R2, [BP-33]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fsub R0, R1
  mov [BP-49], R0
  mov R0, [BP-49]
  mov [BP-50], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-31]
  mov R2, [BP-31]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-33]
  mov R2, [BP-33]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-48], R0
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-45]
  mov [SP+1], R1
  lea R1, [BP-53]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-51]
  mov [SP], R1
  lea R1, [BP-53]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Solve22
  mov R0, [BP-46]
  fsgn R0
  mov R1, [BP-55]
  fmul R0, R1
  mov R1, [BP-47]
  mov R3, [BP-14]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-57], R0
  mov R0, [BP-46]
  fsgn R0
  mov R1, [BP-54]
  fmul R0, R1
  mov R1, [BP-47]
  mov R3, [BP-14]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-56], R0
  mov R1, [BP-14]
  mov R0, [R1]
  mov R1, [BP-57]
  fadd R0, R1
  mov R1, [BP-14]
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-56]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-59]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-59]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-31]
  mov [SP], R4
  lea R4, [BP-57]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-61]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-33]
  mov [SP], R4
  lea R4, [BP-57]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_45800_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45800_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_45800_end:
__if_45816_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45816_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_45816_end:
__function_b2SolveRevoluteJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareWeldJoint:
  push BP
  mov BP, SP
  isub SP, 22
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 83
  mov [BP-13], R0
__if_45933_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_45933_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_45933_end
__if_45933_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_45933_end:
__if_45949_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_45949_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_45949_end
__if_45949_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_45949_end:
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 8
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-10]
  mov R1, [BP-12]
  fadd R0, R1
  mov [BP-18], R0
__if_46052_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_46052_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_46052_end
__if_46052_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_46052_end:
__if_46066_start:
  mov R1, [BP-13]
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_46066_else
  mov R13, [BP-13]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_46066_end
__if_46066_else:
  mov R2, [BP-13]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 4
  mov [SP+3], R1
  call __function_b2MakeSoft
__if_46066_end:
__if_46085_start:
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_46085_else
  mov R13, [BP-13]
  iadd R13, 7
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_46085_end
__if_46085_else:
  mov R2, [BP-13]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 7
  mov [SP+3], R1
  call __function_b2MakeSoft
__if_46085_end:
__function_b2PrepareWeldJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartWeldJoint:
  push BP
  mov BP, SP
  isub SP, 26
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 83
  mov [BP-14], R0
__if_46144_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46144_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_46144_end
__if_46144_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_46144_end:
__if_46164_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46164_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_46164_end
__if_46164_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_46164_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
__if_46206_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46206_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP-14]
  iadd R1, 10
  mov [SP+2], R1
  lea R1, [BP-22]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R2, [BP-15]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-12]
  lea R4, [BP-18]
  mov [SP], R4
  mov R4, [BP-14]
  iadd R4, 10
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R5, [BP-14]
  iadd R5, 12
  mov R4, [R5]
  fadd R3, R4
  fmul R2, R3
  fsub R1, R2
  mov R2, [BP-15]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_46206_end:
__if_46248_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46248_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  mov R1, [BP-14]
  iadd R1, 10
  mov [SP+2], R1
  lea R1, [BP-22]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R2, [BP-16]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-13]
  lea R4, [BP-20]
  mov [SP], R4
  mov R4, [BP-14]
  iadd R4, 10
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R5, [BP-14]
  iadd R5, 12
  mov R4, [R5]
  fadd R3, R4
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-16]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_46248_end:
__function_b2WarmStartWeldJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveWeldJoint:
  push BP
  mov BP, SP
  isub SP, 66
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 83
  mov [BP-14], R0
__if_46331_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46331_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_46331_end
__if_46331_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_46331_end:
__if_46351_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46351_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_46351_end
__if_46351_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_46351_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2MulRot
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2InvMulRot
  lea R1, [BP-28]
  mov [SP], R1
  call __function_b2Rot_GetAngle
  mov [BP-29], R0
  mov R0, 0.000000
  mov [BP-30], R0
  mov R0, 1.000000
  mov [BP-31], R0
  mov R0, 0.000000
  mov [BP-32], R0
__if_46433_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_46435
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_46435:
  jf R0, __if_46433_end
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  mov R1, [BP-29]
  fmul R0, R1
  mov [BP-30], R0
  mov R1, [BP-14]
  iadd R1, 7
  iadd R1, 1
  mov R0, [R1]
  mov [BP-31], R0
  mov R1, [BP-14]
  iadd R1, 7
  iadd R1, 2
  mov R0, [R1]
  mov [BP-32], R0
__if_46433_end:
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov [BP-33], R0
  mov R0, [BP-31]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-33]
  mov R2, [BP-30]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-32]
  mov R3, [BP-14]
  iadd R3, 12
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-34], R0
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-34]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-34]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-34]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R12, global_b2Vec2_zero
  lea DR, [BP-28]
  mov CR, 2
  movs
  mov R0, 1.000000
  mov [BP-29], R0
  mov R0, 0.000000
  mov [BP-30], R0
__if_46535_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_46537
  mov R2, [BP-14]
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_46537:
  jf R0, __if_46535_end
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-26]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-58]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-56]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-60]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 23
  mov [SP+1], R1
  lea R1, [BP-62]
  mov [SP+2], R1
  call __function_b2Add
  mov R2, [BP-14]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-62]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP-14]
  iadd R1, 4
  iadd R1, 1
  mov R0, [R1]
  mov [BP-29], R0
  mov R1, [BP-14]
  iadd R1, 4
  iadd R1, 2
  mov R0, [R1]
  mov [BP-30], R0
__if_46535_end:
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-36]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  lea R1, [BP-38]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-38]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2Sub
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-23]
  mov R2, [BP-23]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-25]
  mov R2, [BP-25]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-44], R0
  mov R0, [BP-23]
  fsgn R0
  mov R1, [BP-24]
  fmul R0, R1
  mov R1, [BP-12]
  fmul R0, R1
  mov R1, [BP-25]
  mov R2, [BP-26]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fsub R0, R1
  mov [BP-42], R0
  mov R0, [BP-42]
  mov [BP-43], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-24]
  mov R2, [BP-24]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-26]
  mov R2, [BP-26]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-41], R0
  lea R1, [BP-40]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  lea R1, [BP-46]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-44]
  mov [SP], R1
  lea R1, [BP-46]
  mov [SP+1], R1
  lea R1, [BP-48]
  mov [SP+2], R1
  call __function_b2Solve22
  mov R0, [BP-29]
  fsgn R0
  mov R1, [BP-48]
  fmul R0, R1
  mov R1, [BP-30]
  mov R3, [BP-14]
  iadd R3, 10
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-50], R0
  mov R0, [BP-29]
  fsgn R0
  mov R1, [BP-47]
  fmul R0, R1
  mov R1, [BP-30]
  mov R3, [BP-14]
  iadd R3, 10
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-49], R0
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  mov R1, [BP-50]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 10
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-49]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 10
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-50]
  mov [SP+2], R1
  lea R1, [BP-52]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-52]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-50]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-50]
  mov [SP+2], R1
  lea R1, [BP-54]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-54]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-50]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_46834_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46834_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_46834_end:
__if_46850_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46850_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_46850_end:
__function_b2SolveWeldJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PreparePrismaticJoint:
  push BP
  mov BP, SP
  isub SP, 21
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 109
  mov [BP-13], R0
__if_46967_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46967_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_46967_end
__if_46967_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_46967_end:
__if_46983_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46983_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_46983_end
__if_46983_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_46983_end:
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 15
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 8
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 19
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [SP+2], R1
  call __function_b2Sub
  mov R2, [BP-13]
  iadd R2, 6
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 7
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [SP+3], R1
  call __function_b2MakeSoft
__function_b2PreparePrismaticJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrismaticAxis:
  push BP
  mov BP, SP
  isub SP, 7
  mov R0, 1.000000
  mov [BP-2], R0
  mov R0, 0.000000
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 15
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RotateVector
__function_b2PrismaticAxis_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartPrismaticJoint:
  push BP
  mov BP, SP
  isub SP, 51
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 109
  mov [BP-14], R0
__if_47160_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47160_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_47160_end
__if_47160_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_47160_end:
__if_47180_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47180_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_47180_end
__if_47180_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_47180_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-22]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 23
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-14]
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2PrismaticAxis
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-33], R0
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-34], R0
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 4
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fsub R0, R1
  mov [BP-35], R0
  lea R1, [BP-30]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-38], R0
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-39], R0
  mov R1, [BP-14]
  mov R0, [R1]
  mov [BP-40], R0
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-41], R0
  mov R0, [BP-35]
  mov R1, [BP-30]
  fmul R0, R1
  mov R1, [BP-40]
  mov R2, [BP-37]
  fmul R1, R2
  fadd R0, R1
  mov [BP-43], R0
  mov R0, [BP-35]
  mov R1, [BP-29]
  fmul R0, R1
  mov R1, [BP-40]
  mov R2, [BP-36]
  fmul R1, R2
  fadd R0, R1
  mov [BP-42], R0
  mov R0, [BP-35]
  mov R1, [BP-33]
  fmul R0, R1
  mov R1, [BP-40]
  mov R2, [BP-38]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-41]
  fadd R0, R1
  mov [BP-44], R0
  mov R0, [BP-35]
  mov R1, [BP-34]
  fmul R0, R1
  mov R1, [BP-40]
  mov R2, [BP-39]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-41]
  fadd R0, R1
  mov [BP-45], R0
__if_47385_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_47385_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  lea R1, [BP-47]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-47]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-12]
  mov R2, [BP-44]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_47385_end:
__if_47417_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_47417_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-43]
  mov [SP+2], R1
  lea R1, [BP-47]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-47]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  mov R2, [BP-45]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_47417_end:
__function_b2WarmStartPrismaticJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolvePrismaticJoint:
  push BP
  mov BP, SP
  isub SP, 107
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 109
  mov [BP-14], R0
__if_47492_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47492_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_47492_end
__if_47492_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_47492_end:
__if_47512_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47512_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_47512_end
__if_47512_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_47512_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2MulRot
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2InvMulRot
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 19
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-34]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 23
  mov [SP+1], R1
  lea R1, [BP-36]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-38]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-36]
  mov [SP], R1
  lea R1, [BP-38]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-14]
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP+1], R1
  lea R1, [BP-42]
  mov [SP+2], R1
  call __function_b2PrismaticAxis
  lea R1, [BP-42]
  mov [SP], R1
  lea R1, [BP-40]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-43], R0
  lea R1, [BP-30]
  mov [SP], R1
  lea R1, [BP-40]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-45]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-46], R0
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-47], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-12]
  mov R2, [BP-46]
  fmul R1, R2
  mov R2, [BP-46]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-13]
  mov R2, [BP-47]
  fmul R1, R2
  mov R2, [BP-47]
  fmul R1, R2
  fadd R0, R1
  mov [BP-48], R0
__if_47700_start:
  mov R0, [BP-48]
  fgt R0, 0.000000
  jf R0, __if_47700_else
  mov R0, 1.000000
  mov R1, [BP-48]
  fdiv R0, R1
  mov [BP-49], R0
  jmp __if_47700_end
__if_47700_else:
  mov R0, 0.000000
  mov [BP-49], R0
__if_47700_end:
__if_47712_start:
  mov R1, [BP-14]
  iadd R1, 28
  mov R0, [R1]
  jf R0, __if_47712_end
  mov R0, [BP-43]
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fsub R0, R1
  mov [BP-85], R0
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  mov R1, [BP-85]
  fmul R0, R1
  mov [BP-86], R0
  mov R1, [BP-14]
  iadd R1, 25
  iadd R1, 1
  mov R0, [R1]
  mov [BP-87], R0
  mov R1, [BP-14]
  iadd R1, 25
  iadd R1, 2
  mov R0, [R1]
  mov [BP-88], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-90]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-42]
  mov [SP], R2
  lea R2, [BP-90]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-47]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-46]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-91], R0
  mov R0, [BP-87]
  fsgn R0
  mov R1, [BP-49]
  fmul R0, R1
  mov R1, [BP-91]
  mov R2, [BP-86]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-88]
  mov R3, [BP-14]
  iadd R3, 2
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-92], R0
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-92]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-92]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  lea R1, [BP-94]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-92]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-95], R0
  mov R0, [BP-92]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-96], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-94]
  mov [SP+2], R1
  lea R1, [BP-98]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-98]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-95]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-94]
  mov [SP+2], R1
  lea R1, [BP-100]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-100]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-96]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_47712_end:
__if_47844_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __if_47844_end
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-86]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-42]
  mov [SP], R2
  lea R2, [BP-86]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-47]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-46]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-87], R0
  mov R0, [BP-49]
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  mov R2, [BP-87]
  fsub R1, R2
  fmul R0, R1
  mov [BP-88], R0
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-89], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 9
  mov R1, [R2]
  fmul R0, R1
  mov [BP-90], R0
  mov R3, [BP-14]
  iadd R3, 3
  mov R2, [R3]
  mov R3, [BP-88]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-90]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-90]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-89]
  fsub R0, R1
  mov [BP-88], R0
  mov R1, [BP-88]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  lea R1, [BP-92]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-88]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-93], R0
  mov R0, [BP-88]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-94], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-92]
  mov [SP+2], R1
  lea R1, [BP-96]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-96]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-93]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-92]
  mov [SP+2], R1
  lea R1, [BP-98]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-98]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-94]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_47844_end:
__if_47966_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_47966_end
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  fmul R0, 0.250000
  mov [BP-85], R0
  mov R0, [BP-43]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  mov [BP-86], R0
__if_47987_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_47987_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_48001_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_48001_else
  call __function_b2GetLengthUnitsPerMeter
  mov [BP-103], R0
  mov R2, [BP-86]
  mov [SP], R2
  mov R2, [BP-103]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov R2, [BP+5]
  fmul R1, R2
  mov [BP-87], R1
  mov R0, R1
  jmp __if_48001_end
__if_48001_else:
__if_48016_start:
  mov R0, [BP+6]
  jf R0, __if_48016_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-86]
  fmul R0, R1
  mov [BP-87], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-88], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-89], R0
__if_48016_end:
__if_48001_end:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-90], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-92]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-42]
  mov [SP], R2
  lea R2, [BP-92]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-47]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-46]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-93], R0
  mov R0, [BP-49]
  fsgn R0
  mov R1, [BP-88]
  fmul R0, R1
  mov R1, [BP-93]
  mov R2, [BP-87]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-89]
  mov R2, [BP-90]
  fmul R1, R2
  fsub R0, R1
  mov [BP-94], R0
  mov R2, [BP-90]
  mov R3, [BP-94]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-90]
  fsub R0, R1
  mov [BP-94], R0
  mov R1, [BP-94]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-94]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-97], R0
  mov R0, [BP-94]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-98], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  lea R1, [BP-100]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-100]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-97]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  lea R1, [BP-102]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-102]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-98]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
  jmp __if_47987_end
__if_47987_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 4
  mov [R1], R0
__if_47987_end:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-86], R0
__if_48162_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_48162_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_48176_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_48176_else
  call __function_b2GetLengthUnitsPerMeter
  mov [BP-103], R0
  mov R2, [BP-86]
  mov [SP], R2
  mov R2, [BP-103]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov R2, [BP+5]
  fmul R1, R2
  mov [BP-87], R1
  mov R0, R1
  jmp __if_48176_end
__if_48176_else:
__if_48191_start:
  mov R0, [BP+6]
  jf R0, __if_48191_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-86]
  fmul R0, R1
  mov [BP-87], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-88], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-89], R0
__if_48191_end:
__if_48176_end:
  mov R1, [BP-14]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-90], R0
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-92]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-42]
  mov [SP], R2
  lea R2, [BP-92]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-46]
  mov R3, [BP-19]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-47]
  mov R3, [BP-22]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-93], R0
  mov R0, [BP-49]
  fsgn R0
  mov R1, [BP-88]
  fmul R0, R1
  mov R1, [BP-93]
  mov R2, [BP-87]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-89]
  mov R2, [BP-90]
  fmul R1, R2
  fsub R0, R1
  mov [BP-94], R0
  mov R2, [BP-90]
  mov R3, [BP-94]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 5
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-90]
  fsub R0, R1
  mov [BP-94], R0
  mov R1, [BP-94]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-94]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-97], R0
  mov R0, [BP-94]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-98], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  lea R1, [BP-100]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-18]
  lea R12, [BP-100]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-97]
  fmul R1, R2
  fadd R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-96]
  mov [SP+2], R1
  lea R1, [BP-102]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-21]
  lea R12, [BP-102]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-98]
  fmul R1, R2
  fsub R0, R1
  mov [BP-22], R0
  jmp __if_48162_end
__if_48162_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 5
  mov [R1], R0
__if_48162_end:
__if_47966_end:
  lea R1, [BP-42]
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-40]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-53]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-53]
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-54], R0
  lea R1, [BP-32]
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-55], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-59]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-51]
  mov [SP], R2
  lea R2, [BP-59]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-55]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-54]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov [BP-57], R1
  mov R0, R1
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov [BP-56], R0
  mov R12, global_b2Vec2_zero
  lea DR, [BP-61]
  mov CR, 2
  movs
  mov R0, 1.000000
  mov [BP-62], R0
  mov R0, 0.000000
  mov [BP-63], R0
__if_48402_start:
  mov R0, [BP+6]
  jf R0, __if_48402_end
  lea R2, [BP-51]
  mov [SP], R2
  lea R2, [BP-40]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-86], R1
  mov R0, R1
  lea R2, [BP-28]
  mov [SP], R2
  call __function_b2Rot_GetAngle
  mov R1, R0
  mov [BP-85], R1
  mov R0, R1
  mov R2, [BP+3]
  iadd R2, 18
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-86]
  mov [SP+1], R1
  lea R1, [BP-61]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-62], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-63], R0
__if_48402_end:
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-12]
  mov R2, [BP-54]
  fmul R1, R2
  mov R2, [BP-54]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-13]
  mov R2, [BP-55]
  fmul R1, R2
  mov R2, [BP-55]
  fmul R1, R2
  fadd R0, R1
  mov [BP-64], R0
  mov R0, [BP-12]
  mov R1, [BP-54]
  fmul R0, R1
  mov R1, [BP-13]
  mov R2, [BP-55]
  fmul R1, R2
  fadd R0, R1
  mov [BP-65], R0
  mov R0, [BP-12]
  mov R1, [BP-13]
  fadd R0, R1
  mov [BP-66], R0
__if_48470_start:
  mov R0, [BP-66]
  feq R0, 0.000000
  jf R0, __if_48470_end
  mov R0, 1.000000
  mov [BP-66], R0
__if_48470_end:
  mov R0, [BP-64]
  mov [BP-70], R0
  mov R0, [BP-65]
  mov [BP-68], R0
  mov R0, [BP-65]
  mov [BP-69], R0
  mov R0, [BP-66]
  mov [BP-67], R0
  lea R1, [BP-57]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  lea R1, [BP-72]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-70]
  mov [SP], R1
  lea R1, [BP-72]
  mov [SP+1], R1
  lea R1, [BP-74]
  mov [SP+2], R1
  call __function_b2Solve22
  mov R0, [BP-62]
  fsgn R0
  mov R1, [BP-74]
  fmul R0, R1
  mov R1, [BP-63]
  mov R3, [BP-14]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-76], R0
  mov R0, [BP-62]
  fsgn R0
  mov R1, [BP-73]
  fmul R0, R1
  mov R1, [BP-63]
  mov R3, [BP-14]
  iadd R3, 1
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-75], R0
  mov R1, [BP-14]
  mov R0, [R1]
  mov R1, [BP-76]
  fadd R0, R1
  mov R1, [BP-14]
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-75]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-76]
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  lea R1, [BP-78]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-76]
  mov R1, [BP-54]
  fmul R0, R1
  mov R1, [BP-75]
  fadd R0, R1
  mov [BP-79], R0
  mov R0, [BP-76]
  mov R1, [BP-55]
  fmul R0, R1
  mov R1, [BP-75]
  fadd R0, R1
  mov [BP-80], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-78]
  mov [SP+2], R1
  lea R1, [BP-82]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-82]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-79]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-78]
  mov [SP+2], R1
  lea R1, [BP-84]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-84]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-80]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_48634_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48634_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_48634_end:
__if_48650_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48650_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_48650_end:
__function_b2SolvePrismaticJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareWheelJoint:
  push BP
  mov BP, SP
  isub SP, 44
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 140
  mov [BP-13], R0
__if_48767_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_48767_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
  jmp __if_48767_end
__if_48767_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
__if_48767_end:
__if_48783_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_48783_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
  jmp __if_48783_end
__if_48783_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
__if_48783_end:
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 13
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 13
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 8
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 17
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 17
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 21
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, [BP-13]
  iadd R12, 13
  lea DR, [BP-19]
  mov CR, 2
  movs
  mov R12, [BP-13]
  iadd R12, 17
  lea DR, [BP-21]
  mov CR, 2
  movs
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-13]
  iadd R1, 21
  mov [SP], R1
  lea R1, [BP-23]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, 1.000000
  mov [BP-27], R0
  mov R0, 0.000000
  mov [BP-26], R0
  mov R1, [BP-13]
  iadd R1, 13
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  lea R1, [BP-29]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-25]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-34], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-35], R0
  mov R0, [BP-9]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-10]
  mov R2, [BP-34]
  fmul R1, R2
  mov R2, [BP-34]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-12]
  mov R2, [BP-35]
  fmul R1, R2
  mov R2, [BP-35]
  fmul R1, R2
  fadd R0, R1
  mov [BP-36], R0
__if_48978_start:
  mov R0, [BP-36]
  fgt R0, 0.000000
  jf R0, __if_48978_else
  mov R0, 1.000000
  mov R1, [BP-36]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_48978_end
__if_48978_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_48978_end:
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-37], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-38], R0
  mov R0, [BP-9]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-10]
  mov R2, [BP-37]
  fmul R1, R2
  mov R2, [BP-37]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-12]
  mov R2, [BP-38]
  fmul R1, R2
  mov R2, [BP-38]
  fmul R1, R2
  fadd R0, R1
  mov [BP-39], R0
__if_49023_start:
  mov R0, [BP-39]
  fgt R0, 0.000000
  jf R0, __if_49023_else
  mov R0, 1.000000
  mov R1, [BP-39]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_49023_end
__if_49023_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_49023_end:
  mov R2, [BP-13]
  iadd R2, 9
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 10
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 26
  mov [SP+3], R1
  call __function_b2MakeSoft
  mov R0, [BP-10]
  mov R1, [BP-12]
  fadd R0, R1
  mov [BP-40], R0
__if_49051_start:
  mov R0, [BP-40]
  fgt R0, 0.000000
  jf R0, __if_49051_else
  mov R0, 1.000000
  mov R1, [BP-40]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_49051_end
__if_49051_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_49051_end:
__function_b2PrepareWheelJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartWheelJoint:
  push BP
  mov BP, SP
  isub SP, 53
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 140
  mov [BP-14], R0
__if_49105_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_49105_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_49105_end
__if_49105_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49105_end:
__if_49125_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_49125_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_49125_end
__if_49125_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49125_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 13
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 17
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-22]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 21
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-24]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, 1.000000
  mov [BP-30], R0
  mov R0, 0.000000
  mov [BP-29], R0
  mov R1, [BP-14]
  iadd R1, 13
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-34]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  call __function_b2LeftPerp
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-38]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-38]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-39], R0
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-40], R0
  lea R1, [BP-38]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-41], R0
  lea R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-42], R0
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 4
  mov R1, [R2]
  fsub R0, R1
  mov [BP-43], R0
  mov R0, [BP-43]
  mov R1, [BP-34]
  fmul R0, R1
  mov R2, [BP-14]
  mov R1, [R2]
  mov R2, [BP-36]
  fmul R1, R2
  fadd R0, R1
  mov [BP-45], R0
  mov R0, [BP-43]
  mov R1, [BP-33]
  fmul R0, R1
  mov R2, [BP-14]
  mov R1, [R2]
  mov R2, [BP-35]
  fmul R1, R2
  fadd R0, R1
  mov [BP-44], R0
  mov R0, [BP-43]
  mov R1, [BP-39]
  fmul R0, R1
  mov R2, [BP-14]
  mov R1, [R2]
  mov R2, [BP-41]
  fmul R1, R2
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 1
  mov R1, [R2]
  fadd R0, R1
  mov [BP-46], R0
  mov R0, [BP-43]
  mov R1, [BP-40]
  fmul R0, R1
  mov R2, [BP-14]
  mov R1, [R2]
  mov R2, [BP-42]
  fmul R1, R2
  fadd R0, R1
  mov R2, [BP-14]
  iadd R2, 1
  mov R1, [R2]
  fadd R0, R1
  mov [BP-47], R0
__if_49345_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_49345_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  lea R1, [BP-49]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-49]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-12]
  mov R2, [BP-46]
  fmul R1, R2
  fsub R0, R1
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_49345_end:
__if_49377_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_49377_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  lea R1, [BP-49]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-49]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  mov R2, [BP-47]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_49377_end:
__function_b2WarmStartWheelJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveWheelJoint:
  push BP
  mov BP, SP
  isub SP, 70
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 140
  mov [BP-14], R0
__if_49452_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_49452_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_49452_end
__if_49452_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49452_end:
__if_49472_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_49472_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_49472_end
__if_49472_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49472_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
  mov R0, [BP-12]
  mov R1, [BP-13]
  fadd R0, R1
  feq R0, 0.000000
  mov [BP-23], R0
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 13
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 17
  mov [SP+1], R1
  lea R1, [BP-27]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-29]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-29]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 21
  mov [SP+1], R1
  lea R1, [BP-31]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-27]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-33]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-31]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-35]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, 1.000000
  mov [BP-37], R0
  mov R0, 0.000000
  mov [BP-36], R0
  mov R1, [BP-14]
  iadd R1, 13
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-37]
  mov [SP+1], R1
  lea R1, [BP-39]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  lea R1, [BP-39]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-42], R0
  lea R1, [BP-35]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-44]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-44]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-45], R0
  lea R1, [BP-27]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-46], R0
__if_49638_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_49641
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_49641:
  jf R0, __if_49638_end
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov R2, [BP-14]
  iadd R2, 6
  mov R1, [R2]
  fsub R0, R1
  mov [BP-47], R0
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-48], R0
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-49], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fmul R0, R1
  mov [BP-50], R0
  mov R3, [BP-14]
  iadd R3, 1
  mov R2, [R3]
  mov R3, [BP-48]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-50]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-50]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-49]
  fsub R0, R1
  mov [BP-48], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-48]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-48]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_49638_end:
__if_49702_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_49702_end
  mov R0, [BP-42]
  mov [BP-47], R0
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-48], R0
  mov R1, [BP-14]
  iadd R1, 26
  iadd R1, 1
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP-14]
  iadd R1, 26
  iadd R1, 2
  mov R0, [R1]
  mov [BP-50], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-52]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-41]
  mov [SP], R2
  lea R2, [BP-52]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-46]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-45]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-53], R0
  mov R0, [BP-49]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-53]
  mov R2, [BP-48]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-50]
  mov R3, [BP-14]
  iadd R3, 2
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-54], R0
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-54]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-54]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-54]
  mov R1, [BP-45]
  fmul R0, R1
  mov [BP-57], R0
  mov R0, [BP-54]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-58], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-60]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-60]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-57]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  lea R1, [BP-62]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-62]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-58]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_49702_end:
__if_49832_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __if_49832_end
  mov R0, [BP-42]
  mov R2, [BP-14]
  iadd R2, 7
  mov R1, [R2]
  fsub R0, R1
  mov [BP-47], R0
  mov R0, 0.000000
  mov [BP-48], R0
  mov R0, 1.000000
  mov [BP-49], R0
  mov R0, 0.000000
  mov [BP-50], R0
__if_49852_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_49852_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_49852_end
__if_49852_else:
__if_49861_start:
  mov R0, [BP+6]
  jf R0, __if_49861_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-48], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-50], R0
__if_49861_end:
__if_49852_end:
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-52]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-41]
  mov [SP], R2
  lea R2, [BP-52]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-46]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-45]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-53], R0
  mov R0, [BP-49]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-53]
  mov R2, [BP-48]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-50]
  mov R3, [BP-14]
  iadd R3, 3
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-54], R0
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-55], R0
  mov R2, [BP-55]
  mov R3, [BP-54]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-55]
  fsub R0, R1
  mov [BP-54], R0
  mov R1, [BP-54]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-54]
  mov R1, [BP-45]
  fmul R0, R1
  mov [BP-58], R0
  mov R0, [BP-54]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-59], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-61]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-58]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-63]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-59]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
  mov R1, [BP-14]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-42]
  fsub R0, R1
  mov [BP-47], R0
  mov R0, 0.000000
  mov [BP-48], R0
  mov R0, 1.000000
  mov [BP-49], R0
  mov R0, 0.000000
  mov [BP-50], R0
__if_50014_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_50014_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_50014_end
__if_50014_else:
__if_50023_start:
  mov R0, [BP+6]
  jf R0, __if_50023_end
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-47]
  fmul R0, R1
  mov [BP-48], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-49], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-50], R0
__if_50023_end:
__if_50014_end:
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-21]
  mov [SP+1], R1
  lea R1, [BP-52]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-41]
  mov [SP], R2
  lea R2, [BP-52]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-45]
  mov R3, [BP-19]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-46]
  mov R3, [BP-22]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-53], R0
  mov R0, [BP-49]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 25
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-53]
  mov R2, [BP-48]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-50]
  mov R3, [BP-14]
  iadd R3, 4
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-54], R0
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-55], R0
  mov R2, [BP-55]
  mov R3, [BP-54]
  fadd R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 4
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-55]
  fsub R0, R1
  mov [BP-54], R0
  mov R1, [BP-54]
  mov [SP], R1
  lea R1, [BP-41]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-54]
  mov R1, [BP-45]
  fmul R0, R1
  mov [BP-58], R0
  mov R0, [BP-54]
  mov R1, [BP-46]
  fmul R0, R1
  mov [BP-59], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-18]
  lea R12, [BP-61]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-58]
  fmul R1, R2
  fadd R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-57]
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-21]
  lea R12, [BP-63]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-59]
  fmul R1, R2
  fsub R0, R1
  mov [BP-22], R0
__if_49832_end:
  lea R1, [BP-41]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  call __function_b2LeftPerp
  mov R0, 0.000000
  mov [BP-49], R0
  mov R0, 1.000000
  mov [BP-50], R0
  mov R0, 0.000000
  mov [BP-51], R0
__if_50177_start:
  mov R0, [BP+6]
  jf R0, __if_50177_end
  lea R1, [BP-48]
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-66]
  fmul R0, R1
  mov [BP-49], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 1
  mov R0, [R1]
  mov [BP-50], R0
  mov R1, [BP+3]
  iadd R1, 18
  iadd R1, 2
  mov R0, [R1]
  mov [BP-51], R0
__if_50177_end:
  lea R1, [BP-44]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-52], R0
  lea R1, [BP-27]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-53], R0
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-48]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-53]
  mov R3, [BP-22]
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-52]
  mov R3, [BP-19]
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-56], R0
  mov R0, [BP-50]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-56]
  mov R2, [BP-49]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-51]
  mov R3, [BP-14]
  mov R2, [R3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-57], R0
  mov R1, [BP-14]
  mov R0, [R1]
  mov R1, [BP-57]
  fadd R0, R1
  mov R1, [BP-14]
  mov [R1], R0
  mov R1, [BP-57]
  mov [SP], R1
  lea R1, [BP-48]
  mov [SP+1], R1
  lea R1, [BP-59]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R0, [BP-57]
  mov R1, [BP-52]
  fmul R0, R1
  mov [BP-60], R0
  mov R0, [BP-57]
  mov R1, [BP-53]
  fmul R0, R1
  mov [BP-61], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-59]
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-63]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-60]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-59]
  mov [SP+2], R1
  lea R1, [BP-65]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-65]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-61]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_50324_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_50324_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_50324_end:
__if_50340_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_50340_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50340_end:
__function_b2SolveWheelJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareMotorJoint:
  push BP
  mov BP, SP
  isub SP, 30
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 21
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-5]
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-7], R0
  mov R1, [BP-6]
  mov R0, [R1]
  mov R2, [BP-4]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-9], R0
  mov R1, [BP-7]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-8]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP+3]
  iadd R1, 12
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP+3]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-12]
  mov R1, [BP+3]
  iadd R1, 15
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 172
  mov [BP-13], R0
__if_50457_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_50457_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_50457_end
__if_50457_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_50457_end:
__if_50473_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_50473_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_50473_end
__if_50473_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_50473_end:
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 25
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-7]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 8
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 29
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP+3]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-8]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-8]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-17]
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 29
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-8]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-7]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-13]
  iadd R1, 33
  mov [SP+2], R1
  call __function_b2Sub
  mov R12, [BP-13]
  iadd R12, 25
  lea DR, [BP-19]
  mov CR, 2
  movs
  mov R12, [BP-13]
  iadd R12, 29
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R2, [BP-13]
  iadd R2, 5
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 17
  mov [SP+3], R1
  call __function_b2MakeSoft
  mov R2, [BP-13]
  iadd R2, 8
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-13]
  iadd R2, 9
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-13]
  iadd R1, 20
  mov [SP+3], R1
  call __function_b2MakeSoft
  mov R0, [BP-9]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-18]
  mov R2, [BP-18]
  fmul R1, R2
  mov R2, [BP-10]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-20]
  mov R2, [BP-20]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov [BP-25], R0
  mov R0, [BP-18]
  fsgn R0
  mov R1, [BP-19]
  fmul R0, R1
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-20]
  mov R2, [BP-21]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fsub R0, R1
  mov [BP-24], R0
  mov R0, [BP-24]
  mov [BP-23], R0
  mov R0, [BP-9]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-19]
  mov R2, [BP-19]
  fmul R1, R2
  mov R2, [BP-10]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-21]
  mov R2, [BP-21]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
  lea R1, [BP-25]
  mov [SP], R1
  mov R1, [BP-13]
  iadd R1, 35
  mov [SP+1], R1
  call __function_b2GetInverse22
  mov R0, [BP-10]
  mov R1, [BP-12]
  fadd R0, R1
  mov [BP-26], R0
__if_50685_start:
  mov R0, [BP-26]
  fgt R0, 0.000000
  jf R0, __if_50685_else
  mov R0, 1.000000
  mov R1, [BP-26]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
  jmp __if_50685_end
__if_50685_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
__if_50685_end:
__function_b2PrepareMotorJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartMotorJoint:
  push BP
  mov BP, SP
  isub SP, 29
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 172
  mov [BP-14], R0
__if_50739_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_50739_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_50739_end
__if_50739_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_50739_end:
__if_50759_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_50759_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_50759_end
__if_50759_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50759_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 25
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 29
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-14]
  iadd R1, 11
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 14
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  mov R2, [BP-14]
  iadd R2, 16
  mov R1, [R2]
  fadd R0, R1
  mov [BP-23], R0
__if_50819_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_50819_end
  mov R1, [BP-15]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  lea R1, [BP-25]
  mov [SP+3], R1
  call __function_b2MulSub
  mov R13, [BP-15]
  lea R12, [BP-25]
  mov CR, 2
  movs
  mov R2, [BP-15]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-12]
  lea R4, [BP-18]
  mov [SP], R4
  lea R4, [BP-22]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R4, [BP-23]
  fadd R3, R4
  fmul R2, R3
  fsub R1, R2
  mov R2, [BP-15]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_50819_end:
__if_50858_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_50858_end
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  lea R1, [BP-25]
  mov [SP+3], R1
  call __function_b2MulAdd
  mov R13, [BP-16]
  lea R12, [BP-25]
  mov CR, 2
  movs
  mov R2, [BP-16]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP-13]
  lea R4, [BP-20]
  mov [SP], R4
  lea R4, [BP-22]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  mov R4, [BP-23]
  fadd R3, R4
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-16]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
__if_50858_end:
__function_b2WarmStartMotorJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveMotorJoint:
  push BP
  mov BP, SP
  isub SP, 71
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  lea R1, [BP-9]
  mov [SP], R1
  call __function_b2InitDummyBodyState
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov [BP-12], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov [BP-13], R0
  mov R0, [BP+3]
  iadd R0, 172
  mov [BP-14], R0
__if_50938_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_50938_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_50938_end
__if_50938_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_50938_end:
__if_50958_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_50958_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_50958_end
__if_50958_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50958_end:
  mov R12, [BP-15]
  lea DR, [BP-18]
  mov CR, 2
  movs
  mov R1, [BP-15]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-19], R0
  mov R12, [BP-16]
  lea DR, [BP-21]
  mov CR, 2
  movs
  mov R1, [BP-16]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-22], R0
__if_50992_start:
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_50999
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_50999:
  jf R0, __if_50992_end
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 25
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2MulRot
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 29
  iadd R1, 2
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2MulRot
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2InvMulRot
  lea R1, [BP-32]
  mov [SP], R1
  call __function_b2Rot_GetAngle
  mov [BP-33], R0
  mov R1, [BP-14]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP-33]
  fmul R0, R1
  mov [BP-34], R0
  mov R1, [BP-14]
  iadd R1, 20
  iadd R1, 1
  mov R0, [R1]
  mov [BP-35], R0
  mov R1, [BP-14]
  iadd R1, 20
  iadd R1, 2
  mov R0, [R1]
  mov [BP-36], R0
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov [BP-37], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 10
  mov R1, [R2]
  fmul R0, R1
  mov [BP-38], R0
  mov R1, [BP-14]
  iadd R1, 16
  mov R0, [R1]
  mov [BP-39], R0
  mov R0, [BP-35]
  fsgn R0
  mov R2, [BP-14]
  iadd R2, 39
  mov R1, [R2]
  fmul R0, R1
  mov R1, [BP-37]
  mov R2, [BP-34]
  fadd R1, R2
  fmul R0, R1
  mov R1, [BP-36]
  mov R2, [BP-39]
  fmul R1, R2
  fsub R0, R1
  mov [BP-40], R0
  mov R2, [BP-39]
  mov R3, [BP-40]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-38]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-38]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 16
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-39]
  fsub R0, R1
  mov [BP-40], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-40]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-40]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_50992_end:
__if_51119_start:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_51119_end
  mov R0, [BP-22]
  mov R1, [BP-19]
  fsub R0, R1
  mov R2, [BP-14]
  iadd R2, 3
  mov R1, [R2]
  fsub R0, R1
  mov [BP-27], R0
  mov R1, [BP-14]
  iadd R1, 39
  mov R0, [R1]
  fsgn R0
  mov R1, [BP-27]
  fmul R0, R1
  mov [BP-28], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 4
  mov R1, [R2]
  fmul R0, R1
  mov [BP-29], R0
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  mov [BP-30], R0
  mov R2, [BP-30]
  mov R3, [BP-28]
  fadd R2, R3
  mov [SP], R2
  mov R2, [BP-29]
  fsgn R2
  mov [SP+1], R2
  mov R2, [BP-29]
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov R2, [BP-14]
  iadd R2, 13
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  mov R1, [BP-30]
  fsub R0, R1
  mov [BP-28], R0
  mov R0, [BP-19]
  mov R1, [BP-12]
  mov R2, [BP-28]
  fmul R1, R2
  fsub R0, R1
  mov [BP-19], R0
  mov R0, [BP-22]
  mov R1, [BP-13]
  mov R2, [BP-28]
  fmul R1, R2
  fadd R0, R1
  mov [BP-22], R0
__if_51119_end:
  mov R1, [BP-15]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 25
  mov [SP+1], R1
  lea R1, [BP-24]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-16]
  iadd R1, 6
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 29
  mov [SP+1], R1
  lea R1, [BP-26]
  mov [SP+2], R1
  call __function_b2RotateVector
__if_51204_start:
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_51211
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_51211:
  jf R0, __if_51204_end
  mov R1, [BP-16]
  iadd R1, 4
  mov [SP], R1
  mov R1, [BP-15]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-26]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-28]
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-32]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 33
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Add
  mov R2, [BP-14]
  iadd R2, 17
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  lea R1, [BP-36]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP-14]
  iadd R1, 17
  iadd R1, 1
  mov R0, [R1]
  mov [BP-37], R0
  mov R1, [BP-14]
  iadd R1, 17
  iadd R1, 2
  mov R0, [R1]
  mov [BP-38], R0
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-40]
  mov [SP+1], R1
  lea R1, [BP-42]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-44]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-44]
  mov [SP+1], R1
  lea R1, [BP-46]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-42]
  mov [SP], R1
  lea R1, [BP-46]
  mov [SP+1], R1
  lea R1, [BP-48]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-48]
  mov [SP], R1
  lea R1, [BP-36]
  mov [SP+1], R1
  lea R1, [BP-50]
  mov [SP+2], R1
  call __function_b2Add
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-23]
  mov R2, [BP-23]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-25]
  mov R2, [BP-25]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-54], R0
  mov R0, [BP-23]
  fsgn R0
  mov R1, [BP-24]
  fmul R0, R1
  mov R1, [BP-12]
  fmul R0, R1
  mov R1, [BP-25]
  mov R2, [BP-26]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fsub R0, R1
  mov [BP-53], R0
  mov R0, [BP-53]
  mov [BP-52], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  fadd R0, R1
  mov R1, [BP-24]
  mov R2, [BP-24]
  fmul R1, R2
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-26]
  mov R2, [BP-26]
  fmul R1, R2
  mov R2, [BP-13]
  fmul R1, R2
  fadd R0, R1
  mov [BP-51], R0
  lea R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-14]
  iadd R1, 35
  mov [SP+1], R1
  call __function_b2GetInverse22
  mov R1, [BP-14]
  iadd R1, 35
  mov [SP], R1
  lea R1, [BP-50]
  mov [SP+1], R1
  lea R1, [BP-56]
  mov [SP+2], R1
  call __function_b2MulMV
  mov R12, [BP-14]
  iadd R12, 14
  lea DR, [BP-58]
  mov CR, 2
  movs
  mov R0, [BP-37]
  fsgn R0
  mov R1, [BP-56]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-58]
  fmul R1, R2
  fsub R0, R1
  mov [BP-60], R0
  mov R0, [BP-37]
  fsgn R0
  mov R1, [BP-55]
  fmul R0, R1
  mov R1, [BP-38]
  mov R2, [BP-57]
  fmul R1, R2
  fsub R0, R1
  mov [BP-59], R0
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 7
  mov R1, [R2]
  fmul R0, R1
  mov [BP-61], R0
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  mov R1, [BP-60]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 14
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 14
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-59]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 14
  iadd R1, 1
  mov [R1], R0
__if_51475_start:
  mov R2, [BP-14]
  iadd R2, 14
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-61]
  mov R3, [BP-61]
  fmul R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_51475_end
  mov R1, [BP-14]
  iadd R1, 14
  mov [SP], R1
  lea R1, [BP-67]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R0, [BP-67]
  mov R1, [BP-61]
  fmul R0, R1
  mov R1, [BP-14]
  iadd R1, 14
  mov [R1], R0
  mov R0, [BP-66]
  mov R1, [BP-61]
  fmul R0, R1
  mov R1, [BP-14]
  iadd R1, 14
  iadd R1, 1
  mov [R1], R0
__if_51475_end:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  mov R1, [BP-58]
  fsub R0, R1
  mov [BP-60], R0
  mov R1, [BP-14]
  iadd R1, 14
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-57]
  fsub R0, R1
  mov [BP-59], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  lea R1, [BP-63]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-63]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-60]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-60]
  mov [SP+2], R1
  lea R1, [BP-65]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-65]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-60]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_51204_end:
__if_51575_start:
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_51575_end
  mov R1, [BP-22]
  mov [SP], R1
  lea R1, [BP-26]
  mov [SP+1], R1
  lea R1, [BP-28]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-21]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-19]
  mov [SP], R1
  lea R1, [BP-24]
  mov [SP+1], R1
  lea R1, [BP-32]
  mov [SP+2], R1
  call __function_b2CrossSV
  lea R1, [BP-18]
  mov [SP], R1
  lea R1, [BP-32]
  mov [SP+1], R1
  lea R1, [BP-34]
  mov [SP+2], R1
  call __function_b2Add
  lea R1, [BP-30]
  mov [SP], R1
  lea R1, [BP-34]
  mov [SP+1], R1
  lea R1, [BP-36]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-36]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-38]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP-14]
  iadd R1, 35
  mov [SP], R1
  lea R1, [BP-38]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2MulMV
  mov R0, [BP-40]
  fsgn R0
  mov [BP-42], R0
  mov R0, [BP-39]
  fsgn R0
  mov [BP-41], R0
  mov R12, [BP-14]
  iadd R12, 11
  lea DR, [BP-44]
  mov CR, 2
  movs
  mov R0, [BP+4]
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fmul R0, R1
  mov [BP-45], R0
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-42]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP-14]
  iadd R1, 11
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-41]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
__if_51688_start:
  mov R2, [BP-14]
  iadd R2, 11
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-45]
  mov R3, [BP-45]
  fmul R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_51688_end
  mov R1, [BP-14]
  iadd R1, 11
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R0, [BP-51]
  mov R1, [BP-45]
  fmul R0, R1
  mov R1, [BP-14]
  iadd R1, 11
  mov [R1], R0
  mov R0, [BP-50]
  mov R1, [BP-45]
  fmul R0, R1
  mov R1, [BP-14]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
__if_51688_end:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-44]
  fsub R0, R1
  mov [BP-42], R0
  mov R1, [BP-14]
  iadd R1, 11
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-41], R0
  lea R1, [BP-18]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-42]
  mov [SP+2], R1
  lea R1, [BP-47]
  mov [SP+3], R1
  call __function_b2MulSub
  lea R13, [BP-18]
  lea R12, [BP-47]
  mov CR, 2
  movs
  mov R1, [BP-19]
  mov R2, [BP-12]
  lea R4, [BP-24]
  mov [SP], R4
  lea R4, [BP-42]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov [BP-19], R1
  mov R0, R1
  lea R1, [BP-21]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-42]
  mov [SP+2], R1
  lea R1, [BP-49]
  mov [SP+3], R1
  call __function_b2MulAdd
  lea R13, [BP-21]
  lea R12, [BP-49]
  mov CR, 2
  movs
  mov R1, [BP-22]
  mov R2, [BP-13]
  lea R4, [BP-26]
  mov [SP], R4
  lea R4, [BP-42]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov [BP-22], R1
  mov R0, R1
__if_51575_end:
__if_51788_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51788_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_51788_end:
__if_51804_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51804_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_51804_end:
__function_b2SolveMotorJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2PrepareJoints:
  push BP
  mov BP, SP
  isub SP, 9
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_51839_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_51839_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 212
  iadd R0, R1
  mov [BP-4], R0
  mov R2, [BP-4]
  iadd R2, 16
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP+4]
  fmul R1, 0.250000
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-5], R0
  mov R1, [BP-5]
  mov [SP], R1
  mov R2, [BP-4]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, [BP-4]
  iadd R1, 18
  mov [SP+3], R1
  call __function_b2MakeSoft
__if_51873_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_51873_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareDistanceJoint
  jmp __if_51873_end
__if_51873_else:
__if_51882_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_51882_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareRevoluteJoint
  jmp __if_51882_end
__if_51882_else:
__if_51891_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_51891_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWeldJoint
  jmp __if_51891_end
__if_51891_else:
__if_51900_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_51900_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PreparePrismaticJoint
  jmp __if_51900_end
__if_51900_else:
__if_51909_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_51909_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWheelJoint
  jmp __if_51909_end
__if_51909_else:
__if_51918_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51918_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareMotorJoint
__if_51918_end:
__if_51909_end:
__if_51900_end:
__if_51891_end:
__if_51882_end:
__if_51873_end:
__for_51839_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_51839_start
__for_51839_end:
__function_b2PrepareJoints_return:
  mov SP, BP
  pop BP
  ret

__function_b2WarmStartJoints:
  push BP
  mov BP, SP
  isub SP, 6
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_51944_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_51944_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 212
  iadd R0, R1
  mov [BP-4], R0
__if_51962_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_51962_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartDistanceJoint
  jmp __if_51962_end
__if_51962_else:
__if_51970_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_51970_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartRevoluteJoint
  jmp __if_51970_end
__if_51970_else:
__if_51978_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_51978_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWeldJoint
  jmp __if_51978_end
__if_51978_else:
__if_51986_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_51986_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartPrismaticJoint
  jmp __if_51986_end
__if_51986_else:
__if_51994_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_51994_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWheelJoint
  jmp __if_51994_end
__if_51994_else:
__if_52002_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52002_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartMotorJoint
__if_52002_end:
__if_51994_end:
__if_51986_end:
__if_51978_end:
__if_51970_end:
__if_51962_end:
__for_51944_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_51944_start
__for_51944_end:
__function_b2WarmStartJoints_return:
  mov SP, BP
  pop BP
  ret

__function_b2SolveJoints:
  push BP
  mov BP, SP
  isub SP, 9
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_52030_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_52030_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 212
  iadd R0, R1
  mov [BP-4], R0
__if_52048_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_52048_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2SolveDistanceJoint
  jmp __if_52048_end
__if_52048_else:
__if_52059_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_52059_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2SolveRevoluteJoint
  jmp __if_52059_end
__if_52059_else:
__if_52070_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_52070_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2SolveWeldJoint
  jmp __if_52070_end
__if_52070_else:
__if_52079_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_52079_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2SolvePrismaticJoint
  jmp __if_52079_end
__if_52079_else:
__if_52090_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_52090_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, [BP+4]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2SolveWheelJoint
  jmp __if_52090_end
__if_52090_else:
__if_52101_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52101_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2SolveMotorJoint
__if_52101_end:
__if_52090_end:
__if_52079_end:
__if_52070_end:
__if_52059_end:
__if_52048_end:
__for_52030_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_52030_start
__for_52030_end:
__function_b2SolveJoints_return:
  mov SP, BP
  pop BP
  ret

__function_b2TrySleepIsland:
  push BP
  mov BP, SP
  isub SP, 16
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 13
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 7
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-2], R0
__if_52127_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_52127_end
  mov R3, [BP+2]
  iadd R3, 11
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+2]
  iadd R3, 11
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 16
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 11
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 11
  iadd R1, 1
  mov [R1], R0
__if_52127_end:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 16
  iadd R0, R1
  mov [BP-3], R0
  mov R0, -1
  mov R1, [BP-3]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 6
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 6
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 9
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 12
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 12
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-3]
  iadd R1, 15
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-4], R0
  mov R0, 0
  mov [BP-5], R0
__for_52258_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_52258_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R0, [R2]
  mov R1, [BP-5]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-8], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP-8]
  imul R1, 21
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-10], R0
  mov R3, [BP-3]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 24
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-11], R0
  mov R1, [BP-3]
  mov R13, [R1]
  mov R1, [BP-11]
  imul R1, 24
  iadd R13, R1
  mov R1, [BP-4]
  mov R12, [R1]
  mov R1, [BP-10]
  imul R1, 24
  iadd R12, R1
  mov CR, 24
  movs
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-10]
  mov [SP+2], R1
  call __function_b2RemoveBodySim
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-12], R0
__if_52345_start:
  mov R0, [BP-10]
  mov R1, [BP-12]
  ine R0, R1
  jf R0, __if_52345_end
  mov R1, [BP-4]
  iadd R1, 3
  mov R13, [R1]
  mov R1, [BP-10]
  imul R1, 8
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 3
  mov R12, [R1]
  mov R1, [BP-12]
  imul R1, 8
  iadd R12, R1
  mov CR, 8
  movs
__if_52345_end:
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-9]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-11]
  mov R1, [BP-9]
  iadd R1, 2
  mov [R1], R0
__for_52258_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_52258_start
__for_52258_end:
  mov R0, 0
  mov [BP-5], R0
__for_52377_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_52377_end
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R3, [BP-1]
  iadd R3, 7
  mov R2, [R3]
  mov R3, [BP-5]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  iadd R1, 10
  mov R0, [R1]
  mov [BP-9], R0
  mov R3, [BP-3]
  iadd R3, 6
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 6
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 6
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 49
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-3]
  iadd R1, 6
  mov R13, [R1]
  mov R1, [BP-10]
  imul R1, 49
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 6
  mov R12, [R1]
  mov R1, [BP-9]
  imul R1, 49
  iadd R12, R1
  mov CR, 49
  movs
  mov R1, [BP-3]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-11], R0
__if_52454_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_52454_end
  mov R1, [BP-4]
  iadd R1, 6
  mov R13, [R1]
  mov R1, [BP-9]
  imul R1, 49
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 6
  mov R12, [R1]
  mov R1, [BP-11]
  imul R1, 49
  iadd R12, R1
  mov CR, 49
  movs
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R3, [BP-4]
  iadd R3, 6
  mov R2, [R3]
  mov R3, [BP-9]
  imul R3, 49
  iadd R2, R3
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP-12]
  iadd R1, 10
  mov [R1], R0
__if_52454_end:
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 6
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-8]
  iadd R1, 8
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP-8]
  iadd R1, 10
  mov [R1], R0
__for_52377_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_52377_start
__for_52377_end:
  mov R0, 0
  mov [BP-5], R0
__for_52504_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_52504_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-1]
  iadd R3, 10
  mov R2, [R3]
  mov R3, [BP-5]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-9], R0
  mov R3, [BP-3]
  iadd R3, 9
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 9
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 9
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 212
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-10], R0
  mov R1, [BP-3]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-10]
  imul R1, 212
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-9]
  imul R1, 212
  iadd R12, R1
  mov CR, 212
  movs
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-11], R0
__if_52581_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_52581_end
  mov R1, [BP-4]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-9]
  imul R1, 212
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-11]
  imul R1, 212
  iadd R12, R1
  mov CR, 212
  movs
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-4]
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP-9]
  imul R3, 212
  iadd R2, R3
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP-12]
  iadd R1, 3
  mov [R1], R0
__if_52581_end:
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-8]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-10]
  mov R1, [BP-8]
  iadd R1, 3
  mov [R1], R0
__for_52504_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_52504_start
__for_52504_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-6], R0
  mov R3, [BP-3]
  iadd R3, 12
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 12
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP-3]
  iadd R3, 12
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 12
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP-3]
  iadd R2, 12
  mov R1, [R2]
  mov R3, [BP-3]
  iadd R3, 12
  iadd R3, 1
  mov R2, [R3]
  iadd R1, R2
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP-3]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-7], R0
__if_52679_start:
  mov R0, [BP-6]
  mov R1, [BP-7]
  ine R0, R1
  jf R0, __if_52679_end
  mov R2, [BP-4]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-7]
  iadd R1, R2
  mov R0, [R1]
  mov [BP-8], R0
  mov R2, [BP-4]
  iadd R2, 12
  mov R0, [R2]
  mov R1, [BP-7]
  iadd R0, R1
  mov R0, [R0]
  mov R2, [BP-4]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-6]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-6]
  mov R2, [BP+2]
  iadd R2, 47
  mov R1, [R2]
  mov R2, [BP-8]
  imul R2, 13
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
__if_52679_end:
  mov R1, [BP-4]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_52728_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_52728_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_52728_end:
__function_b2TrySleepIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSleep:
  push BP
  mov BP, SP
  isub SP, 9
__if_52741_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_52741_end
  jmp __function_b2UpdateSleep_return
__if_52741_end:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
__while_52758_start:
__while_52758_continue:
  mov R0, [BP-1]
  ige R0, 0
  jf R0, __while_52758_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
__if_52771_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_52771_end
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_52758_continue
__if_52771_end:
  mov R2, [BP-2]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  iadd R1, R2
  mov R0, [R1]
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 13
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP-4]
  iadd R1, 5
  mov R0, [R1]
  igt R0, 0
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_52811_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_52811_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R3, [BP-4]
  iadd R3, 4
  mov R1, [R3]
  mov R2, [BP-6]
  iadd R1, R2
  mov R1, [R1]
  imul R1, 21
  iadd R0, R1
  mov [BP-7], R0
__if_52833_start:
  mov R1, [BP-7]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_52833_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_52811_end
__if_52833_end:
__if_52843_start:
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  flt R0, 0.500000
  jf R0, __if_52843_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_52811_end
__if_52843_end:
__for_52811_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_52811_start
__for_52811_end:
__if_52853_start:
  mov R0, [BP-5]
  jf R0, __if_52853_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2TrySleepIsland
__if_52853_end:
  mov R0, [BP-1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_52758_start
__while_52758_end:
__function_b2UpdateSleep_return:
  mov SP, BP
  pop BP
  ret

__function_b2ReportHitEvents:
  push BP
  mov BP, SP
  isub SP, 26
  mov R1, [BP+2]
  iadd R1, 59
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__for_52884_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_52884_end
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 49
  iadd R0, R1
  mov [BP-5], R0
__if_52902_start:
  mov R1, [BP-5]
  iadd R1, 41
  mov R0, [R1]
  and R0, 1048576
  ieq R0, 0
  jf R0, __if_52902_end
  jmp __for_52884_continue
__if_52902_end:
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, -1
  mov [BP-7], R0
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_52923_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_52923_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_52937_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_52947
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_52947:
  jf R0, __if_52937_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__if_52937_end:
__if_52923_end:
__if_52957_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_52957_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_52971_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_52981
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 12
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_52981:
  jf R0, __if_52971_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-7], R0
__if_52971_end:
__if_52957_end:
__if_52991_start:
  mov R0, [BP-7]
  ieq R0, -1
  jf R0, __if_52991_end
  jmp __for_52884_continue
__if_52991_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 85
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 4
  mov R1, [R2]
  imul R1, 85
  iadd R0, R1
  mov [BP-10], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-11], R0
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-12], R0
__if_53037_start:
  mov R1, [BP-11]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_53044
  mov R2, [BP-12]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53044:
  jf R0, __if_53037_else
__if_53048_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_53048_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_53048_end
__if_53048_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  iadd R12, 2
  mov CR, 2
  movs
__if_53048_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
  jmp __if_53037_end
__if_53037_else:
__if_53079_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_53079_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  mov CR, 2
  movs
  jmp __if_53079_end
__if_53079_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  mov CR, 2
  movs
__if_53079_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
__if_53037_end:
  mov R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-14]
  mov [SP+1], R1
  lea R1, [BP-22]
  mov [SP+2], R1
  call __function_b2Add
  lea R13, [BP-20]
  mov R12, [BP-5]
  iadd R12, 9
  mov CR, 2
  movs
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-18], R0
  mov R1, [BP-5]
  iadd R1, 4
  mov R0, [R1]
  mov [BP-17], R0
  mov R0, [BP-6]
  mov [BP-16], R0
  mov R1, [BP+2]
  iadd R1, 70
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  call __function_b2AddHitEvent
__for_52884_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_52884_start
__for_52884_end:
__function_b2ReportHitEvents_return:
  mov SP, BP
  pop BP
  ret

__function_b2Solve:
  push BP
  mov BP, SP
  isub SP, 22
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_53161_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_53161_end
  mov R0, 1
  mov [BP+4], R0
__if_53161_end:
  mov R0, [BP+3]
  mov R1, [BP+4]
  cif R1
  fdiv R0, R1
  mov [BP-3], R0
__if_53175_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_53175_else
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
  jmp __if_53175_end
__if_53175_else:
  mov R0, 0.000000
  mov [BP-4], R0
__if_53175_end:
__if_53189_start:
  mov R0, [BP+3]
  fgt R0, 0.000000
  jf R0, __if_53189_else
  mov R0, 1.000000
  mov R1, [BP+3]
  fdiv R0, R1
  mov [BP-5], R0
  jmp __if_53189_end
__if_53189_else:
  mov R0, 0.000000
  mov [BP-5], R0
__if_53189_end:
  mov R1, [BP+2]
  iadd R1, 60
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP-5]
  fmul R0, 0.785398
  mov [BP-7], R0
  mov R2, [BP+2]
  iadd R2, 55
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP-4]
  fmul R1, 0.125000
  mov [SP+1], R1
  call __function_b2MinFloat
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 56
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-3]
  mov [SP+2], R1
  lea R1, [BP-11]
  mov [SP+3], R1
  call __function_b2MakeSoft
  mov R1, [BP-8]
  fmul R1, 2.000000
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 56
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-3]
  mov [SP+2], R1
  lea R1, [BP-14]
  mov [SP+3], R1
  call __function_b2MakeSoft
  mov R0, -1
  mov [BP-15], R0
  mov R0, 0
  mov [BP-16], R0
__if_53247_start:
  mov R0, [BP-2]
  igt R0, 0
  jf R0, __if_53247_end
__if_53252_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 63
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_53252_end
__if_53258_start:
  mov R1, [BP+2]
  iadd R1, 62
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53258_end
  mov R2, [BP+2]
  iadd R2, 62
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 63
  mov R1, [R2]
  imul R1, 38
  mov [SP+1], R1
  call __function_b2Free
__if_53258_end:
  mov R2, [BP-2]
  imul R2, 38
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 62
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 63
  mov [R1], R0
__if_53252_end:
  mov R1, [BP+2]
  iadd R1, 62
  mov R0, [R1]
  mov [BP-15], R0
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-15]
  mov [SP+1], R2
  lea R2, [BP-11]
  mov [SP+2], R2
  lea R2, [BP-14]
  mov [SP+3], R2
  call __function_b2PrepareContacts
  mov R1, R0
  mov [BP-16], R1
  mov R0, R1
__if_53247_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_b2PrepareJoints
  mov R0, 0
  mov [BP-17], R0
__for_53300_start:
  mov R0, [BP-17]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_53300_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2IntegrateVelocities
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2WarmStartJoints
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  call __function_b2WarmStartContacts
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, 1
  mov [SP+3], R1
  call __function_b2SolveJoints
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-4]
  mov [SP+3], R1
  mov R1, 1
  mov [SP+4], R1
  call __function_b2SolveContacts
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  mov R1, [BP-7]
  mov [SP+3], R1
  call __function_b2IntegratePositions
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, 0
  mov [SP+3], R1
  call __function_b2SolveJoints
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-4]
  mov [SP+3], R1
  mov R1, 0
  mov [SP+4], R1
  call __function_b2SolveContacts
__for_53300_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_53300_start
__for_53300_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  call __function_b2ApplyRestitution
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  call __function_b2StoreImpulses
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2ReportHitEvents
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP-5]
  mov [SP+2], R1
  call __function_b2FinalizeBodies
__if_53360_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  jf R0, __if_53360_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSplitIsland
__if_53366_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53366_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 50
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2SplitIsland
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_53366_end:
__if_53360_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSleep
__function_b2Solve_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_Step:
  push BP
  mov BP, SP
  isub SP, 3
__if_53390_start:
  mov R0, [BP+3]
  fle R0, 0.000000
  jf R0, __if_53390_end
  jmp __function_b2World_Step_return
__if_53390_end:
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 64
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 67
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 70
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 73
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 76
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateBroadPhasePairs
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2Collide
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2Solve
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2OverlapSensors
__function_b2World_Step_return:
  mov SP, BP
  pop BP
  ret

__function_CycNow:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  call __function_get_frame_counter
  mov [BP-1], R0
  call __function_get_cycle_counter
  mov [BP-2], R0
  call __function_get_frame_counter
  mov [BP-3], R0
__if_53443_start:
  mov R0, [BP-1]
  mov R1, [BP-3]
  ine R0, R1
  jf R0, __if_53443_end
  call __function_get_cycle_counter
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R0, [BP-3]
  mov [BP-1], R0
__if_53443_end:
  mov R0, [BP-1]
  mov R1, [global_g_baseFrame]
  isub R0, R1
  imul R0, 250000
  mov R1, [BP-2]
  iadd R0, R1
__function_CycNow_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_ShowInt:
  push BP
  mov BP, SP
  isub SP, 23
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-20]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-20]
  mov [SP+2], R1
  call __function_print_at
__function_ShowInt_return:
  mov SP, BP
  pop BP
  ret

__function_BuildScene:
  push BP
  mov BP, SP
  isub SP, 151
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2CreateWorld
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 53
  mov [R1], R0
  mov R0, -10.000000
  mov R1, [BP+2]
  iadd R1, 53
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-11]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R1, 8.000000
  mov [SP], R1
  mov R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-47]
  mov [SP+2], R1
  call __function_b2MakeBox
  lea R1, [BP-69]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, 0
  mov [BP-69], R0
  mov R0, 0.000000
  mov [BP-68], R0
  mov R0, 0.000000
  mov [BP-67], R0
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  lea R1, [BP-72]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-72]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  lea R1, [BP-47]
  mov [SP+3], R1
  lea R1, [BP-75]
  mov [SP+4], R1
  call __function_b2CreatePolygonShape
  mov R0, 5
  mov [BP-76], R0
  mov R0, 1.050000
  mov [BP-77], R0
  mov R0, 0
  mov [BP-78], R0
__for_53553_start:
  mov R0, [BP-78]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_53553_end
  mov R0, [BP-78]
  mov R1, [BP-76]
  imod R0, R1
  mov [BP-79], R0
  mov R0, [BP-78]
  mov R1, [BP-76]
  idiv R0, R1
  mov [BP-80], R0
  mov R0, [BP-79]
  isub R0, 2
  cif R0
  mov R1, [BP-77]
  fmul R0, R1
  mov [BP-81], R0
  mov R0, [BP-80]
  cif R0
  mov R1, [BP-77]
  fmul R0, R1
  fadd R0, 1.200000
  mov [BP-82], R0
  mov R1, 0.500000
  mov [SP], R1
  mov R1, 0.500000
  mov [SP+1], R1
  lea R1, [BP-118]
  mov [SP+2], R1
  call __function_b2MakeBox
  lea R1, [BP-140]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, 2
  mov [BP-140], R0
  mov R0, [BP-81]
  mov [BP-139], R0
  mov R0, [BP-82]
  mov [BP-138], R0
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-140]
  mov [SP+1], R1
  lea R1, [BP-143]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-143]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  lea R1, [BP-118]
  mov [SP+3], R1
  lea R1, [BP-146]
  mov [SP+4], R1
  call __function_b2CreatePolygonShape
__for_53553_continue:
  mov R0, [BP-78]
  mov R1, R0
  iadd R1, 1
  mov [BP-78], R1
  jmp __for_53553_start
__for_53553_end:
__function_BuildScene_return:
  mov SP, BP
  pop BP
  ret

__function_MeasureScene:
  push BP
  mov BP, SP
  isub SP, 91
  lea R1, [BP-81]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_BuildScene
  mov R0, 40
  mov [BP-82], R0
  mov R0, 4
  mov [BP-83], R0
  mov R0, 0
  mov [BP-84], R0
__for_53657_start:
  mov R0, [BP-84]
  mov R1, [BP-82]
  ilt R0, R1
  jf R0, __for_53657_end
  lea R1, [BP-81]
  mov [SP], R1
  mov R1, [global_g_dt]
  mov [SP+1], R1
  mov R1, 4
  mov [SP+2], R1
  call __function_b2World_Step
__for_53657_continue:
  mov R0, [BP-84]
  mov R1, R0
  iadd R1, 1
  mov [BP-84], R1
  jmp __for_53657_start
__for_53657_end:
  call __function_get_frame_counter
  mov R1, R0
  mov [global_g_baseFrame], R1
  mov R0, R1
  mov R0, 0
  mov [BP-85], R0
  mov R0, 0
  mov [BP-86], R0
  mov R0, 0
  mov [BP-87], R0
  mov R0, 0
  mov [BP-84], R0
__for_53685_start:
  mov R0, [BP-84]
  mov R1, [BP-83]
  ilt R0, R1
  jf R0, __for_53685_end
  call __function_CycNow
  mov R1, R0
  mov [BP-88], R1
  mov R0, R1
  lea R1, [BP-81]
  mov [SP], R1
  call __function_b2UpdateBroadPhasePairs
  mov R1, [BP-85]
  call __function_CycNow
  mov R2, R0
  mov R3, [BP-88]
  isub R2, R3
  iadd R1, R2
  mov [BP-85], R1
  mov R0, R1
  call __function_CycNow
  mov R1, R0
  mov [BP-88], R1
  mov R0, R1
  lea R1, [BP-81]
  mov [SP], R1
  call __function_b2Collide
  mov R1, [BP-86]
  call __function_CycNow
  mov R2, R0
  mov R3, [BP-88]
  isub R2, R3
  iadd R1, R2
  mov [BP-86], R1
  mov R0, R1
  call __function_CycNow
  mov R1, R0
  mov [BP-88], R1
  mov R0, R1
  lea R1, [BP-81]
  mov [SP], R1
  mov R1, [global_g_dt]
  mov [SP+1], R1
  mov R1, 4
  mov [SP+2], R1
  call __function_b2Solve
  mov R1, [BP-87]
  call __function_CycNow
  mov R2, R0
  mov R3, [BP-88]
  isub R2, R3
  iadd R1, R2
  mov [BP-87], R1
  mov R0, R1
__for_53685_continue:
  mov R0, [BP-84]
  mov R1, R0
  iadd R1, 1
  mov [BP-84], R1
  jmp __for_53685_start
__for_53685_end:
  mov R0, [BP-85]
  mov R1, [BP-83]
  idiv R0, R1
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-86]
  mov R1, [BP-83]
  idiv R0, R1
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-87]
  mov R1, [BP-83]
  idiv R0, R1
  lea R1, [BP+6]
  mov R1, [R1]
  mov [R1], R0
  mov R1, [BP-70]
  iadd R1, 32
  iadd R1, 6
  iadd R1, 1
  mov R0, [R1]
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  lea R1, [BP-81]
  mov [SP], R1
  call __function_b2DestroyWorld
__function_MeasureScene_return:
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 24
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R0, 0.016667
  mov [global_g_dt], R0
  mov R1, 10
  mov [SP], R1
  lea R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  lea R1, [BP-3]
  mov [SP+3], R1
  lea R1, [BP-4]
  mov [SP+4], R1
  call __function_MeasureScene
  mov R1, 20
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  lea R1, [BP-7]
  mov [SP+3], R1
  lea R1, [BP-8]
  mov [SP+4], R1
  call __function_MeasureScene
  mov R1, 40
  mov [SP], R1
  lea R1, [BP-9]
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  lea R1, [BP-11]
  mov [SP+3], R1
  lea R1, [BP-12]
  mov [SP+4], R1
  call __function_MeasureScene
  mov R0, [BP-2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R1, [BP-4]
  iadd R0, R1
  mov [BP-13], R0
  mov R0, [BP-6]
  mov R1, [BP-7]
  iadd R0, R1
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-14], R0
  mov R0, [BP-10]
  mov R1, [BP-11]
  iadd R0, R1
  mov R1, [BP-12]
  iadd R0, R1
  mov [BP-15], R0
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R0, 20
  mov [BP-16], R0
  mov R0, 240
  mov [BP-17], R0
  mov R0, 380
  mov [BP-18], R0
  mov R0, 520
  mov [BP-19], R0
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_53863
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 55
  mov [SP+1], R1
  mov R1, __literal_string_53867
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 55
  mov [SP+1], R1
  mov R1, __literal_string_53871
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 55
  mov [SP+1], R1
  mov R1, __literal_string_53875
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 85
  mov [SP+1], R1
  mov R1, __literal_string_53879
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 85
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 85
  mov [SP+1], R1
  mov R1, [BP-5]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 85
  mov [SP+1], R1
  mov R1, [BP-9]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  mov R1, __literal_string_53895
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  mov R1, [BP-10]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 145
  mov [SP+1], R1
  mov R1, __literal_string_53911
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 145
  mov [SP+1], R1
  mov R1, [BP-3]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 145
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 145
  mov [SP+1], R1
  mov R1, [BP-11]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 175
  mov [SP+1], R1
  mov R1, __literal_string_53927
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 175
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 175
  mov [SP+1], R1
  mov R1, [BP-8]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 175
  mov [SP+1], R1
  mov R1, [BP-12]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 205
  mov [SP+1], R1
  mov R1, __literal_string_53943
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 205
  mov [SP+1], R1
  mov R1, [BP-13]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 205
  mov [SP+1], R1
  mov R1, [BP-14]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 205
  mov [SP+1], R1
  mov R1, [BP-15]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 235
  mov [SP+1], R1
  mov R1, __literal_string_53959
  mov [SP+2], R1
  call __function_print_at
  mov R1, [BP-17]
  mov [SP], R1
  mov R1, 235
  mov [SP+1], R1
  mov R1, [BP-13]
  idiv R1, 2500
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-18]
  mov [SP], R1
  mov R1, 235
  mov [SP+1], R1
  mov R1, [BP-14]
  idiv R1, 2500
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-19]
  mov [SP], R1
  mov R1, 235
  mov [SP+1], R1
  mov R1, [BP-15]
  idiv R1, 2500
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, [BP-16]
  mov [SP], R1
  mov R1, 285
  mov [SP+1], R1
  mov R1, __literal_string_53981
  mov [SP+2], R1
  call __function_print_at
__while_53982_start:
__while_53982_continue:
  mov R0, 1
  jf R0, __while_53982_end
  call __function_end_frame
  jmp __while_53982_start
__while_53982_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_1068:
  string "0123456789ABCDEF"
__literal_string_1105:
  string "-2147483648"
__literal_string_53863:
  string "VIRCONBOX2D PROFILER   BUDGET/FRAME = 250000 CYCLES"
__literal_string_53867:
  string "10 BOX"
__literal_string_53871:
  string "20 BOX"
__literal_string_53875:
  string "40 BOX"
__literal_string_53879:
  string "CONTACTS"
__literal_string_53895:
  string "PAIRING"
__literal_string_53911:
  string "COLLIDE"
__literal_string_53927:
  string "SOLVE"
__literal_string_53943:
  string "TOTAL/STEP"
__literal_string_53959:
  string "PCT OF FRAME"
__literal_string_53981:
  string "(numbers = CPU cycles, averaged over 4 settled steps)"
