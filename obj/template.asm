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
  %define global_vb2_world 17
  %define global_vb2_camX 101
  %define global_vb2_camY 102
  %define global_vb2_camPPM 103
  %define global_vb2_lastHit 104
  %define global_vb2_pickX 111
  %define global_vb2_pickY 112
  %define global_vb2_pickShape 113

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

__function_select_gamepad:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out INP_SelectedGamepad, R0
__function_select_gamepad_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_left:
  push BP
  mov BP, SP
  in R0, INP_GamepadLeft
__function_gamepad_left_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_right:
  push BP
  mov BP, SP
  in R0, INP_GamepadRight
__function_gamepad_right_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_up:
  push BP
  mov BP, SP
  in R0, INP_GamepadUp
__function_gamepad_up_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_down:
  push BP
  mov BP, SP
  in R0, INP_GamepadDown
__function_gamepad_down_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_a:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonA
__function_gamepad_button_a_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_b:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonB
__function_gamepad_button_b_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_start:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonStart
__function_gamepad_button_start_return:
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
__if_905_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_910
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_910:
  jf R0, __if_905_end
  mov R0, 1
  jmp __function_islower_return
__if_905_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_921
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_921:
  jf R0, __LogicalAnd_ShortCircuit_925
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_925:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_930_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_935
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_935:
  jf R0, __if_930_end
  mov R0, 1
  jmp __function_isupper_return
__if_930_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_946
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_946:
  jf R0, __LogicalAnd_ShortCircuit_950
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_950:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_1081_start:
__while_1081_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1081_end
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
  jmp __while_1081_start
__while_1081_end:
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
__while_1134_start:
__while_1134_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1134_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1134_start
__while_1134_end:
__while_1139_start:
__while_1139_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1139_end
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
  jmp __while_1139_start
__while_1139_end:
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
  mov SR, __literal_string_1203
  mov CR, 17
  movs
  lea R0, [BP-50]
  mov [BP-51], R0
__if_1212_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_1217
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_1217:
  jf R0, __if_1212_end
  jmp __function_itoa_return
__if_1212_end:
__if_1221_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_1226
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_1226:
  jf R0, __if_1221_else
__if_1230_start:
  mov R0, [BP+2]
  ieq R0, 0x80000000
  jf R0, __if_1230_end
  lea DR, [BP-63]
  mov SR, __literal_string_1240
  mov CR, 12
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_strcpy
  jmp __function_itoa_return
__if_1230_end:
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
  jmp __if_1221_end
__if_1221_else:
__if_1255_start:
  mov R0, [BP+2]
  ilt R0, 0
  jf R0, __if_1255_end
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
__if_1311_start:
  mov R0, [BP+2]
  bnot R0
  jf R0, __if_1311_end
  jmp __label_1331_digits_stored
__if_1311_end:
__if_1255_end:
__if_1221_end:
__do_1315_start:
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
__do_1315_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_1315_start
__do_1315_end:
__label_1331_digits_stored:
__do_1332_start:
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
__do_1332_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_1332_start
__do_1332_end:
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
__if_1510_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  flt R0, R1
  jf R0, __if_1510_end
  mov R0, [BP+3]
  jmp __function_b2ClampFloat_return
__if_1510_end:
__if_1516_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  fgt R0, R1
  jf R0, __if_1516_end
  mov R0, [BP+4]
  jmp __function_b2ClampFloat_return
__if_1516_end:
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
__if_1903_start:
  mov R0, [BP-1]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_1903_end
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Normalize_return
__if_1903_end:
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

__function_b2MakeRot:
  push BP
  mov BP, SP
  isub SP, 1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_cos
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_sin
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
__function_b2MakeRot_return:
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
__if_1972_start:
  mov R0, [BP-1]
  fgt R0, 0.000000
  jf R0, __if_1972_end
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
__if_1972_end:
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
__if_2465_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2465_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2GetLengthAndNormalize_return
__if_2465_end:
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
__if_2506_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_2511
  mov R1, [BP+3]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_2511:
  jf R0, __if_2506_end
  mov R0, 0.000000
  jmp __function_b2Atan2_return
__if_2506_end:
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
__if_2642_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_2642_end
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
__if_2642_end:
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
__if_2727_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_2727_end
  mov R0, 1.000000
  mov R1, [BP-4]
  fdiv R0, R1
  mov [BP-5], R0
__if_2727_end:
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
  jf R0, __LogicalAnd_ShortCircuit_2770
  mov R1, [BP-1]
  flt R1, 1.000600
  and R0, R1
__LogicalAnd_ShortCircuit_2770:
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
__if_2862_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2862_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2862_end:
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
__if_2934_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2934_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2934_end:
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
  jf R0, __LogicalAnd_ShortCircuit_2991
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2991:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3002
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3002:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3013
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3013:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3024
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
__LogicalAnd_ShortCircuit_3024:
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
__if_3140_start:
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3140_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3140_end:
__if_3150_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3150_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3150_end:
__if_3160_start:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3160_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3160_end:
__if_3170_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3170_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3170_end:
  mov R0, 1
__function_b2AABB_Overlaps_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2PlaneSeparation:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 2
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP+3]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fsub R1, R2
  mov R0, R1
__function_b2PlaneSeparation_return:
  iadd SP, 2
  pop R3
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
__if_3241_start:
  mov R0, [BP+2]
  mov R1, [BP+2]
  fne R0, R1
  jf R0, __if_3241_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3241_end:
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
__if_3260_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fgt R0, R1
  jf R0, __if_3260_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3260_end:
__if_3266_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fsgn R1
  flt R0, R1
  jf R0, __if_3266_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3266_end:
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
  jf R1, __LogicalAnd_ShortCircuit_3281
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_b2IsValidFloat
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_3281:
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
__if_3287_start:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3287_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3287_end:
__if_3294_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3294_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3294_end:
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

__function_b2SubPos:
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
__function_b2SubPos_return:
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
__if_4374_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4376
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4376:
  jf R0, __if_4374_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_4385_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4385_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4385_end:
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
__if_4374_end:
__if_4404_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4406
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4406:
  jf R0, __if_4404_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_4414_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_4414_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_4414_end:
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
__if_4404_end:
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
__if_4436_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_4436_end
  jmp __function_reduce_malloc_block_return
__if_4436_end:
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
__if_4479_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4479_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4479_end:
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
__if_4498_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_4498_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_4498_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_4508_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_4511
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_4511:
  jf R0, __if_4508_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4508_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_4523_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_4523_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4523_end:
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
__if_4538_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4538_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4538_end:
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
__if_4553_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_4553_end
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
__if_4553_end:
__if_4588_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_4588_end
  mov R0, -1
  jmp __function_malloc_return
__if_4588_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_4597_start:
__while_4597_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_4597_end
__if_4600_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_4603
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_4603:
  jf R0, __if_4600_end
  jmp __while_4597_end
__if_4600_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_4597_start
__while_4597_end:
__if_4613_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_4613_end
  mov R0, -1
  jmp __function_malloc_return
__if_4613_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_4623_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_4623_else
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
__if_4668_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4668_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4668_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_4623_end
__if_4623_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_4623_end:
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
__if_4693_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_4693_end
  jmp __function_free_return
__if_4693_end:
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
__if_4721_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_4721_end
  mov R0, -1
  jmp __function_calloc_return
__if_4721_end:
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
__if_4735_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_4735_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_4735_end:
__if_4741_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_4741_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_4741_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_4760_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_4760_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_4760_end:
__if_4766_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_4766_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4766_end
__if_4766_else:
__if_4777_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_4777_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4777_end
__if_4777_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_4788_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_4788_end
  mov R0, -1
  jmp __function_realloc_return
__if_4788_end:
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
__if_4777_end:
__if_4766_end:
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
__if_4875_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_4880
  mov R1, [BP-8]
  mov R2, [BP-11]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_4880:
  jf R0, __if_4875_else
__if_4884_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4884_else
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
  jmp __if_4884_end
__if_4884_else:
__if_4903_start:
  mov R0, [BP-8]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4903_else
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
  jmp __if_4903_end
__if_4903_else:
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4903_end:
__if_4884_end:
  jmp __if_4875_end
__if_4875_else:
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
__if_4950_start:
  mov R0, [BP-13]
  fne R0, 0.000000
  jf R0, __if_4950_end
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
__if_4950_end:
  mov R0, [BP-12]
  mov R1, [BP-14]
  fmul R0, R1
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-8]
  fdiv R0, R1
  mov [BP-15], R0
__if_4980_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jf R0, __if_4980_else
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
  jmp __if_4980_end
__if_4980_else:
__if_4997_start:
  mov R0, [BP-15]
  fgt R0, 1.000000
  jf R0, __if_4997_end
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
__if_4997_end:
__if_4980_end:
  mov R0, [BP-14]
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-15]
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4875_end:
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
__for_5062_start:
  mov R0, [BP-1]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_5062_end
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
__for_5062_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5062_start
__for_5062_end:
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
__if_5143_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_5143_end
  mov R0, [BP+2]
  jmp __function_b2SimplexVertexPtr_return
__if_5143_end:
__if_5151_start:
  mov R0, [BP+3]
  ieq R0, 1
  jf R0, __if_5151_end
  mov R0, [BP+2]
  iadd R0, 9
  jmp __function_b2SimplexVertexPtr_return
__if_5151_end:
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
__for_5254_start:
  mov R0, [BP-4]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_5254_end
  mov R1, [BP+2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-5], R0
__if_5273_start:
  mov R0, [BP-5]
  mov R1, [BP-3]
  fgt R0, R1
  jf R0, __if_5273_end
  mov R0, [BP-4]
  mov [BP-2], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_5273_end:
__for_5254_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_5254_start
__for_5254_end:
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
__for_5296_start:
  mov R0, [BP-1]
  mov R2, [BP+5]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5296_end
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
__for_5296_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5296_start
__for_5296_end:
__if_5357_start:
  mov R1, [BP+5]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_5357_end
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
__if_5357_end:
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
__for_5416_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5416_end
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
__for_5416_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5416_start
__for_5416_end:
__function_b2MakeSimplexCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeWitnessPoints:
  push BP
  mov BP, SP
  isub SP, 7
__if_5450_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_5450_else
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
  jmp __if_5450_end
__if_5450_else:
__if_5468_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_5468_else
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
  jmp __if_5468_end
__if_5468_else:
__if_5506_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_5506_else
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
  jmp __if_5506_end
__if_5506_else:
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
__if_5506_end:
__if_5468_end:
__if_5450_end:
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
__if_5579_start:
  mov R0, [BP-7]
  fle R0, 0.000000
  jf R0, __if_5579_end
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
__if_5579_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_5605_start:
  mov R0, [BP-8]
  fle R0, 0.000000
  jf R0, __if_5605_end
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
__if_5605_end:
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
__if_5827_start:
  mov R0, [BP-12]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5832
  mov R1, [BP-18]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5832:
  jf R0, __if_5827_end
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
__if_5827_end:
__if_5850_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5855
  mov R1, [BP-12]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5855:
  jf R0, __LogicalAnd_ShortCircuit_5859
  mov R1, [BP-31]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5859:
  jf R0, __if_5850_end
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
__if_5850_end:
__if_5911_start:
  mov R0, [BP-17]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5916
  mov R1, [BP-18]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5916:
  jf R0, __LogicalAnd_ShortCircuit_5920
  mov R1, [BP-30]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5920:
  jf R0, __if_5911_end
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
__if_5911_end:
__if_5977_start:
  mov R0, [BP-11]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5982
  mov R1, [BP-24]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5982:
  jf R0, __if_5977_end
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
__if_5977_end:
__if_6005_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6010
  mov R1, [BP-23]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6010:
  jf R0, __if_6005_end
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
__if_6005_end:
__if_6033_start:
  mov R0, [BP-23]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6038
  mov R1, [BP-24]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6038:
  jf R0, __LogicalAnd_ShortCircuit_6042
  mov R1, [BP-29]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6042:
  jf R0, __if_6033_end
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
__if_6033_end:
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
__for_6165_start:
  mov R0, [BP-61]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_6165_end
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
__for_6165_continue:
  mov R0, [BP-61]
  mov R1, R0
  iadd R1, 1
  mov [BP-61], R1
  jmp __for_6165_start
__for_6165_end:
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
__while_6225_start:
__while_6225_continue:
  mov R0, [BP-58]
  mov R1, [BP-57]
  ilt R0, R1
  jf R0, __while_6225_end
  mov R0, [BP-20]
  mov [BP-61], R0
  mov R0, 0
  mov [BP-68], R0
__for_6234_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6234_end
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
__for_6234_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6234_start
__for_6234_end:
  mov R0, 0.000000
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-62], R0
__if_6272_start:
  mov R0, [BP-20]
  ieq R0, 1
  jf R0, __if_6272_else
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __if_6272_end
__if_6272_else:
__if_6284_start:
  mov R0, [BP-20]
  ieq R0, 2
  jf R0, __if_6284_else
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex2
  jmp __if_6284_end
__if_6284_else:
__if_6294_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6294_end
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex3
__if_6294_end:
__if_6284_end:
__if_6272_end:
__if_6304_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6304_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6304_end:
__if_6320_start:
  lea R2, [BP-63]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-56]
  flt R1, R2
  mov R0, R1
  jf R0, __if_6320_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6320_end:
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
__for_6402_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6402_end
__if_6412_start:
  mov R1, [BP-64]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov R1, [R1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_6421
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  lea R2, [BP-55]
  mov R3, [BP-68]
  iadd R2, R3
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6421:
  jf R0, __if_6412_end
  mov R0, 1
  mov [BP-67], R0
  jmp __for_6402_end
__if_6412_end:
__for_6402_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6402_start
__for_6402_end:
__if_6431_start:
  mov R0, [BP-67]
  jf R0, __if_6431_end
  jmp __while_6225_end
__if_6431_end:
  mov R0, [BP-20]
  iadd R0, 1
  mov [BP-20], R0
  jmp __while_6225_start
__while_6225_end:
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
__if_6480_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  jf R0, __if_6480_end
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
__if_6480_end:
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
__for_6666_start:
  mov R0, [BP-56]
  ilt R0, 20
  jf R0, __for_6666_end
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
__if_6692_start:
  mov R0, [BP-59]
  mov R1, [BP-3]
  mov R2, [BP-4]
  fadd R1, R2
  flt R0, R1
  jf R0, __if_6692_end
__if_6700_start:
  mov R0, [BP-56]
  ieq R0, 0
  jf R0, __if_6700_else
__if_6705_start:
  mov R1, [BP+2]
  iadd R1, 43
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_6708
  mov R1, [BP-59]
  mov R2, [BP-1]
  fmul R2, 2.000000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6708:
  jf R0, __if_6705_else
  mov R0, [BP-59]
  mov R1, [BP-1]
  fsub R0, R1
  mov [BP-3], R0
  jmp __if_6705_end
__if_6705_else:
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
__if_6705_end:
  jmp __if_6700_end
__if_6700_else:
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
__if_6700_end:
__if_6692_end:
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
__if_6802_start:
  mov R0, [BP-66]
  fge R0, 0.000000
  jf R0, __if_6802_end
  jmp __function_b2ShapeCast_return
__if_6802_end:
  mov R0, [BP-12]
  mov R1, [BP-3]
  mov R2, [BP-59]
  fsub R1, R2
  mov R2, [BP-66]
  fdiv R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_6818_start:
  mov R0, [BP-12]
  mov R2, [BP+2]
  iadd R2, 42
  mov R1, [R2]
  fge R0, R1
  jf R0, __if_6818_end
  jmp __function_b2ShapeCast_return
__if_6818_end:
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
__for_6666_continue:
  mov R0, [BP-56]
  iadd R0, 1
  mov [BP-56], R0
  jmp __for_6666_start
__for_6666_end:
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
__if_6994_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_6994_end
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
__if_6994_end:
__if_7059_start:
  mov R0, [BP+2]
  iadd R0, 1
  mov R0, [R0]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  ieq R0, R1
  jf R0, __if_7059_end
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
__if_7187_start:
  lea R2, [BP-45]
  mov [SP], R2
  lea R2, [BP-37]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7187_end
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
__if_7187_end:
  jmp __function_b2MakeSeparationFunction_return
__if_7059_end:
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
__if_7326_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-19]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7326_end
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
__if_7326_end:
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
__if_7370_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7370_else
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
  jmp __if_7370_end
__if_7370_else:
__if_7471_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7471_else
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
  jmp __if_7471_end
__if_7471_else:
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
__if_7471_end:
__if_7370_end:
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
__if_7667_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7667_else
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
  jmp __if_7667_end
__if_7667_else:
__if_7721_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7721_else
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
  jmp __if_7721_end
__if_7721_else:
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
__if_7721_end:
__if_7667_end:
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
__while_7936_start:
__while_7936_continue:
  mov R0, [BP-78]
  jf R0, __while_7936_end
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
__if_8008_start:
  mov R0, [BP-89]
  fle R0, 0.000000
  jf R0, __if_8008_end
  mov R0, 2
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_8008_end:
__if_8023_start:
  mov R0, [BP-89]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8023_end
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
__if_8023_end:
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
__while_8102_start:
__while_8102_continue:
  mov R0, [BP-132]
  jf R0, __while_8102_end
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
__if_8119_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_8119_end
  mov R0, 4
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-23]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8102_end
__if_8119_end:
__if_8138_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  fgt R0, R1
  jf R0, __if_8138_end
  mov R0, [BP-130]
  mov [BP-27], R0
  jmp __while_8102_end
__if_8138_end:
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
__if_8157_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  flt R0, R1
  jf R0, __if_8157_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8102_end
__if_8157_end:
__if_8176_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8176_end
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
  jmp __while_8102_end
__if_8176_end:
  mov R0, 0
  mov [BP-137], R0
  mov R0, [BP-27]
  mov [BP-138], R0
  mov R0, [BP-130]
  mov [BP-139], R0
  mov R0, 1
  mov [BP-140], R0
__while_8243_start:
__while_8243_continue:
  mov R0, [BP-140]
  jf R0, __while_8243_end
__if_8248_start:
  mov R0, [BP-137]
  and R0, 1
  ine R0, 0
  jf R0, __if_8248_else
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
  jmp __if_8248_end
__if_8248_else:
  mov R0, [BP-138]
  mov R1, [BP-139]
  fadd R0, R1
  fmul R0, 0.500000
  mov [BP-141], R0
__if_8248_end:
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
__if_8294_start:
  mov R2, [BP-142]
  mov R3, [BP-25]
  fsub R2, R3
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, [BP-26]
  flt R1, R2
  mov R0, R1
  jf R0, __if_8294_end
  mov R0, [BP-141]
  mov [BP-130], R0
  jmp __while_8243_end
__if_8294_end:
__if_8306_start:
  mov R0, [BP-142]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_8306_else
  mov R0, [BP-141]
  mov [BP-138], R0
  mov R0, [BP-142]
  mov [BP-136], R0
  jmp __if_8306_end
__if_8306_else:
  mov R0, [BP-141]
  mov [BP-139], R0
  mov R0, [BP-142]
  mov [BP-135], R0
__if_8306_end:
__if_8324_start:
  mov R0, [BP-137]
  ieq R0, 50
  jf R0, __if_8324_end
  jmp __while_8243_end
__if_8324_end:
  jmp __while_8243_start
__while_8243_end:
  mov R0, [BP-131]
  iadd R0, 1
  mov [BP-131], R0
__if_8334_start:
  mov R0, [BP-131]
  ieq R0, 8
  jf R0, __if_8334_end
  jmp __while_8102_end
__if_8334_end:
  jmp __while_8102_start
__while_8102_end:
__if_8339_start:
  mov R0, [BP-129]
  jf R0, __if_8339_end
  jmp __while_7936_end
__if_8339_end:
__if_8342_start:
  mov R0, [BP-29]
  mov R1, [BP-28]
  ieq R0, R1
  jf R0, __if_8342_end
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
  jmp __while_7936_end
__if_8342_end:
  jmp __while_7936_start
__while_7936_end:
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
__for_8776_start:
  mov R0, [BP-8]
  mov R1, [BP+3]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_8776_end
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
__for_8776_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_8776_start
__for_8776_end:
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
__if_8979_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_8979_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakeOffsetRoundedPolygon_return
__if_8979_end:
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
__for_9014_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9014_end
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
__for_9014_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_9014_start
__for_9014_end:
  mov R0, 0
  mov [BP-5], R0
__for_9037_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9037_end
  mov R0, 0
  mov [BP-6], R0
__if_9051_start:
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_9051_end
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-6], R0
__if_9051_end:
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
__for_9037_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_9037_start
__for_9037_end:
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
__for_9121_start:
  mov R0, [BP-3]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9121_end
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
__for_9121_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_9121_start
__for_9121_end:
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
__if_9353_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_9353_end
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
__if_9353_end:
__if_9379_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_9379_end
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
__if_9379_end:
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
__if_9428_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_9428_else
  mov R0, 1.412000
  mov [BP-27], R0
  mov R0, 0
  mov [BP-28], R0
__for_9436_start:
  mov R0, [BP-28]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9436_end
  mov R0, [BP-28]
  isub R0, 1
  mov [BP-29], R0
__if_9451_start:
  mov R0, [BP-28]
  ieq R0, 0
  jf R0, __if_9451_end
  mov R0, [BP-17]
  isub R0, 1
  mov [BP-29], R0
__if_9451_end:
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
__for_9436_continue:
  mov R0, [BP-28]
  mov R1, R0
  iadd R1, 1
  mov [BP-28], R1
  jmp __for_9436_start
__for_9436_end:
  jmp __if_9428_end
__if_9428_else:
  mov R0, 0
  mov [BP-27], R0
__for_9504_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9504_end
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
__for_9504_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9504_start
__for_9504_end:
__if_9428_end:
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
__for_9547_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_9547_end
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
__for_9547_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9547_start
__for_9547_end:
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
__for_9881_start:
  mov R0, [BP-8]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9881_end
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
__for_9881_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_9881_start
__for_9881_end:
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
__if_10119_start:
  mov R0, [BP-8]
  feq R0, 0.000000
  jf R0, __if_10119_end
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
__if_10119_end:
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
__if_10230_start:
  mov R0, [BP-7]
  feq R0, 0.000000
  jf R0, __if_10230_end
__if_10235_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10235_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10235_end:
  jmp __function_b2RayCastCircle_return
__if_10230_end:
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
__if_10277_start:
  mov R0, [BP-13]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __if_10277_end
  jmp __function_b2RayCastCircle_return
__if_10277_end:
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
__if_10293_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10299
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-15]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10299:
  jf R0, __if_10293_end
__if_10305_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10305_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10305_end:
  jmp __function_b2RayCastCircle_return
__if_10293_end:
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
__if_10411_start:
  mov R0, [BP-7]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_10411_end
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
__if_10411_end:
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
__if_10475_start:
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
  jf R0, __if_10475_end
__if_10486_start:
  mov R0, [BP-16]
  flt R0, 0.000000
  jf R0, __if_10486_end
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
__if_10486_end:
__if_10508_start:
  mov R0, [BP-16]
  mov R1, [BP-7]
  fgt R0, R1
  jf R0, __if_10508_end
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
__if_10508_end:
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
__if_10475_end:
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
__if_10578_start:
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  fsgn R0
  mov R1, [BP-25]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_10587
  mov R1, [BP-25]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_10587:
  jf R0, __if_10578_end
  jmp __function_b2RayCastCapsule_return
__if_10578_end:
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
__if_10655_start:
  mov R0, [BP-31]
  mov R1, [BP-32]
  flt R0, R1
  jf R0, __if_10655_else
  mov R0, [BP-31]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-27]
  mov CR, 2
  movs
  jmp __if_10655_end
__if_10655_else:
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
__if_10655_end:
__if_10678_start:
  mov R0, [BP-33]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10684
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-22]
  fmul R1, R2
  mov R2, [BP-33]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10684:
  jf R0, __if_10678_end
  jmp __function_b2RayCastCapsule_return
__if_10678_end:
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
__if_10707_start:
  mov R0, [BP-36]
  flt R0, 0.000000
  jf R0, __if_10707_else
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
  jmp __if_10707_end
__if_10707_else:
__if_10729_start:
  mov R0, [BP-7]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __if_10729_else
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
  jmp __if_10729_end
__if_10729_else:
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
__if_10729_end:
__if_10707_end:
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
__if_10820_start:
  mov R0, [BP+4]
  jf R0, __if_10820_end
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
__if_10845_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-29]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_10845_end
  jmp __function_b2RayCastSegment_return
__if_10845_end:
__if_10820_end:
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
__if_10890_start:
  mov R0, [BP-11]
  feq R0, 0.000000
  jf R0, __if_10890_end
  jmp __function_b2RayCastSegment_return
__if_10890_end:
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
__if_10925_start:
  mov R0, [BP-19]
  feq R0, 0.000000
  jf R0, __if_10925_end
  jmp __function_b2RayCastSegment_return
__if_10925_end:
  mov R0, [BP-18]
  mov R1, [BP-19]
  fdiv R0, R1
  mov [BP-20], R0
__if_10935_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10941
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-20]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10941:
  jf R0, __if_10935_end
  jmp __function_b2RayCastSegment_return
__if_10935_end:
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
__if_10971_start:
  mov R0, [BP-25]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10976
  mov R1, [BP-11]
  mov R2, [BP-25]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10976:
  jf R0, __if_10971_end
  jmp __function_b2RayCastSegment_return
__if_10971_end:
__if_10980_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_10980_end
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Neg
__if_10980_end:
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
__if_11029_start:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  fne R0, 0.000000
  jf R0, __if_11029_end
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
__if_11029_end:
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
__for_11112_start:
  mov R0, [BP-10]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_11112_end
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
__if_11167_start:
  mov R0, [BP-20]
  feq R0, 0.000000
  jf R0, __if_11167_else
__if_11172_start:
  mov R0, [BP-19]
  flt R0, 0.000000
  jf R0, __if_11172_end
  jmp __function_b2RayCastPolygon_return
__if_11172_end:
  jmp __if_11167_end
__if_11167_else:
__if_11178_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11183
  mov R1, [BP-19]
  mov R2, [BP-7]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11183:
  jf R0, __if_11178_else
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-10]
  mov [BP-9], R0
  jmp __if_11178_end
__if_11178_else:
__if_11197_start:
  mov R0, [BP-20]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11202
  mov R1, [BP-19]
  mov R2, [BP-8]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11202:
  jf R0, __if_11197_end
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-8], R0
__if_11197_end:
__if_11178_end:
__if_11167_end:
__if_11213_start:
  mov R0, [BP-8]
  mov R1, [BP-7]
  flt R0, R1
  jf R0, __if_11213_end
  jmp __function_b2RayCastPolygon_return
__if_11213_end:
__for_11112_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_11112_start
__for_11112_end:
__if_11218_start:
  mov R0, [BP-9]
  ige R0, 0
  jf R0, __if_11218_else
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
  jmp __if_11218_end
__if_11218_else:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_11218_end:
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
__if_11506_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11506_end
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
__if_11506_end:
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
__if_11608_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11608_end
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
__if_11608_end:
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
__if_11711_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11711_end
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
__if_11711_end:
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
__if_11810_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11810_end
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
__if_11810_end:
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
__if_11855_start:
  mov R0, [BP+5]
  ieq R0, 0
  jf R0, __if_11855_end
  jmp __function_b2RecurseHull_return
__if_11855_end:
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
__if_11900_start:
  mov R0, [BP-25]
  fgt R0, 0.000000
  jf R0, __if_11900_end
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
__if_11900_end:
  mov R0, 1
  mov [BP-62], R0
__for_11914_start:
  mov R0, [BP-62]
  mov R1, [BP+5]
  ilt R0, R1
  jf R0, __for_11914_end
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
__if_11939_start:
  mov R0, [BP-63]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_11939_end
  mov R0, [BP-62]
  mov [BP-22], R0
  mov R0, [BP-63]
  mov [BP-25], R0
__if_11939_end:
__if_11950_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_11950_end
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
__if_11950_end:
__for_11914_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11914_start
__for_11914_end:
__if_11964_start:
  mov R1, [BP-25]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 2.000000
  flt R1, R2
  mov R0, R1
  jf R0, __if_11964_end
  jmp __function_b2RecurseHull_return
__if_11964_end:
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
__for_11999_start:
  mov R0, [BP-62]
  mov R1, [BP-28]
  ilt R0, R1
  jf R0, __for_11999_end
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
__for_11999_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11999_start
__for_11999_end:
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
__for_12033_start:
  mov R0, [BP-62]
  mov R1, [BP-45]
  ilt R0, R1
  jf R0, __for_12033_end
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
__for_12033_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_12033_start
__for_12033_end:
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
__if_12948_start:
  mov R1, [BP-12]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_12948_end
  jmp __function_b2CollideCircles_return
__if_12948_end:
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
__if_13081_start:
  mov R0, [BP-11]
  flt R0, 0.000000
  jf R0, __if_13081_else
  lea R13, [BP-16]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_13081_end
__if_13081_else:
__if_13089_start:
  mov R0, [BP-14]
  flt R0, 0.000000
  jf R0, __if_13089_else
  lea R13, [BP-16]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_13089_end
__if_13089_else:
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
__if_13089_end:
__if_13081_end:
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
__if_13150_start:
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_13150_end
  jmp __function_b2CollideCapsuleAndCircle_return
__if_13150_end:
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
__for_13270_start:
  mov R0, [BP-10]
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __for_13270_end
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
__if_13302_start:
  mov R0, [BP-29]
  mov R1, [BP-8]
  fgt R0, R1
  jf R0, __if_13302_end
  mov R0, [BP-29]
  mov [BP-8], R0
  mov R0, [BP-10]
  mov [BP-7], R0
__if_13302_end:
__for_13270_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_13270_start
__for_13270_end:
__if_13313_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13313_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13313_end:
  mov R0, [BP-7]
  mov [BP-11], R0
__if_13325_start:
  mov R0, [BP-11]
  iadd R0, 1
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __if_13325_else
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-12], R0
  jmp __if_13325_end
__if_13325_else:
  mov R0, 0
  mov [BP-12], R0
__if_13325_end:
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
__if_13401_start:
  mov R0, [BP-21]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13406
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13406:
  jf R0, __if_13401_else
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
__if_13436_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13436_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13436_end:
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
  jmp __if_13401_end
__if_13401_else:
__if_13508_start:
  mov R0, [BP-26]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13513
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13513:
  jf R0, __if_13508_else
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
__if_13543_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13543_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13543_end:
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
  jmp __if_13508_end
__if_13508_else:
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
__if_13508_end:
__if_13401_end:
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
__if_13841_start:
  mov R0, [BP-27]
  fne R0, 0.000000
  jf R0, __if_13841_end
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
__if_13841_end:
  mov R0, [BP-26]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-25]
  fadd R0, R1
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-29], R0
__if_13870_start:
  mov R0, [BP-29]
  flt R0, 0.000000
  jf R0, __if_13870_else
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
  jmp __if_13870_end
__if_13870_else:
__if_13887_start:
  mov R0, [BP-29]
  fgt R0, 1.000000
  jf R0, __if_13887_end
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
__if_13887_end:
__if_13870_end:
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
__if_13957_start:
  mov R0, [BP-34]
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fgt R0, R1
  jf R0, __if_13957_end
  jmp __function_b2CollideCapsules_return
__if_13957_end:
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
  jf R0, __LogicalAnd_ShortCircuit_14026
  mov R1, [BP-49]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14026:
  jt R0, __LogicalOr_ShortCircuit_14029
  mov R1, [BP-48]
  mov R2, [BP-40]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_14035
  mov R2, [BP-49]
  mov R3, [BP-40]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_14035:
  or R0, R1
__LogicalOr_ShortCircuit_14029:
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
  jf R0, __LogicalAnd_ShortCircuit_14073
  mov R1, [BP-52]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14073:
  jt R0, __LogicalOr_ShortCircuit_14076
  mov R1, [BP-51]
  mov R2, [BP-41]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_14082
  mov R2, [BP-52]
  mov R3, [BP-41]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_14082:
  or R0, R1
__LogicalOr_ShortCircuit_14076:
  mov [BP-53], R0
__if_14085_start:
  mov R0, [BP-50]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_14090
  mov R1, [BP-53]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_14090:
  jf R0, __if_14085_end
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
__if_14144_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14144_else
  mov R0, [BP-62]
  mov [BP-56], R0
  jmp __if_14144_end
__if_14144_else:
  mov R0, [BP-63]
  mov [BP-56], R0
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Neg
__if_14144_end:
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
__if_14211_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14211_else
  mov R0, [BP-62]
  mov [BP-59], R0
  jmp __if_14211_end
__if_14211_else:
  mov R0, [BP-63]
  mov [BP-59], R0
  lea R1, [BP-58]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Neg
__if_14211_end:
__if_14228_start:
  mov R1, [BP-56]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 0.100000
  fadd R1, R2
  mov R2, [BP-59]
  fge R1, R2
  mov R0, R1
  jf R0, __if_14228_else
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
__if_14250_start:
  mov R0, [BP-48]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14255
  mov R1, [BP-49]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14255:
  jf R0, __if_14250_else
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
  jmp __if_14250_end
__if_14250_else:
__if_14274_start:
  mov R0, [BP-49]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14279
  mov R1, [BP-48]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14279:
  jf R0, __if_14274_end
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
__if_14274_end:
__if_14250_end:
__if_14298_start:
  mov R0, [BP-48]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14303
  mov R1, [BP-49]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14303:
  jf R0, __if_14298_else
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
  jmp __if_14298_end
__if_14298_else:
__if_14322_start:
  mov R0, [BP-49]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14327
  mov R1, [BP-48]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14327:
  jf R0, __if_14322_end
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
__if_14322_end:
__if_14298_end:
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
__if_14374_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14384
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14384:
  mov R0, R1
  jf R0, __if_14374_end
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
__if_14374_end:
  jmp __if_14228_end
__if_14228_else:
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
__if_14506_start:
  mov R0, [BP-51]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14511
  mov R1, [BP-52]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14511:
  jf R0, __if_14506_else
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
  jmp __if_14506_end
__if_14506_else:
__if_14530_start:
  mov R0, [BP-52]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14535
  mov R1, [BP-51]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14535:
  jf R0, __if_14530_end
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
__if_14530_end:
__if_14506_end:
__if_14554_start:
  mov R0, [BP-51]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14559
  mov R1, [BP-52]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14559:
  jf R0, __if_14554_else
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
  jmp __if_14554_end
__if_14554_else:
__if_14578_start:
  mov R0, [BP-52]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14583
  mov R1, [BP-51]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14583:
  jf R0, __if_14578_end
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
__if_14578_end:
__if_14554_end:
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
__if_14630_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14640
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14640:
  mov R0, R1
  jf R0, __if_14630_end
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
__if_14630_end:
__if_14228_end:
__if_14085_end:
__if_14749_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_14749_end
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
__if_14764_start:
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-21]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_14764_else
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Normalize
  jmp __if_14764_end
__if_14764_else:
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
__if_14764_end:
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
__if_14805_start:
  mov R0, [BP-28]
  feq R0, 0.000000
  jf R0, __if_14805_else
  mov R0, 0
  mov [BP-60], R0
  jmp __if_14805_end
__if_14805_else:
  mov R0, 1
  mov [BP-60], R0
__if_14805_end:
__if_14817_start:
  mov R0, [BP-29]
  feq R0, 0.000000
  jf R0, __if_14817_else
  mov R0, 0
  mov [BP-61], R0
  jmp __if_14817_end
__if_14817_else:
  mov R0, 1
  mov [BP-61], R0
__if_14817_end:
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
__if_14749_end:
__if_14876_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_14876_end
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
__if_14876_end:
__if_14898_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_14898_end
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
__if_14898_end:
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
__if_15034_start:
  mov R0, [BP-13]
  flt R0, 0.000000
  jf R0, __if_15034_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15034_end:
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
__if_15064_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __if_15064_else
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
__if_15086_start:
  mov R0, [BP-35]
  fle R0, 0.000000
  jf R0, __if_15086_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15086_end:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_15064_end
__if_15064_else:
__if_15094_start:
  mov R0, [BP-16]
  fle R0, 0.000000
  jf R0, __if_15094_else
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
__if_15125_start:
  mov R0, [BP-37]
  fgt R0, 0.000000
  jf R0, __if_15125_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15125_end:
  lea R13, [BP-19]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_15094_end
__if_15094_else:
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
__if_15167_start:
  mov R0, [BP-33]
  fgt R0, 0.000000
  jf R0, __if_15167_else
  mov R1, 1.000000
  mov R2, [BP-33]
  fdiv R1, R2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_15167_end
__if_15167_else:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
__if_15167_end:
__if_15094_end:
__if_15064_end:
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
__if_15211_start:
  mov R1, [BP-26]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_15211_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15211_end:
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
__for_15372_start:
  mov R0, [BP-5]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_15372_end
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
__for_15402_start:
  mov R0, [BP-11]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_15402_end
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
__if_15439_start:
  mov R0, [BP-14]
  mov R1, [BP-10]
  flt R0, R1
  jf R0, __if_15439_end
  mov R0, [BP-14]
  mov [BP-10], R0
__if_15439_end:
__for_15402_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_15402_start
__for_15402_end:
__if_15446_start:
  mov R0, [BP-10]
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_15446_end
  mov R0, [BP-10]
  mov [BP-4], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_15446_end:
__for_15372_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_15372_start
__for_15372_end:
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
__if_15484_start:
  mov R0, [BP+6]
  jf R0, __if_15484_else
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+2]
  mov [BP-4], R0
  mov R0, [BP+5]
  mov [BP-2], R0
__if_15496_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15496_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15496_end
__if_15496_else:
  mov R0, 0
  mov [BP-3], R0
__if_15496_end:
  mov R0, [BP+4]
  mov [BP-5], R0
__if_15514_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15514_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15514_end
__if_15514_else:
  mov R0, 0
  mov [BP-6], R0
__if_15514_end:
  jmp __if_15484_end
__if_15484_else:
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-4], R0
  mov R0, [BP+4]
  mov [BP-2], R0
__if_15539_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15539_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15539_end
__if_15539_else:
  mov R0, 0
  mov [BP-3], R0
__if_15539_end:
  mov R0, [BP+5]
  mov [BP-5], R0
__if_15557_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15557_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15557_end
__if_15557_else:
  mov R0, 0
  mov [BP-6], R0
__if_15557_end:
__if_15484_end:
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
__if_15681_start:
  mov R0, [BP-21]
  mov R1, [BP-19]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_15686
  mov R1, [BP-20]
  mov R2, [BP-22]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_15686:
  jf R0, __if_15681_end
  jmp __function_b2ClipPolygons_return
__if_15681_end:
__if_15692_start:
  mov R0, [BP-22]
  mov R1, [BP-19]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15697
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15697:
  jf R0, __if_15692_else
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
  jmp __if_15692_end
__if_15692_else:
  lea R13, [BP-24]
  lea R12, [BP-16]
  mov CR, 2
  movs
__if_15692_end:
__if_15752_start:
  mov R0, [BP-21]
  mov R1, [BP-20]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15757
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15757:
  jf R0, __if_15752_else
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
  jmp __if_15752_end
__if_15752_else:
  lea R13, [BP-26]
  lea R12, [BP-14]
  mov CR, 2
  movs
__if_15752_end:
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
__if_15929_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_15929_else
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
  jmp __if_15929_end
__if_15929_else:
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
__if_15929_end:
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
__for_16180_start:
  mov R0, [BP-46]
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16180_end
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
__for_16180_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16180_start
__for_16180_end:
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
__for_16229_start:
  mov R0, [BP-46]
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16229_end
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
__for_16229_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16229_start
__for_16229_end:
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
__if_16294_start:
  mov R0, [BP-85]
  mov R1, [BP-4]
  mov R2, [BP-88]
  fadd R1, R2
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16301
  mov R1, [BP-87]
  mov R2, [BP-4]
  mov R3, [BP-88]
  fadd R2, R3
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16301:
  jf R0, __if_16294_end
  jmp __function_b2CollidePolygons_return
__if_16294_end:
__if_16309_start:
  mov R0, [BP-85]
  mov R1, [BP-87]
  fge R0, R1
  jf R0, __if_16309_else
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
__for_16336_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16336_end
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
__if_16356_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16356_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-86], R0
__if_16356_end:
__for_16336_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16336_start
__for_16336_end:
  jmp __if_16309_end
__if_16309_else:
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
__for_16390_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16390_end
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
__if_16410_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16410_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-84], R0
__if_16410_end:
__for_16390_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16390_start
__for_16390_end:
__if_16309_end:
__if_16421_start:
  mov R0, [BP-85]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16428
  mov R1, [BP-87]
  mov R2, [BP-3]
  fmul R2, 0.100000
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16428:
  jf R0, __if_16421_else
  mov R0, [BP-84]
  mov [BP-90], R0
__if_16439_start:
  mov R0, [BP-84]
  iadd R0, 1
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16439_else
  mov R0, [BP-84]
  iadd R0, 1
  mov [BP-91], R0
  jmp __if_16439_end
__if_16439_else:
  mov R0, 0
  mov [BP-91], R0
__if_16439_end:
  mov R0, [BP-86]
  mov [BP-92], R0
__if_16459_start:
  mov R0, [BP-86]
  iadd R0, 1
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16459_else
  mov R0, [BP-86]
  iadd R0, 1
  mov [BP-93], R0
  jmp __if_16459_end
__if_16459_else:
  mov R0, 0
  mov [BP-93], R0
__if_16459_end:
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
__if_16521_start:
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_16521_end
  jmp __function_b2CollidePolygons_return
__if_16521_end:
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
__if_16541_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16541_end
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
__if_16541_end:
__if_16555_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16555_end
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
__if_16555_end:
__if_16569_start:
  mov R0, [BP-110]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fadd R0, R1
  mov R1, [BP-111]
  flt R0, R1
  jf R0, __if_16569_end
  mov R0, 1.000000
  mov R1, [BP-109]
  fdiv R0, R1
  mov [BP-112], R0
__if_16583_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16590
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16590:
  jf R0, __if_16583_else
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
  jmp __if_16583_end
__if_16583_else:
__if_16690_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16697
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16697:
  jf R0, __if_16690_else
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
  jmp __if_16690_end
__if_16690_else:
__if_16797_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16804
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16804:
  jf R0, __if_16797_else
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
  jmp __if_16797_end
__if_16797_else:
__if_16904_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16911
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16911:
  jf R0, __if_16904_end
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
__if_16904_end:
__if_16797_end:
__if_16690_end:
__if_16583_end:
__if_16569_end:
  jmp __if_16421_end
__if_16421_else:
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
__if_16421_end:
__if_17019_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_17019_end
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
__if_17019_end:
__if_17041_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_17041_end
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
__if_17041_end:
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
__if_17127_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fle R1, 0.000000
  mov R0, R1
  jf R0, __if_17127_else
__if_17136_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jf R0, __if_17136_end
__if_17140_start:
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
  jf R0, __if_17140_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17140_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17136_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
  jmp __if_17127_end
__if_17127_else:
__if_17155_start:
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  jf R0, __if_17155_end
__if_17159_start:
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
  jf R0, __if_17159_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17159_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17155_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
__if_17127_end:
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
__if_17239_start:
  mov R0, [BP-9]
  mov R1, [BP-3]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_17244
  mov R1, [BP-6]
  mov R2, [BP-12]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_17244:
  jf R0, __if_17239_end
  jmp __function_b2ClipSegments_return
__if_17239_end:
__if_17250_start:
  mov R0, [BP-12]
  mov R1, [BP-3]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17255
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17255:
  jf R0, __if_17250_else
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
  jmp __if_17250_end
__if_17250_else:
  lea R13, [BP-14]
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17250_end:
__if_17287_start:
  mov R0, [BP-9]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17292
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17292:
  jf R0, __if_17287_else
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
  jmp __if_17287_end
__if_17287_else:
  lea R13, [BP-16]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17287_end:
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
__if_17606_start:
  mov R0, [BP-51]
  jf R0, __if_17606_end
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-72], R1
  mov R0, R1
__if_17606_end:
__if_17619_start:
  mov R0, [BP-50]
  jf R0, __if_17619_end
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
__if_17619_end:
__if_17642_start:
  mov R0, [BP-71]
  jf R0, __LogicalAnd_ShortCircuit_17644
  mov R1, [BP-72]
  and R0, R1
__LogicalAnd_ShortCircuit_17644:
  jf R0, __LogicalAnd_ShortCircuit_17647
  mov R1, [BP-73]
  and R0, R1
__LogicalAnd_ShortCircuit_17647:
  jf R0, __if_17642_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17642_end:
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
__if_17699_start:
  mov R1, [BP-117]
  mov R2, [BP-40]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 4.000000
  fadd R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_17699_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17699_end:
  lea R12, [BP-68]
  lea DR, [BP-125]
  mov CR, 2
  movs
__if_17716_start:
  mov R0, [BP-51]
  jf R0, __if_17716_end
  lea R13, [BP-125]
  lea R12, [BP-55]
  mov CR, 2
  movs
__if_17716_end:
  lea R12, [BP-68]
  lea DR, [BP-127]
  mov CR, 2
  movs
__if_17726_start:
  mov R0, [BP-50]
  jf R0, __if_17726_end
  lea R13, [BP-127]
  lea R12, [BP-53]
  mov CR, 2
  movs
__if_17726_end:
  mov R0, -1
  mov [BP-128], R0
  mov R0, -1
  mov [BP-129], R0
__if_17741_start:
  mov R1, [BP-71]
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_17747
  mov R2, [BP-117]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 0.100000
  fgt R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_17747:
  mov R0, R1
  jf R0, __if_17741_else
__if_17756_start:
  mov R1, [BP+5]
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_17756_else
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
__if_17793_start:
  mov R0, [BP-144]
  ieq R0, 0
  jf R0, __if_17793_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17793_end:
__if_17798_start:
  mov R0, [BP-144]
  ieq R0, 1
  jf R0, __if_17798_end
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
__if_17798_end:
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-128], R0
  jmp __if_17756_end
__if_17756_else:
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
__if_17887_start:
  mov R0, [BP-136]
  mov R1, [BP-137]
  ieq R0, R1
  jf R0, __if_17887_else
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
__if_17932_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  fgt R0, R1
  jf R0, __if_17932_end
  mov R0, [BP-138]
  mov [BP-148], R0
__if_17932_end:
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
__if_17959_start:
  mov R0, [BP-151]
  ieq R0, 0
  jf R0, __if_17959_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17959_end:
__if_17964_start:
  mov R0, [BP-151]
  ieq R0, 1
  jf R0, __if_17964_end
  mov R0, [BP-148]
  mov [BP-138], R0
__if_17972_start:
  mov R0, [BP-148]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17972_else
  mov R0, [BP-148]
  iadd R0, 1
  mov [BP-139], R0
  jmp __if_17972_end
__if_17972_else:
  mov R0, 0
  mov [BP-139], R0
__if_17972_end:
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
__if_18030_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  flt R0, R1
  jf R0, __if_18030_else
__if_18035_start:
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
  jf R0, __if_18035_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18035_end:
  jmp __if_18030_end
__if_18030_else:
__if_18049_start:
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
  jf R0, __if_18049_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18049_end:
__if_18030_end:
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
__if_18106_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18106_end
  lea R1, [BP-141]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18106_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17964_end:
  mov R0, [BP-148]
  mov [BP-129], R0
  jmp __if_17887_end
__if_17887_else:
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
__if_18166_start:
  mov R0, [BP-148]
  mov R1, [BP-149]
  flt R0, R1
  jf R0, __if_18166_else
  mov R0, [BP-138]
  mov [BP-128], R0
  jmp __if_18166_end
__if_18166_else:
  mov R0, [BP-139]
  mov [BP-128], R0
__if_18166_end:
__if_17887_end:
__if_17756_end:
  jmp __if_17741_end
__if_17741_else:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-136], R0
  mov R0, 0
  mov [BP-137], R0
__for_18185_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18185_end
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
__if_18217_start:
  mov R0, [BP-144]
  mov R1, [BP-136]
  flt R0, R1
  jf R0, __if_18217_end
  mov R0, [BP-144]
  mov [BP-136], R0
  mov R0, [BP-137]
  mov [BP-128], R0
__if_18217_end:
__for_18185_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18185_start
__for_18185_end:
__if_18228_start:
  mov R0, [BP-51]
  jf R0, __if_18228_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18238_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18238_end
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
__if_18271_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18271_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18271_end:
__for_18238_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18238_start
__for_18238_end:
__if_18278_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18278_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18278_end:
__if_18228_end:
__if_18290_start:
  mov R0, [BP-50]
  jf R0, __if_18290_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18300_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18300_end
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
__if_18333_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18333_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18333_end:
__for_18300_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18300_start
__for_18300_end:
__if_18340_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18340_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18340_end:
__if_18290_end:
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-138], R0
  mov R0, -1
  mov [BP-139], R0
  mov R0, 0
  mov [BP-137], R0
__for_18363_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18363_end
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
__if_18386_start:
  lea R2, [BP-57]
  mov [SP], R2
  lea R2, [BP-143]
  mov [SP+1], R2
  call __function_b2ClassifyNormal
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __if_18386_end
  jmp __for_18363_continue
__if_18386_end:
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
__if_18432_start:
  mov R0, [BP-150]
  mov R1, [BP-138]
  fgt R0, R1
  jf R0, __if_18432_end
  mov R0, [BP-150]
  mov [BP-138], R0
  mov R0, [BP-137]
  mov [BP-139], R0
__if_18432_end:
__for_18363_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18363_start
__for_18363_end:
__if_18443_start:
  mov R0, [BP-138]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18443_end
  mov R0, [BP-139]
  mov [BP-140], R0
__if_18453_start:
  mov R0, [BP-140]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18453_else
  mov R0, [BP-140]
  iadd R0, 1
  mov [BP-141], R0
  jmp __if_18453_end
__if_18453_else:
  mov R0, 0
  mov [BP-141], R0
__if_18453_end:
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
__if_18517_start:
  mov R0, [BP-152]
  mov R1, [BP-153]
  flt R0, R1
  jf R0, __if_18517_else
__if_18522_start:
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
  jf R0, __if_18522_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18522_end:
  jmp __if_18517_end
__if_18517_else:
__if_18536_start:
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
  jf R0, __if_18536_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18536_end:
__if_18517_end:
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
__if_18593_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18593_end
  lea R1, [BP-147]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18593_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18443_end:
__if_18605_start:
  mov R0, [BP-128]
  ieq R0, -1
  jf R0, __if_18605_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18605_end:
__if_17741_end:
__if_18615_start:
  mov R0, [BP-129]
  ine R0, -1
  jf R0, __if_18615_else
  mov R0, [BP-129]
  mov [BP-130], R0
__if_18624_start:
  mov R0, [BP-130]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18624_else
  mov R0, [BP-130]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18624_end
__if_18624_else:
  mov R0, 0
  mov [BP-131], R0
__if_18624_end:
  jmp __if_18615_end
__if_18615_else:
  mov R0, [BP-128]
  mov [BP-136], R0
__if_18644_start:
  mov R0, [BP-136]
  igt R0, 0
  jf R0, __if_18644_else
  mov R0, [BP-136]
  isub R0, 1
  mov [BP-137], R0
  jmp __if_18644_end
__if_18644_else:
  mov R0, [BP-41]
  isub R0, 1
  mov [BP-137], R0
__if_18644_end:
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
__if_18684_start:
  mov R0, [BP-142]
  mov R1, [BP-143]
  flt R0, R1
  jf R0, __if_18684_else
  mov R0, [BP-137]
  mov [BP-130], R0
  mov R0, [BP-136]
  mov [BP-131], R0
  jmp __if_18684_end
__if_18684_else:
  mov R0, [BP-136]
  mov [BP-130], R0
__if_18699_start:
  mov R0, [BP-136]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18699_else
  mov R0, [BP-136]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18699_end
__if_18699_else:
  mov R0, 0
  mov [BP-131], R0
__if_18699_end:
__if_18684_end:
__if_18615_end:
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
__if_18828_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_18828_end
  mov R0, 32
  jmp __function_b2CLZ32_return
__if_18828_end:
  mov R0, 0
  mov [BP-1], R0
  mov R0, 31
  mov [BP-2], R0
__for_18839_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_18839_end
__if_18849_start:
  mov R0, [BP+2]
  mov R1, [BP-2]
  isgn R1
  shl R0, R1
  and R0, 1
  ine R0, 0
  jf R0, __if_18849_end
  mov R0, [BP-1]
  jmp __function_b2CLZ32_return
__if_18849_end:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__for_18839_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_18839_start
__for_18839_end:
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
__if_18897_start:
  mov R0, [BP+2]
  ile R0, 1
  jf R0, __if_18897_end
  mov R0, 1
  jmp __function_b2RoundUpPowerOf2_return
__if_18897_end:
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
__if_18946_start:
  mov R0, [BP-1]
  mov R1, [BP+4]
  ige R0, R1
  jf R0, __if_18946_end
  mov R0, [BP+2]
  jmp __function_b2GrowArray_return
__if_18946_end:
  mov R0, 8
  mov [BP-2], R0
__if_18955_start:
  mov R0, [BP-1]
  ine R0, 0
  jf R0, __if_18955_end
  mov R0, [BP-1]
  imul R0, 2
  mov [BP-2], R0
__if_18955_end:
__if_18964_start:
  mov R0, [BP-2]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __if_18964_end
  mov R0, [BP+4]
  mov [BP-2], R0
__if_18964_end:
__if_18973_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_18973_else
  mov R2, [BP-2]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  jmp __if_18973_end
__if_18973_else:
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
__if_18973_end:
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
__for_19186_start:
  mov R0, [BP-2]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19186_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R2, [BP+3]
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19186_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_19186_start
__for_19186_end:
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
__if_19262_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19262_end
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
__for_19326_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19326_end
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19326_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_19326_start
__for_19326_end:
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
__if_19262_end:
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
__while_19477_start:
__while_19477_continue:
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __while_19477_end
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
__if_19504_start:
  mov R0, [BP-22]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19504_end
  mov R0, [BP-19]
  mov [BP-17], R0
  mov R0, [BP-22]
  mov [BP-18], R0
__if_19504_end:
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
__if_19567_start:
  mov R0, [BP-23]
  jf R0, __if_19567_else
  mov R0, [BP-34]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_19575_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19575_end
  mov R0, [BP-20]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_19575_end:
  jmp __if_19567_end
__if_19567_else:
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
__if_19567_end:
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
__if_19631_start:
  mov R0, [BP-24]
  jf R0, __if_19631_else
  mov R0, [BP-45]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_19639_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19639_end
  mov R0, [BP-21]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_19639_end:
  jmp __if_19631_end
__if_19631_else:
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
__if_19631_end:
__if_19667_start:
  mov R0, [BP-23]
  jf R0, __LogicalAnd_ShortCircuit_19669
  mov R1, [BP-24]
  and R0, R1
__LogicalAnd_ShortCircuit_19669:
  jf R0, __if_19667_end
  jmp __while_19477_end
__if_19667_end:
__if_19672_start:
  mov R0, [BP-18]
  mov R1, [BP-25]
  fle R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19677
  mov R1, [BP-18]
  mov R2, [BP-36]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_19677:
  jf R0, __if_19672_end
  jmp __while_19477_end
__if_19672_end:
__if_19681_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  feq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19686
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_19686:
  jf R0, __if_19681_end
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
__if_19681_end:
__if_19732_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_19737
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_19737:
  jf R0, __if_19732_else
  mov R0, [BP-20]
  mov [BP-19], R0
  mov R0, [BP-35]
  mov [BP-10], R0
  mov R0, [BP-34]
  mov [BP-15], R0
  jmp __if_19732_end
__if_19732_else:
  mov R0, [BP-21]
  mov [BP-19], R0
  mov R0, [BP-46]
  mov [BP-10], R0
  mov R0, [BP-45]
  mov [BP-15], R0
__if_19732_end:
  jmp __while_19477_start
__while_19477_end:
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
__if_19766_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19766_end
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
__if_19766_end:
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
__if_19893_start:
  mov R0, [BP-6]
  ine R0, -1
  jf R0, __if_19893_else
__if_19900_start:
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  ieq R0, R1
  jf R0, __if_19900_else
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_19900_end
__if_19900_else:
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_19900_end:
  jmp __if_19893_end
__if_19893_else:
  mov R0, [BP-7]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_19893_end:
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-9], R0
__while_19933_start:
__while_19933_continue:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __while_19933_end
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
  jmp __while_19933_start
__while_19933_end:
__function_b2InsertLeaf_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveLeaf:
  push BP
  mov BP, SP
  isub SP, 11
__if_20032_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_20032_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2RemoveLeaf_return
__if_20032_end:
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
__if_20063_start:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_20063_else
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  jmp __if_20063_end
__if_20063_else:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__if_20063_end:
__if_20085_start:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __if_20085_else
__if_20092_start:
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_20092_else
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_20092_end
__if_20092_else:
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_20092_end:
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
__while_20126_start:
__while_20126_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_20126_end
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
  jmp __while_20126_start
__while_20126_end:
  jmp __if_20085_end
__if_20085_else:
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
__if_20085_end:
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
__if_20345_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20345_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20345_end:
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
__while_20368_start:
__while_20368_continue:
  mov R0, [BP-257]
  igt R0, 0
  jf R0, __while_20368_end
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
__if_20396_start:
  mov R1, [BP-259]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2AABB_Overlaps
  jf R0, __if_20396_end
__if_20403_start:
  mov R1, [BP-259]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20403_else
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
__if_20422_start:
  mov R0, [BP-260]
  ieq R0, 0
  jf R0, __if_20422_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20422_end:
  jmp __if_20403_end
__if_20403_else:
__if_20428_start:
  mov R0, [BP-257]
  ilt R0, 255
  jf R0, __if_20428_end
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
__if_20428_end:
__if_20403_end:
__if_20396_end:
  jmp __while_20368_start
__while_20368_end:
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
__if_20474_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20474_end
  jmp __function_b2DynamicTree_RayCast_return
__if_20474_end:
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
__while_20587_start:
__while_20587_continue:
  mov R0, [BP-274]
  igt R0, 0
  jf R0, __while_20587_end
  mov R0, [BP-274]
  isub R0, 1
  mov [BP-274], R0
  lea R0, [BP-273]
  mov R1, [BP-274]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-281], R0
__if_20602_start:
  mov R0, [BP-281]
  ieq R0, -1
  jf R0, __if_20602_end
  jmp __while_20587_continue
__if_20602_end:
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
__if_20625_start:
  mov R1, [BP-282]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_20625_end
  jmp __while_20587_continue
__if_20625_end:
__if_20634_start:
  lea R2, [BP-286]
  mov [SP], R2
  lea R2, [BP-17]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_20634_end
  jmp __while_20587_continue
__if_20634_end:
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
__if_20681_start:
  mov R0, [BP-294]
  mov R1, [BP-293]
  flt R0, R1
  jf R0, __if_20681_end
  jmp __while_20587_continue
__if_20681_end:
__if_20686_start:
  mov R1, [BP-282]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20686_else
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
__if_20711_start:
  mov R0, [BP-295]
  feq R0, 0.000000
  jf R0, __if_20711_end
  jmp __function_b2DynamicTree_RayCast_return
__if_20711_end:
__if_20716_start:
  mov R0, [BP-295]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_20721
  mov R1, [BP-295]
  mov R2, [BP-11]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_20721:
  jf R0, __if_20716_end
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
__if_20716_end:
  jmp __if_20686_end
__if_20686_else:
__if_20773_start:
  mov R0, [BP-274]
  ilt R0, 255
  jf R0, __if_20773_end
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
__if_20810_start:
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
  jf R0, __if_20810_else
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
  jmp __if_20810_end
__if_20810_else:
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
__if_20810_end:
__if_20773_end:
__if_20686_end:
  jmp __while_20587_start
__while_20587_end:
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
__if_20887_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20887_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_20887_end:
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
__while_21026_start:
__while_21026_continue:
  mov R0, [BP-278]
  igt R0, 0
  jf R0, __while_21026_end
  mov R0, [BP-278]
  isub R0, 1
  mov [BP-278], R0
  lea R0, [BP-277]
  mov R1, [BP-278]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-287], R0
__if_21041_start:
  mov R0, [BP-287]
  ieq R0, -1
  jf R0, __if_21041_end
  jmp __while_21026_continue
__if_21041_end:
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
__if_21064_start:
  mov R1, [BP-288]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_21064_end
  jmp __while_21026_continue
__if_21064_end:
__if_21073_start:
  lea R2, [BP-292]
  mov [SP], R2
  lea R2, [BP-21]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_21073_end
  jmp __while_21026_continue
__if_21073_end:
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
__if_21129_start:
  mov R0, [BP-302]
  mov R1, [BP-301]
  flt R0, R1
  jf R0, __if_21129_end
  jmp __while_21026_continue
__if_21129_end:
__if_21134_start:
  mov R1, [BP-288]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_21134_else
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
__if_21159_start:
  mov R0, [BP-303]
  feq R0, 0.000000
  jf R0, __if_21159_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21159_end:
__if_21164_start:
  mov R0, [BP-303]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21169
  mov R1, [BP-303]
  mov R2, [BP-15]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21169:
  jf R0, __if_21164_end
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
__if_21164_end:
  jmp __if_21134_end
__if_21134_else:
__if_21240_start:
  mov R0, [BP-278]
  ilt R0, 255
  jf R0, __if_21240_end
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
__if_21277_start:
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
  jf R0, __if_21277_else
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
  jmp __if_21277_end
__if_21277_else:
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
__if_21277_end:
__if_21240_end:
__if_21134_end:
  jmp __while_21026_start
__while_21026_end:
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
__if_21397_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_21397_end
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
__if_21397_end:
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
__if_21432_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_21432_end
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
__if_21452_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __if_21452_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__if_21452_end:
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
__if_21432_end:
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
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 7
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 8
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 9
  mov [R1], R0
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 10
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 11
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
__if_21935_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_21943
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21943:
  jf R0, __if_21935_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jmp __function_b2ShouldShapesCollide_return
__if_21935_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_21966
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21966:
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
  jf R0, __LogicalAnd_ShortCircuit_22003
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22003:
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
__if_22017_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22017_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleAABB
  jmp __if_22017_end
__if_22017_else:
__if_22028_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22028_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleAABB
  jmp __if_22028_end
__if_22028_else:
__if_22039_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22039_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputePolygonAABB
  jmp __if_22039_end
__if_22039_else:
__if_22050_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22050_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22050_end
__if_22050_else:
__if_22061_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22061_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22061_end
__if_22061_else:
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
__if_22061_end:
__if_22050_end:
__if_22039_end:
__if_22028_end:
__if_22017_end:
__function_b2ComputeShapeAABB_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShapeTestPoint:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 3
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
__if_22105_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22105_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCircle
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22105_end
__if_22105_else:
__if_22117_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22117_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCapsule
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22117_end
__if_22117_else:
__if_22129_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22129_end
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInPolygon
  jmp __function_b2ShapeTestPoint_return
__if_22129_end:
__if_22117_end:
__if_22105_end:
  mov R0, 0
__function_b2ShapeTestPoint_return:
  iadd SP, 3
  pop R1
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
__if_22168_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22168_end
  jmp __function_b2ShapeCastShape_return
__if_22168_end:
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
__for_22191_start:
  mov R0, [BP-25]
  mov R2, [BP-23]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22191_end
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
__for_22191_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_22191_start
__for_22191_end:
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__if_22227_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22227_else
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCircle
  jmp __if_22227_end
__if_22227_else:
__if_22239_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22239_else
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCapsule
  jmp __if_22239_end
__if_22239_else:
__if_22251_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22251_else
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastPolygon
  jmp __if_22251_end
__if_22251_else:
__if_22263_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22263_else
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
  jmp __if_22263_end
__if_22263_else:
__if_22275_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22275_end
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
__if_22275_end:
__if_22263_end:
__if_22251_end:
__if_22239_end:
__if_22227_end:
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
__if_22334_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22334_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCircle
  jmp __if_22334_end
__if_22334_else:
__if_22346_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22346_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCapsule
  jmp __if_22346_end
__if_22346_else:
__if_22358_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22358_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndPolygon
  jmp __if_22358_end
__if_22358_else:
__if_22370_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22370_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22370_end
__if_22370_else:
__if_22382_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22382_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22382_end
__if_22382_else:
  jmp __function_b2CollideMover_return
__if_22382_end:
__if_22370_end:
__if_22358_end:
__if_22346_end:
__if_22334_end:
__if_22396_start:
  mov R1, [BP+5]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22396_end
  jmp __function_b2CollideMover_return
__if_22396_end:
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
__if_22420_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22420_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 4
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22420_end
__if_22420_else:
__if_22435_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22435_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 30
  iadd R2, 2
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22435_end
__if_22435_else:
__if_22450_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22450_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 34
  mov R1, [R2]
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22450_end
__if_22450_else:
__if_22466_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22466_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22466_end
__if_22466_else:
__if_22479_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22479_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, 2
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2MakeProxy
  jmp __if_22479_end
__if_22479_else:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 16
  mov [R1], R0
__if_22479_end:
__if_22466_end:
__if_22450_end:
__if_22435_end:
__if_22420_end:
__function_b2MakeShapeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShapeCentroid:
  push BP
  mov BP, SP
  isub SP, 4
__if_22500_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22500_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 30
  mov CR, 2
  movs
  jmp __if_22500_end
__if_22500_else:
__if_22511_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22511_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 2
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_22511_end
__if_22511_else:
__if_22527_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22527_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 38
  iadd R12, 32
  mov CR, 2
  movs
  jmp __if_22527_end
__if_22527_else:
__if_22538_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22538_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 74
  iadd R1, 2
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_22538_end
__if_22538_else:
__if_22554_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22554_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  iadd R1, 2
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, [BP+3]
  mov [SP+3], R1
  call __function_b2Lerp
  jmp __if_22554_end
__if_22554_else:
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_22554_end:
__if_22538_end:
__if_22527_end:
__if_22511_end:
__if_22500_end:
__function_b2GetShapeCentroid_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShapeProjectedPerimeter:
  push BP
  mov BP, SP
  isub SP, 9
  push R1
  push R2
  isub SP, 3
__if_22579_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22579_end
  mov R1, [BP+2]
  iadd R1, 30
  iadd R1, 2
  mov R0, [R1]
  fmul R0, 2.000000
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_22579_end:
__if_22590_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22590_end
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Sub
  lea R2, [BP-2]
  mov [SP], R2
  mov R2, [BP+3]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov [BP-9], R1
  mov R1, [BP-9]
  mov [SP], R1
  call __function_b2AbsFloat
  mov [BP-3], R0
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 4
  mov R1, [R2]
  fmul R1, 2.000000
  fadd R0, R1
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_22590_end:
__if_22624_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22624_end
  mov R12, [BP+2]
  iadd R12, 38
  lea DR, [BP-2]
  mov CR, 2
  movs
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-3], R0
  mov R0, [BP-3]
  mov [BP-4], R0
  mov R0, 1
  mov [BP-5], R0
__for_22648_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22648_end
  mov R12, [BP+2]
  iadd R12, 38
  mov R1, [BP-5]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-7]
  mov CR, 2
  movs
  lea R1, [BP-7]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
  mov R2, [BP-3]
  mov [SP], R2
  mov R2, [BP-8]
  mov [SP+1], R2
  call __function_b2MinFloat
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  mov R2, [BP-4]
  mov [SP], R2
  mov R2, [BP-8]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
__for_22648_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_22648_start
__for_22648_end:
  mov R0, [BP-4]
  mov R1, [BP-3]
  fsub R0, R1
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 34
  mov R1, [R2]
  fmul R1, 2.000000
  fadd R0, R1
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_22624_end:
__if_22694_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22694_end
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 74
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-2], R0
  mov R1, [BP-2]
  mov R2, [BP-1]
  fsub R1, R2
  mov [SP], R1
  call __function_b2AbsFloat
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_22694_end:
  mov R0, 0.000000
__function_b2GetShapeProjectedPerimeter_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ComputeShapeMass:
  push BP
  mov BP, SP
  isub SP, 3
__if_22726_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22726_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputeCircleMass
  jmp __if_22726_end
__if_22726_else:
__if_22738_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22738_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleMass
  jmp __if_22738_end
__if_22738_else:
__if_22750_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22750_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2ComputePolygonMass
  jmp __if_22750_end
__if_22750_else:
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
__if_22750_end:
__if_22738_end:
__if_22726_end:
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
__if_22793_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22793_else
  mov R1, [BP+2]
  iadd R1, 33
  iadd R1, 4
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2Sub
  mov R1, [BP+2]
  iadd R1, 33
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
  jmp __if_22793_end
__if_22793_else:
__if_22841_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22841_else
  mov R1, [BP+2]
  iadd R1, 30
  iadd R1, 2
  mov R0, [R1]
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 30
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
  jmp __if_22841_end
__if_22841_else:
__if_22874_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22874_end
  mov R0, [BP+2]
  iadd R0, 38
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
__for_22900_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_22900_end
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
__for_22900_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_22900_start
__for_22900_end:
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
__if_22874_end:
__if_22841_end:
__if_22793_end:
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
__if_23049_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_23049_end
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
__if_23049_end:
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
__if_23083_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_23083_end
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
__if_23083_end:
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
__if_23201_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23201_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  call __function_b2GrowBitSet
__if_23201_end:
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
__if_23236_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23236_end
  jmp __function_b2ClearBit_return
__if_23236_end:
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
__if_23269_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23269_end
  mov R0, 0
  jmp __function_b2GetBit_return
__if_23269_end:
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
  jt R0, __LogicalOr_ShortCircuit_23421
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+3]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ine R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_23421:
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
__while_23441_start:
__while_23441_continue:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_23445
  mov R4, [BP+2]
  mov R3, [R4]
  mov R4, [BP-2]
  imul R4, 2
  iadd R3, R4
  mov R2, [R3]
  mov R3, [BP+3]
  ieq R2, R3
  jf R2, __LogicalAnd_ShortCircuit_23460
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
__LogicalAnd_ShortCircuit_23460:
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_23445:
  mov R0, R1
  jf R0, __while_23441_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
  jmp __while_23441_start
__while_23441_end:
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
__if_23480_start:
  mov R0, [BP+2]
  igt R0, 16
  jf R0, __if_23480_else
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2RoundUpPowerOf2
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_23480_end
__if_23480_else:
  mov R0, 16
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_23480_end:
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
__for_23629_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_23629_end
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
__if_23651_start:
  mov R0, [BP-4]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23656
  mov R1, [BP-5]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23656:
  jf R0, __if_23651_end
  jmp __for_23629_continue
__if_23651_end:
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
__for_23629_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_23629_start
__for_23629_end:
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
__if_23680_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __if_23680_else
  mov R0, [BP+2]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_23680_end
__if_23680_else:
  mov R0, [BP+3]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
__if_23680_end:
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
  jf R0, __LogicalAnd_ShortCircuit_23742
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
__LogicalAnd_ShortCircuit_23742:
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
__if_23772_start:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2SlotOccupied
  jf R0, __if_23772_end
  mov R0, 1
  jmp __function_b2AddKey_return
__if_23772_end:
__if_23778_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23778_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2GrowTable
__if_23778_end:
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
__if_23822_start:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_23822_end
  mov R0, 0
  jmp __function_b2RemoveKey_return
__if_23822_end:
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
__while_23858_start:
__while_23858_continue:
  mov R0, 1
  jf R0, __while_23858_end
  mov R0, [BP-6]
  iadd R0, 1
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-6], R0
__if_23872_start:
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23885
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23885:
  jf R0, __if_23872_end
  jmp __while_23858_end
__if_23872_end:
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
__if_23910_start:
  mov R0, [BP-4]
  mov R1, [BP-6]
  ile R0, R1
  jf R0, __if_23910_else
__if_23915_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_23920
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_23920:
  jf R0, __if_23915_end
  jmp __while_23858_continue
__if_23915_end:
  jmp __if_23910_end
__if_23910_else:
__if_23925_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jt R0, __LogicalOr_ShortCircuit_23930
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_23930:
  jf R0, __if_23925_end
  jmp __while_23858_continue
__if_23925_end:
__if_23910_end:
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
  jmp __while_23858_start
__while_23858_end:
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
__for_23993_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_23993_end
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
__for_23993_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23993_start
__for_23993_end:
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
__for_24045_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_24045_end
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
__for_24045_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24045_start
__for_24045_end:
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
__if_24079_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_24079_end
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
__if_24079_end:
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
__if_24112_start:
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
  jf R0, __if_24112_end
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
__if_24112_end:
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
__if_24175_start:
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
  jf R0, __if_24175_end
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
__for_24197_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_24197_end
__if_24207_start:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_24207_end
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
  jmp __for_24197_end
__if_24207_end:
__for_24197_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_24197_start
__for_24197_end:
__if_24175_end:
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
__for_24237_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_24237_end
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
__for_24237_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24237_start
__for_24237_end:
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
__if_24301_start:
  mov R0, [BP+3]
  ine R0, 0
  jf R0, __if_24301_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2BufferMove
__if_24301_end:
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
__if_24454_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_24454_end
  mov R0, [BP+2]
  jmp __function_b2ContactEdgeAt_return
__if_24454_end:
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
  jt R0, __LogicalOr_ShortCircuit_24480
  mov R1, [BP+2]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24480:
  mov [BP-1], R0
  mov R0, [BP+3]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_24490
  mov R1, [BP+3]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24490:
  mov [BP-2], R0
__if_24493_start:
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_24495
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_24495:
  jf R0, __if_24493_end
  mov R0, 0
  jmp __function_b2CanCollide_return
__if_24493_end:
  mov R0, 1
__function_b2CanCollide_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCollisionRank:
  push BP
  mov BP, SP
__if_24503_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_24503_end
  mov R0, 0
  jmp __function_b2ShapeCollisionRank_return
__if_24503_end:
__if_24509_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_24509_end
  mov R0, 1
  jmp __function_b2ShapeCollisionRank_return
__if_24509_end:
__if_24515_start:
  mov R0, [BP+2]
  ieq R0, 3
  jf R0, __if_24515_end
  mov R0, 2
  jmp __function_b2ShapeCollisionRank_return
__if_24515_end:
__if_24521_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_24521_end
  mov R0, 3
  jmp __function_b2ShapeCollisionRank_return
__if_24521_end:
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
__if_24555_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_24555_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCircles
  jmp __if_24555_end
__if_24555_else:
__if_24569_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_24569_else
__if_24574_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24574_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsuleAndCircle
  jmp __if_24574_end
__if_24574_else:
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideCapsules
__if_24574_end:
  jmp __if_24569_end
__if_24569_else:
__if_24596_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_24596_else
__if_24601_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24601_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndCircle
  jmp __if_24601_end
__if_24601_else:
__if_24614_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24614_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndCapsule
  jmp __if_24614_end
__if_24614_else:
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideSegmentAndPolygon
__if_24614_end:
__if_24601_end:
  jmp __if_24596_end
__if_24596_else:
__if_24636_start:
  mov R0, [BP-1]
  ieq R0, 4
  jf R0, __if_24636_else
__if_24641_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24641_else
  mov R1, [BP+2]
  iadd R1, 78
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollideChainSegmentAndCircle
  jmp __if_24641_end
__if_24641_else:
__if_24654_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24654_else
  mov R0, 0
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 78
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-9]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2CollideChainSegmentAndCapsule
  jmp __if_24654_end
__if_24654_else:
  mov R0, 0
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 78
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  lea R1, [BP-9]
  mov [SP+3], R1
  mov R1, [BP+5]
  mov [SP+4], R1
  call __function_b2CollideChainSegmentAndPolygon
__if_24654_end:
__if_24641_end:
  jmp __if_24636_end
__if_24636_else:
__if_24695_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24695_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygonAndCircle
  jmp __if_24695_end
__if_24695_else:
__if_24708_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24708_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygonAndCapsule
  jmp __if_24708_end
__if_24708_else:
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  call __function_b2CollidePolygons
__if_24708_end:
__if_24695_end:
__if_24636_end:
__if_24596_end:
__if_24569_end:
__if_24555_end:
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
__if_24817_start:
  mov R0, [BP+3]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_24822
  mov R1, [BP+4]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24822:
  jf R0, __if_24817_else
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
  jmp __if_24817_end
__if_24817_else:
__if_24838_start:
  mov R0, [BP+3]
  ige R0, 2
  jf R0, __LogicalAnd_ShortCircuit_24843
  mov R1, [BP+7]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24843:
  jf R0, __if_24838_end
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
__if_24838_end:
__if_24817_end:
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
__if_24973_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_24973_end
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
__if_24973_end:
__if_24995_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_24995_end
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
__if_24995_end:
__if_25017_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_25017_end
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
__if_25017_end:
__if_25036_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_25036_end
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
__if_25036_end:
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
__if_25088_start:
  mov R0, [BP-25]
  jf R0, __if_25088_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 65536
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25088_end
__if_25088_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25088_end:
__if_25105_start:
  mov R0, [BP-25]
  jf R0, __LogicalAnd_ShortCircuit_25107
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  jt R1, __LogicalOr_ShortCircuit_25111
  mov R3, [BP+6]
  iadd R3, 22
  mov R2, [R3]
  or R1, R2
__LogicalOr_ShortCircuit_25111:
  and R0, R1
__LogicalAnd_ShortCircuit_25107:
  jf R0, __if_25105_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 1048576
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25105_end
__if_25105_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -1048577
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25105_end:
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
__if_25143_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __if_25143_end
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
__if_25143_end:
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
__if_25556_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_25556_end
  mov R0, [BP+2]
  iadd R0, 4
  jmp __function_b2JointEdgeAt_return
__if_25556_end:
  mov R0, [BP+2]
  iadd R0, 4
  iadd R0, 3
__function_b2JointEdgeAt_return:
  mov SP, BP
  pop BP
  ret

__function_b2ShouldReportContactEvents:
  push BP
  mov BP, SP
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 23
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_25934
  mov R2, [BP+3]
  iadd R2, 23
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_25934:
__function_b2ShouldReportContactEvents_return:
  pop R2
  pop R1
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

__function_b2World_GetBeginTouchEventCount:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  iadd R1, 67
  iadd R1, 1
  mov R0, [R1]
__function_b2World_GetBeginTouchEventCount_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2World_GetBeginTouchEvents:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
__function_b2World_GetBeginTouchEvents_return:
  pop R1
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
  iadd R1, 56
  mov [R1], R0
  mov R0, -10.000000
  mov R1, [BP+2]
  iadd R1, 56
  iadd R1, 1
  mov [R1], R0
  mov R0, 30.000000
  mov R1, [BP+2]
  iadd R1, 58
  mov [R1], R0
  mov R0, 10.000000
  mov R1, [BP+2]
  iadd R1, 59
  mov [R1], R0
  mov R0, 3.000000
  mov R1, [BP+2]
  iadd R1, 60
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 61
  mov [R1], R0
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 62
  mov [R1], R0
  mov R0, 400.000000
  mov R1, [BP+2]
  iadd R1, 63
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 64
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 65
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 66
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
  iadd R1, 79
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 79
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 82
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 83
  mov [R1], R0
  mov R0, 0
  mov [BP-1], R0
__for_26344_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_26344_end
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
__for_26344_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26344_start
__for_26344_end:
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
  mov R0, 1
  mov R1, [BP+2]
  iadd R1, 53
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 54
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+2]
  iadd R1, 55
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
__for_26522_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26522_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
__if_26542_start:
  mov R1, [BP-2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26542_end
  mov R2, [BP-2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_26542_end:
__if_26557_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26557_end
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
__if_26557_end:
__if_26572_start:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26572_end
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
__if_26572_end:
__if_26587_start:
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26587_end
  mov R2, [BP-2]
  iadd R2, 9
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 9
  iadd R2, 2
  mov R1, [R2]
  imul R1, 63
  mov [SP+1], R1
  call __function_b2Free
__if_26587_end:
__if_26602_start:
  mov R1, [BP-2]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26602_end
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
__if_26602_end:
__for_26522_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26522_start
__for_26522_end:
__if_26617_start:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26617_end
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
__if_26617_end:
__if_26632_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26632_end
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
__if_26632_end:
__if_26647_start:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26647_end
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 2
  mov R1, [R2]
  imul R1, 87
  mov [SP+1], R1
  call __function_b2Free
__if_26647_end:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2DestroyBroadPhase
__if_26666_start:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26666_end
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
__if_26666_end:
__if_26681_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26681_end
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
__if_26681_end:
  mov R0, 0
  mov [BP-1], R0
__for_26696_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26696_end
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_26716_start:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26716_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26716_end:
__if_26726_start:
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26726_end
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
__if_26726_end:
__if_26738_start:
  mov R1, [BP-2]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26738_end
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
__if_26738_end:
__for_26696_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26696_start
__for_26696_end:
__if_26750_start:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26750_end
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
__if_26750_end:
__if_26765_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26765_end
  mov R2, [BP+2]
  iadd R2, 65
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26765_end:
__if_26775_start:
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26775_end
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
__if_26775_end:
__if_26790_start:
  mov R1, [BP+2]
  iadd R1, 70
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26790_end
  mov R2, [BP+2]
  iadd R2, 70
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 70
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26790_end:
__if_26805_start:
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26805_end
  mov R2, [BP+2]
  iadd R2, 73
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 73
  iadd R2, 2
  mov R1, [R2]
  imul R1, 7
  mov [SP+1], R1
  call __function_b2Free
__if_26805_end:
__if_26820_start:
  mov R1, [BP+2]
  iadd R1, 76
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26820_end
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
__if_26820_end:
__if_26835_start:
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26835_end
  mov R2, [BP+2]
  iadd R2, 79
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 79
  iadd R2, 2
  mov R1, [R2]
  imul R1, 2
  mov [SP+1], R1
  call __function_b2Free
__if_26835_end:
__if_26850_start:
  mov R1, [BP+2]
  iadd R1, 82
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26850_end
  mov R2, [BP+2]
  iadd R2, 82
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 83
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
__if_26850_end:
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
__if_26895_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_26895_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
  mov R0, 1
  jmp __function_b2WakeBody_return
__if_26895_end:
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
__if_26918_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_26918_end
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
__if_26918_end:
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
__if_27073_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_27073_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_27073_end:
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
__if_27112_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27112_end
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
__if_27112_end:
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
__if_27153_start:
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27153_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27153_end:
__if_27163_start:
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27163_end
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
__if_27163_end:
__if_27175_start:
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27175_end
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
__if_27175_end:
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
__if_27254_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_27254_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27254_end:
__if_27260_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_27260_end
  mov R0, [BP+4]
  jmp __function_b2MergeIslands_return
__if_27260_end:
__if_27268_start:
  mov R0, [BP+4]
  ieq R0, -1
  jf R0, __if_27268_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27268_end:
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
__if_27296_start:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_27296_else
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
  jmp __if_27296_end
__if_27296_else:
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__if_27296_end:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_27322_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27322_end
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
__for_27322_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27322_start
__for_27322_end:
  mov R0, 0
  mov [BP-6], R0
__for_27384_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27384_end
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
__for_27384_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27384_start
__for_27384_end:
  mov R0, 0
  mov [BP-6], R0
__for_27447_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27447_end
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
__for_27447_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27447_start
__for_27447_end:
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
__if_27666_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27666_end
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
__if_27666_end:
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
__if_27842_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27842_end
  jmp __function_b2UnlinkJoint_return
__if_27842_end:
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
__if_27872_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27872_end
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
__if_27872_end:
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
__if_27971_start:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27971_end
  jmp __function_b2RemoveBodyFromIsland_return
__if_27971_end:
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
__if_28001_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28001_end
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
__if_28001_end:
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
__if_28045_start:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28045_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2DestroyIsland
__if_28045_end:
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
__while_28056_start:
__while_28056_continue:
  mov R0, [BP+2]
  mov R1, [BP+3]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ine R0, R1
  jf R0, __while_28056_end
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
  jmp __while_28056_start
__while_28056_end:
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
__if_28095_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_28095_end
  jmp __function_b2IslandUnion_return
__if_28095_end:
__if_28100_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_28100_else
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28100_end
__if_28100_else:
__if_28113_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  igt R0, R1
  jf R0, __if_28113_else
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28113_end
__if_28113_else:
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
__if_28113_end:
__if_28100_end:
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
__if_28188_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_28188_end
  jmp __function_b2SplitIsland_return
__if_28188_end:
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
__for_28203_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28203_end
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
__for_28203_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28203_start
__for_28203_end:
  mov R0, 0
  mov [BP-13], R0
__for_28223_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28223_end
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
__if_28255_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28262
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28262:
  jf R0, __if_28255_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28255_end:
__for_28223_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28223_start
__for_28223_end:
  mov R0, 0
  mov [BP-13], R0
__for_28272_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28272_end
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
__if_28304_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28311
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28311:
  jf R0, __if_28304_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28304_end:
__for_28272_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28272_start
__for_28272_end:
  mov R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
__for_28327_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28327_end
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
__if_28344_start:
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-13]
  ieq R0, R1
  jf R0, __if_28344_end
  mov R0, [BP-14]
  iadd R0, 1
  mov [BP-14], R0
__if_28344_end:
__for_28327_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28327_start
__for_28327_end:
__if_28355_start:
  mov R0, [BP-14]
  ieq R0, 1
  jf R0, __if_28355_end
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
__if_28355_end:
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
__for_28411_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28411_end
  mov R0, -1
  mov R1, [BP-15]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_28411_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28411_start
__for_28411_end:
  mov R0, 0
  mov [BP-13], R0
__for_28427_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28427_end
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
__if_28442_start:
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov R0, [R0]
  ieq R0, -1
  jf R0, __if_28442_end
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
__if_28442_end:
__for_28427_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28427_start
__for_28427_end:
  mov R0, 0
  mov [BP-13], R0
__for_28462_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28462_end
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
__for_28462_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28462_start
__for_28462_end:
  mov R0, 0
  mov [BP-13], R0
__for_28537_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28537_end
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
__if_28561_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28561_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28561_end:
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
__for_28537_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28537_start
__for_28537_end:
  mov R0, 0
  mov [BP-13], R0
__for_28630_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28630_end
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
__if_28654_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28654_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28654_end:
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
__for_28630_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28630_start
__for_28630_end:
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
__for_28762_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_28762_end
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
__if_28790_start:
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_28796
  mov R1, [BP-4]
  mov R2, [BP-2]
  igt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_28796:
  jf R0, __if_28790_end
  mov R0, [BP-4]
  mov [BP-2], R0
__if_28790_end:
__for_28762_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_28762_start
__for_28762_end:
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

__function_b2MakeBodyId:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 64
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
__function_b2MakeBodyId_return:
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
__if_28968_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_28968_end
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
__if_28968_end:
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
  jt R0, __LogicalOr_ShortCircuit_29041
  mov R2, [BP+3]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_29041:
  jf R0, __LogicalAnd_ShortCircuit_29046
  mov R2, [BP+3]
  iadd R2, 19
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_29046:
  mov [BP-1], R0
__if_29051_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29051_else
  mov R0, 1
  mov [BP-2], R0
  jmp __if_29051_end
__if_29051_else:
__if_29060_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29060_else
  mov R0, 0
  mov [BP-2], R0
  jmp __if_29060_end
__if_29060_else:
__if_29069_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_29069_else
  mov R0, 2
  mov [BP-2], R0
  jmp __if_29069_end
__if_29069_else:
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
__if_29084_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29084_end
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
__if_29084_end:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov [R1], R0
__if_29069_end:
__if_29060_end:
__if_29051_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__if_29226_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  jf R0, __if_29226_end
  mov R0, [BP-4]
  or R0, 1
  mov [BP-4], R0
__if_29226_end:
__if_29234_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  jf R0, __if_29234_end
  mov R0, [BP-4]
  or R0, 2
  mov [BP-4], R0
__if_29234_end:
__if_29242_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  jf R0, __if_29242_end
  mov R0, [BP-4]
  or R0, 4
  mov [BP-4], R0
__if_29242_end:
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
__if_29361_start:
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  jf R0, __if_29361_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 16
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29361_end:
__if_29371_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_29371_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 128
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29371_end:
__if_29381_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29381_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 512
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29381_end:
__if_29393_start:
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  jf R0, __if_29393_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 2048
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29393_end:
__if_29403_start:
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  jf R0, __if_29403_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 4096
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29403_end:
__if_29413_start:
  mov R0, [BP-2]
  ieq R0, 2
  jf R0, __if_29413_end
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
__if_29413_end:
__if_29478_start:
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29478_end
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
__if_29478_end:
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
__if_29638_start:
  mov R0, [BP-2]
  ige R0, 2
  jf R0, __if_29638_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2CreateIslandForBody
__if_29638_end:
  mov R0, [BP-3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 64
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

__function_b2DestroyBody:
  push BP
  mov BP, SP
  isub SP, 12
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  mov [BP-2], R0
__while_29728_start:
__while_29728_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29728_end
  mov R0, [BP-2]
  shl R0, -1
  mov [BP-6], R0
  mov R0, [BP-2]
  and R0, 1
  mov [BP-7], R0
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R1, [BP-6]
  imul R1, 17
  iadd R0, R1
  mov [BP-8], R0
  mov R3, [BP-8]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2JointEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-2], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyJointInternal
  jmp __while_29728_start
__while_29728_end:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_29767_start:
__while_29767_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_29767_end
  mov R0, [BP-3]
  shl R0, -1
  mov [BP-6], R0
  mov R0, [BP-3]
  and R0, 1
  mov [BP-7], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-6]
  imul R1, 16
  iadd R0, R1
  mov [BP-8], R0
  mov R3, [BP-8]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-3], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __while_29767_start
__while_29767_end:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__while_29806_start:
__while_29806_continue:
  mov R0, [BP-4]
  ine R0, -1
  jf R0, __while_29806_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-4], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  mov R1, 0
  mov [SP+3], R1
  call __function_b2DestroyShapeInternal
  jmp __while_29806_start
__while_29806_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2RemoveBodyFromIsland
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-5], R0
  mov R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 4
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+2], R1
  call __function_b2RemoveBodySim
__if_29851_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29851_else
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-6], R0
__if_29864_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  ine R0, R1
  jf R0, __if_29864_end
  mov R1, [BP-5]
  iadd R1, 3
  mov R13, [R1]
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 8
  iadd R13, R1
  mov R1, [BP-5]
  iadd R1, 3
  mov R12, [R1]
  mov R1, [BP-6]
  imul R1, 8
  iadd R12, R1
  mov CR, 8
  movs
__if_29864_end:
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_29851_end
__if_29851_else:
__if_29890_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __LogicalAnd_ShortCircuit_29898
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_29898:
  jf R0, __if_29890_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2DestroySolverSet
__if_29890_end:
__if_29851_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 17
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2FreeId
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
  iadd R1, 17
  mov [R1], R0
__function_b2DestroyBody_return:
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
__if_29971_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_29971_end
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
__if_29988_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_29988_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29998_start:
__while_29998_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29998_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
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
  jmp __while_29998_start
__while_29998_end:
__if_29988_end:
  jmp __function_b2UpdateBodyMassData_return
__if_29971_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30049_start:
__while_30049_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30049_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
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
  jmp __while_30049_start
__while_30049_end:
__if_30097_start:
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30097_end
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
__if_30097_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30126_start:
__while_30126_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30126_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-12]
  mov [SP+1], R1
  call __function_b2ComputeShapeMass
__if_30147_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_30147_end
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
__if_30147_end:
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_30126_start
__while_30126_end:
__if_30187_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30187_else
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 13
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  jmp __if_30187_end
__if_30187_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_30187_end:
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
__if_30231_start:
  mov R0, [BP-7]
  ine R0, -1
  jf R0, __if_30231_end
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
__if_30231_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30273_start:
__while_30273_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30273_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
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
  jmp __while_30273_start
__while_30273_end:
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
__if_30328_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30328_end
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
  mov R2, 87
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
  imul R2, 87
  iadd R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 87
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
__if_30328_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_30379_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_30379_else
  mov R13, [BP-2]
  iadd R13, 30
  mov R12, [BP+5]
  mov CR, 3
  movs
  jmp __if_30379_end
__if_30379_else:
__if_30389_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_30389_else
  mov R13, [BP-2]
  iadd R13, 33
  mov R12, [BP+5]
  mov CR, 5
  movs
  jmp __if_30389_end
__if_30389_else:
__if_30399_start:
  mov R0, [BP+6]
  ieq R0, 3
  jf R0, __if_30399_else
  mov R13, [BP-2]
  iadd R13, 38
  mov R12, [BP+5]
  mov CR, 36
  movs
  jmp __if_30399_end
__if_30399_else:
__if_30409_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_30409_else
  mov R13, [BP-2]
  iadd R13, 74
  mov R12, [BP+5]
  mov CR, 4
  movs
  jmp __if_30409_end
__if_30409_else:
__if_30419_start:
  mov R0, [BP+6]
  ieq R0, 4
  jf R0, __if_30419_end
  mov R13, [BP-2]
  iadd R13, 78
  mov R12, [BP+5]
  mov CR, 9
  movs
__if_30419_end:
__if_30409_end:
__if_30399_end:
__if_30389_end:
__if_30379_end:
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
  mov R1, [BP+4]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 25
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 26
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 27
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-2]
  iadd R1, 28
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 29
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
__if_30512_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_30512_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_30512_end
__if_30512_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_30512_end:
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
__if_30554_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __if_30554_end
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
__if_30554_end:
__if_30685_start:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30685_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 5
  mov R1, [R2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_30685_end:
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

__function_b2CreateCircleShape:
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
  mov R1, 0
  mov [SP+4], R1
  call __function_b2CreateShapeInternal
  mov [BP-2], R0
__if_30749_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30749_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30749_end:
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
__function_b2CreateCircleShape_return:
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
__if_30791_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30791_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30791_end:
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

__function_b2CreateSegmentShape:
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
  mov R1, 2
  mov [SP+4], R1
  call __function_b2CreateShapeInternal
  mov [BP-2], R0
__if_30875_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30875_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30875_end:
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
__function_b2CreateSegmentShape_return:
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
  imul R1, 87
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
__if_31220_start:
  mov R0, [BP+4]
  jf R0, __if_31220_end
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_31227_start:
__while_31227_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31227_end
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
__if_31258_start:
  mov R1, [BP-6]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_31265
  mov R2, [BP-6]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_31265:
  jf R0, __if_31258_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_31258_end:
  jmp __while_31227_start
__while_31227_end:
__if_31220_end:
__if_31272_start:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31272_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 2
  mov R2, [R3]
  imul R2, 87
  iadd R1, R2
  iadd R1, 3
  mov [R1], R0
__if_31272_end:
__if_31289_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31289_end
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 18
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 3
  mov R2, [R3]
  imul R2, 87
  iadd R1, R2
  iadd R1, 2
  mov [R1], R0
__if_31289_end:
__if_31306_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_31306_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
__if_31306_end:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__if_31323_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31323_end
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
__if_31323_end:
__if_31343_start:
  mov R1, [BP+3]
  iadd R1, 26
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31343_end
  mov R2, [BP+3]
  iadd R2, 26
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 28
  mov R1, [R2]
  imul R1, 1
  mov [SP+1], R1
  call __function_b2Free
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 26
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 27
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 28
  mov [R1], R0
__if_31343_end:
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  mov [R1], R0
__if_31379_start:
  mov R0, [BP+5]
  jf R0, __if_31379_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31379_end:
__function_b2DestroyShapeInternal_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_SetTransform:
  push BP
  mov BP, SP
  isub SP, 13
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
  call __function_b2WakeBody
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-2], R0
  mov R13, [BP-2]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 2
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-2]
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP-2]
  iadd R1, 4
  mov [SP+2], R1
  call __function_b2TransformWorldPoint
  mov R13, [BP-2]
  iadd R13, 6
  mov R12, [BP-2]
  iadd R12, 2
  mov CR, 2
  movs
  mov R13, [BP-2]
  iadd R13, 8
  mov R12, [BP-2]
  iadd R12, 4
  mov CR, 2
  movs
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-3], R0
__while_31453_start:
__while_31453_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31453_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_31468_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31468_end
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-9]
  fsub R0, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-9]
  fsub R0, R1
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-9]
  fadd R0, R1
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-9]
  fadd R0, R1
  mov R1, [BP-4]
  iadd R1, 9
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-10], R0
  mov R0, [BP-8]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-4]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-7]
  mov R1, [BP-10]
  fsub R0, R1
  mov R1, [BP-4]
  iadd R1, 13
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-6]
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-4]
  iadd R1, 13
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-5]
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-4]
  iadd R1, 13
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-4]
  iadd R1, 13
  mov [SP+2], R1
  call __function_b2BroadPhase_MoveProxy
__if_31468_end:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  jmp __while_31453_start
__while_31453_end:
__function_b2Body_SetTransform_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_Wake:
  push BP
  mov BP, SP
  isub SP, 3
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
  call __function_b2WakeBody
__function_b2Body_Wake_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_IsAwake:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
__function_b2Body_IsAwake_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetLocalPoint:
  push BP
  mov BP, SP
  isub SP, 5
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
  call __function_b2GetBodySim
  mov [BP-2], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
__function_b2Body_GetLocalPoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetPosition:
  push BP
  mov BP, SP
  isub SP, 4
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
  call __function_b2GetBodySim
  mov [BP-2], R0
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, [BP-2]
  mov CR, 2
  movs
__function_b2Body_GetPosition_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetRotation:
  push BP
  mov BP, SP
  isub SP, 4
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
  call __function_b2GetBodySim
  mov [BP-2], R0
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, [BP-2]
  iadd R12, 2
  mov CR, 2
  movs
__function_b2Body_GetRotation_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetLinearVelocity:
  push BP
  mov BP, SP
  isub SP, 4
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
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31823_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31823_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Body_GetLinearVelocity_return
__if_31823_end:
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, [BP-2]
  mov CR, 2
  movs
__function_b2Body_GetLinearVelocity_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetAngularVelocity:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 2
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
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31855_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31855_end
  mov R0, 0.000000
  jmp __function_b2Body_GetAngularVelocity_return
__if_31855_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
__function_b2Body_GetAngularVelocity_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2Body_SetLinearVelocity:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
__if_31873_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_31873_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_31873_end:
__if_31879_start:
  mov R2, [BP+4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  fgt R1, 0.000000
  mov R0, R1
  jf R0, __if_31879_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31879_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31892_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31892_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_31892_end:
  mov R13, [BP-2]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__function_b2Body_SetLinearVelocity_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_SetAngularVelocity:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
__if_31911_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_31911_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_31911_end:
__if_31917_start:
  mov R0, [BP+4]
  fne R0, 0.000000
  jf R0, __if_31917_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31917_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31929_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31929_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_31929_end:
  mov R0, [BP+4]
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
__function_b2Body_SetAngularVelocity_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_ApplyForceToCenter:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
__if_32002_start:
  mov R0, [BP+5]
  jf R0, __if_32002_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32002_end:
__if_32007_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32007_end
  jmp __function_b2Body_ApplyForceToCenter_return
__if_32007_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 12
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP-2]
  iadd R1, 12
  mov [SP+2], R1
  call __function_b2Add
__function_b2Body_ApplyForceToCenter_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_ApplyTorque:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
__if_32036_start:
  mov R0, [BP+5]
  jf R0, __if_32036_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32036_end:
__if_32041_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32041_end
  jmp __function_b2Body_ApplyTorque_return
__if_32041_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 14
  mov R0, [R1]
  mov R1, [BP+4]
  fadd R0, R1
  mov R1, [BP-2]
  iadd R1, 14
  mov [R1], R0
__function_b2Body_ApplyTorque_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_ApplyLinearImpulseToCenter:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
__if_32133_start:
  mov R0, [BP+5]
  jf R0, __if_32133_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32133_end:
__if_32138_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32138_end
  jmp __function_b2Body_ApplyLinearImpulseToCenter_return
__if_32138_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-3], R0
  mov R1, [BP-3]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 15
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_b2MulAdd
__function_b2Body_ApplyLinearImpulseToCenter_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_GetMass:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
__function_b2Body_GetMass_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MakeShapeId:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 64
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
__function_b2MakeShapeId_return:
  mov SP, BP
  pop BP
  ret

__function_b2Shape_GetBody:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetShape
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MakeBodyId
__function_b2Shape_GetBody_return:
  mov SP, BP
  pop BP
  ret

__function_b2Shape_TestPoint:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetShape
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  mov R1, [BP-1]
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ShapeTestPoint
__function_b2Shape_TestPoint_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2UpdateShapeAABBs:
  push BP
  mov BP, SP
  isub SP, 9
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2ComputeShapeAABB
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R0, R1
  mov [BP-5], R0
  mov R0, [BP-4]
  mov R1, [BP-5]
  fsub R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-5]
  fsub R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-5]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-5]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 9
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 17
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP-4]
  mov R1, [BP-6]
  fsub R0, R1
  mov R1, [BP+2]
  iadd R1, 13
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-6]
  fsub R0, R1
  mov R1, [BP+2]
  iadd R1, 13
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP-6]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 13
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-6]
  fadd R0, R1
  mov R1, [BP+2]
  iadd R1, 13
  iadd R1, 2
  iadd R1, 1
  mov [R1], R0
__function_b2UpdateShapeAABBs_return:
  mov SP, BP
  pop BP
  ret

__function_b2ResetProxy:
  push BP
  mov BP, SP
  isub SP, 15
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_32981_start:
__while_32981_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_32981_end
  mov R0, [BP-3]
  shl R0, -1
  mov [BP-8], R0
  mov R0, [BP-3]
  and R0, 1
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-8]
  imul R1, 16
  iadd R0, R1
  mov [BP-10], R0
  mov R3, [BP-10]
  mov [SP], R3
  mov R3, [BP-9]
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-3], R1
  mov R0, R1
__if_33012_start:
  mov R1, [BP-10]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_33019
  mov R2, [BP-10]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-2]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_33019:
  jf R0, __if_33012_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_33012_end:
  jmp __while_32981_start
__while_32981_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
__if_33033_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33033_else
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  and R0, 3
  mov [BP-8], R0
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
__if_33053_start:
  mov R0, [BP+5]
  jf R0, __if_33053_else
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2BroadPhase_DestroyProxy
  mov R2, [BP+2]
  iadd R2, 21
  mov [SP], R2
  mov R2, [BP-8]
  mov [SP+1], R2
  mov R2, [BP+3]
  iadd R2, 13
  mov [SP+2], R2
  mov R3, [BP+3]
  iadd R3, 19
  mov R2, [R3]
  mov [SP+3], R2
  mov R2, [BP-2]
  mov [SP+4], R2
  call __function_b2BroadPhase_CreateProxy
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 8
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2BufferMove
  jmp __if_33053_end
__if_33053_else:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  iadd R1, 13
  mov [SP+2], R1
  call __function_b2BroadPhase_MoveProxy
__if_33053_end:
  jmp __if_33033_end
__if_33033_else:
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
__if_33033_end:
__function_b2ResetProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2Shape_SetDensity:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetShape
  mov [BP-1], R0
__if_33108_start:
  mov R0, [BP+4]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  feq R0, R1
  jf R0, __if_33108_end
  jmp __function_b2Shape_SetDensity_return
__if_33108_end:
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_33118_start:
  mov R0, [BP+5]
  jf R0, __if_33118_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  imul R1, 21
  iadd R0, R1
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_33118_end:
__function_b2Shape_SetDensity_return:
  mov SP, BP
  pop BP
  ret

__function_b2Shape_SetFriction:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetShape
  mov [BP-1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 6
  mov [R1], R0
__function_b2Shape_SetFriction_return:
  mov SP, BP
  pop BP
  ret

__function_b2Shape_SetRestitution:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetShape
  mov [BP-1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 7
  mov [R1], R0
__function_b2Shape_SetRestitution_return:
  mov SP, BP
  pop BP
  ret

__function_b2SyncBodyFlags:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_33375_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_33375_end
  mov R1, [BP-1]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__if_33375_end:
__function_b2SyncBodyFlags_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransferBody:
  push BP
  mov BP, SP
  isub SP, 8
__if_34570_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_34570_end
  jmp __function_b2TransferBody_return
__if_34570_end:
  mov R1, [BP+5]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-1], R0
  mov R3, [BP+3]
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+3]
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 24
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+3]
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  mov R13, [R1]
  mov R1, [BP-2]
  imul R1, 24
  iadd R13, R1
  mov R1, [BP+4]
  mov R12, [R1]
  mov R1, [BP-1]
  imul R1, 24
  iadd R12, R1
  mov CR, 24
  movs
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+3]
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 24
  iadd R0, R1
  mov [BP-3], R0
  mov R1, [BP-3]
  iadd R1, 23
  mov R0, [R1]
  and R0, -41
  mov R1, [BP-3]
  iadd R1, 23
  mov [R1], R0
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 4
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  call __function_b2RemoveBodySim
__if_34649_start:
  mov R1, [BP+4]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_34649_else
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_34662_start:
  mov R0, [BP-1]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_34662_end
  mov R1, [BP+4]
  iadd R1, 3
  mov R13, [R1]
  mov R1, [BP-1]
  imul R1, 8
  iadd R13, R1
  mov R1, [BP+4]
  iadd R1, 3
  mov R12, [R1]
  mov R1, [BP-4]
  imul R1, 8
  iadd R12, R1
  mov CR, 8
  movs
__if_34662_end:
  mov R0, [BP-4]
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_34649_end
__if_34649_else:
__if_34682_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_34682_end
  mov R3, [BP+3]
  iadd R3, 3
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+3]
  iadd R2, 3
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+3]
  iadd R3, 3
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 8
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 3
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 3
  iadd R2, 1
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-4], R0
  mov R1, [BP+3]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 8
  mov [SP+2], R1
  call __function_memset
  mov R13, [BP-4]
  iadd R13, 6
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R1, [BP-3]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_34682_end:
__if_34649_end:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+5]
  iadd R1, 2
  mov [R1], R0
__function_b2TransferBody_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransferJoint:
  push BP
  mov BP, SP
  isub SP, 8
__if_34752_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_34752_end
  jmp __function_b2TransferJoint_return
__if_34752_end:
  mov R1, [BP+5]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  mov R3, [BP+3]
  iadd R3, 9
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP+3]
  iadd R2, 9
  iadd R2, 2
  mov [SP+1], R2
  mov R3, [BP+3]
  iadd R3, 9
  iadd R3, 1
  mov R2, [R3]
  iadd R2, 1
  mov [SP+2], R2
  mov R2, 63
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP+3]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-2]
  imul R1, 63
  iadd R13, R1
  mov R1, [BP+4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-1]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
  movs
  mov R1, [BP+3]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+4]
  iadd R1, 9
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-3], R0
__if_34811_start:
  mov R0, [BP-1]
  mov R1, [BP-3]
  ine R0, R1
  jf R0, __if_34811_end
  mov R1, [BP+4]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-1]
  imul R1, 63
  iadd R13, R1
  mov R1, [BP+4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
  movs
  mov R2, [BP+4]
  iadd R2, 9
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 63
  iadd R1, R2
  mov R0, [R1]
  mov [BP-4], R0
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov R2, [BP-4]
  imul R2, 17
  iadd R1, R2
  iadd R1, 3
  mov [R1], R0
__if_34811_end:
  mov R0, [BP-3]
  mov R1, [BP+4]
  iadd R1, 9
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+5]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+5]
  iadd R1, 3
  mov [R1], R0
  mov R0, -1
  mov R1, [BP+5]
  iadd R1, 2
  mov [R1], R0
__function_b2TransferJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyBodyContacts:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
__while_34871_start:
__while_34871_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_34871_end
  mov R0, [BP-1]
  shl R0, -1
  mov [BP-2], R0
  mov R0, [BP-1]
  and R0, 1
  mov [BP-3], R0
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 16
  iadd R0, R1
  mov [BP-4], R0
  mov R3, [BP-4]
  mov [SP], R3
  mov R3, [BP-3]
  mov [SP+1], R3
  call __function_b2ContactEdgeAt
  mov R2, R0
  iadd R2, 2
  mov R1, [R2]
  mov [BP-1], R1
  mov R0, R1
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __while_34871_start
__while_34871_end:
__function_b2DestroyBodyContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2DestroyBodyProxies:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-1], R0
__while_34913_start:
__while_34913_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_34913_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_34928_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34928_end
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2BroadPhase_DestroyProxy
  mov R0, -1
  mov R1, [BP-2]
  iadd R1, 8
  mov [R1], R0
__if_34928_end:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_34913_start
__while_34913_end:
__function_b2DestroyBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateBodyProxies:
  push BP
  mov BP, SP
  isub SP, 11
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-5], R0
__while_34967_start:
__while_34967_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_34967_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
__if_34982_start:
  mov R0, [BP+4]
  ieq R0, 0
  jf R0, __if_34982_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_34982_end
__if_34982_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_34982_end:
  mov R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
  mov R2, [BP+2]
  iadd R2, 21
  mov [SP], R2
  mov R2, [BP+4]
  mov [SP+1], R2
  mov R2, [BP-6]
  iadd R2, 13
  mov [SP+2], R2
  mov R3, [BP-6]
  iadd R3, 19
  mov R2, [R3]
  mov [SP+3], R2
  mov R3, [BP-6]
  mov R2, [R3]
  mov [SP+4], R2
  call __function_b2BroadPhase_CreateProxy
  mov R1, R0
  mov R2, [BP-6]
  iadd R2, 8
  mov [R2], R1
  mov R0, R1
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  mov R2, [BP-6]
  iadd R2, 8
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2BufferMove
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-5], R0
  jmp __while_34967_start
__while_34967_end:
__function_b2CreateBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_EnableSleeping:
  push BP
  mov BP, SP
  isub SP, 3
__if_35847_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 51
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_35847_end
  jmp __function_b2World_EnableSleeping_return
__if_35847_end:
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 51
  mov [R1], R0
__if_35857_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_35857_end
  mov R0, 3
  mov [BP-1], R0
__for_35864_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_35864_end
__if_35876_start:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_35876_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_35876_end:
__for_35864_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_35864_start
__for_35864_end:
__if_35857_end:
__function_b2World_EnableSleeping_return:
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
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_35954_start:
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
  jf R0, __if_35954_end
  mov R0, 1
  jmp __function_b2OverlapFilterCallback_return
__if_35954_end:
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

__function_b2World_OverlapAABB:
  push BP
  mov BP, SP
  isub SP, 14
  mov R0, 0
  mov R1, [BP+7]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+5]
  mov [BP-1], R0
  mov R0, [BP+6]
  mov [BP-2], R0
__if_35996_start:
  mov R0, [BP+4]
  ine R0, -1
  jf R0, __if_35996_end
  mov R0, [BP+2]
  mov [BP-6], R0
  mov R0, [BP+4]
  mov [BP-5], R0
  mov R0, [BP+5]
  mov [BP-4], R0
  mov R0, [BP+6]
  mov [BP-3], R0
  mov R0, __function_b2OverlapFilterCallback
  mov [BP-1], R0
  lea R0, [BP-6]
  mov [BP-2], R0
__if_35996_end:
  mov R0, 0
  mov [BP-7], R0
__for_36027_start:
  mov R0, [BP-7]
  ilt R0, 3
  jf R0, __for_36027_end
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  mov R2, [BP-7]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  mov R1, [BP-2]
  mov [SP+3], R1
  lea R1, [BP-9]
  mov [SP+4], R1
  call __function_b2DynamicTree_QueryAll
  mov R1, [BP+7]
  mov R0, [R1]
  mov R1, [BP-9]
  iadd R0, R1
  mov R1, [BP+7]
  mov [R1], R0
  mov R1, [BP+7]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-8]
  iadd R0, R1
  mov R1, [BP+7]
  iadd R1, 1
  mov [R1], R0
__for_36027_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_36027_start
__for_36027_end:
__function_b2World_OverlapAABB_return:
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_36096_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36107
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
__LogicalAnd_ShortCircuit_36107:
  mov R0, R1
  jf R0, __if_36096_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2RayCastClosestCallback_return
__if_36096_end:
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
__if_36179_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_36179_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_36179_end
__if_36179_else:
__if_36192_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_36192_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_36192_end
__if_36192_else:
__if_36205_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_36205_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_36205_end
__if_36205_else:
__if_36218_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_36218_end
  mov R1, [BP-3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  lea R1, [BP-18]
  mov [SP+3], R1
  call __function_b2RayCastSegment
__if_36218_end:
__if_36205_end:
__if_36192_end:
__if_36179_end:
__if_36232_start:
  mov R0, [BP-12]
  jf R0, __LogicalAnd_ShortCircuit_36235
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36235:
  jf R0, __if_36232_end
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
__if_36232_end:
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

__function_b2World_CastRayClosest:
  push BP
  mov BP, SP
  isub SP, 19
  push R1
  push R2
  isub SP, 6
  mov R0, [BP+2]
  mov [BP-10], R0
  mov R0, [BP+5]
  mov [BP-9], R0
  mov R0, -1
  mov [BP-1], R0
  lea R13, [BP-8]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  lea R13, [BP-6]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
  mov R0, 1.000000
  mov [BP-4], R0
  mov R0, 0
  mov [BP-3], R0
  mov R0, 0
  mov [BP-2], R0
  lea R13, [BP-15]
  lea R12, [BP+3]
  mov R12, [R12]
  mov CR, 2
  movs
  lea R13, [BP-13]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
  mov R0, 1.000000
  mov [BP-11], R0
  mov R0, -1
  mov [BP-16], R0
__if_36350_start:
  mov R0, [BP+5]
  ine R0, -1
  jf R0, __if_36350_end
  mov R1, [BP+5]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-16], R0
__if_36350_end:
  mov R0, 0
  mov [BP-17], R0
__for_36360_start:
  mov R0, [BP-17]
  ilt R0, 3
  jf R0, __for_36360_end
  mov R2, [BP+2]
  iadd R2, 21
  mov R1, [R2]
  mov R2, [BP-17]
  imul R2, 11
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, __function_b2RayCastClosestCallback
  mov [SP+3], R1
  lea R1, [BP-10]
  mov [SP+4], R1
  lea R1, [BP-19]
  mov [SP+5], R1
  call __function_b2DynamicTree_RayCast
__if_36388_start:
  mov R0, [BP-2]
  jf R0, __if_36388_end
  mov R0, [BP-4]
  mov [BP-11], R0
__if_36388_end:
__for_36360_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_36360_start
__for_36360_end:
  lea R13, [BP+6]
  mov R13, [R13]
  lea R12, [BP-8]
  mov CR, 7
  movs
__if_36403_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_36403_end
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
__if_36403_end:
  mov R0, [BP-1]
__function_b2World_CastRayClosest_return:
  iadd SP, 6
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_36449_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36460
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
__LogicalAnd_ShortCircuit_36460:
  mov R0, R1
  jf R0, __if_36449_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2ShapeCastClosestCallback_return
__if_36449_end:
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
__if_36515_start:
  mov R0, [BP-29]
  jf R0, __LogicalAnd_ShortCircuit_36518
  mov R1, [BP-31]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36518:
  jf R0, __if_36515_end
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
__if_36515_end:
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

__function_b2WorldRayCastCallback:
  push BP
  mov BP, SP
  isub SP, 26
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_37015_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37026
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
__LogicalAnd_ShortCircuit_37026:
  mov R0, R1
  jf R0, __if_37015_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2WorldRayCastCallback_return
__if_37015_end:
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
__if_37098_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_37098_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_37098_end
__if_37098_else:
__if_37111_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_37111_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_37111_end
__if_37111_else:
__if_37124_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_37124_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_37124_end
__if_37124_else:
__if_37137_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_37137_end
  mov R1, [BP-3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  lea R1, [BP-18]
  mov [SP+3], R1
  call __function_b2RayCastSegment
__if_37137_end:
__if_37124_end:
__if_37111_end:
__if_37098_end:
__if_37151_start:
  mov R0, [BP-12]
  jf R0, __if_37151_end
  lea R12, [BP-18]
  lea DR, [BP-25]
  mov CR, 7
  movs
  mov R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-16]
  mov [SP+1], R1
  lea R1, [BP-23]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-18]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+2], R1
  mov R3, [BP-1]
  iadd R3, 2
  mov R2, [R3]
  call R2
  mov [BP-26], R0
__if_37186_start:
  mov R0, [BP-26]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37191
  mov R1, [BP-26]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37191:
  jf R0, __if_37186_end
  mov R0, [BP-26]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37186_end:
  mov R0, [BP-26]
  jmp __function_b2WorldRayCastCallback_return
__if_37151_end:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
__function_b2WorldRayCastCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2WorldShapeCastCallback:
  push BP
  mov BP, SP
  isub SP, 43
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_37321_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37332
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
__LogicalAnd_ShortCircuit_37332:
  mov R0, R1
  jf R0, __if_37321_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2WorldShapeCastCallback_return
__if_37321_end:
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
  iadd R12, 4
  mov CR, 18
  movs
  lea R13, [BP-10]
  mov R12, [BP-1]
  iadd R12, 22
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
__if_37387_start:
  mov R0, [BP-29]
  jf R0, __if_37387_end
  lea R12, [BP-35]
  lea DR, [BP-42]
  mov CR, 7
  movs
  mov R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  call __function_b2TransformPoint
  mov R1, [BP-6]
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-42]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP+4]
  mov [SP], R1
  lea R1, [BP-42]
  mov [SP+1], R1
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov [SP+2], R1
  mov R3, [BP-1]
  iadd R3, 2
  mov R2, [R3]
  call R2
  mov [BP-43], R0
__if_37422_start:
  mov R0, [BP-43]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37427
  mov R1, [BP-43]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37427:
  jf R0, __if_37422_end
  mov R0, [BP-43]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37422_end:
  mov R0, [BP-43]
  jmp __function_b2WorldShapeCastCallback_return
__if_37387_end:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
__function_b2WorldShapeCastCallback_return:
  iadd SP, 4
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2WorldOverlapCallback:
  push BP
  mov BP, SP
  isub SP, 64
  push R1
  push R2
  push R3
  push R4
  isub SP, 3
  mov R0, [BP+4]
  mov [BP-1], R0
  mov R1, [BP-1]
  mov R0, [R1]
  mov [BP-2], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_37711_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37722
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
__LogicalAnd_ShortCircuit_37722:
  mov R0, R1
  jf R0, __if_37711_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_37711_end:
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
  lea R13, [BP-46]
  mov R12, [BP-1]
  iadd R12, 2
  mov R12, [R12]
  mov CR, 18
  movs
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  lea R13, [BP-10]
  mov R12, [BP-5]
  mov CR, 4
  movs
  mov R0, 1
  mov [BP-6], R0
  mov R0, 0
  mov [BP-53], R0
  lea R1, [BP-46]
  mov [SP], R1
  lea R1, [BP-53]
  mov [SP+1], R1
  lea R1, [BP-62]
  mov [SP+2], R1
  call __function_b2ShapeDistance
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 0.100000
  mov R0, R1
  mov [BP-63], R0
__if_37786_start:
  mov R0, [BP-56]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_37786_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_37786_end:
  mov R1, [BP+3]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP+1], R1
  mov R3, [BP-1]
  iadd R3, 3
  mov R2, [R3]
  call R2
  mov [BP-64], R0
__if_37801_start:
  mov R0, [BP-64]
  ieq R0, 0
  jf R0, __if_37801_end
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_37801_end:
  mov R0, [BP-64]
__function_b2WorldOverlapCallback_return:
  iadd SP, 3
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ExplosionCallback:
  push BP
  mov BP, SP
  isub SP, 89
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
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
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  lea R1, [BP-8]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  lea R1, [BP-10]
  mov [SP+2], R1
  call __function_b2InvTransformPoint
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-51]
  mov [SP+1], R1
  call __function_b2MakeShapeProxy
  lea R1, [BP-10]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  lea R1, [BP-33]
  mov [SP+3], R1
  call __function_b2MakeProxy
  lea R13, [BP-15]
  mov R12, global_b2Transform_identity
  mov CR, 4
  movs
  mov R0, 1
  mov [BP-11], R0
  mov R0, 0
  mov [BP-58], R0
  lea R1, [BP-51]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  lea R1, [BP-67]
  mov [SP+2], R1
  call __function_b2ShapeDistance
__if_38126_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_38126_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38126_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_38140_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_38140_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38140_end:
  lea R12, [BP-67]
  lea DR, [BP-69]
  mov CR, 2
  movs
__if_38151_start:
  mov R0, [BP-61]
  feq R0, 0.000000
  jf R0, __if_38151_end
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  call __function_b2GetShapeCentroid
__if_38151_end:
  lea R1, [BP-69]
  mov [SP], R1
  lea R1, [BP-10]
  mov [SP+1], R1
  lea R1, [BP-71]
  mov [SP+2], R1
  call __function_b2Sub
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R1, R2
  mov R0, R1
  mov [BP-72], R0
__if_38180_start:
  lea R2, [BP-71]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-72]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_38180_else
  lea R1, [BP-71]
  mov [SP], R1
  lea R1, [BP-89]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R13, [BP-71]
  lea R12, [BP-89]
  mov CR, 2
  movs
  jmp __if_38180_end
__if_38180_else:
  mov R0, 1.000000
  mov [BP-71], R0
  mov R0, 0.000000
  mov [BP-70], R0
__if_38180_end:
  lea R1, [BP-71]
  mov [SP], R1
  lea R1, [BP-74]
  mov [SP+1], R1
  call __function_b2LeftPerp
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-74]
  mov [SP+1], R1
  call __function_b2GetShapeProjectedPerimeter
  mov [BP-75], R0
  mov R0, 1.000000
  mov [BP-76], R0
__if_38222_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_38230
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_38230:
  jf R0, __if_38222_end
  mov R3, [BP-1]
  iadd R3, 3
  mov R2, [R3]
  mov R4, [BP-1]
  iadd R4, 4
  mov R3, [R4]
  fadd R2, R3
  mov R3, [BP-61]
  fsub R2, R3
  mov R4, [BP-1]
  iadd R4, 4
  mov R3, [R4]
  fdiv R2, R3
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 1.000000
  mov [SP+2], R2
  call __function_b2ClampFloat
  mov R1, R0
  mov [BP-76], R1
  mov R0, R1
__if_38222_end:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-75]
  fmul R0, R1
  mov R1, [BP-76]
  fmul R0, R1
  mov [BP-77], R0
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-71]
  mov [SP+1], R1
  lea R1, [BP-79]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R1, [BP-77]
  mov [SP], R1
  lea R1, [BP-79]
  mov [SP+1], R1
  lea R1, [BP-81]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-82], R0
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-83], R0
  mov R1, [BP-83]
  mov R0, [R1]
  mov R2, [BP-82]
  iadd R2, 15
  mov R1, [R2]
  mov R2, [BP-81]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-83]
  mov [R1], R0
  mov R1, [BP-83]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-82]
  iadd R2, 15
  mov R1, [R2]
  mov R2, [BP-80]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-83]
  iadd R1, 1
  mov [R1], R0
  lea R1, [BP-69]
  mov [SP], R1
  mov R1, [BP-82]
  iadd R1, 10
  mov [SP+1], R1
  lea R1, [BP-85]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-6]
  mov [SP], R1
  lea R1, [BP-85]
  mov [SP+1], R1
  lea R1, [BP-87]
  mov [SP+2], R1
  call __function_b2RotateVector
  mov R2, [BP-83]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP-82]
  iadd R3, 16
  mov R2, [R3]
  lea R4, [BP-87]
  mov [SP], R4
  lea R4, [BP-81]
  mov [SP+1], R4
  call __function_b2Cross
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R2, [BP-83]
  iadd R2, 2
  mov [R2], R1
  mov R0, R1
  mov R0, 1
__function_b2ExplosionCallback_return:
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_38469_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38480
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
__LogicalAnd_ShortCircuit_38480:
  mov R0, R1
  jf R0, __if_38469_end
  mov R0, 1
  jmp __function_b2MoverCollideCallback_return
__if_38469_end:
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
__if_38511_start:
  mov R1, [BP-6]
  jf R1, __LogicalAnd_ShortCircuit_38514
  lea R3, [BP-11]
  mov [SP], R3
  call __function_b2IsNormalized
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_38514:
  mov R0, R1
  jf R0, __if_38511_end
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
__if_38511_end:
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
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_38676_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38687
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
__LogicalAnd_ShortCircuit_38687:
  mov R0, R1
  jf R0, __if_38676_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_38676_end:
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
__if_38727_start:
  mov R0, [BP-30]
  feq R0, 0.000000
  jf R0, __if_38727_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_38727_end:
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
__if_38940_start:
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
  jf R0, __if_38940_end
  jmp __function_b2CreateContact_return
__if_38940_end:
__if_38949_start:
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
  jf R0, __if_38949_end
  mov R0, [BP+3]
  mov [BP-12], R0
  mov R0, [BP+4]
  mov [BP+3], R0
  mov R0, [BP-12]
  mov [BP+4], R0
__if_38949_end:
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
__if_38987_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_38994
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  or R0, R1
__LogicalOr_ShortCircuit_38994:
  jf R0, __if_38987_else
  mov R0, 2
  mov [BP-3], R0
  jmp __if_38987_end
__if_38987_else:
  mov R0, 1
  mov [BP-3], R0
__if_38987_end:
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
__if_39017_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_39017_end
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
__if_39017_end:
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
__if_39127_start:
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  and R0, 4096
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_39140
  mov R2, [BP-2]
  iadd R2, 18
  mov R1, [R2]
  and R1, 4096
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_39140:
  jf R0, __if_39127_end
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_39127_end:
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
__if_39183_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39183_end
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
__if_39183_end:
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
__if_39255_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39255_end
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
__if_39255_end:
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
__if_39393_start:
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39393_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_39393_end:
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
__if_39428_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39428_end
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
__if_39428_end:
__if_39457_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39457_end
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
__if_39457_end:
__if_39486_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_39486_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_39486_end:
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
__if_39525_start:
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39525_end
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
__if_39525_end:
__if_39554_start:
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39554_end
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
__if_39554_end:
__if_39583_start:
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_39583_end
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
__if_39583_end:
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
__if_39626_start:
  mov R0, [BP-8]
  mov R1, [BP-9]
  ine R0, R1
  jf R0, __if_39626_end
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
__if_39626_end:
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
__if_39701_start:
  mov R0, [BP+4]
  jf R0, __LogicalAnd_ShortCircuit_39703
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_39703:
  jf R0, __if_39701_end
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
__if_39701_end:
__function_b2DestroyContact_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetContactSim:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 8
  mov R1, [R2]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 10
  mov R1, [R2]
  imul R1, 49
  iadd R0, R1
__function_b2GetContactSim_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2MakeContactId:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov R1, [BP+4]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 64
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 2
  mov [R1], R0
__function_b2MakeContactId_return:
  mov SP, BP
  pop BP
  ret

__function_b2Contact_IsValid:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
__if_39763_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 64
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_39763_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39763_end:
__if_39771_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_39778
  mov R2, [BP+3]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 33
  iadd R3, 1
  mov R2, [R3]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_39778:
  jf R0, __if_39771_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39771_end:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
__if_39796_start:
  mov R1, [BP-1]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_39796_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39796_end:
__if_39805_start:
  mov R1, [BP-1]
  iadd R1, 15
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_39805_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39805_end:
  mov R0, 1
__function_b2Contact_IsValid_return:
  pop R3
  pop R2
  pop R1
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
  imul R1, 63
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
__while_40132_start:
__while_40132_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40132_end
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
__if_40163_start:
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
  jf R0, __if_40163_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_40163_end:
  jmp __while_40132_start
__while_40132_end:
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
__while_40192_start:
__while_40192_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40192_end
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
__if_40225_start:
  mov R0, [BP-6]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_40231
  mov R2, [BP-5]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_40231:
  jf R0, __if_40225_end
  mov R0, 0
  jmp __function_b2ShouldBodiesCollide_return
__if_40225_end:
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
  jmp __while_40192_start
__while_40192_end:
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
__if_40277_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 1
  jt R0, __LogicalOr_ShortCircuit_40284
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 1
  or R0, R1
__LogicalOr_ShortCircuit_40284:
  jf R0, __if_40277_else
  mov R0, 1
  mov [BP-3], R0
  jmp __if_40277_end
__if_40277_else:
__if_40290_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_40297
  mov R2, [BP-2]
  iadd R2, 19
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_40297:
  jf R0, __if_40290_else
  mov R0, 0
  mov [BP-3], R0
  jmp __if_40290_end
__if_40290_else:
  mov R0, 2
  mov [BP-3], R0
__if_40290_end:
__if_40277_end:
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
__if_40320_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_40320_end
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
__if_40320_end:
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
__if_40458_start:
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40458_end
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
__if_40458_end:
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
__if_40529_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40529_end
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
__if_40529_end:
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
  mov R2, 63
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
  imul R1, 63
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
  mov R1, 63
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
__if_40672_start:
  mov R0, [BP+8]
  ieq R0, 0
  jf R0, __if_40672_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContactsBetweenBodies
__if_40672_end:
__if_40680_start:
  mov R0, [BP-3]
  ige R0, 2
  jf R0, __if_40680_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2LinkJoint
__if_40680_end:
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
__if_40701_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40701_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkJoint
__if_40701_end:
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
__if_40743_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40743_end
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
__if_40743_end:
__if_40772_start:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40772_end
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
__if_40772_end:
__if_40801_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_40801_end
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
__if_40801_end:
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
__if_40824_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40824_end
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
__if_40824_end:
__if_40853_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40853_end
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
__if_40853_end:
__if_40882_start:
  mov R1, [BP-5]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_40882_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 8
  mov [R1], R0
__if_40882_end:
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
__if_40925_start:
  mov R0, [BP-7]
  mov R1, [BP-8]
  ine R0, R1
  jf R0, __if_40925_end
  mov R1, [BP-6]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-7]
  imul R1, 63
  iadd R13, R1
  mov R1, [BP-6]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-8]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
  movs
  mov R1, [BP-6]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-7]
  imul R1, 63
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
__if_40925_end:
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
__if_41000_start:
  mov R0, [BP+4]
  jf R0, __if_41000_end
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
__if_41000_end:
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
  iadd R0, 23
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
  iadd R0, 23
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
  iadd R0, 23
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
  iadd R0, 23
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
  iadd R0, 23
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
  iadd R1, 64
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

__function_b2DestroyJoint:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 40
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  isub R2, 1
  imul R2, 17
  iadd R1, R2
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyJointInternal
__function_b2DestroyJoint_return:
  mov SP, BP
  pop BP
  ret

__function_b2DefaultDistanceJointDef:
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
  mov R13, [BP+2]
  iadd R13, 6
  iadd R13, 2
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R13, [BP+2]
  iadd R13, 10
  iadd R13, 2
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R0, 1.000000
  mov R1, [BP+2]
  iadd R1, 14
  mov [R1], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 100000.000000
  mov R2, [BP+2]
  iadd R2, 18
  mov [R2], R1
  mov R0, R1
__function_b2DefaultDistanceJointDef_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateDistanceJointDef:
  push BP
  mov BP, SP
  isub SP, 12
  mov R1, [BP+3]
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  isub R0, 1
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 6
  mov [SP+3], R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [SP+4], R1
  mov R2, [BP+3]
  iadd R2, 14
  mov R1, [R2]
  mov [SP+5], R1
  mov R2, [BP+3]
  iadd R2, 21
  mov R1, [R2]
  mov [SP+6], R1
  call __function_b2CreateDistanceJoint
  mov [BP-3], R0
  mov R5, [BP+2]
  mov [SP], R5
  mov R5, [BP-3]
  mov [SP+1], R5
  call __function_b2GetJointSimById
  mov R4, R0
  iadd R4, 23
  mov R3, [R4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP-3]
  mov [SP+1], R4
  call __function_b2GetJointSimById
  mov R3, R0
  iadd R3, 23
  mov R2, [R3]
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_b2GetJointSimById
  mov R1, R0
  iadd R1, 23
  mov R0, R1
  mov [BP-4], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 25
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 26
  mov [R1], R0
__if_41775_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_41775_end
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  mov [BP-5], R2
  mov R3, [BP+3]
  iadd R3, 17
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-5]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-4]
  iadd R2, 5
  mov [R2], R1
  mov R0, R1
  mov R3, [BP+3]
  iadd R3, 17
  mov R2, [R3]
  mov [SP], R2
  mov R3, [BP+3]
  iadd R3, 18
  mov R2, [R3]
  mov [SP+1], R2
  call __function_b2MaxFloat
  mov R1, R0
  mov R2, [BP-4]
  iadd R2, 6
  mov [R2], R1
  mov R0, R1
__if_41775_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MakeJointId
__function_b2CreateDistanceJointDef_return:
  mov SP, BP
  pop BP
  ret

__function_b2DefaultRevoluteJointDef:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 25
  mov [SP+2], R1
  call __function_memset
  mov R13, [BP+2]
  iadd R13, 6
  iadd R13, 2
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
  mov R13, [BP+2]
  iadd R13, 10
  iadd R13, 2
  mov R12, global_b2Rot_identity
  mov CR, 2
  movs
__function_b2DefaultRevoluteJointDef_return:
  mov SP, BP
  pop BP
  ret

__function_b2CreateRevoluteJointDef:
  push BP
  mov BP, SP
  isub SP, 10
  mov R1, [BP+3]
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  isub R0, 1
  mov [BP-2], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  mov R1, [BP+3]
  iadd R1, 6
  mov [SP+3], R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [SP+4], R1
  mov R2, [BP+3]
  iadd R2, 24
  mov R1, [R2]
  mov [SP+5], R1
  call __function_b2CreateRevoluteJoint
  mov [BP-3], R0
  mov R5, [BP+2]
  mov [SP], R5
  mov R5, [BP-3]
  mov [SP+1], R5
  call __function_b2GetJointSimById
  mov R4, R0
  iadd R4, 23
  mov R3, [R4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP-3]
  mov [SP+1], R4
  call __function_b2GetJointSimById
  mov R3, R0
  iadd R3, 23
  mov R2, [R3]
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-3]
  mov [SP+1], R2
  call __function_b2GetJointSimById
  mov R1, R0
  iadd R1, 23
  mov R0, R1
  mov [BP-4], R0
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 29
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 6
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 7
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 17
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 30
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 10
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 31
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 22
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 11
  mov [R1], R0
  mov R1, [BP+3]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 12
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MakeJointId
__function_b2CreateRevoluteJointDef_return:
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

__function_b2Joint_GetType:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  isub SP, 2
  mov R3, [BP+2]
  mov [SP], R3
  mov R3, [BP+3]
  mov [SP+1], R3
  call __function_b2Joint_GetSim
  mov R2, R0
  iadd R2, 3
  mov R1, [R2]
  mov R0, R1
__function_b2Joint_GetType_return:
  iadd SP, 2
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2RevoluteJoint_EnableMotor:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+4]
  mov R6, [BP+2]
  mov [SP], R6
  mov R6, [BP+3]
  mov [SP+1], R6
  call __function_b2Joint_GetSim
  mov R5, R0
  iadd R5, 23
  mov R4, [R5]
  mov R5, [BP+2]
  mov [SP], R5
  mov R5, [BP+3]
  mov [SP+1], R5
  call __function_b2Joint_GetSim
  mov R4, R0
  iadd R4, 23
  mov R3, [R4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP+3]
  mov [SP+1], R4
  call __function_b2Joint_GetSim
  mov R3, R0
  iadd R3, 23
  iadd R3, 30
  mov R2, [R3]
  mov R3, [BP+2]
  mov [SP], R3
  mov R3, [BP+3]
  mov [SP+1], R3
  call __function_b2Joint_GetSim
  mov R2, R0
  iadd R2, 23
  iadd R2, 30
  mov [R2], R1
  mov R0, R1
__function_b2RevoluteJoint_EnableMotor_return:
  mov SP, BP
  pop BP
  ret

__function_b2RevoluteJoint_SetMotorSpeed:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+4]
  mov R6, [BP+2]
  mov [SP], R6
  mov R6, [BP+3]
  mov [SP+1], R6
  call __function_b2Joint_GetSim
  mov R5, R0
  iadd R5, 23
  mov R4, [R5]
  mov R5, [BP+2]
  mov [SP], R5
  mov R5, [BP+3]
  mov [SP+1], R5
  call __function_b2Joint_GetSim
  mov R4, R0
  iadd R4, 23
  mov R3, [R4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP+3]
  mov [SP+1], R4
  call __function_b2Joint_GetSim
  mov R3, R0
  iadd R3, 23
  iadd R3, 10
  mov R2, [R3]
  mov R3, [BP+2]
  mov [SP], R3
  mov R3, [BP+3]
  mov [SP+1], R3
  call __function_b2Joint_GetSim
  mov R2, R0
  iadd R2, 23
  iadd R2, 10
  mov [R2], R1
  mov R0, R1
__function_b2RevoluteJoint_SetMotorSpeed_return:
  mov SP, BP
  pop BP
  ret

__function_b2RevoluteJoint_SetMaxMotorTorque:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+4]
  mov R6, [BP+2]
  mov [SP], R6
  mov R6, [BP+3]
  mov [SP+1], R6
  call __function_b2Joint_GetSim
  mov R5, R0
  iadd R5, 23
  mov R4, [R5]
  mov R5, [BP+2]
  mov [SP], R5
  mov R5, [BP+3]
  mov [SP+1], R5
  call __function_b2Joint_GetSim
  mov R4, R0
  iadd R4, 23
  mov R3, [R4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP+3]
  mov [SP+1], R4
  call __function_b2Joint_GetSim
  mov R3, R0
  iadd R3, 23
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP+2]
  mov [SP], R3
  mov R3, [BP+3]
  mov [SP+1], R3
  call __function_b2Joint_GetSim
  mov R2, R0
  iadd R2, 23
  iadd R2, 9
  mov [R2], R1
  mov R0, R1
__function_b2RevoluteJoint_SetMaxMotorTorque_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetJointAxisA:
  push BP
  mov BP, SP
  isub SP, 11
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  mov R0, 1.000000
  mov [BP-6], R0
  mov R0, 0.000000
  mov [BP-5], R0
  mov R1, [BP+3]
  iadd R1, 4
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  lea R1, [BP-8]
  mov [SP+2], R1
  call __function_b2RotateVector
  lea R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2RotateVector
__function_b2GetJointAxisA_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetJointConstraintForce:
  push BP
  mov BP, SP
  isub SP, 23
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetJointSim
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 55
  mov R0, [R1]
  mov [BP-2], R0
__if_44393_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44393_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44393_end
__if_44393_else:
__if_44407_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44407_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44407_end
__if_44407_else:
__if_44421_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44421_else
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 11
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 14
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Add
  mov R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44421_end
__if_44421_else:
__if_44447_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_44447_else
  mov R0, [BP-1]
  iadd R0, 23
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2GetBodyTransform
  lea R1, [BP-7]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 4
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 8
  mov [SP+1], R1
  lea R1, [BP-15]
  mov [SP+2], R1
  call __function_b2TransformPoint
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  lea R1, [BP-17]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-17]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R1, [BP-3]
  iadd R1, 9
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 10
  mov R1, [R2]
  fadd R0, R1
  mov R2, [BP-3]
  iadd R2, 11
  mov R1, [R2]
  fsub R0, R1
  mov R2, [BP-3]
  iadd R2, 12
  mov R1, [R2]
  fadd R0, R1
  mov R1, [BP-2]
  fmul R0, R1
  mov [BP-20], R0
  mov R1, [BP-20]
  mov [SP], R1
  lea R1, [BP-19]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44447_end
__if_44447_else:
__if_44534_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_44534_else
  mov R0, [BP-1]
  iadd R0, 23
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2GetJointAxisA
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2LeftPerp
  mov R0, [BP-2]
  mov R2, [BP-3]
  mov R1, [R2]
  fmul R0, R1
  mov [BP-8], R0
  mov R0, [BP-2]
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-3]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  mov R3, [BP-3]
  iadd R3, 5
  mov R2, [R3]
  fsub R1, R2
  fmul R0, R1
  mov [BP-9], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP-9]
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2Add
  jmp __if_44534_end
__if_44534_else:
__if_44602_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_44602_else
  mov R0, [BP-1]
  iadd R0, 23
  mov [BP-3], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2GetJointAxisA
  lea R1, [BP-5]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2LeftPerp
  mov R0, [BP-2]
  mov R2, [BP-3]
  mov R1, [R2]
  fmul R0, R1
  mov [BP-8], R0
  mov R0, [BP-2]
  mov R2, [BP-3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP-3]
  iadd R3, 3
  mov R2, [R3]
  fadd R1, R2
  mov R3, [BP-3]
  iadd R3, 4
  mov R2, [R3]
  fsub R1, R2
  fmul R0, R1
  mov [BP-9], R0
  mov R1, [BP-8]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  lea R1, [BP-11]
  mov [SP+2], R1
  call __function_b2MulSV
  mov R1, [BP-9]
  mov [SP], R1
  lea R1, [BP-5]
  mov [SP+1], R1
  lea R1, [BP-13]
  mov [SP+2], R1
  call __function_b2MulSV
  lea R1, [BP-11]
  mov [SP], R1
  lea R1, [BP-13]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2Add
  jmp __if_44602_end
__if_44602_else:
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_44602_end:
__if_44534_end:
__if_44447_end:
__if_44421_end:
__if_44407_end:
__if_44393_end:
__function_b2GetJointConstraintForce_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetJointConstraintTorque:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  push R3
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetJointSim
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 55
  mov R0, [R1]
  mov [BP-2], R0
__if_44686_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44686_end
  mov R0, [BP-1]
  iadd R0, 23
  mov [BP-3], R0
  mov R0, [BP-2]
  mov R2, [BP-3]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-3]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  mov R3, [BP-3]
  iadd R3, 5
  mov R2, [R3]
  fsub R1, R2
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44686_end:
__if_44710_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_44710_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44710_end:
__if_44723_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_44723_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44723_end:
__if_44735_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44735_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 12
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44735_end:
__if_44747_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44747_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 13
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 23
  iadd R3, 16
  mov R2, [R3]
  fadd R1, R2
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44747_end:
  mov R0, 0.000000
__function_b2GetJointConstraintTorque_return:
  iadd SP, 2
  pop R3
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
__if_45530_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45530_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_45530_end:
__if_45545_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45545_end
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
__if_45545_end:
__if_45560_start:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45560_end
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
__if_45560_end:
__if_45575_start:
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45575_end
  mov R2, [BP-1]
  iadd R2, 9
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 2
  mov R1, [R2]
  imul R1, 63
  mov [SP+1], R1
  call __function_b2Free
__if_45575_end:
__if_45590_start:
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45590_end
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
__if_45590_end:
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
__if_45694_start:
  mov R0, [BP+3]
  ilt R0, 3
  jf R0, __if_45694_end
  jmp __function_b2WakeSolverSet_return
__if_45694_end:
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
__for_45717_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45717_end
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
__for_45717_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45717_start
__for_45717_end:
  mov R0, 0
  mov [BP-3], R0
__for_45855_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45855_end
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
__for_45855_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45855_start
__for_45855_end:
  mov R0, 0
  mov [BP-3], R0
__for_45931_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45931_end
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-1]
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP-3]
  imul R3, 63
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
  mov R2, 63
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
  imul R1, 63
  iadd R13, R1
  mov R1, [BP-1]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
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
__for_45931_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45931_start
__for_45931_end:
  mov R0, 0
  mov [BP-3], R0
__for_46007_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46007_end
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
__for_46007_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46007_start
__for_46007_end:
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
__for_46098_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_46098_end
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
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 4
  mov R1, [R2]
  imul R1, 87
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
__if_46177_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46184
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_46184:
  jf R0, __if_46177_end
  jmp __for_46098_continue
__if_46177_end:
__if_46188_start:
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
  jf R0, __if_46188_end
__if_46199_start:
  mov R1, [BP-8]
  jf R1, __LogicalAnd_ShortCircuit_46201
  mov R3, [BP-6]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2ShouldReportContactEvents
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_46201:
  mov R0, R1
  jf R0, __if_46199_end
  mov R1, [BP+2]
  iadd R1, 70
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
__if_46199_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __for_46098_continue
__if_46188_end:
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
__if_46228_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46228_else
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  jmp __if_46228_end
__if_46228_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46228_end:
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
__if_46254_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46254_else
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  jmp __if_46254_end
__if_46254_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46254_end:
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
__if_46314_start:
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
  jf R0, __if_46314_else
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
  jmp __if_46314_end
__if_46314_else:
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
__if_46314_end:
__if_46354_start:
  mov R0, [BP-19]
  jf R0, __LogicalAnd_ShortCircuit_46356
  mov R1, [BP-8]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_46356:
  jf R0, __if_46354_else
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  or R0, 1
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46368_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46368_end
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
__if_46368_end:
__if_46380_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46380_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46380_end:
__if_46389_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46389_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46389_end:
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
__if_46416_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46416_end
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46416_end:
__if_46426_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46426_end
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46426_end:
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
  jmp __if_46354_end
__if_46354_else:
__if_46459_start:
  mov R0, [BP-19]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_46464
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_46464:
  jf R0, __if_46459_end
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  and R0, -2
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46474_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46474_end
  mov R1, [BP+2]
  iadd R1, 70
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
__if_46474_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_46459_end:
__if_46354_end:
__if_46489_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_46489_end
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
__if_46489_end:
__if_46508_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_46508_end
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
__if_46508_end:
__for_46098_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_46098_start
__for_46098_end:
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
__if_46564_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46564_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46564_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  and R0, 3
  mov [BP-5], R0
__if_46579_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_46579_else
__if_46584_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46590
  mov R1, [BP-4]
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_46590:
  jf R0, __if_46584_end
__if_46595_start:
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
  jf R0, __if_46595_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46595_end:
__if_46584_end:
  jmp __if_46579_end
__if_46579_else:
__if_46607_start:
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
  jf R0, __if_46607_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46607_end:
__if_46579_end:
__if_46618_start:
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
  jf R0, __if_46618_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46618_end:
__if_46632_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_46632_else
  mov R0, [BP+3]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-7], R0
  jmp __if_46632_end
__if_46632_else:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP+3]
  mov [BP-7], R0
__if_46632_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-6]
  imul R1, 87
  iadd R0, R1
  mov [BP-8], R0
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-7]
  imul R1, 87
  iadd R0, R1
  mov [BP-9], R0
__if_46669_start:
  mov R1, [BP-8]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46669_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46669_end:
__if_46677_start:
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
  jf R0, __if_46677_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46677_end:
__if_46687_start:
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
  jf R0, __if_46687_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46687_end:
__if_46699_start:
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
  jf R0, __if_46699_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46699_end:
__if_46710_start:
  mov R1, [BP-8]
  iadd R1, 24
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_46713
  mov R2, [BP-9]
  iadd R2, 24
  mov R1, [R2]
  or R0, R1
__LogicalOr_ShortCircuit_46713:
  jf R0, __if_46710_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46710_end:
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
__for_46737_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_46737_end
  mov R2, [BP-1]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-4], R0
__if_46753_start:
  mov R0, [BP-4]
  ieq R0, -1
  jf R0, __if_46753_end
  jmp __for_46737_continue
__if_46753_end:
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
__if_46807_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_46807_end
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
__if_46807_end:
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
__for_46737_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46737_start
__for_46737_end:
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
__if_46892_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46892_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46892_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_46907_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46907_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46907_end:
__if_46916_start:
  mov R1, [BP-4]
  iadd R1, 25
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_46916_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46916_end:
__if_46923_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_46923_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46923_end:
__if_46928_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46928_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46928_end:
__if_46936_start:
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
  jf R0, __if_46936_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46936_end:
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
__if_46996_start:
  mov R0, [BP-59]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R1, 10.000000
  flt R0, R1
  jf R0, __if_46996_end
  mov R3, [BP-2]
  iadd R3, 82
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-2]
  iadd R2, 83
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
  iadd R2, 82
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+3]
  mov R2, [BP-2]
  iadd R2, 82
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
__if_46996_end:
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
__for_47046_start:
  mov R0, [BP-2]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_47046_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_47064_start:
  mov R1, [BP-3]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47064_end
  jmp __for_47046_continue
__if_47064_end:
__if_47072_start:
  mov R1, [BP-3]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_47072_end
  jmp __for_47046_continue
__if_47072_end:
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
  jf R0, __LogicalAnd_ShortCircuit_47108
  mov R2, [BP-3]
  iadd R2, 25
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_47108:
  mov [BP-12], R0
__if_47111_start:
  mov R0, [BP-12]
  jf R0, __if_47111_end
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
__for_47133_start:
  mov R0, [BP-25]
  ilt R0, 3
  jf R0, __for_47133_end
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
__for_47133_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_47133_start
__for_47133_end:
__if_47111_end:
  mov R0, [BP-5]
  mov [BP-13], R0
  mov R1, [BP-3]
  iadd R1, 26
  mov R0, [R1]
  mov [BP-14], R0
  mov R1, [BP-3]
  iadd R1, 27
  mov R0, [R1]
  mov [BP-15], R0
  mov R1, [BP+2]
  iadd R1, 82
  mov R0, [R1]
  mov [BP-16], R0
  mov R0, 0
  mov [BP-17], R0
__for_47177_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47177_end
  mov R0, [BP-16]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47195_start:
  mov R0, [BP-18]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47195_end
__if_47204_start:
  mov R0, [BP-14]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47204_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47195_end
__if_47204_end:
__for_47195_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47195_start
__for_47195_end:
__if_47215_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47215_end
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47215_end:
__for_47177_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47177_start
__for_47177_end:
  mov R0, 0
  mov [BP-17], R0
__for_47226_start:
  mov R0, [BP-17]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47226_end
  mov R0, [BP-14]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47244_start:
  mov R0, [BP-18]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47244_end
__if_47253_start:
  mov R0, [BP-16]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47253_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47244_end
__if_47253_end:
__for_47244_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47244_start
__for_47244_end:
__if_47264_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47264_end
  mov R1, [BP+2]
  iadd R1, 79
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47264_end:
__for_47226_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47226_start
__for_47226_end:
  mov R3, [BP-3]
  iadd R3, 26
  mov R2, [R3]
  mov [SP], R2
  mov R2, [BP-3]
  iadd R2, 28
  mov [SP+1], R2
  mov R2, [BP-13]
  mov [SP+2], R2
  mov R2, 1
  mov [SP+3], R2
  call __function_b2GrowArray
  mov R1, R0
  mov R2, [BP-3]
  iadd R2, 26
  mov [R2], R1
  mov R0, R1
  mov R0, 0
  mov [BP-17], R0
__for_47286_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47286_end
  mov R2, [BP+2]
  iadd R2, 82
  mov R0, [R2]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov R2, [BP-3]
  iadd R2, 26
  mov R1, [R2]
  mov R2, [BP-17]
  iadd R1, R2
  mov [R1], R0
__for_47286_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47286_start
__for_47286_end:
  mov R0, [BP-13]
  mov R1, [BP-3]
  iadd R1, 27
  mov [R1], R0
__for_47046_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_47046_start
__for_47046_end:
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
  iadd R12, 56
  lea DR, [BP-6]
  mov CR, 2
  movs
  mov R0, 0
  mov [BP-7], R0
__for_47340_start:
  mov R0, [BP-7]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_47340_end
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
__if_47394_start:
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_47394_else
  mov R1, [BP-8]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-15], R0
  jmp __if_47394_end
__if_47394_else:
  mov R0, 0.000000
  mov [BP-15], R0
__if_47394_end:
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
__for_47340_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_47340_start
__for_47340_end:
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
__for_47503_start:
  mov R0, [BP-6]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_47503_end
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
__if_47527_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  jf R0, __if_47527_end
  mov R0, 0.000000
  mov [BP-9], R0
__if_47527_end:
__if_47539_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 2
  ine R0, 0
  jf R0, __if_47539_end
  mov R0, 0.000000
  mov [BP-8], R0
__if_47539_end:
__if_47551_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 4
  ine R0, 0
  jf R0, __if_47551_end
  mov R0, 0.000000
  mov [BP-10], R0
__if_47551_end:
__if_47562_start:
  lea R2, [BP-9]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-4]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_47562_end
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
__if_47562_end:
__if_47596_start:
  mov R0, [BP-10]
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-5]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_47607
  mov R2, [BP-7]
  iadd R2, 3
  mov R1, [R2]
  and R1, 128
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_47607:
  jf R0, __if_47596_end
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
__if_47596_end:
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
__for_47503_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_47503_start
__for_47503_end:
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
__if_47695_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47695_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47695_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_47710_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47710_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47710_end:
__if_47719_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47719_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47719_end:
__if_47727_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47727_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47727_end:
__if_47732_start:
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
  jf R0, __if_47732_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47732_end:
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
__if_47758_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_47758_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47758_end:
__if_47768_start:
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
  jf R0, __if_47768_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47768_end:
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
__if_47840_start:
  mov R0, [BP-64]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_47847
  mov R1, [BP-64]
  mov R3, [BP-1]
  iadd R3, 13
  mov R2, [R3]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_47847:
  jf R0, __if_47840_end
  mov R0, [BP-64]
  mov R1, [BP-1]
  iadd R1, 13
  mov [R1], R0
__if_47840_end:
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
__while_47938_start:
__while_47938_continue:
  mov R0, [BP-34]
  ine R0, -1
  jf R0, __while_47938_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-34]
  imul R1, 87
  iadd R0, R1
  mov [BP-35], R0
  mov R1, [BP-35]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-34], R0
__if_47957_start:
  mov R1, [BP-35]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47957_end
  jmp __while_47938_continue
__if_47957_end:
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
__if_48044_start:
  mov R0, [BP-25]
  jf R0, __if_48044_end
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
__if_48044_end:
  jmp __while_47938_start
__while_47938_end:
__if_48077_start:
  mov R0, [BP-11]
  flt R0, 1.000000
  jf R0, __if_48077_else
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
  jmp __if_48077_end
__if_48077_else:
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
__if_48077_end:
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
__while_48186_start:
__while_48186_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_48186_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_48201_start:
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48201_end
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
__if_48267_start:
  mov R2, [BP-3]
  iadd R2, 13
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2AABB_Contains
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_48267_end
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
__if_48267_end:
__if_48201_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_48186_start
__while_48186_end:
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
__for_48363_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48363_end
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
__if_48483_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_48493
  mov R2, [BP-6]
  iadd R2, 23
  mov R1, [R2]
  and R1, 2048
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_48493:
  jt R0, __LogicalOr_ShortCircuit_48497
  mov R1, [BP-21]
  mov R3, [BP-14]
  iadd R3, 14
  mov R2, [R3]
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_48497:
  jf R0, __if_48483_else
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
  jmp __if_48483_end
__if_48483_else:
  mov R1, [BP-14]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
__if_48483_end:
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
  jf R0, __LogicalAnd_ShortCircuit_48573
  mov R2, [BP-14]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_48573:
  jf R0, __LogicalAnd_ShortCircuit_48579
  mov R1, [BP-28]
  mov R3, [BP-6]
  iadd R3, 17
  mov R2, [R3]
  fmul R2, 0.500000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_48579:
  mov [BP-29], R0
__if_48585_start:
  mov R0, [BP-29]
  jf R0, __if_48585_else
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_48595_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_48595_end
  jmp __for_48363_continue
__if_48595_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  jmp __if_48585_end
__if_48585_else:
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
__if_48585_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_48363_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48363_start
__for_48363_end:
  mov R0, 0
  mov [BP-5], R0
__for_48623_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48623_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
__if_48639_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 24
  ine R0, 24
  jf R0, __if_48639_end
  jmp __for_48623_continue
__if_48639_end:
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
__for_48623_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48623_start
__for_48623_end:
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
__if_48810_start:
  mov R0, [BP-9]
  fgt R0, 0.000000
  jf R0, __if_48810_else
  mov R0, 1.000000
  mov R1, [BP-9]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  jmp __if_48810_end
__if_48810_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_48810_end:
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
__if_48853_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_48853_else
  mov R0, 1.000000
  mov R1, [BP-12]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  jmp __if_48853_end
__if_48853_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_48853_end:
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
__for_48948_start:
  mov R0, [BP-6]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48948_end
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
__if_48969_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_48969_end
  jmp __for_48948_continue
__if_48969_end:
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
__if_49054_start:
  mov R0, [BP-9]
  ieq R0, -1
  jt R0, __LogicalOr_ShortCircuit_49061
  mov R1, [BP-10]
  ieq R1, -1
  or R0, R1
__LogicalOr_ShortCircuit_49061:
  jf R0, __if_49054_else
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 3
  movs
  jmp __if_49054_end
__if_49054_else:
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 3
  movs
__if_49054_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
__if_49082_start:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __if_49082_end
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
__if_49082_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-17], R0
__if_49107_start:
  mov R0, [BP-10]
  ine R0, -1
  jf R0, __if_49107_end
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
__if_49107_end:
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
__if_49137_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_49137_end
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
__if_49137_end:
__if_49171_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_49171_end
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
__if_49171_end:
__for_48948_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_48948_start
__for_48948_end:
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
__for_49382_start:
  mov R0, [BP-11]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_49382_end
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
__if_49412_start:
  mov R0, [BP-13]
  ieq R0, -1
  jf R0, __if_49412_else
  lea R0, [BP-10]
  mov [BP-15], R0
  jmp __if_49412_end
__if_49412_else:
  mov R0, [BP-2]
  mov R1, [BP-13]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49412_end:
__if_49430_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_49430_else
  lea R0, [BP-10]
  mov [BP-16], R0
  jmp __if_49430_end
__if_49430_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49430_end:
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
__if_49479_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_49479_end
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
__if_49479_end:
__if_49510_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_49510_end
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
__if_49510_end:
__if_49541_start:
  mov R0, [BP-13]
  ine R0, -1
  jf R0, __if_49541_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_49541_end:
__if_49556_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_49556_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_49556_end:
__for_49382_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_49382_start
__for_49382_end:
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
__if_49695_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __if_49695_else
  mov R0, [BP-11]
  mov R1, [BP+12]
  fmul R0, R1
  mov [BP-12], R0
  jmp __if_49695_end
__if_49695_else:
__if_49705_start:
  mov R0, [BP+14]
  jf R0, __if_49705_end
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
__if_49705_end:
__if_49695_end:
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
__if_49815_start:
  mov R0, [BP-23]
  flt R0, 0.000000
  jf R0, __if_49815_end
  mov R0, 0.000000
  mov [BP-23], R0
__if_49815_end:
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
  iadd R1, 60
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
__for_50177_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50177_end
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
__if_50207_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50207_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50207_end
__if_50207_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50207_end:
__if_50225_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50225_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50225_end
__if_50225_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50225_end:
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
__if_50304_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50304_end
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
__if_50304_end:
__if_50345_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50345_end
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
__if_50345_end:
__if_50386_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_50386_end
__if_50391_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50391_end
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
__if_50391_end:
__if_50424_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50424_end
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
__if_50424_end:
__if_50386_end:
__if_50457_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50457_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50457_end:
__if_50472_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_50472_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_50472_end:
__for_50177_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50177_start
__for_50177_end:
__function_b2SolveContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitutionPoint:
  push BP
  mov BP, SP
  isub SP, 17
__if_50500_start:
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+5]
  fsgn R1
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_50508
  mov R2, [BP+2]
  iadd R2, 8
  mov R1, [R2]
  feq R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_50508:
  jf R0, __if_50500_end
  jmp __function_b2ApplyRestitutionPoint_return
__if_50500_end:
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
  iadd R1, 61
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
__for_50756_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50756_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
__if_50772_start:
  mov R1, [BP-13]
  iadd R1, 32
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_50772_end
  jmp __for_50756_continue
__if_50772_end:
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
__if_50792_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50792_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50792_end
__if_50792_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50792_end:
__if_50810_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50810_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50810_end
__if_50810_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50810_end:
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
__if_50846_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50846_end
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
__if_50846_end:
__if_50878_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50878_end
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
__if_50878_end:
__if_50910_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50910_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50910_end:
__if_50925_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_50925_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_50925_end:
__for_50756_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50756_start
__for_50756_end:
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
__for_50959_start:
  mov R0, [BP-3]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50959_end
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
__if_50983_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50983_end
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
__if_50983_end:
__if_51033_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_51033_end
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
__if_51033_end:
__for_50959_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_50959_start
__for_50959_end:
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
__if_51207_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51207_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_51207_end
__if_51207_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_51207_end:
__if_51223_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51223_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_51223_end
__if_51223_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_51223_end:
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
__if_51358_start:
  mov R0, [BP-30]
  fgt R0, 0.000000
  jf R0, __if_51358_else
  mov R0, 1.000000
  mov R1, [BP-30]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_51358_end
__if_51358_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_51358_end:
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
__if_51422_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51422_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51422_end
__if_51422_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51422_end:
__if_51442_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51442_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_51442_end
__if_51442_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51442_end:
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
__if_51549_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51549_end
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
__if_51549_end:
__if_51585_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51585_end
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
__if_51585_end:
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
__if_51665_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51665_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51665_end
__if_51665_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51665_end:
__if_51685_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51685_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_51685_end
__if_51685_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51685_end:
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
__if_51792_start:
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_51795
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 6
  mov R2, [R3]
  flt R1, R2
  jt R1, __LogicalOr_ShortCircuit_51804
  mov R3, [BP-14]
  iadd R3, 26
  mov R2, [R3]
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_51804:
  and R0, R1
__LogicalAnd_ShortCircuit_51795:
  jf R0, __if_51792_else
__if_51808_start:
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_51808_end
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
__if_51808_end:
__if_51982_start:
  mov R1, [BP-14]
  iadd R1, 27
  mov R0, [R1]
  jf R0, __if_51982_end
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
__if_51982_end:
__if_52129_start:
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  jf R0, __if_52129_end
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
__if_52199_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52199_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52199_end
__if_52199_else:
__if_52208_start:
  mov R0, [BP+6]
  jf R0, __if_52208_end
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
__if_52208_end:
__if_52199_end:
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
__if_52385_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52385_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52385_end
__if_52385_else:
__if_52394_start:
  mov R0, [BP+6]
  jf R0, __if_52394_end
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
__if_52394_end:
__if_52385_end:
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
__if_52129_end:
  jmp __if_51792_end
__if_51792_else:
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
__if_52572_start:
  mov R0, [BP+6]
  jf R0, __if_52572_end
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
__if_52572_end:
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
__if_51792_end:
__if_52672_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52672_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_52672_end:
__if_52688_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52688_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_52688_end:
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
  iadd R0, 23
  mov [BP-13], R0
__if_52806_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52806_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_52806_end
__if_52806_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_52806_end:
__if_52822_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52822_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_52822_end
__if_52822_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_52822_end:
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
__if_52925_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_52925_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_52925_end
__if_52925_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_52925_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_52989_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52989_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_52989_end
__if_52989_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_52989_end:
__if_53009_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53009_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53009_end
__if_53009_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53009_end:
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
__if_53064_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53064_end
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
__if_53064_end:
__if_53105_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53105_end
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
__if_53105_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_53190_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53190_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53190_end
__if_53190_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53190_end:
__if_53210_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53210_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53210_end
__if_53210_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53210_end:
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
__if_53285_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53288
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53288:
  jf R0, __if_53285_end
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
__if_53285_end:
__if_53365_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53368
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53368:
  jf R0, __if_53365_end
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
__if_53365_end:
__if_53429_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53432
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53432:
  jf R0, __if_53429_end
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
__if_53458_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_53458_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_53458_end
__if_53458_else:
__if_53467_start:
  mov R0, [BP+6]
  jf R0, __if_53467_end
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
__if_53467_end:
__if_53458_end:
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
__if_53556_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_53556_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_53556_end
__if_53556_else:
__if_53565_start:
  mov R0, [BP+6]
  jf R0, __if_53565_end
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
__if_53565_end:
__if_53556_end:
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
__if_53429_end:
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
__if_53714_start:
  mov R0, [BP+6]
  jf R0, __if_53714_end
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
__if_53714_end:
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
__if_53965_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53965_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_53965_end:
__if_53981_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53981_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_53981_end:
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
  iadd R0, 23
  mov [BP-13], R0
__if_54099_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54099_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_54099_end
__if_54099_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_54099_end:
__if_54115_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54115_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_54115_end
__if_54115_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_54115_end:
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
__if_54218_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_54218_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_54218_end
__if_54218_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_54218_end:
__if_54232_start:
  mov R1, [BP-13]
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54232_else
  mov R13, [BP-13]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54232_end
__if_54232_else:
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
__if_54232_end:
__if_54251_start:
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54251_else
  mov R13, [BP-13]
  iadd R13, 7
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54251_end
__if_54251_else:
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
__if_54251_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_54311_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54311_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54311_end
__if_54311_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54311_end:
__if_54331_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54331_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54331_end
__if_54331_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54331_end:
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
__if_54373_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54373_end
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
__if_54373_end:
__if_54415_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54415_end
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
__if_54415_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_54499_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54499_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54499_end
__if_54499_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54499_end:
__if_54519_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54519_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54519_end
__if_54519_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54519_end:
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
__if_54601_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_54603
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_54603:
  jf R0, __if_54601_end
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
__if_54601_end:
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
__if_54703_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_54705
  mov R2, [BP-14]
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_54705:
  jf R0, __if_54703_end
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
__if_54703_end:
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
__if_55002_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55002_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_55002_end:
__if_55018_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55018_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_55018_end:
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
  iadd R0, 23
  mov [BP-13], R0
__if_55136_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55136_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_55136_end
__if_55136_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_55136_end:
__if_55152_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55152_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_55152_end
__if_55152_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_55152_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_55330_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55330_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55330_end
__if_55330_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55330_end:
__if_55350_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55350_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55350_end
__if_55350_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55350_end:
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
__if_55555_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55555_end
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
__if_55555_end:
__if_55587_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55587_end
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
__if_55587_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_55663_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55663_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55663_end
__if_55663_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55663_end:
__if_55683_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55683_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55683_end
__if_55683_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55683_end:
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
__if_55871_start:
  mov R0, [BP-48]
  fgt R0, 0.000000
  jf R0, __if_55871_else
  mov R0, 1.000000
  mov R1, [BP-48]
  fdiv R0, R1
  mov [BP-49], R0
  jmp __if_55871_end
__if_55871_else:
  mov R0, 0.000000
  mov [BP-49], R0
__if_55871_end:
__if_55883_start:
  mov R1, [BP-14]
  iadd R1, 28
  mov R0, [R1]
  jf R0, __if_55883_end
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
__if_55883_end:
__if_56015_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __if_56015_end
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
__if_56015_end:
__if_56137_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_56137_end
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
__if_56158_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56158_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56172_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56172_else
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
  jmp __if_56172_end
__if_56172_else:
__if_56187_start:
  mov R0, [BP+6]
  jf R0, __if_56187_end
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
__if_56187_end:
__if_56172_end:
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
  jmp __if_56158_end
__if_56158_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 4
  mov [R1], R0
__if_56158_end:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-86], R0
__if_56333_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56333_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56347_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56347_else
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
  jmp __if_56347_end
__if_56347_else:
__if_56362_start:
  mov R0, [BP+6]
  jf R0, __if_56362_end
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
__if_56362_end:
__if_56347_end:
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
  jmp __if_56333_end
__if_56333_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 5
  mov [R1], R0
__if_56333_end:
__if_56137_end:
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
__if_56573_start:
  mov R0, [BP+6]
  jf R0, __if_56573_end
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
__if_56573_end:
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
__if_56641_start:
  mov R0, [BP-66]
  feq R0, 0.000000
  jf R0, __if_56641_end
  mov R0, 1.000000
  mov [BP-66], R0
__if_56641_end:
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
__if_56805_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56805_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_56805_end:
__if_56821_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56821_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_56821_end:
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
  iadd R0, 23
  mov [BP-13], R0
__if_56939_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_56939_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
  jmp __if_56939_end
__if_56939_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
__if_56939_end:
__if_56955_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_56955_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
  jmp __if_56955_end
__if_56955_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
__if_56955_end:
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
__if_57150_start:
  mov R0, [BP-36]
  fgt R0, 0.000000
  jf R0, __if_57150_else
  mov R0, 1.000000
  mov R1, [BP-36]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_57150_end
__if_57150_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_57150_end:
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
__if_57195_start:
  mov R0, [BP-39]
  fgt R0, 0.000000
  jf R0, __if_57195_else
  mov R0, 1.000000
  mov R1, [BP-39]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_57195_end
__if_57195_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_57195_end:
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
__if_57223_start:
  mov R0, [BP-40]
  fgt R0, 0.000000
  jf R0, __if_57223_else
  mov R0, 1.000000
  mov R1, [BP-40]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_57223_end
__if_57223_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_57223_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_57278_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57278_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57278_end
__if_57278_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57278_end:
__if_57298_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57298_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57298_end
__if_57298_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57298_end:
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
__if_57518_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57518_end
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
__if_57518_end:
__if_57550_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57550_end
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
__if_57550_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_57626_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57626_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57626_end
__if_57626_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57626_end:
__if_57646_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57646_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57646_end
__if_57646_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57646_end:
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
__if_57812_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_57815
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_57815:
  jf R0, __if_57812_end
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
__if_57812_end:
__if_57876_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_57876_end
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
__if_57876_end:
__if_58006_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __if_58006_end
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
__if_58026_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58026_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58026_end
__if_58026_else:
__if_58035_start:
  mov R0, [BP+6]
  jf R0, __if_58035_end
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
__if_58035_end:
__if_58026_end:
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
__if_58188_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58188_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58188_end
__if_58188_else:
__if_58197_start:
  mov R0, [BP+6]
  jf R0, __if_58197_end
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
__if_58197_end:
__if_58188_end:
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
__if_58006_end:
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
__if_58351_start:
  mov R0, [BP+6]
  jf R0, __if_58351_end
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
__if_58351_end:
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
__if_58498_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58498_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_58498_end:
__if_58514_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58514_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_58514_end:
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
  iadd R0, 23
  mov [BP-13], R0
__if_58632_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_58632_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_58632_end
__if_58632_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_58632_end:
__if_58648_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_58648_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_58648_end
__if_58648_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_58648_end:
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
__if_58860_start:
  mov R0, [BP-26]
  fgt R0, 0.000000
  jf R0, __if_58860_else
  mov R0, 1.000000
  mov R1, [BP-26]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
  jmp __if_58860_end
__if_58860_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
__if_58860_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_58915_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58915_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_58915_end
__if_58915_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_58915_end:
__if_58935_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58935_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_58935_end
__if_58935_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_58935_end:
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
__if_58995_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58995_end
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
__if_58995_end:
__if_59034_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59034_end
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
__if_59034_end:
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
  iadd R0, 23
  mov [BP-14], R0
__if_59115_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59115_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_59115_end
__if_59115_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_59115_end:
__if_59135_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59135_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59135_end
__if_59135_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59135_end:
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
__if_59169_start:
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59176
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59176:
  jf R0, __if_59169_end
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
__if_59169_end:
__if_59296_start:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59296_end
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
__if_59296_end:
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
__if_59381_start:
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59388
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59388:
  jf R0, __if_59381_end
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
__if_59652_start:
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
  jf R0, __if_59652_end
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
__if_59652_end:
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
__if_59381_end:
__if_59752_start:
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59752_end
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
__if_59865_start:
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
  jf R0, __if_59865_end
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
__if_59865_end:
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
__if_59752_end:
__if_59965_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59965_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_59965_end:
__if_59981_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59981_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_59981_end:
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
__for_60016_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60016_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
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
__if_60050_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60050_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareDistanceJoint
  jmp __if_60050_end
__if_60050_else:
__if_60059_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60059_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareRevoluteJoint
  jmp __if_60059_end
__if_60059_else:
__if_60068_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60068_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWeldJoint
  jmp __if_60068_end
__if_60068_else:
__if_60077_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60077_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PreparePrismaticJoint
  jmp __if_60077_end
__if_60077_else:
__if_60086_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60086_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWheelJoint
  jmp __if_60086_end
__if_60086_else:
__if_60095_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60095_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareMotorJoint
__if_60095_end:
__if_60086_end:
__if_60077_end:
__if_60068_end:
__if_60059_end:
__if_60050_end:
__for_60016_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60016_start
__for_60016_end:
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
__for_60121_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60121_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60139_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60139_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartDistanceJoint
  jmp __if_60139_end
__if_60139_else:
__if_60147_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60147_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartRevoluteJoint
  jmp __if_60147_end
__if_60147_else:
__if_60155_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60155_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWeldJoint
  jmp __if_60155_end
__if_60155_else:
__if_60163_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60163_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartPrismaticJoint
  jmp __if_60163_end
__if_60163_else:
__if_60171_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60171_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWheelJoint
  jmp __if_60171_end
__if_60171_else:
__if_60179_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60179_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartMotorJoint
__if_60179_end:
__if_60171_end:
__if_60163_end:
__if_60155_end:
__if_60147_end:
__if_60139_end:
__for_60121_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60121_start
__for_60121_end:
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
__for_60207_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60207_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60225_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60225_else
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
  jmp __if_60225_end
__if_60225_else:
__if_60236_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60236_else
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
  jmp __if_60236_end
__if_60236_else:
__if_60247_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60247_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2SolveWeldJoint
  jmp __if_60247_end
__if_60247_else:
__if_60256_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60256_else
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
  jmp __if_60256_end
__if_60256_else:
__if_60267_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60267_else
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
  jmp __if_60267_end
__if_60267_else:
__if_60278_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60278_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2SolveMotorJoint
__if_60278_end:
__if_60267_end:
__if_60256_end:
__if_60247_end:
__if_60236_end:
__if_60225_end:
__for_60207_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60207_start
__for_60207_end:
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
__if_60304_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_60304_end
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
__if_60304_end:
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
__for_60435_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60435_end
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
__if_60522_start:
  mov R0, [BP-10]
  mov R1, [BP-12]
  ine R0, R1
  jf R0, __if_60522_end
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
__if_60522_end:
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
__for_60435_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60435_start
__for_60435_end:
  mov R0, 0
  mov [BP-5], R0
__for_60554_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60554_end
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
__if_60631_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_60631_end
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
__if_60631_end:
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
__for_60554_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60554_start
__for_60554_end:
  mov R0, 0
  mov [BP-5], R0
__for_60681_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60681_end
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
  mov R2, 63
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
  imul R1, 63
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-9]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
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
__if_60758_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_60758_end
  mov R1, [BP-4]
  iadd R1, 9
  mov R13, [R1]
  mov R1, [BP-9]
  imul R1, 63
  iadd R13, R1
  mov R1, [BP-4]
  iadd R1, 9
  mov R12, [R1]
  mov R1, [BP-11]
  imul R1, 63
  iadd R12, R1
  mov CR, 63
  movs
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  mov R3, [BP-4]
  iadd R3, 9
  mov R2, [R3]
  mov R3, [BP-9]
  imul R3, 63
  iadd R2, R3
  mov R1, [R2]
  imul R1, 17
  iadd R0, R1
  mov [BP-12], R0
  mov R0, [BP-9]
  mov R1, [BP-12]
  iadd R1, 3
  mov [R1], R0
__if_60758_end:
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
__for_60681_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60681_start
__for_60681_end:
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
__if_60856_start:
  mov R0, [BP-6]
  mov R1, [BP-7]
  ine R0, R1
  jf R0, __if_60856_end
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
__if_60856_end:
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
__if_60905_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_60905_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_60905_end:
__function_b2TrySleepIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSleep:
  push BP
  mov BP, SP
  isub SP, 9
__if_60950_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60950_end
  jmp __function_b2UpdateSleep_return
__if_60950_end:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
__while_60967_start:
__while_60967_continue:
  mov R0, [BP-1]
  ige R0, 0
  jf R0, __while_60967_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
__if_60980_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_60980_end
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_60967_continue
__if_60980_end:
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
__for_61020_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61020_end
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
__if_61042_start:
  mov R1, [BP-7]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_61042_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61020_end
__if_61042_end:
__if_61052_start:
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  flt R0, 0.500000
  jf R0, __if_61052_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61020_end
__if_61052_end:
__for_61020_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_61020_start
__for_61020_end:
__if_61062_start:
  mov R0, [BP-5]
  jf R0, __if_61062_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2TrySleepIsland
__if_61062_end:
  mov R0, [BP-1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_60967_start
__while_60967_end:
__function_b2UpdateSleep_return:
  mov SP, BP
  pop BP
  ret

__function_b2ReportHitEvents:
  push BP
  mov BP, SP
  isub SP, 26
  mov R1, [BP+2]
  iadd R1, 62
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
__for_61093_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_61093_end
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 49
  iadd R0, R1
  mov [BP-5], R0
__if_61111_start:
  mov R1, [BP-5]
  iadd R1, 41
  mov R0, [R1]
  and R0, 1048576
  ieq R0, 0
  jf R0, __if_61111_end
  jmp __for_61093_continue
__if_61111_end:
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, -1
  mov [BP-7], R0
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_61132_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_61132_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61146_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61156
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61156:
  jf R0, __if_61146_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__if_61146_end:
__if_61132_end:
__if_61166_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_61166_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61180_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61190
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 12
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61190:
  jf R0, __if_61180_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-7], R0
__if_61180_end:
__if_61166_end:
__if_61200_start:
  mov R0, [BP-7]
  ieq R0, -1
  jf R0, __if_61200_end
  jmp __for_61093_continue
__if_61200_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 3
  mov R1, [R2]
  imul R1, 87
  iadd R0, R1
  mov [BP-9], R0
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R2, [BP-5]
  iadd R2, 4
  mov R1, [R2]
  imul R1, 87
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
__if_61246_start:
  mov R1, [BP-11]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_61253
  mov R2, [BP-12]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_61253:
  jf R0, __if_61246_else
__if_61257_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61257_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_61257_end
__if_61257_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  iadd R12, 2
  mov CR, 2
  movs
__if_61257_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
  jmp __if_61246_end
__if_61246_else:
__if_61288_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61288_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  mov CR, 2
  movs
  jmp __if_61288_end
__if_61288_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  mov CR, 2
  movs
__if_61288_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
__if_61246_end:
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
  iadd R1, 73
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  call __function_b2AddHitEvent
__for_61093_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_61093_start
__for_61093_end:
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
__if_61370_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_61370_end
  mov R0, 1
  mov [BP+4], R0
__if_61370_end:
  mov R0, [BP+3]
  mov R1, [BP+4]
  cif R1
  fdiv R0, R1
  mov [BP-3], R0
__if_61384_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_61384_else
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
  jmp __if_61384_end
__if_61384_else:
  mov R0, 0.000000
  mov [BP-4], R0
__if_61384_end:
  mov R0, [BP-4]
  mov R1, [BP+2]
  iadd R1, 55
  mov [R1], R0
__if_61402_start:
  mov R0, [BP+3]
  fgt R0, 0.000000
  jf R0, __if_61402_else
  mov R0, 1.000000
  mov R1, [BP+3]
  fdiv R0, R1
  mov [BP-5], R0
  jmp __if_61402_end
__if_61402_else:
  mov R0, 0.000000
  mov [BP-5], R0
__if_61402_end:
  mov R1, [BP+2]
  iadd R1, 63
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP-5]
  fmul R0, 0.785398
  mov [BP-7], R0
  mov R2, [BP+2]
  iadd R2, 58
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
  iadd R2, 59
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
  iadd R2, 59
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
__if_61460_start:
  mov R0, [BP-2]
  igt R0, 0
  jf R0, __if_61460_end
__if_61465_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_61465_end
__if_61471_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_61471_end
  mov R2, [BP+2]
  iadd R2, 65
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  imul R1, 38
  mov [SP+1], R1
  call __function_b2Free
__if_61471_end:
  mov R2, [BP-2]
  imul R2, 38
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov R2, [BP+2]
  iadd R2, 65
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 66
  mov [R1], R0
__if_61465_end:
  mov R1, [BP+2]
  iadd R1, 65
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
__if_61460_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_b2PrepareJoints
  mov R0, 0
  mov [BP-17], R0
__for_61513_start:
  mov R0, [BP-17]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_61513_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2IntegrateVelocities
__if_61526_start:
  mov R1, [BP+2]
  iadd R1, 53
  mov R0, [R1]
  jf R0, __if_61526_end
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
__if_61526_end:
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
__for_61513_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_61513_start
__for_61513_end:
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
__if_61577_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  jf R0, __if_61577_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSplitIsland
__if_61583_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_61583_end
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
__if_61583_end:
__if_61577_end:
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
__if_61607_start:
  mov R0, [BP+3]
  fle R0, 0.000000
  jf R0, __if_61607_end
  jmp __function_b2World_Step_return
__if_61607_end:
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
  mov R0, 0
  mov R1, [BP+2]
  iadd R1, 79
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

__function_vb2_Init:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2CreateWorld
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  mov R1, 20.000000
  mov [SP+2], R1
  call __function_vb2_SetCamera
__function_vb2_Init_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_EnableSleep:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  call __function_b2World_EnableSleeping
__function_vb2_EnableSleep_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_Step:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, 0.016667
  mov [SP+1], R1
  mov R1, 4
  mov [SP+2], R1
  call __function_b2World_Step
__function_vb2_Step_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_PackHandle:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+3]
  and R0, 32767
  shl R0, 16
  mov R1, [BP+2]
  and R1, 65535
  or R0, R1
__function_vb2_PackHandle_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_ResolveBody:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
__if_61904_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_61904_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61904_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_61923_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_61928
  mov R1, [BP-1]
  mov R2, [22]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_61928:
  jf R0, __if_61923_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61923_end:
  mov R0, [21]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
__if_61945_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_61945_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61945_end:
__if_61954_start:
  mov R1, [BP-3]
  iadd R1, 20
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_61954_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61954_end:
  mov R0, [BP-1]
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [81]
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 20
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 1
__function_vb2_ResolveBody_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_ResolveShape:
  push BP
  mov BP, SP
  isub SP, 4
  push R1
  push R2
  isub SP, 3
__if_62001_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62001_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62001_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-4], R0
__if_62017_start:
  mov R1, [BP-4]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_62017_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62017_end:
  mov R1, global_vb2_world
  mov [SP], R1
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2MakeShapeId
  mov R0, 1
__function_vb2_ResolveShape_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_MakeBox:
  push BP
  mov BP, SP
  isub SP, 76
  push R1
  isub SP, 5
  lea R1, [BP-22]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, [BP+6]
  mov [BP-22], R0
  mov R0, [BP+2]
  mov [BP-21], R0
  mov R0, [BP+3]
  mov [BP-20], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  lea R1, [BP-61]
  mov [SP+2], R1
  call __function_b2MakeBox
  lea R1, [BP-73]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-73]
  mov [SP+2], R1
  lea R1, [BP-61]
  mov [SP+3], R1
  lea R1, [BP-76]
  mov [SP+4], R1
  call __function_b2CreatePolygonShape
  mov R1, [BP-25]
  mov [SP], R1
  mov R1, [BP-23]
  mov [SP+1], R1
  call __function_vb2_PackHandle
__function_vb2_MakeBox_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_Wall:
  push BP
  mov BP, SP
  push R1
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, 0
  mov [SP+4], R1
  call __function_vb2_MakeBox
__function_vb2_Wall_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_Box:
  push BP
  mov BP, SP
  push R1
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  mov R1, [BP+5]
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_vb2_MakeBox
__function_vb2_Box_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_Ball:
  push BP
  mov BP, SP
  isub SP, 43
  push R1
  isub SP, 5
  lea R1, [BP-22]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, 2
  mov [BP-22], R0
  mov R0, [BP+2]
  mov [BP-21], R0
  mov R0, [BP+3]
  mov [BP-20], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R0, 0.000000
  mov [BP-28], R0
  mov R0, 0.000000
  mov [BP-27], R0
  mov R0, [BP+4]
  mov [BP-26], R0
  lea R1, [BP-40]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-40]
  mov [SP+2], R1
  lea R1, [BP-28]
  mov [SP+3], R1
  lea R1, [BP-43]
  mov [SP+4], R1
  call __function_b2CreateCircleShape
  mov R1, [BP-25]
  mov [SP], R1
  mov R1, [BP-23]
  mov [SP+1], R1
  call __function_vb2_PackHandle
__function_vb2_Ball_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_Line:
  push BP
  mov BP, SP
  isub SP, 44
  push R1
  isub SP, 5
  lea R1, [BP-22]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, 0
  mov [BP-22], R0
  mov R0, 0.000000
  mov [BP-21], R0
  mov R0, 0.000000
  mov [BP-20], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  lea R1, [BP-25]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R0, [BP+2]
  mov [BP-29], R0
  mov R0, [BP+3]
  mov [BP-28], R0
  mov R0, [BP+4]
  mov [BP-27], R0
  mov R0, [BP+5]
  mov [BP-26], R0
  lea R1, [BP-41]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-41]
  mov [SP+2], R1
  lea R1, [BP-29]
  mov [SP+3], R1
  lea R1, [BP-44]
  mov [SP+4], R1
  call __function_b2CreateSegmentShape
  mov R1, [BP-25]
  mov [SP], R1
  mov R1, [BP-23]
  mov [SP+1], R1
  call __function_vb2_PackHandle
__function_vb2_Line_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_GetX:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62295_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62295_end
  mov R0, 0.000000
  jmp __function_vb2_GetX_return
__if_62295_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetPosition
  mov R0, [BP-5]
__function_vb2_GetX_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_GetY:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62320_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62320_end
  mov R0, 0.000000
  jmp __function_vb2_GetY_return
__if_62320_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetPosition
  mov R0, [BP-4]
__function_vb2_GetY_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_ApplyImpulse:
  push BP
  mov BP, SP
  isub SP, 9
__if_62590_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62590_end
  jmp __function_vb2_ApplyImpulse_return
__if_62590_end:
  mov R0, [BP+3]
  mov [BP-5], R0
  mov R0, [BP+4]
  mov [BP-4], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  mov R1, 1
  mov [SP+3], R1
  call __function_b2Body_ApplyLinearImpulseToCenter
__function_vb2_ApplyImpulse_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_ApplyTorque:
  push BP
  mov BP, SP
  isub SP, 7
__if_62653_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62653_end
  jmp __function_vb2_ApplyTorque_return
__if_62653_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, 1
  mov [SP+3], R1
  call __function_b2Body_ApplyTorque
__function_vb2_ApplyTorque_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetFriction:
  push BP
  mov BP, SP
  isub SP, 6
__if_62709_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62709_end
  jmp __function_vb2_SetFriction_return
__if_62709_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2Shape_SetFriction
__function_vb2_SetFriction_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetBounce:
  push BP
  mov BP, SP
  isub SP, 6
__if_62728_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62728_end
  jmp __function_vb2_SetBounce_return
__if_62728_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2Shape_SetRestitution
__function_vb2_SetBounce_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetCamera:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  mov [global_vb2_camX], R0
  mov R0, [BP+3]
  mov [global_vb2_camY], R0
  mov R0, [BP+4]
  mov [global_vb2_camPPM], R0
__function_vb2_SetCamera_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_ScreenX:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [global_vb2_camX]
  fsub R0, R1
  mov R1, [global_vb2_camPPM]
  fmul R0, R1
  fadd R0, 320.000000
  cfi R0
__function_vb2_ScreenX_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_ScreenY:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [global_vb2_camY]
  fsub R0, R1
  mov R1, [global_vb2_camPPM]
  fmul R0, R1
  fsgn R0
  fadd R0, 180.000000
  cfi R0
__function_vb2_ScreenY_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_BodyOfShape:
  push BP
  mov BP, SP
  isub SP, 6
  push R1
  isub SP, 3
__if_62839_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_62839_end
  mov R0, -1
  jmp __function_vb2_BodyOfShape_return
__if_62839_end:
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2MakeShapeId
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2Shape_GetBody
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_vb2_PackHandle
__function_vb2_BodyOfShape_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_RayCast:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  isub SP, 5
  mov R0, [BP+2]
  mov [BP-2], R0
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+4]
  mov R1, [BP+2]
  fsub R0, R1
  mov [BP-4], R0
  mov R0, [BP+5]
  mov R1, [BP+3]
  fsub R0, R1
  mov [BP-3], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  mov R1, -1
  mov [SP+3], R1
  mov R1, global_vb2_lastHit
  mov [SP+4], R1
  call __function_b2World_CastRayClosest
  mov [BP-5], R0
  mov R1, [BP-5]
  mov [SP], R1
  call __function_vb2_BodyOfShape
__function_vb2_RayCast_return:
  iadd SP, 5
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_HitX:
  push BP
  mov BP, SP
  mov R0, [106]
__function_vb2_HitX_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_HitY:
  push BP
  mov BP, SP
  mov R0, [107]
__function_vb2_HitY_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_PointPickCallback:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  isub SP, 3
__if_62943_start:
  mov R0, [global_vb2_pickShape]
  ine R0, -1
  jf R0, __if_62943_end
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_62943_end:
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  lea R1, [BP-3]
  mov [SP+2], R1
  call __function_b2MakeShapeId
  mov R0, [global_vb2_pickX]
  mov [BP-5], R0
  mov R0, [global_vb2_pickY]
  mov [BP-4], R0
__if_62969_start:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Shape_TestPoint
  jf R0, __if_62969_end
  mov R0, [BP+3]
  mov [global_vb2_pickShape], R0
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_62969_end:
  mov R0, 1
__function_vb2_PointPickCallback_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_TouchCount:
  push BP
  mov BP, SP
  push R1
  isub SP, 1
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2World_GetBeginTouchEventCount
__function_vb2_TouchCount_return:
  iadd SP, 1
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_TouchA:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  push R4
  isub SP, 1
__if_63044_start:
  mov R1, [BP+2]
  ilt R1, 0
  jt R1, __LogicalOr_ShortCircuit_63049
  mov R2, [BP+2]
  mov R4, global_vb2_world
  mov [SP], R4
  call __function_b2World_GetBeginTouchEventCount
  mov R3, R0
  ige R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_63049:
  mov R0, R1
  jf R0, __if_63044_end
  mov R0, -1
  jmp __function_vb2_TouchA_return
__if_63044_end:
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2World_GetBeginTouchEvents
  mov [BP-1], R0
  mov R2, [BP-1]
  mov R3, [BP+2]
  imul R3, 2
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_BodyOfShape
__function_vb2_TouchA_return:
  iadd SP, 1
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_TouchB:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
  push R4
  isub SP, 1
__if_63070_start:
  mov R1, [BP+2]
  ilt R1, 0
  jt R1, __LogicalOr_ShortCircuit_63075
  mov R2, [BP+2]
  mov R4, global_vb2_world
  mov [SP], R4
  call __function_b2World_GetBeginTouchEventCount
  mov R3, R0
  ige R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_63075:
  mov R0, R1
  jf R0, __if_63070_end
  mov R0, -1
  jmp __function_vb2_TouchB_return
__if_63070_end:
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2World_GetBeginTouchEvents
  mov [BP-1], R0
  mov R2, [BP-1]
  mov R3, [BP+2]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_BodyOfShape
__function_vb2_TouchB_return:
  iadd SP, 1
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_ResolveJoint:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
__if_63097_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_63097_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63097_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_63116_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_63121
  mov R1, [BP-1]
  mov R2, [58]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_63121:
  jf R0, __if_63116_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63116_end:
  mov R0, [57]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 17
  iadd R0, R1
  mov [BP-3], R0
__if_63138_start:
  mov R1, [BP-3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_63138_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63138_end:
__if_63147_start:
  mov R1, [BP-3]
  iadd R1, 15
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_63147_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63147_end:
  mov R0, [BP-1]
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [81]
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 1
__function_vb2_ResolveJoint_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 58
  call __function_vb2_Init
  mov R1, 1
  mov [SP], R1
  call __function_vb2_EnableSleep
  mov R1, 0.000000
  mov [SP], R1
  mov R1, -3.000000
  mov [SP+1], R1
  mov R1, 20.000000
  mov [SP+2], R1
  call __function_vb2_SetCamera
  mov R1, 0.000000
  mov [SP], R1
  mov R1, -8.000000
  mov [SP+1], R1
  mov R1, 15.500000
  mov [SP+2], R1
  mov R1, 0.500000
  mov [SP+3], R1
  call __function_vb2_Wall
  mov R1, -15.500000
  mov [SP], R1
  mov R1, -3.000000
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, 5.000000
  mov [SP+3], R1
  call __function_vb2_Wall
  mov R1, 15.500000
  mov [SP], R1
  mov R1, -3.000000
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  mov R1, 5.000000
  mov [SP+3], R1
  call __function_vb2_Wall
  mov R1, -9.000000
  mov [SP], R1
  mov R1, -7.500000
  mov [SP+1], R1
  mov R1, -2.000000
  mov [SP+2], R1
  mov R1, -4.500000
  mov [SP+3], R1
  call __function_vb2_Line
  mov R1, -12.000000
  mov [SP], R1
  mov R1, -6.000000
  mov [SP+1], R1
  mov R1, 0.600000
  mov [SP+2], R1
  call __function_vb2_Ball
  mov [BP-1], R0
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, 0.900000
  mov [SP+1], R1
  call __function_vb2_SetFriction
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, 0.200000
  mov [SP+1], R1
  call __function_vb2_SetBounce
  mov R0, 0
  mov [BP-26], R0
  mov R0, 0
  mov [BP-27], R0
__for_63535_start:
  mov R0, [BP-27]
  ilt R0, 5
  jf R0, __for_63535_end
  mov R2, 7.000000
  mov [SP], R2
  mov R2, [BP-27]
  cif R2
  fmul R2, 1.100000
  fadd R2, -7.000000
  mov [SP+1], R2
  mov R2, 0.500000
  mov [SP+2], R2
  mov R2, 0.500000
  mov [SP+3], R2
  call __function_vb2_Box
  mov R1, R0
  lea R2, [BP-25]
  mov R3, [BP-26]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-26]
  iadd R0, 1
  mov [BP-26], R0
__for_63535_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_63535_start
__for_63535_end:
  mov R1, 0
  mov [SP], R1
  call __function_select_gamepad
__while_63568_start:
__while_63568_continue:
  mov R0, 1
  jf R0, __while_63568_end
  mov R1, [BP-1]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-28], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-29], R0
  call __function_get_frame_counter
  mov R1, R0
  cif R1
  fmul R1, 0.020000
  mov R0, R1
  mov [BP-30], R0
  mov R1, [BP-28]
  mov R3, [BP-30]
  mov [SP], R3
  call __function_cos
  mov R2, R0
  fmul R2, 6.000000
  fadd R1, R2
  mov R0, R1
  mov [BP-31], R0
  mov R1, [BP-29]
  mov R3, [BP-30]
  mov [SP], R3
  call __function_sin
  mov R2, R0
  fmul R2, 6.000000
  fadd R1, R2
  mov R0, R1
  mov [BP-32], R0
__if_63600_start:
  mov R0, [BP-32]
  flt R0, -6.900000
  jf R0, __if_63600_end
  mov R0, -6.900000
  mov [BP-32], R0
__if_63600_end:
__if_63613_start:
  mov R0, [BP-31]
  flt R0, -14.400000
  jf R0, __if_63613_end
  mov R0, -14.400000
  mov [BP-31], R0
__if_63613_end:
__if_63626_start:
  mov R0, [BP-31]
  fgt R0, 14.400000
  jf R0, __if_63626_end
  mov R0, 14.400000
  mov [BP-31], R0
__if_63626_end:
  mov R0, [BP-31]
  mov R1, [BP-28]
  fsub R0, R1
  mov [BP-33], R0
  mov R0, [BP-32]
  mov R1, [BP-29]
  fsub R0, R1
  mov [BP-34], R0
  mov R1, [BP-33]
  mov R2, [BP-33]
  fmul R1, R2
  mov R2, [BP-34]
  mov R3, [BP-34]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-35], R0
__if_63657_start:
  mov R0, [BP-35]
  flt R0, 0.001000
  jf R0, __if_63657_end
  mov R0, 1.000000
  mov [BP-35], R0
__if_63657_end:
  mov R0, [BP-33]
  mov R1, [BP-35]
  fdiv R0, R1
  mov [BP-33], R0
  mov R0, [BP-34]
  mov R1, [BP-35]
  fdiv R0, R1
  mov [BP-34], R0
  mov R1, [BP-28]
  mov [SP], R1
  mov R1, [BP-29]
  fsub R1, 0.600000
  fsub R1, 0.020000
  mov [SP+1], R1
  mov R1, [BP-28]
  mov [SP+2], R1
  mov R1, [BP-29]
  fsub R1, 0.600000
  fsub R1, 0.150000
  mov [SP+3], R1
  call __function_vb2_RayCast
  mov [BP-36], R0
  mov R0, [BP-36]
  ine R0, -1
  mov [BP-37], R0
__if_63696_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_63696_end
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, 6.000000
  mov [SP+1], R1
  call __function_vb2_ApplyTorque
__if_63696_end:
__if_63703_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_63703_end
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, -6.000000
  mov [SP+1], R1
  call __function_vb2_ApplyTorque
__if_63703_end:
__if_63711_start:
  call __function_gamepad_button_a
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_63716
  mov R2, [BP-37]
  and R1, R2
__LogicalAnd_ShortCircuit_63716:
  mov R0, R1
  jf R0, __if_63711_end
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  mov R1, 5.000000
  mov [SP+2], R1
  call __function_vb2_ApplyImpulse
__if_63711_end:
__if_63721_start:
  call __function_gamepad_button_b
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_63726
  mov R2, [BP-26]
  ilt R2, 24
  and R1, R2
__LogicalAnd_ShortCircuit_63726:
  mov R0, R1
  jf R0, __if_63721_end
  mov R2, [BP-31]
  mov [SP], R2
  mov R2, [BP-32]
  mov [SP+1], R2
  mov R2, 0.400000
  mov [SP+2], R2
  mov R2, 0.400000
  mov [SP+3], R2
  call __function_vb2_Box
  mov R1, R0
  lea R2, [BP-25]
  mov R3, [BP-26]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, [BP-26]
  iadd R0, 1
  mov [BP-26], R0
__if_63721_end:
  call __function_gamepad_button_start
  mov R1, R0
  igt R1, 0
  mov R0, R1
  mov [BP-38], R0
  mov R0, [BP-31]
  mov [BP-39], R0
  mov R0, [BP-32]
  mov [BP-40], R0
  mov R0, [BP-28]
  mov R1, [BP-33]
  fmul R1, 0.650000
  fadd R0, R1
  mov [BP-41], R0
  mov R0, [BP-29]
  mov R1, [BP-34]
  fmul R1, 0.650000
  fadd R0, R1
  mov [BP-42], R0
  mov R0, -1
  mov [BP-43], R0
__if_63780_start:
  mov R0, [BP-38]
  jf R0, __if_63780_end
  mov R2, [BP-41]
  mov [SP], R2
  mov R2, [BP-42]
  mov [SP+1], R2
  mov R2, [BP-31]
  mov [SP+2], R2
  mov R2, [BP-32]
  mov [SP+3], R2
  call __function_vb2_RayCast
  mov R1, R0
  mov [BP-43], R1
  mov R0, R1
__if_63790_start:
  mov R0, [BP-43]
  ine R0, -1
  jf R0, __if_63790_end
  call __function_vb2_HitX
  mov R1, R0
  mov [BP-39], R1
  mov R0, R1
  call __function_vb2_HitY
  mov R1, R0
  mov [BP-40], R1
  mov R0, R1
__if_63790_end:
__if_63780_end:
  call __function_vb2_Step
  mov R0, 0
  mov [BP-44], R0
  mov R0, 0
  mov [BP-45], R0
__for_63808_start:
  mov R1, [BP-45]
  call __function_vb2_TouchCount
  mov R2, R0
  ilt R1, R2
  mov R0, R1
  jf R0, __for_63808_end
__if_63818_start:
  mov R2, [BP-45]
  mov [SP], R2
  call __function_vb2_TouchA
  mov R1, R0
  mov R2, [BP-1]
  ieq R1, R2
  jt R1, __LogicalOr_ShortCircuit_63825
  mov R3, [BP-45]
  mov [SP], R3
  call __function_vb2_TouchB
  mov R2, R0
  mov R3, [BP-1]
  ieq R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_63825:
  mov R0, R1
  jf R0, __if_63818_end
  mov R0, [BP-44]
  iadd R0, 1
  mov [BP-44], R0
__if_63818_end:
__for_63808_continue:
  mov R0, [BP-45]
  mov R1, R0
  iadd R1, 1
  mov [BP-45], R1
  jmp __for_63808_start
__for_63808_end:
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 10
  mov [SP], R1
  mov R1, 8
  mov [SP+1], R1
  mov R1, __literal_string_63840
  mov [SP+2], R1
  call __function_print_at
  mov R1, 10
  mov [SP], R1
  mov R1, 22
  mov [SP+1], R1
  mov R1, __literal_string_63844
  mov [SP+2], R1
  call __function_print_at
__if_63845_start:
  mov R0, [BP-37]
  jf R0, __if_63845_end
  mov R1, 500
  mov [SP], R1
  mov R1, 8
  mov [SP+1], R1
  mov R1, __literal_string_63850
  mov [SP+2], R1
  call __function_print_at
__if_63845_end:
__if_63851_start:
  mov R0, [BP-44]
  igt R0, 0
  jf R0, __if_63851_end
  mov R1, 500
  mov [SP], R1
  mov R1, 22
  mov [SP+1], R1
  mov R1, __literal_string_63858
  mov [SP+2], R1
  call __function_print_at
__if_63851_end:
  mov R0, -15.000000
  mov [BP-46], R0
__for_63861_start:
  mov R0, [BP-46]
  fle R0, 15.000000
  jf R0, __for_63861_end
  mov R2, -7.500000
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-53], R1
  mov R2, [BP-46]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_63880
  mov [SP+2], R1
  call __function_print_at
__for_63861_continue:
  mov R0, [BP-46]
  fadd R0, 0.500000
  mov [BP-46], R0
  jmp __for_63861_start
__for_63861_end:
  mov R0, -7.500000
  mov [BP-47], R0
__for_63883_start:
  mov R0, [BP-47]
  fle R0, 2.000000
  jf R0, __for_63883_end
  mov R2, [BP-47]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-53], R1
  mov R2, -15.000000
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_63903
  mov [SP+2], R1
  call __function_print_at
  mov R2, [BP-47]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-53], R1
  mov R2, 15.000000
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_63909
  mov [SP+2], R1
  call __function_print_at
__for_63883_continue:
  mov R0, [BP-47]
  fadd R0, 0.500000
  mov [BP-47], R0
  jmp __for_63883_start
__for_63883_end:
  mov R0, 0.000000
  mov [BP-48], R0
__for_63912_start:
  mov R0, [BP-48]
  fle R0, 1.000000
  jf R0, __for_63912_end
  mov R0, [BP-48]
  fmul R0, 7.000000
  fadd R0, -9.000000
  mov [BP-50], R0
  mov R0, [BP-48]
  fmul R0, 3.000000
  fadd R0, -7.500000
  mov [BP-51], R0
  mov R2, [BP-51]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R2, [BP-50]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_63960
  mov [SP+2], R1
  call __function_print_at
__for_63912_continue:
  mov R0, [BP-48]
  fadd R0, 0.040000
  mov [BP-48], R0
  jmp __for_63912_start
__for_63912_end:
  mov R2, [BP-32]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R2, [BP-31]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_63970
  mov [SP+2], R1
  call __function_print_at
__if_63971_start:
  mov R0, [BP-38]
  jf R0, __if_63971_end
  mov R0, 0.000000
  mov [BP-50], R0
__for_63976_start:
  mov R0, [BP-50]
  fle R0, 1.000000
  jf R0, __for_63976_end
  mov R0, [BP-41]
  mov R1, [BP-39]
  mov R2, [BP-41]
  fsub R1, R2
  mov R2, [BP-50]
  fmul R1, R2
  fadd R0, R1
  mov [BP-51], R0
  mov R0, [BP-42]
  mov R1, [BP-40]
  mov R2, [BP-42]
  fsub R1, R2
  mov R2, [BP-50]
  fmul R1, R2
  fadd R0, R1
  mov [BP-52], R0
  mov R2, [BP-52]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R2, [BP-51]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_64018
  mov [SP+2], R1
  call __function_print_at
__for_63976_continue:
  mov R0, [BP-50]
  fadd R0, 0.040000
  mov [BP-50], R0
  jmp __for_63976_start
__for_63976_end:
__if_64019_start:
  mov R0, [BP-43]
  ine R0, -1
  jf R0, __if_64019_end
  mov R2, [BP-40]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R2, [BP-39]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_64033
  mov [SP+2], R1
  call __function_print_at
__if_64019_end:
__if_63971_end:
  mov R0, 0
  mov [BP-49], R0
__for_64036_start:
  mov R0, [BP-49]
  mov R1, [BP-26]
  ilt R0, R1
  jf R0, __for_64036_end
  lea R0, [BP-25]
  mov R1, [BP-49]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-50], R0
  mov R3, [BP-50]
  mov [SP], R3
  call __function_vb2_GetY
  mov R2, R0
  mov [BP-53], R2
  mov R2, [BP-53]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R3, [BP-50]
  mov [SP], R3
  call __function_vb2_GetX
  mov R2, R0
  mov [BP-54], R2
  mov R2, [BP-54]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 8
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_64062
  mov [SP+2], R1
  call __function_print_at
__for_64036_continue:
  mov R0, [BP-49]
  mov R1, R0
  iadd R1, 1
  mov [BP-49], R1
  jmp __for_64036_start
__for_64036_end:
  mov R2, [BP-29]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-53], R1
  mov R2, [BP-28]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-54], R1
  mov R1, [BP-54]
  mov [SP], R1
  mov R1, [BP-53]
  mov [SP+1], R1
  mov R1, __literal_string_64072
  mov [SP+2], R1
  call __function_print_at
  call __function_end_frame
  jmp __while_63568_start
__while_63568_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_1203:
  string "0123456789ABCDEF"
__literal_string_1240:
  string "-2147483648"
__literal_string_63840:
  string "VIRCONBOX2D TEMPLATE"
__literal_string_63844:
  string "DPAD ROLL   A JUMP   B CRATE   START LASER"
__literal_string_63850:
  string "GROUNDED"
__literal_string_63858:
  string "BUMP!"
__literal_string_63880:
  string "="
__literal_string_63903:
  string "|"
__literal_string_63909:
  string "|"
__literal_string_63960:
  string "/"
__literal_string_63970:
  string "+"
__literal_string_64018:
  string "."
__literal_string_64033:
  string "X"
__literal_string_64062:
  string "[]"
__literal_string_64072:
  string "O"
