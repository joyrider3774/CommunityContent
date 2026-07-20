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
  %define global_BlockBody 114
  %define global_BlockHW 126
  %define global_BlockHH 138
  %define global_BlockRegion 150
  %define global_BlockCount 162
  %define global_PigBody 163
  %define global_PoofX 166
  %define global_PoofY 169
  %define global_PoofFrames 172
  %define global_PigCount 175
  %define global_Bird 176
  %define global_BirdsLeft 177
  %define global_Score 178
  %define global_GameState 179
  %define global_AimOX 180
  %define global_AimOY 181
  %define global_FlyFrames 182
  %define global_SlowFrames 183

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

__function_make_color_rgb:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+4]
  shl R0, 16
  or R0, -16777216
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgb_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_make_color_rgba:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+5]
  shl R0, 24
  mov R1, [BP+4]
  shl R1, 16
  or R0, R1
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgba_return:
  pop R1
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

__function_define_region_topleft:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  out GPU_RegionHotSpotY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
__function_define_region_topleft_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_center:
  push BP
  mov BP, SP
  isub SP, 2
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R0, R1
  idiv R0, 2
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+5]
  iadd R0, R1
  idiv R0, 2
  mov [BP-2], R0
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP-1]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP-2]
  out GPU_RegionHotSpotY, R0
__function_define_region_center_return:
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

__function_set_drawing_scale:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingScaleX, R0
  mov R0, [BP+3]
  out GPU_DrawingScaleY, R0
__function_set_drawing_scale_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_angle:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingAngle, R0
__function_set_drawing_angle_return:
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

__function_draw_region_zoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionZoomed
__function_draw_region_zoomed_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotozoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionRotozoomed
__function_draw_region_rotozoomed_at_return:
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

__function_ceil:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  ceil R0
__function_ceil_return:
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

__function_draw_horizontal_line:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, [BP+4]
  mov R2, [BP+2]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_horizontal_line_return:
  mov SP, BP
  pop BP
  ret

__function_draw_line:
  push BP
  mov BP, SP
  isub SP, 6
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
__if_1467_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_1472
  mov R1, [BP+3]
  mov R2, [BP+5]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1472:
  jf R0, __if_1467_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __function_draw_line_return
__if_1467_end:
  mov R0, [BP+4]
  mov R1, [BP+2]
  isub R0, R1
  mov [BP-1], R0
  mov R0, [BP+5]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-2], R0
  mov R2, [BP-1]
  mov R3, [BP-1]
  imul R2, R3
  mov R3, [BP-2]
  mov R4, [BP-2]
  imul R3, R4
  iadd R2, R3
  cif R2
  mov [SP], R2
  call __function_sqrt
  mov R1, R0
  fadd R1, 1.000000
  mov R0, R1
  mov [BP-3], R0
  mov R1, [BP-2]
  cif R1
  mov [SP], R1
  mov R1, [BP-1]
  cif R1
  mov [SP+1], R1
  call __function_atan2
  mov [BP-4], R0
  mov R1, [BP-4]
  mov [SP], R1
  call __function_set_drawing_angle
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_rotozoomed_at
__function_draw_line_return:
  mov SP, BP
  pop BP
  ret

__function_draw_rectangle:
  push BP
  mov BP, SP
  isub SP, 2
  out GPU_SelectedTexture, -1
  out GPU_SelectedRegion, 256
  mov R1, [BP+4]
  mov R2, [BP+2]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP], R1
  mov R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 1
  cif R1
  mov [SP], R1
  mov R1, [BP+5]
  mov R2, [BP+3]
  isub R1, R2
  iadd R1, 1
  cif R1
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_draw_rectangle_return:
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
__if_1980_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  flt R0, R1
  jf R0, __if_1980_end
  mov R0, [BP+3]
  jmp __function_b2ClampFloat_return
__if_1980_end:
__if_1986_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  fgt R0, R1
  jf R0, __if_1986_end
  mov R0, [BP+4]
  jmp __function_b2ClampFloat_return
__if_1986_end:
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
__if_2373_start:
  mov R0, [BP-1]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2373_end
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Normalize_return
__if_2373_end:
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
__if_2442_start:
  mov R0, [BP-1]
  fgt R0, 0.000000
  jf R0, __if_2442_end
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
__if_2442_end:
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
__if_2935_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2935_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2GetLengthAndNormalize_return
__if_2935_end:
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
__if_2976_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_2981
  mov R1, [BP+3]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_2981:
  jf R0, __if_2976_end
  mov R0, 0.000000
  jmp __function_b2Atan2_return
__if_2976_end:
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
__if_3112_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_3112_end
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
__if_3112_end:
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
__if_3197_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_3197_end
  mov R0, 1.000000
  mov R1, [BP-4]
  fdiv R0, R1
  mov [BP-5], R0
__if_3197_end:
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
  jf R0, __LogicalAnd_ShortCircuit_3240
  mov R1, [BP-1]
  flt R1, 1.000600
  and R0, R1
__LogicalAnd_ShortCircuit_3240:
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
__if_3332_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_3332_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_3332_end:
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
__if_3404_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_3404_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_3404_end:
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
  jf R0, __LogicalAnd_ShortCircuit_3461
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3461:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3472
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3472:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3483
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3483:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3494
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
__LogicalAnd_ShortCircuit_3494:
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
__if_3610_start:
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3610_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3610_end:
__if_3620_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3620_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3620_end:
__if_3630_start:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3630_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3630_end:
__if_3640_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3640_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3640_end:
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
__if_3711_start:
  mov R0, [BP+2]
  mov R1, [BP+2]
  fne R0, R1
  jf R0, __if_3711_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3711_end:
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
__if_3730_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fgt R0, R1
  jf R0, __if_3730_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3730_end:
__if_3736_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fsgn R1
  flt R0, R1
  jf R0, __if_3736_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3736_end:
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
  jf R1, __LogicalAnd_ShortCircuit_3751
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_b2IsValidFloat
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_3751:
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
__if_3757_start:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3757_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3757_end:
__if_3764_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3764_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3764_end:
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
__if_4844_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4846
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4846:
  jf R0, __if_4844_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_4855_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4855_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4855_end:
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
__if_4844_end:
__if_4874_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_4876
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_4876:
  jf R0, __if_4874_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_4884_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_4884_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_4884_end:
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
__if_4874_end:
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
__if_4906_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_4906_end
  jmp __function_reduce_malloc_block_return
__if_4906_end:
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
__if_4949_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_4949_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_4949_end:
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
__if_4968_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_4968_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_4968_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_4978_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_4981
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_4981:
  jf R0, __if_4978_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4978_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_4993_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_4993_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_4993_end:
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
__if_5008_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_5008_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_5008_end:
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
__if_5023_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_5023_end
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
__if_5023_end:
__if_5058_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_5058_end
  mov R0, -1
  jmp __function_malloc_return
__if_5058_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_5067_start:
__while_5067_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_5067_end
__if_5070_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_5073
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_5073:
  jf R0, __if_5070_end
  jmp __while_5067_end
__if_5070_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_5067_start
__while_5067_end:
__if_5083_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_5083_end
  mov R0, -1
  jmp __function_malloc_return
__if_5083_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_5093_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_5093_else
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
__if_5138_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_5138_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_5138_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_5093_end
__if_5093_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_5093_end:
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
__if_5163_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_5163_end
  jmp __function_free_return
__if_5163_end:
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
__if_5191_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_5191_end
  mov R0, -1
  jmp __function_calloc_return
__if_5191_end:
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
__if_5205_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_5205_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_5205_end:
__if_5211_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_5211_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_5211_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_5230_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_5230_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_5230_end:
__if_5236_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_5236_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_5236_end
__if_5236_else:
__if_5247_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_5247_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_5247_end
__if_5247_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_5258_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_5258_end
  mov R0, -1
  jmp __function_realloc_return
__if_5258_end:
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
__if_5247_end:
__if_5236_end:
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
__if_5345_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_5350
  mov R1, [BP-8]
  mov R2, [BP-11]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_5350:
  jf R0, __if_5345_else
__if_5354_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_5354_else
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
  jmp __if_5354_end
__if_5354_else:
__if_5373_start:
  mov R0, [BP-8]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_5373_else
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
  jmp __if_5373_end
__if_5373_else:
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_5373_end:
__if_5354_end:
  jmp __if_5345_end
__if_5345_else:
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
__if_5420_start:
  mov R0, [BP-13]
  fne R0, 0.000000
  jf R0, __if_5420_end
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
__if_5420_end:
  mov R0, [BP-12]
  mov R1, [BP-14]
  fmul R0, R1
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-8]
  fdiv R0, R1
  mov [BP-15], R0
__if_5450_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jf R0, __if_5450_else
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
  jmp __if_5450_end
__if_5450_else:
__if_5467_start:
  mov R0, [BP-15]
  fgt R0, 1.000000
  jf R0, __if_5467_end
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
__if_5467_end:
__if_5450_end:
  mov R0, [BP-14]
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-15]
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_5345_end:
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
__for_5532_start:
  mov R0, [BP-1]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_5532_end
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
__for_5532_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5532_start
__for_5532_end:
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
__if_5613_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_5613_end
  mov R0, [BP+2]
  jmp __function_b2SimplexVertexPtr_return
__if_5613_end:
__if_5621_start:
  mov R0, [BP+3]
  ieq R0, 1
  jf R0, __if_5621_end
  mov R0, [BP+2]
  iadd R0, 9
  jmp __function_b2SimplexVertexPtr_return
__if_5621_end:
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
__for_5724_start:
  mov R0, [BP-4]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_5724_end
  mov R1, [BP+2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-5], R0
__if_5743_start:
  mov R0, [BP-5]
  mov R1, [BP-3]
  fgt R0, R1
  jf R0, __if_5743_end
  mov R0, [BP-4]
  mov [BP-2], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_5743_end:
__for_5724_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_5724_start
__for_5724_end:
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
__for_5766_start:
  mov R0, [BP-1]
  mov R2, [BP+5]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5766_end
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
__for_5766_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5766_start
__for_5766_end:
__if_5827_start:
  mov R1, [BP+5]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_5827_end
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
__if_5827_end:
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
__for_5886_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5886_end
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
__for_5886_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5886_start
__for_5886_end:
__function_b2MakeSimplexCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeWitnessPoints:
  push BP
  mov BP, SP
  isub SP, 7
__if_5920_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_5920_else
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
  jmp __if_5920_end
__if_5920_else:
__if_5938_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_5938_else
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
  jmp __if_5938_end
__if_5938_else:
__if_5976_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_5976_else
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
  jmp __if_5976_end
__if_5976_else:
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
__if_5976_end:
__if_5938_end:
__if_5920_end:
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
__if_6049_start:
  mov R0, [BP-7]
  fle R0, 0.000000
  jf R0, __if_6049_end
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
__if_6049_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_6075_start:
  mov R0, [BP-8]
  fle R0, 0.000000
  jf R0, __if_6075_end
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
__if_6075_end:
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
__if_6297_start:
  mov R0, [BP-12]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6302
  mov R1, [BP-18]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6302:
  jf R0, __if_6297_end
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
__if_6297_end:
__if_6320_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6325
  mov R1, [BP-12]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6325:
  jf R0, __LogicalAnd_ShortCircuit_6329
  mov R1, [BP-31]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6329:
  jf R0, __if_6320_end
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
__if_6320_end:
__if_6381_start:
  mov R0, [BP-17]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6386
  mov R1, [BP-18]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6386:
  jf R0, __LogicalAnd_ShortCircuit_6390
  mov R1, [BP-30]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6390:
  jf R0, __if_6381_end
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
__if_6381_end:
__if_6447_start:
  mov R0, [BP-11]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6452
  mov R1, [BP-24]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6452:
  jf R0, __if_6447_end
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
__if_6447_end:
__if_6475_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6480
  mov R1, [BP-23]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6480:
  jf R0, __if_6475_end
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
__if_6475_end:
__if_6503_start:
  mov R0, [BP-23]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_6508
  mov R1, [BP-24]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6508:
  jf R0, __LogicalAnd_ShortCircuit_6512
  mov R1, [BP-29]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_6512:
  jf R0, __if_6503_end
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
__if_6503_end:
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
__for_6635_start:
  mov R0, [BP-61]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_6635_end
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
__for_6635_continue:
  mov R0, [BP-61]
  mov R1, R0
  iadd R1, 1
  mov [BP-61], R1
  jmp __for_6635_start
__for_6635_end:
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
__while_6695_start:
__while_6695_continue:
  mov R0, [BP-58]
  mov R1, [BP-57]
  ilt R0, R1
  jf R0, __while_6695_end
  mov R0, [BP-20]
  mov [BP-61], R0
  mov R0, 0
  mov [BP-68], R0
__for_6704_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6704_end
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
__for_6704_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6704_start
__for_6704_end:
  mov R0, 0.000000
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-62], R0
__if_6742_start:
  mov R0, [BP-20]
  ieq R0, 1
  jf R0, __if_6742_else
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __if_6742_end
__if_6742_else:
__if_6754_start:
  mov R0, [BP-20]
  ieq R0, 2
  jf R0, __if_6754_else
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex2
  jmp __if_6754_end
__if_6754_else:
__if_6764_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6764_end
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex3
__if_6764_end:
__if_6754_end:
__if_6742_end:
__if_6774_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6774_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6774_end:
__if_6790_start:
  lea R2, [BP-63]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-56]
  flt R1, R2
  mov R0, R1
  jf R0, __if_6790_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6790_end:
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
__for_6872_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6872_end
__if_6882_start:
  mov R1, [BP-64]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov R1, [R1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_6891
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  lea R2, [BP-55]
  mov R3, [BP-68]
  iadd R2, R3
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6891:
  jf R0, __if_6882_end
  mov R0, 1
  mov [BP-67], R0
  jmp __for_6872_end
__if_6882_end:
__for_6872_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6872_start
__for_6872_end:
__if_6901_start:
  mov R0, [BP-67]
  jf R0, __if_6901_end
  jmp __while_6695_end
__if_6901_end:
  mov R0, [BP-20]
  iadd R0, 1
  mov [BP-20], R0
  jmp __while_6695_start
__while_6695_end:
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
__if_6950_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  jf R0, __if_6950_end
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
__if_6950_end:
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
__for_7136_start:
  mov R0, [BP-56]
  ilt R0, 20
  jf R0, __for_7136_end
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
__if_7162_start:
  mov R0, [BP-59]
  mov R1, [BP-3]
  mov R2, [BP-4]
  fadd R1, R2
  flt R0, R1
  jf R0, __if_7162_end
__if_7170_start:
  mov R0, [BP-56]
  ieq R0, 0
  jf R0, __if_7170_else
__if_7175_start:
  mov R1, [BP+2]
  iadd R1, 43
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_7178
  mov R1, [BP-59]
  mov R2, [BP-1]
  fmul R2, 2.000000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_7178:
  jf R0, __if_7175_else
  mov R0, [BP-59]
  mov R1, [BP-1]
  fsub R0, R1
  mov [BP-3], R0
  jmp __if_7175_end
__if_7175_else:
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
__if_7175_end:
  jmp __if_7170_end
__if_7170_else:
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
__if_7170_end:
__if_7162_end:
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
__if_7272_start:
  mov R0, [BP-66]
  fge R0, 0.000000
  jf R0, __if_7272_end
  jmp __function_b2ShapeCast_return
__if_7272_end:
  mov R0, [BP-12]
  mov R1, [BP-3]
  mov R2, [BP-59]
  fsub R1, R2
  mov R2, [BP-66]
  fdiv R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_7288_start:
  mov R0, [BP-12]
  mov R2, [BP+2]
  iadd R2, 42
  mov R1, [R2]
  fge R0, R1
  jf R0, __if_7288_end
  jmp __function_b2ShapeCast_return
__if_7288_end:
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
__for_7136_continue:
  mov R0, [BP-56]
  iadd R0, 1
  mov [BP-56], R0
  jmp __for_7136_start
__for_7136_end:
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
__if_7464_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_7464_end
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
__if_7464_end:
__if_7529_start:
  mov R0, [BP+2]
  iadd R0, 1
  mov R0, [R0]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  ieq R0, R1
  jf R0, __if_7529_end
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
__if_7657_start:
  lea R2, [BP-45]
  mov [SP], R2
  lea R2, [BP-37]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7657_end
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
__if_7657_end:
  jmp __function_b2MakeSeparationFunction_return
__if_7529_end:
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
__if_7796_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-19]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7796_end
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
__if_7796_end:
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
__if_7840_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7840_else
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
  jmp __if_7840_end
__if_7840_else:
__if_7941_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7941_else
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
  jmp __if_7941_end
__if_7941_else:
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
__if_7941_end:
__if_7840_end:
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
__if_8137_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_8137_else
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
  jmp __if_8137_end
__if_8137_else:
__if_8191_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_8191_else
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
  jmp __if_8191_end
__if_8191_else:
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
__if_8191_end:
__if_8137_end:
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
__while_8406_start:
__while_8406_continue:
  mov R0, [BP-78]
  jf R0, __while_8406_end
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
__if_8478_start:
  mov R0, [BP-89]
  fle R0, 0.000000
  jf R0, __if_8478_end
  mov R0, 2
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_8478_end:
__if_8493_start:
  mov R0, [BP-89]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8493_end
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
__if_8493_end:
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
__while_8572_start:
__while_8572_continue:
  mov R0, [BP-132]
  jf R0, __while_8572_end
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
__if_8589_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_8589_end
  mov R0, 4
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-23]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8572_end
__if_8589_end:
__if_8608_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  fgt R0, R1
  jf R0, __if_8608_end
  mov R0, [BP-130]
  mov [BP-27], R0
  jmp __while_8572_end
__if_8608_end:
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
__if_8627_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  flt R0, R1
  jf R0, __if_8627_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8572_end
__if_8627_end:
__if_8646_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8646_end
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
  jmp __while_8572_end
__if_8646_end:
  mov R0, 0
  mov [BP-137], R0
  mov R0, [BP-27]
  mov [BP-138], R0
  mov R0, [BP-130]
  mov [BP-139], R0
  mov R0, 1
  mov [BP-140], R0
__while_8713_start:
__while_8713_continue:
  mov R0, [BP-140]
  jf R0, __while_8713_end
__if_8718_start:
  mov R0, [BP-137]
  and R0, 1
  ine R0, 0
  jf R0, __if_8718_else
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
  jmp __if_8718_end
__if_8718_else:
  mov R0, [BP-138]
  mov R1, [BP-139]
  fadd R0, R1
  fmul R0, 0.500000
  mov [BP-141], R0
__if_8718_end:
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
__if_8764_start:
  mov R2, [BP-142]
  mov R3, [BP-25]
  fsub R2, R3
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, [BP-26]
  flt R1, R2
  mov R0, R1
  jf R0, __if_8764_end
  mov R0, [BP-141]
  mov [BP-130], R0
  jmp __while_8713_end
__if_8764_end:
__if_8776_start:
  mov R0, [BP-142]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_8776_else
  mov R0, [BP-141]
  mov [BP-138], R0
  mov R0, [BP-142]
  mov [BP-136], R0
  jmp __if_8776_end
__if_8776_else:
  mov R0, [BP-141]
  mov [BP-139], R0
  mov R0, [BP-142]
  mov [BP-135], R0
__if_8776_end:
__if_8794_start:
  mov R0, [BP-137]
  ieq R0, 50
  jf R0, __if_8794_end
  jmp __while_8713_end
__if_8794_end:
  jmp __while_8713_start
__while_8713_end:
  mov R0, [BP-131]
  iadd R0, 1
  mov [BP-131], R0
__if_8804_start:
  mov R0, [BP-131]
  ieq R0, 8
  jf R0, __if_8804_end
  jmp __while_8572_end
__if_8804_end:
  jmp __while_8572_start
__while_8572_end:
__if_8809_start:
  mov R0, [BP-129]
  jf R0, __if_8809_end
  jmp __while_8406_end
__if_8809_end:
__if_8812_start:
  mov R0, [BP-29]
  mov R1, [BP-28]
  ieq R0, R1
  jf R0, __if_8812_end
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
  jmp __while_8406_end
__if_8812_end:
  jmp __while_8406_start
__while_8406_end:
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
__for_9246_start:
  mov R0, [BP-8]
  mov R1, [BP+3]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_9246_end
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
__for_9246_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_9246_start
__for_9246_end:
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
__if_9449_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_9449_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakeOffsetRoundedPolygon_return
__if_9449_end:
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
__for_9484_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9484_end
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
__for_9484_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_9484_start
__for_9484_end:
  mov R0, 0
  mov [BP-5], R0
__for_9507_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9507_end
  mov R0, 0
  mov [BP-6], R0
__if_9521_start:
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_9521_end
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-6], R0
__if_9521_end:
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
__for_9507_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_9507_start
__for_9507_end:
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
__for_9591_start:
  mov R0, [BP-3]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9591_end
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
__for_9591_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_9591_start
__for_9591_end:
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
__if_9823_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_9823_end
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
__if_9823_end:
__if_9849_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_9849_end
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
__if_9849_end:
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
__if_9898_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_9898_else
  mov R0, 1.412000
  mov [BP-27], R0
  mov R0, 0
  mov [BP-28], R0
__for_9906_start:
  mov R0, [BP-28]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9906_end
  mov R0, [BP-28]
  isub R0, 1
  mov [BP-29], R0
__if_9921_start:
  mov R0, [BP-28]
  ieq R0, 0
  jf R0, __if_9921_end
  mov R0, [BP-17]
  isub R0, 1
  mov [BP-29], R0
__if_9921_end:
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
__for_9906_continue:
  mov R0, [BP-28]
  mov R1, R0
  iadd R1, 1
  mov [BP-28], R1
  jmp __for_9906_start
__for_9906_end:
  jmp __if_9898_end
__if_9898_else:
  mov R0, 0
  mov [BP-27], R0
__for_9974_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9974_end
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
__for_9974_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9974_start
__for_9974_end:
__if_9898_end:
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
__for_10017_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_10017_end
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
__for_10017_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_10017_start
__for_10017_end:
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
__for_10351_start:
  mov R0, [BP-8]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_10351_end
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
__for_10351_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_10351_start
__for_10351_end:
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
__if_10589_start:
  mov R0, [BP-8]
  feq R0, 0.000000
  jf R0, __if_10589_end
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
__if_10589_end:
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
__if_10700_start:
  mov R0, [BP-7]
  feq R0, 0.000000
  jf R0, __if_10700_end
__if_10705_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10705_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10705_end:
  jmp __function_b2RayCastCircle_return
__if_10700_end:
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
__if_10747_start:
  mov R0, [BP-13]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __if_10747_end
  jmp __function_b2RayCastCircle_return
__if_10747_end:
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
__if_10763_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10769
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-15]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10769:
  jf R0, __if_10763_end
__if_10775_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10775_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10775_end:
  jmp __function_b2RayCastCircle_return
__if_10763_end:
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
__if_10881_start:
  mov R0, [BP-7]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_10881_end
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
__if_10881_end:
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
__if_10945_start:
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
  jf R0, __if_10945_end
__if_10956_start:
  mov R0, [BP-16]
  flt R0, 0.000000
  jf R0, __if_10956_end
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
__if_10956_end:
__if_10978_start:
  mov R0, [BP-16]
  mov R1, [BP-7]
  fgt R0, R1
  jf R0, __if_10978_end
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
__if_10978_end:
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
__if_10945_end:
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
__if_11048_start:
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  fsgn R0
  mov R1, [BP-25]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_11057
  mov R1, [BP-25]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11057:
  jf R0, __if_11048_end
  jmp __function_b2RayCastCapsule_return
__if_11048_end:
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
__if_11125_start:
  mov R0, [BP-31]
  mov R1, [BP-32]
  flt R0, R1
  jf R0, __if_11125_else
  mov R0, [BP-31]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-27]
  mov CR, 2
  movs
  jmp __if_11125_end
__if_11125_else:
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
__if_11125_end:
__if_11148_start:
  mov R0, [BP-33]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_11154
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-22]
  fmul R1, R2
  mov R2, [BP-33]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_11154:
  jf R0, __if_11148_end
  jmp __function_b2RayCastCapsule_return
__if_11148_end:
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
__if_11177_start:
  mov R0, [BP-36]
  flt R0, 0.000000
  jf R0, __if_11177_else
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
  jmp __if_11177_end
__if_11177_else:
__if_11199_start:
  mov R0, [BP-7]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __if_11199_else
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
  jmp __if_11199_end
__if_11199_else:
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
__if_11199_end:
__if_11177_end:
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
__if_11290_start:
  mov R0, [BP+4]
  jf R0, __if_11290_end
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
__if_11315_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-29]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_11315_end
  jmp __function_b2RayCastSegment_return
__if_11315_end:
__if_11290_end:
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
__if_11360_start:
  mov R0, [BP-11]
  feq R0, 0.000000
  jf R0, __if_11360_end
  jmp __function_b2RayCastSegment_return
__if_11360_end:
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
__if_11395_start:
  mov R0, [BP-19]
  feq R0, 0.000000
  jf R0, __if_11395_end
  jmp __function_b2RayCastSegment_return
__if_11395_end:
  mov R0, [BP-18]
  mov R1, [BP-19]
  fdiv R0, R1
  mov [BP-20], R0
__if_11405_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_11411
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-20]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_11411:
  jf R0, __if_11405_end
  jmp __function_b2RayCastSegment_return
__if_11405_end:
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
__if_11441_start:
  mov R0, [BP-25]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_11446
  mov R1, [BP-11]
  mov R2, [BP-25]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_11446:
  jf R0, __if_11441_end
  jmp __function_b2RayCastSegment_return
__if_11441_end:
__if_11450_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_11450_end
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Neg
__if_11450_end:
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
__if_11499_start:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  fne R0, 0.000000
  jf R0, __if_11499_end
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
__if_11499_end:
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
__for_11582_start:
  mov R0, [BP-10]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_11582_end
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
__if_11637_start:
  mov R0, [BP-20]
  feq R0, 0.000000
  jf R0, __if_11637_else
__if_11642_start:
  mov R0, [BP-19]
  flt R0, 0.000000
  jf R0, __if_11642_end
  jmp __function_b2RayCastPolygon_return
__if_11642_end:
  jmp __if_11637_end
__if_11637_else:
__if_11648_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11653
  mov R1, [BP-19]
  mov R2, [BP-7]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11653:
  jf R0, __if_11648_else
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-10]
  mov [BP-9], R0
  jmp __if_11648_end
__if_11648_else:
__if_11667_start:
  mov R0, [BP-20]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11672
  mov R1, [BP-19]
  mov R2, [BP-8]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11672:
  jf R0, __if_11667_end
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-8], R0
__if_11667_end:
__if_11648_end:
__if_11637_end:
__if_11683_start:
  mov R0, [BP-8]
  mov R1, [BP-7]
  flt R0, R1
  jf R0, __if_11683_end
  jmp __function_b2RayCastPolygon_return
__if_11683_end:
__for_11582_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_11582_start
__for_11582_end:
__if_11688_start:
  mov R0, [BP-9]
  ige R0, 0
  jf R0, __if_11688_else
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
  jmp __if_11688_end
__if_11688_else:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_11688_end:
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
__if_11976_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11976_end
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
__if_11976_end:
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
__if_12078_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_12078_end
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
__if_12078_end:
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
__if_12181_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_12181_end
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
__if_12181_end:
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
__if_12280_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_12280_end
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
__if_12280_end:
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
__if_12325_start:
  mov R0, [BP+5]
  ieq R0, 0
  jf R0, __if_12325_end
  jmp __function_b2RecurseHull_return
__if_12325_end:
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
__if_12370_start:
  mov R0, [BP-25]
  fgt R0, 0.000000
  jf R0, __if_12370_end
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
__if_12370_end:
  mov R0, 1
  mov [BP-62], R0
__for_12384_start:
  mov R0, [BP-62]
  mov R1, [BP+5]
  ilt R0, R1
  jf R0, __for_12384_end
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
__if_12409_start:
  mov R0, [BP-63]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_12409_end
  mov R0, [BP-62]
  mov [BP-22], R0
  mov R0, [BP-63]
  mov [BP-25], R0
__if_12409_end:
__if_12420_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_12420_end
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
__if_12420_end:
__for_12384_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_12384_start
__for_12384_end:
__if_12434_start:
  mov R1, [BP-25]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 2.000000
  flt R1, R2
  mov R0, R1
  jf R0, __if_12434_end
  jmp __function_b2RecurseHull_return
__if_12434_end:
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
__for_12469_start:
  mov R0, [BP-62]
  mov R1, [BP-28]
  ilt R0, R1
  jf R0, __for_12469_end
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
__for_12469_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_12469_start
__for_12469_end:
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
__for_12503_start:
  mov R0, [BP-62]
  mov R1, [BP-45]
  ilt R0, R1
  jf R0, __for_12503_end
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
__for_12503_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_12503_start
__for_12503_end:
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
__if_13418_start:
  mov R1, [BP-12]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_13418_end
  jmp __function_b2CollideCircles_return
__if_13418_end:
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
__if_13551_start:
  mov R0, [BP-11]
  flt R0, 0.000000
  jf R0, __if_13551_else
  lea R13, [BP-16]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_13551_end
__if_13551_else:
__if_13559_start:
  mov R0, [BP-14]
  flt R0, 0.000000
  jf R0, __if_13559_else
  lea R13, [BP-16]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_13559_end
__if_13559_else:
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
__if_13559_end:
__if_13551_end:
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
__if_13620_start:
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_13620_end
  jmp __function_b2CollideCapsuleAndCircle_return
__if_13620_end:
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
__for_13740_start:
  mov R0, [BP-10]
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __for_13740_end
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
__if_13772_start:
  mov R0, [BP-29]
  mov R1, [BP-8]
  fgt R0, R1
  jf R0, __if_13772_end
  mov R0, [BP-29]
  mov [BP-8], R0
  mov R0, [BP-10]
  mov [BP-7], R0
__if_13772_end:
__for_13740_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_13740_start
__for_13740_end:
__if_13783_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13783_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13783_end:
  mov R0, [BP-7]
  mov [BP-11], R0
__if_13795_start:
  mov R0, [BP-11]
  iadd R0, 1
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __if_13795_else
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-12], R0
  jmp __if_13795_end
__if_13795_else:
  mov R0, 0
  mov [BP-12], R0
__if_13795_end:
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
__if_13871_start:
  mov R0, [BP-21]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13876
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13876:
  jf R0, __if_13871_else
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
__if_13906_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13906_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13906_end:
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
  jmp __if_13871_end
__if_13871_else:
__if_13978_start:
  mov R0, [BP-26]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13983
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13983:
  jf R0, __if_13978_else
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
__if_14013_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_14013_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_14013_end:
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
  jmp __if_13978_end
__if_13978_else:
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
__if_13978_end:
__if_13871_end:
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
__if_14311_start:
  mov R0, [BP-27]
  fne R0, 0.000000
  jf R0, __if_14311_end
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
__if_14311_end:
  mov R0, [BP-26]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-25]
  fadd R0, R1
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-29], R0
__if_14340_start:
  mov R0, [BP-29]
  flt R0, 0.000000
  jf R0, __if_14340_else
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
  jmp __if_14340_end
__if_14340_else:
__if_14357_start:
  mov R0, [BP-29]
  fgt R0, 1.000000
  jf R0, __if_14357_end
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
__if_14357_end:
__if_14340_end:
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
__if_14427_start:
  mov R0, [BP-34]
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fgt R0, R1
  jf R0, __if_14427_end
  jmp __function_b2CollideCapsules_return
__if_14427_end:
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
  jf R0, __LogicalAnd_ShortCircuit_14496
  mov R1, [BP-49]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14496:
  jt R0, __LogicalOr_ShortCircuit_14499
  mov R1, [BP-48]
  mov R2, [BP-40]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_14505
  mov R2, [BP-49]
  mov R3, [BP-40]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_14505:
  or R0, R1
__LogicalOr_ShortCircuit_14499:
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
  jf R0, __LogicalAnd_ShortCircuit_14543
  mov R1, [BP-52]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14543:
  jt R0, __LogicalOr_ShortCircuit_14546
  mov R1, [BP-51]
  mov R2, [BP-41]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_14552
  mov R2, [BP-52]
  mov R3, [BP-41]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_14552:
  or R0, R1
__LogicalOr_ShortCircuit_14546:
  mov [BP-53], R0
__if_14555_start:
  mov R0, [BP-50]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_14560
  mov R1, [BP-53]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_14560:
  jf R0, __if_14555_end
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
__if_14614_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14614_else
  mov R0, [BP-62]
  mov [BP-56], R0
  jmp __if_14614_end
__if_14614_else:
  mov R0, [BP-63]
  mov [BP-56], R0
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Neg
__if_14614_end:
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
__if_14681_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14681_else
  mov R0, [BP-62]
  mov [BP-59], R0
  jmp __if_14681_end
__if_14681_else:
  mov R0, [BP-63]
  mov [BP-59], R0
  lea R1, [BP-58]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Neg
__if_14681_end:
__if_14698_start:
  mov R1, [BP-56]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 0.100000
  fadd R1, R2
  mov R2, [BP-59]
  fge R1, R2
  mov R0, R1
  jf R0, __if_14698_else
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
__if_14720_start:
  mov R0, [BP-48]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14725
  mov R1, [BP-49]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14725:
  jf R0, __if_14720_else
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
  jmp __if_14720_end
__if_14720_else:
__if_14744_start:
  mov R0, [BP-49]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14749
  mov R1, [BP-48]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14749:
  jf R0, __if_14744_end
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
__if_14744_end:
__if_14720_end:
__if_14768_start:
  mov R0, [BP-48]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14773
  mov R1, [BP-49]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14773:
  jf R0, __if_14768_else
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
  jmp __if_14768_end
__if_14768_else:
__if_14792_start:
  mov R0, [BP-49]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14797
  mov R1, [BP-48]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14797:
  jf R0, __if_14792_end
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
__if_14792_end:
__if_14768_end:
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
__if_14844_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14854
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14854:
  mov R0, R1
  jf R0, __if_14844_end
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
__if_14844_end:
  jmp __if_14698_end
__if_14698_else:
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
__if_14976_start:
  mov R0, [BP-51]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14981
  mov R1, [BP-52]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14981:
  jf R0, __if_14976_else
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
  jmp __if_14976_end
__if_14976_else:
__if_15000_start:
  mov R0, [BP-52]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_15005
  mov R1, [BP-51]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_15005:
  jf R0, __if_15000_end
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
__if_15000_end:
__if_14976_end:
__if_15024_start:
  mov R0, [BP-51]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15029
  mov R1, [BP-52]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15029:
  jf R0, __if_15024_else
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
  jmp __if_15024_end
__if_15024_else:
__if_15048_start:
  mov R0, [BP-52]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15053
  mov R1, [BP-51]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15053:
  jf R0, __if_15048_end
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
__if_15048_end:
__if_15024_end:
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
__if_15100_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_15110
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_15110:
  mov R0, R1
  jf R0, __if_15100_end
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
__if_15100_end:
__if_14698_end:
__if_14555_end:
__if_15219_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_15219_end
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
__if_15234_start:
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-21]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_15234_else
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Normalize
  jmp __if_15234_end
__if_15234_else:
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
__if_15234_end:
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
__if_15275_start:
  mov R0, [BP-28]
  feq R0, 0.000000
  jf R0, __if_15275_else
  mov R0, 0
  mov [BP-60], R0
  jmp __if_15275_end
__if_15275_else:
  mov R0, 1
  mov [BP-60], R0
__if_15275_end:
__if_15287_start:
  mov R0, [BP-29]
  feq R0, 0.000000
  jf R0, __if_15287_else
  mov R0, 0
  mov [BP-61], R0
  jmp __if_15287_end
__if_15287_else:
  mov R0, 1
  mov [BP-61], R0
__if_15287_end:
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
__if_15219_end:
__if_15346_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_15346_end
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
__if_15346_end:
__if_15368_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_15368_end
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
__if_15368_end:
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
__if_15504_start:
  mov R0, [BP-13]
  flt R0, 0.000000
  jf R0, __if_15504_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15504_end:
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
__if_15534_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __if_15534_else
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
__if_15556_start:
  mov R0, [BP-35]
  fle R0, 0.000000
  jf R0, __if_15556_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15556_end:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_15534_end
__if_15534_else:
__if_15564_start:
  mov R0, [BP-16]
  fle R0, 0.000000
  jf R0, __if_15564_else
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
__if_15595_start:
  mov R0, [BP-37]
  fgt R0, 0.000000
  jf R0, __if_15595_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15595_end:
  lea R13, [BP-19]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_15564_end
__if_15564_else:
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
__if_15637_start:
  mov R0, [BP-33]
  fgt R0, 0.000000
  jf R0, __if_15637_else
  mov R1, 1.000000
  mov R2, [BP-33]
  fdiv R1, R2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_15637_end
__if_15637_else:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
__if_15637_end:
__if_15564_end:
__if_15534_end:
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
__if_15681_start:
  mov R1, [BP-26]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_15681_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15681_end:
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
__for_15842_start:
  mov R0, [BP-5]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_15842_end
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
__for_15872_start:
  mov R0, [BP-11]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_15872_end
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
__if_15909_start:
  mov R0, [BP-14]
  mov R1, [BP-10]
  flt R0, R1
  jf R0, __if_15909_end
  mov R0, [BP-14]
  mov [BP-10], R0
__if_15909_end:
__for_15872_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_15872_start
__for_15872_end:
__if_15916_start:
  mov R0, [BP-10]
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_15916_end
  mov R0, [BP-10]
  mov [BP-4], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_15916_end:
__for_15842_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_15842_start
__for_15842_end:
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
__if_15954_start:
  mov R0, [BP+6]
  jf R0, __if_15954_else
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+2]
  mov [BP-4], R0
  mov R0, [BP+5]
  mov [BP-2], R0
__if_15966_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15966_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15966_end
__if_15966_else:
  mov R0, 0
  mov [BP-3], R0
__if_15966_end:
  mov R0, [BP+4]
  mov [BP-5], R0
__if_15984_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15984_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15984_end
__if_15984_else:
  mov R0, 0
  mov [BP-6], R0
__if_15984_end:
  jmp __if_15954_end
__if_15954_else:
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-4], R0
  mov R0, [BP+4]
  mov [BP-2], R0
__if_16009_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16009_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_16009_end
__if_16009_else:
  mov R0, 0
  mov [BP-3], R0
__if_16009_end:
  mov R0, [BP+5]
  mov [BP-5], R0
__if_16027_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16027_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_16027_end
__if_16027_else:
  mov R0, 0
  mov [BP-6], R0
__if_16027_end:
__if_15954_end:
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
__if_16151_start:
  mov R0, [BP-21]
  mov R1, [BP-19]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16156
  mov R1, [BP-20]
  mov R2, [BP-22]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16156:
  jf R0, __if_16151_end
  jmp __function_b2ClipPolygons_return
__if_16151_end:
__if_16162_start:
  mov R0, [BP-22]
  mov R1, [BP-19]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_16167
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_16167:
  jf R0, __if_16162_else
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
  jmp __if_16162_end
__if_16162_else:
  lea R13, [BP-24]
  lea R12, [BP-16]
  mov CR, 2
  movs
__if_16162_end:
__if_16222_start:
  mov R0, [BP-21]
  mov R1, [BP-20]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_16227
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_16227:
  jf R0, __if_16222_else
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
  jmp __if_16222_end
__if_16222_else:
  lea R13, [BP-26]
  lea R12, [BP-14]
  mov CR, 2
  movs
__if_16222_end:
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
__if_16399_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_16399_else
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
  jmp __if_16399_end
__if_16399_else:
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
__if_16399_end:
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
__for_16650_start:
  mov R0, [BP-46]
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16650_end
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
__for_16650_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16650_start
__for_16650_end:
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
__for_16699_start:
  mov R0, [BP-46]
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16699_end
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
__for_16699_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16699_start
__for_16699_end:
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
__if_16764_start:
  mov R0, [BP-85]
  mov R1, [BP-4]
  mov R2, [BP-88]
  fadd R1, R2
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16771
  mov R1, [BP-87]
  mov R2, [BP-4]
  mov R3, [BP-88]
  fadd R2, R3
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16771:
  jf R0, __if_16764_end
  jmp __function_b2CollidePolygons_return
__if_16764_end:
__if_16779_start:
  mov R0, [BP-85]
  mov R1, [BP-87]
  fge R0, R1
  jf R0, __if_16779_else
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
__for_16806_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16806_end
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
__if_16826_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16826_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-86], R0
__if_16826_end:
__for_16806_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16806_start
__for_16806_end:
  jmp __if_16779_end
__if_16779_else:
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
__for_16860_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16860_end
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
__if_16880_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16880_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-84], R0
__if_16880_end:
__for_16860_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16860_start
__for_16860_end:
__if_16779_end:
__if_16891_start:
  mov R0, [BP-85]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16898
  mov R1, [BP-87]
  mov R2, [BP-3]
  fmul R2, 0.100000
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16898:
  jf R0, __if_16891_else
  mov R0, [BP-84]
  mov [BP-90], R0
__if_16909_start:
  mov R0, [BP-84]
  iadd R0, 1
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16909_else
  mov R0, [BP-84]
  iadd R0, 1
  mov [BP-91], R0
  jmp __if_16909_end
__if_16909_else:
  mov R0, 0
  mov [BP-91], R0
__if_16909_end:
  mov R0, [BP-86]
  mov [BP-92], R0
__if_16929_start:
  mov R0, [BP-86]
  iadd R0, 1
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16929_else
  mov R0, [BP-86]
  iadd R0, 1
  mov [BP-93], R0
  jmp __if_16929_end
__if_16929_else:
  mov R0, 0
  mov [BP-93], R0
__if_16929_end:
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
__if_16991_start:
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_16991_end
  jmp __function_b2CollidePolygons_return
__if_16991_end:
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
__if_17011_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_17011_end
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
__if_17011_end:
__if_17025_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_17025_end
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
__if_17025_end:
__if_17039_start:
  mov R0, [BP-110]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fadd R0, R1
  mov R1, [BP-111]
  flt R0, R1
  jf R0, __if_17039_end
  mov R0, 1.000000
  mov R1, [BP-109]
  fdiv R0, R1
  mov [BP-112], R0
__if_17053_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_17060
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_17060:
  jf R0, __if_17053_else
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
  jmp __if_17053_end
__if_17053_else:
__if_17160_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_17167
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_17167:
  jf R0, __if_17160_else
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
  jmp __if_17160_end
__if_17160_else:
__if_17267_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_17274
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_17274:
  jf R0, __if_17267_else
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
  jmp __if_17267_end
__if_17267_else:
__if_17374_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_17381
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_17381:
  jf R0, __if_17374_end
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
__if_17374_end:
__if_17267_end:
__if_17160_end:
__if_17053_end:
__if_17039_end:
  jmp __if_16891_end
__if_16891_else:
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
__if_16891_end:
__if_17489_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_17489_end
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
__if_17489_end:
__if_17511_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_17511_end
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
__if_17511_end:
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
__if_17597_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fle R1, 0.000000
  mov R0, R1
  jf R0, __if_17597_else
__if_17606_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jf R0, __if_17606_end
__if_17610_start:
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
  jf R0, __if_17610_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17610_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17606_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
  jmp __if_17597_end
__if_17597_else:
__if_17625_start:
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  jf R0, __if_17625_end
__if_17629_start:
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
  jf R0, __if_17629_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17629_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17625_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
__if_17597_end:
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
__if_17709_start:
  mov R0, [BP-9]
  mov R1, [BP-3]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_17714
  mov R1, [BP-6]
  mov R2, [BP-12]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_17714:
  jf R0, __if_17709_end
  jmp __function_b2ClipSegments_return
__if_17709_end:
__if_17720_start:
  mov R0, [BP-12]
  mov R1, [BP-3]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17725
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17725:
  jf R0, __if_17720_else
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
  jmp __if_17720_end
__if_17720_else:
  lea R13, [BP-14]
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17720_end:
__if_17757_start:
  mov R0, [BP-9]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17762
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17762:
  jf R0, __if_17757_else
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
  jmp __if_17757_end
__if_17757_else:
  lea R13, [BP-16]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17757_end:
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
__if_18076_start:
  mov R0, [BP-51]
  jf R0, __if_18076_end
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-72], R1
  mov R0, R1
__if_18076_end:
__if_18089_start:
  mov R0, [BP-50]
  jf R0, __if_18089_end
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
__if_18089_end:
__if_18112_start:
  mov R0, [BP-71]
  jf R0, __LogicalAnd_ShortCircuit_18114
  mov R1, [BP-72]
  and R0, R1
__LogicalAnd_ShortCircuit_18114:
  jf R0, __LogicalAnd_ShortCircuit_18117
  mov R1, [BP-73]
  and R0, R1
__LogicalAnd_ShortCircuit_18117:
  jf R0, __if_18112_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18112_end:
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
__if_18169_start:
  mov R1, [BP-117]
  mov R2, [BP-40]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 4.000000
  fadd R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_18169_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18169_end:
  lea R12, [BP-68]
  lea DR, [BP-125]
  mov CR, 2
  movs
__if_18186_start:
  mov R0, [BP-51]
  jf R0, __if_18186_end
  lea R13, [BP-125]
  lea R12, [BP-55]
  mov CR, 2
  movs
__if_18186_end:
  lea R12, [BP-68]
  lea DR, [BP-127]
  mov CR, 2
  movs
__if_18196_start:
  mov R0, [BP-50]
  jf R0, __if_18196_end
  lea R13, [BP-127]
  lea R12, [BP-53]
  mov CR, 2
  movs
__if_18196_end:
  mov R0, -1
  mov [BP-128], R0
  mov R0, -1
  mov [BP-129], R0
__if_18211_start:
  mov R1, [BP-71]
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_18217
  mov R2, [BP-117]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 0.100000
  fgt R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_18217:
  mov R0, R1
  jf R0, __if_18211_else
__if_18226_start:
  mov R1, [BP+5]
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_18226_else
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
__if_18263_start:
  mov R0, [BP-144]
  ieq R0, 0
  jf R0, __if_18263_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18263_end:
__if_18268_start:
  mov R0, [BP-144]
  ieq R0, 1
  jf R0, __if_18268_end
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
__if_18268_end:
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-128], R0
  jmp __if_18226_end
__if_18226_else:
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
__if_18357_start:
  mov R0, [BP-136]
  mov R1, [BP-137]
  ieq R0, R1
  jf R0, __if_18357_else
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
__if_18402_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  fgt R0, R1
  jf R0, __if_18402_end
  mov R0, [BP-138]
  mov [BP-148], R0
__if_18402_end:
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
__if_18429_start:
  mov R0, [BP-151]
  ieq R0, 0
  jf R0, __if_18429_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18429_end:
__if_18434_start:
  mov R0, [BP-151]
  ieq R0, 1
  jf R0, __if_18434_end
  mov R0, [BP-148]
  mov [BP-138], R0
__if_18442_start:
  mov R0, [BP-148]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18442_else
  mov R0, [BP-148]
  iadd R0, 1
  mov [BP-139], R0
  jmp __if_18442_end
__if_18442_else:
  mov R0, 0
  mov [BP-139], R0
__if_18442_end:
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
__if_18500_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  flt R0, R1
  jf R0, __if_18500_else
__if_18505_start:
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
  jf R0, __if_18505_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18505_end:
  jmp __if_18500_end
__if_18500_else:
__if_18519_start:
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
  jf R0, __if_18519_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18519_end:
__if_18500_end:
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
__if_18576_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18576_end
  lea R1, [BP-141]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18576_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18434_end:
  mov R0, [BP-148]
  mov [BP-129], R0
  jmp __if_18357_end
__if_18357_else:
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
__if_18636_start:
  mov R0, [BP-148]
  mov R1, [BP-149]
  flt R0, R1
  jf R0, __if_18636_else
  mov R0, [BP-138]
  mov [BP-128], R0
  jmp __if_18636_end
__if_18636_else:
  mov R0, [BP-139]
  mov [BP-128], R0
__if_18636_end:
__if_18357_end:
__if_18226_end:
  jmp __if_18211_end
__if_18211_else:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-136], R0
  mov R0, 0
  mov [BP-137], R0
__for_18655_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18655_end
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
__if_18687_start:
  mov R0, [BP-144]
  mov R1, [BP-136]
  flt R0, R1
  jf R0, __if_18687_end
  mov R0, [BP-144]
  mov [BP-136], R0
  mov R0, [BP-137]
  mov [BP-128], R0
__if_18687_end:
__for_18655_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18655_start
__for_18655_end:
__if_18698_start:
  mov R0, [BP-51]
  jf R0, __if_18698_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18708_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18708_end
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
__if_18741_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18741_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18741_end:
__for_18708_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18708_start
__for_18708_end:
__if_18748_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18748_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18748_end:
__if_18698_end:
__if_18760_start:
  mov R0, [BP-50]
  jf R0, __if_18760_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18770_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18770_end
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
__if_18803_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18803_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18803_end:
__for_18770_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18770_start
__for_18770_end:
__if_18810_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18810_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18810_end:
__if_18760_end:
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-138], R0
  mov R0, -1
  mov [BP-139], R0
  mov R0, 0
  mov [BP-137], R0
__for_18833_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18833_end
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
__if_18856_start:
  lea R2, [BP-57]
  mov [SP], R2
  lea R2, [BP-143]
  mov [SP+1], R2
  call __function_b2ClassifyNormal
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __if_18856_end
  jmp __for_18833_continue
__if_18856_end:
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
__if_18902_start:
  mov R0, [BP-150]
  mov R1, [BP-138]
  fgt R0, R1
  jf R0, __if_18902_end
  mov R0, [BP-150]
  mov [BP-138], R0
  mov R0, [BP-137]
  mov [BP-139], R0
__if_18902_end:
__for_18833_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18833_start
__for_18833_end:
__if_18913_start:
  mov R0, [BP-138]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18913_end
  mov R0, [BP-139]
  mov [BP-140], R0
__if_18923_start:
  mov R0, [BP-140]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18923_else
  mov R0, [BP-140]
  iadd R0, 1
  mov [BP-141], R0
  jmp __if_18923_end
__if_18923_else:
  mov R0, 0
  mov [BP-141], R0
__if_18923_end:
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
__if_18987_start:
  mov R0, [BP-152]
  mov R1, [BP-153]
  flt R0, R1
  jf R0, __if_18987_else
__if_18992_start:
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
  jf R0, __if_18992_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18992_end:
  jmp __if_18987_end
__if_18987_else:
__if_19006_start:
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
  jf R0, __if_19006_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_19006_end:
__if_18987_end:
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
__if_19063_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_19063_end
  lea R1, [BP-147]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_19063_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18913_end:
__if_19075_start:
  mov R0, [BP-128]
  ieq R0, -1
  jf R0, __if_19075_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_19075_end:
__if_18211_end:
__if_19085_start:
  mov R0, [BP-129]
  ine R0, -1
  jf R0, __if_19085_else
  mov R0, [BP-129]
  mov [BP-130], R0
__if_19094_start:
  mov R0, [BP-130]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_19094_else
  mov R0, [BP-130]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_19094_end
__if_19094_else:
  mov R0, 0
  mov [BP-131], R0
__if_19094_end:
  jmp __if_19085_end
__if_19085_else:
  mov R0, [BP-128]
  mov [BP-136], R0
__if_19114_start:
  mov R0, [BP-136]
  igt R0, 0
  jf R0, __if_19114_else
  mov R0, [BP-136]
  isub R0, 1
  mov [BP-137], R0
  jmp __if_19114_end
__if_19114_else:
  mov R0, [BP-41]
  isub R0, 1
  mov [BP-137], R0
__if_19114_end:
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
__if_19154_start:
  mov R0, [BP-142]
  mov R1, [BP-143]
  flt R0, R1
  jf R0, __if_19154_else
  mov R0, [BP-137]
  mov [BP-130], R0
  mov R0, [BP-136]
  mov [BP-131], R0
  jmp __if_19154_end
__if_19154_else:
  mov R0, [BP-136]
  mov [BP-130], R0
__if_19169_start:
  mov R0, [BP-136]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_19169_else
  mov R0, [BP-136]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_19169_end
__if_19169_else:
  mov R0, 0
  mov [BP-131], R0
__if_19169_end:
__if_19154_end:
__if_19085_end:
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
__if_19298_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_19298_end
  mov R0, 32
  jmp __function_b2CLZ32_return
__if_19298_end:
  mov R0, 0
  mov [BP-1], R0
  mov R0, 31
  mov [BP-2], R0
__for_19309_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_19309_end
__if_19319_start:
  mov R0, [BP+2]
  mov R1, [BP-2]
  isgn R1
  shl R0, R1
  and R0, 1
  ine R0, 0
  jf R0, __if_19319_end
  mov R0, [BP-1]
  jmp __function_b2CLZ32_return
__if_19319_end:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__for_19309_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_19309_start
__for_19309_end:
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
__if_19367_start:
  mov R0, [BP+2]
  ile R0, 1
  jf R0, __if_19367_end
  mov R0, 1
  jmp __function_b2RoundUpPowerOf2_return
__if_19367_end:
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
__if_19416_start:
  mov R0, [BP-1]
  mov R1, [BP+4]
  ige R0, R1
  jf R0, __if_19416_end
  mov R0, [BP+2]
  jmp __function_b2GrowArray_return
__if_19416_end:
  mov R0, 8
  mov [BP-2], R0
__if_19425_start:
  mov R0, [BP-1]
  ine R0, 0
  jf R0, __if_19425_end
  mov R0, [BP-1]
  imul R0, 2
  mov [BP-2], R0
__if_19425_end:
__if_19434_start:
  mov R0, [BP-2]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __if_19434_end
  mov R0, [BP+4]
  mov [BP-2], R0
__if_19434_end:
__if_19443_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_19443_else
  mov R2, [BP-2]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  jmp __if_19443_end
__if_19443_else:
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
__if_19443_end:
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
__for_19656_start:
  mov R0, [BP-2]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19656_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R2, [BP+3]
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19656_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_19656_start
__for_19656_end:
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
__if_19732_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19732_end
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
__for_19796_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19796_end
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19796_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_19796_start
__for_19796_end:
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
__if_19732_end:
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
__while_19947_start:
__while_19947_continue:
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __while_19947_end
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
__if_19974_start:
  mov R0, [BP-22]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_19974_end
  mov R0, [BP-19]
  mov [BP-17], R0
  mov R0, [BP-22]
  mov [BP-18], R0
__if_19974_end:
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
__if_20037_start:
  mov R0, [BP-23]
  jf R0, __if_20037_else
  mov R0, [BP-34]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_20045_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_20045_end
  mov R0, [BP-20]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_20045_end:
  jmp __if_20037_end
__if_20037_else:
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
__if_20037_end:
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
__if_20101_start:
  mov R0, [BP-24]
  jf R0, __if_20101_else
  mov R0, [BP-45]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_20109_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_20109_end
  mov R0, [BP-21]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_20109_end:
  jmp __if_20101_end
__if_20101_else:
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
__if_20101_end:
__if_20137_start:
  mov R0, [BP-23]
  jf R0, __LogicalAnd_ShortCircuit_20139
  mov R1, [BP-24]
  and R0, R1
__LogicalAnd_ShortCircuit_20139:
  jf R0, __if_20137_end
  jmp __while_19947_end
__if_20137_end:
__if_20142_start:
  mov R0, [BP-18]
  mov R1, [BP-25]
  fle R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20147
  mov R1, [BP-18]
  mov R2, [BP-36]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_20147:
  jf R0, __if_20142_end
  jmp __while_19947_end
__if_20142_end:
__if_20151_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  feq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20156
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_20156:
  jf R0, __if_20151_end
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
__if_20151_end:
__if_20202_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20207
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_20207:
  jf R0, __if_20202_else
  mov R0, [BP-20]
  mov [BP-19], R0
  mov R0, [BP-35]
  mov [BP-10], R0
  mov R0, [BP-34]
  mov [BP-15], R0
  jmp __if_20202_end
__if_20202_else:
  mov R0, [BP-21]
  mov [BP-19], R0
  mov R0, [BP-46]
  mov [BP-10], R0
  mov R0, [BP-45]
  mov [BP-15], R0
__if_20202_end:
  jmp __while_19947_start
__while_19947_end:
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
__if_20236_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_20236_end
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
__if_20236_end:
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
__if_20363_start:
  mov R0, [BP-6]
  ine R0, -1
  jf R0, __if_20363_else
__if_20370_start:
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  ieq R0, R1
  jf R0, __if_20370_else
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_20370_end
__if_20370_else:
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_20370_end:
  jmp __if_20363_end
__if_20363_else:
  mov R0, [BP-7]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_20363_end:
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-9], R0
__while_20403_start:
__while_20403_continue:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __while_20403_end
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
  jmp __while_20403_start
__while_20403_end:
__function_b2InsertLeaf_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveLeaf:
  push BP
  mov BP, SP
  isub SP, 11
__if_20502_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_20502_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2RemoveLeaf_return
__if_20502_end:
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
__if_20533_start:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_20533_else
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  jmp __if_20533_end
__if_20533_else:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__if_20533_end:
__if_20555_start:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __if_20555_else
__if_20562_start:
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_20562_else
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_20562_end
__if_20562_else:
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_20562_end:
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
__while_20596_start:
__while_20596_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_20596_end
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
  jmp __while_20596_start
__while_20596_end:
  jmp __if_20555_end
__if_20555_else:
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
__if_20555_end:
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
__if_20815_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20815_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20815_end:
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
__while_20838_start:
__while_20838_continue:
  mov R0, [BP-257]
  igt R0, 0
  jf R0, __while_20838_end
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
__if_20866_start:
  mov R1, [BP-259]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2AABB_Overlaps
  jf R0, __if_20866_end
__if_20873_start:
  mov R1, [BP-259]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20873_else
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
__if_20892_start:
  mov R0, [BP-260]
  ieq R0, 0
  jf R0, __if_20892_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20892_end:
  jmp __if_20873_end
__if_20873_else:
__if_20898_start:
  mov R0, [BP-257]
  ilt R0, 255
  jf R0, __if_20898_end
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
__if_20898_end:
__if_20873_end:
__if_20866_end:
  jmp __while_20838_start
__while_20838_end:
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
__if_20944_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20944_end
  jmp __function_b2DynamicTree_RayCast_return
__if_20944_end:
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
__while_21057_start:
__while_21057_continue:
  mov R0, [BP-274]
  igt R0, 0
  jf R0, __while_21057_end
  mov R0, [BP-274]
  isub R0, 1
  mov [BP-274], R0
  lea R0, [BP-273]
  mov R1, [BP-274]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-281], R0
__if_21072_start:
  mov R0, [BP-281]
  ieq R0, -1
  jf R0, __if_21072_end
  jmp __while_21057_continue
__if_21072_end:
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
__if_21095_start:
  mov R1, [BP-282]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_21095_end
  jmp __while_21057_continue
__if_21095_end:
__if_21104_start:
  lea R2, [BP-286]
  mov [SP], R2
  lea R2, [BP-17]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_21104_end
  jmp __while_21057_continue
__if_21104_end:
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
__if_21151_start:
  mov R0, [BP-294]
  mov R1, [BP-293]
  flt R0, R1
  jf R0, __if_21151_end
  jmp __while_21057_continue
__if_21151_end:
__if_21156_start:
  mov R1, [BP-282]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_21156_else
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
__if_21181_start:
  mov R0, [BP-295]
  feq R0, 0.000000
  jf R0, __if_21181_end
  jmp __function_b2DynamicTree_RayCast_return
__if_21181_end:
__if_21186_start:
  mov R0, [BP-295]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21191
  mov R1, [BP-295]
  mov R2, [BP-11]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21191:
  jf R0, __if_21186_end
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
__if_21186_end:
  jmp __if_21156_end
__if_21156_else:
__if_21243_start:
  mov R0, [BP-274]
  ilt R0, 255
  jf R0, __if_21243_end
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
__if_21280_start:
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
  jf R0, __if_21280_else
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
  jmp __if_21280_end
__if_21280_else:
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
__if_21280_end:
__if_21243_end:
__if_21156_end:
  jmp __while_21057_start
__while_21057_end:
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
__if_21357_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21357_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21357_end:
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
__while_21496_start:
__while_21496_continue:
  mov R0, [BP-278]
  igt R0, 0
  jf R0, __while_21496_end
  mov R0, [BP-278]
  isub R0, 1
  mov [BP-278], R0
  lea R0, [BP-277]
  mov R1, [BP-278]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-287], R0
__if_21511_start:
  mov R0, [BP-287]
  ieq R0, -1
  jf R0, __if_21511_end
  jmp __while_21496_continue
__if_21511_end:
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
__if_21534_start:
  mov R1, [BP-288]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_21534_end
  jmp __while_21496_continue
__if_21534_end:
__if_21543_start:
  lea R2, [BP-292]
  mov [SP], R2
  lea R2, [BP-21]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_21543_end
  jmp __while_21496_continue
__if_21543_end:
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
__if_21599_start:
  mov R0, [BP-302]
  mov R1, [BP-301]
  flt R0, R1
  jf R0, __if_21599_end
  jmp __while_21496_continue
__if_21599_end:
__if_21604_start:
  mov R1, [BP-288]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_21604_else
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
__if_21629_start:
  mov R0, [BP-303]
  feq R0, 0.000000
  jf R0, __if_21629_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21629_end:
__if_21634_start:
  mov R0, [BP-303]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21639
  mov R1, [BP-303]
  mov R2, [BP-15]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21639:
  jf R0, __if_21634_end
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
__if_21634_end:
  jmp __if_21604_end
__if_21604_else:
__if_21710_start:
  mov R0, [BP-278]
  ilt R0, 255
  jf R0, __if_21710_end
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
__if_21747_start:
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
  jf R0, __if_21747_else
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
  jmp __if_21747_end
__if_21747_else:
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
__if_21747_end:
__if_21710_end:
__if_21604_end:
  jmp __while_21496_start
__while_21496_end:
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
__if_21867_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_21867_end
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
__if_21867_end:
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
__if_21902_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_21902_end
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
__if_21922_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __if_21922_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__if_21922_end:
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
__if_21902_end:
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
__if_22405_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_22413
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22413:
  jf R0, __if_22405_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jmp __function_b2ShouldShapesCollide_return
__if_22405_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_22436
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22436:
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
  jf R0, __LogicalAnd_ShortCircuit_22473
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22473:
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
__if_22487_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22487_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleAABB
  jmp __if_22487_end
__if_22487_else:
__if_22498_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22498_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleAABB
  jmp __if_22498_end
__if_22498_else:
__if_22509_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22509_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputePolygonAABB
  jmp __if_22509_end
__if_22509_else:
__if_22520_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22520_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22520_end
__if_22520_else:
__if_22531_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22531_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22531_end
__if_22531_else:
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
__if_22531_end:
__if_22520_end:
__if_22509_end:
__if_22498_end:
__if_22487_end:
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
__if_22575_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22575_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCircle
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22575_end
__if_22575_else:
__if_22587_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22587_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCapsule
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22587_end
__if_22587_else:
__if_22599_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22599_end
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInPolygon
  jmp __function_b2ShapeTestPoint_return
__if_22599_end:
__if_22587_end:
__if_22575_end:
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
__if_22638_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22638_end
  jmp __function_b2ShapeCastShape_return
__if_22638_end:
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
__for_22661_start:
  mov R0, [BP-25]
  mov R2, [BP-23]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22661_end
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
__for_22661_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_22661_start
__for_22661_end:
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__if_22697_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22697_else
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCircle
  jmp __if_22697_end
__if_22697_else:
__if_22709_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22709_else
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCapsule
  jmp __if_22709_end
__if_22709_else:
__if_22721_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22721_else
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastPolygon
  jmp __if_22721_end
__if_22721_else:
__if_22733_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22733_else
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
  jmp __if_22733_end
__if_22733_else:
__if_22745_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22745_end
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
__if_22745_end:
__if_22733_end:
__if_22721_end:
__if_22709_end:
__if_22697_end:
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
__if_22804_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22804_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCircle
  jmp __if_22804_end
__if_22804_else:
__if_22816_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22816_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCapsule
  jmp __if_22816_end
__if_22816_else:
__if_22828_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22828_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndPolygon
  jmp __if_22828_end
__if_22828_else:
__if_22840_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22840_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22840_end
__if_22840_else:
__if_22852_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22852_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22852_end
__if_22852_else:
  jmp __function_b2CollideMover_return
__if_22852_end:
__if_22840_end:
__if_22828_end:
__if_22816_end:
__if_22804_end:
__if_22866_start:
  mov R1, [BP+5]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22866_end
  jmp __function_b2CollideMover_return
__if_22866_end:
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
__if_22890_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22890_else
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
  jmp __if_22890_end
__if_22890_else:
__if_22905_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22905_else
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
  jmp __if_22905_end
__if_22905_else:
__if_22920_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22920_else
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
  jmp __if_22920_end
__if_22920_else:
__if_22936_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22936_else
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
  jmp __if_22936_end
__if_22936_else:
__if_22949_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22949_else
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
  jmp __if_22949_end
__if_22949_else:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 16
  mov [R1], R0
__if_22949_end:
__if_22936_end:
__if_22920_end:
__if_22905_end:
__if_22890_end:
__function_b2MakeShapeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShapeCentroid:
  push BP
  mov BP, SP
  isub SP, 4
__if_22970_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22970_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 30
  mov CR, 2
  movs
  jmp __if_22970_end
__if_22970_else:
__if_22981_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22981_else
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
  jmp __if_22981_end
__if_22981_else:
__if_22997_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22997_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 38
  iadd R12, 32
  mov CR, 2
  movs
  jmp __if_22997_end
__if_22997_else:
__if_23008_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_23008_else
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
  jmp __if_23008_end
__if_23008_else:
__if_23024_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_23024_else
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
  jmp __if_23024_end
__if_23024_else:
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_23024_end:
__if_23008_end:
__if_22997_end:
__if_22981_end:
__if_22970_end:
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
__if_23049_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23049_end
  mov R1, [BP+2]
  iadd R1, 30
  iadd R1, 2
  mov R0, [R1]
  fmul R0, 2.000000
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_23049_end:
__if_23060_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23060_end
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
__if_23060_end:
__if_23094_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23094_end
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
__for_23118_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_23118_end
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
__for_23118_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_23118_start
__for_23118_end:
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
__if_23094_end:
__if_23164_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_23164_end
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
__if_23164_end:
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
__if_23196_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23196_else
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
  jmp __if_23196_end
__if_23196_else:
__if_23208_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23208_else
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
  jmp __if_23208_end
__if_23208_else:
__if_23220_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23220_else
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
  jmp __if_23220_end
__if_23220_else:
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
__if_23220_end:
__if_23208_end:
__if_23196_end:
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
__if_23263_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23263_else
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
  jmp __if_23263_end
__if_23263_else:
__if_23311_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23311_else
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
  jmp __if_23311_end
__if_23311_else:
__if_23344_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23344_end
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
__for_23370_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_23370_end
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
__for_23370_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_23370_start
__for_23370_end:
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
__if_23344_end:
__if_23311_end:
__if_23263_end:
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
__if_23519_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_23519_end
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
__if_23519_end:
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
__if_23553_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_23553_end
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
__if_23553_end:
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
__if_23671_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23671_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  call __function_b2GrowBitSet
__if_23671_end:
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
__if_23706_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23706_end
  jmp __function_b2ClearBit_return
__if_23706_end:
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
__if_23739_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23739_end
  mov R0, 0
  jmp __function_b2GetBit_return
__if_23739_end:
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
  jt R0, __LogicalOr_ShortCircuit_23891
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+3]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ine R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_23891:
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
__while_23911_start:
__while_23911_continue:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_23915
  mov R4, [BP+2]
  mov R3, [R4]
  mov R4, [BP-2]
  imul R4, 2
  iadd R3, R4
  mov R2, [R3]
  mov R3, [BP+3]
  ieq R2, R3
  jf R2, __LogicalAnd_ShortCircuit_23930
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
__LogicalAnd_ShortCircuit_23930:
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_23915:
  mov R0, R1
  jf R0, __while_23911_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
  jmp __while_23911_start
__while_23911_end:
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
__if_23950_start:
  mov R0, [BP+2]
  igt R0, 16
  jf R0, __if_23950_else
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2RoundUpPowerOf2
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_23950_end
__if_23950_else:
  mov R0, 16
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_23950_end:
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
__for_24099_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_24099_end
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
__if_24121_start:
  mov R0, [BP-4]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_24126
  mov R1, [BP-5]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_24126:
  jf R0, __if_24121_end
  jmp __for_24099_continue
__if_24121_end:
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
__for_24099_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_24099_start
__for_24099_end:
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
__if_24150_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __if_24150_else
  mov R0, [BP+2]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_24150_end
__if_24150_else:
  mov R0, [BP+3]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
__if_24150_end:
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
  jf R0, __LogicalAnd_ShortCircuit_24212
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
__LogicalAnd_ShortCircuit_24212:
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
__if_24242_start:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2SlotOccupied
  jf R0, __if_24242_end
  mov R0, 1
  jmp __function_b2AddKey_return
__if_24242_end:
__if_24248_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_24248_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2GrowTable
__if_24248_end:
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
__if_24292_start:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_24292_end
  mov R0, 0
  jmp __function_b2RemoveKey_return
__if_24292_end:
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
__while_24328_start:
__while_24328_continue:
  mov R0, 1
  jf R0, __while_24328_end
  mov R0, [BP-6]
  iadd R0, 1
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-6], R0
__if_24342_start:
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_24355
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_24355:
  jf R0, __if_24342_end
  jmp __while_24328_end
__if_24342_end:
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
__if_24380_start:
  mov R0, [BP-4]
  mov R1, [BP-6]
  ile R0, R1
  jf R0, __if_24380_else
__if_24385_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_24390
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24390:
  jf R0, __if_24385_end
  jmp __while_24328_continue
__if_24385_end:
  jmp __if_24380_end
__if_24380_else:
__if_24395_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jt R0, __LogicalOr_ShortCircuit_24400
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_24400:
  jf R0, __if_24395_end
  jmp __while_24328_continue
__if_24395_end:
__if_24380_end:
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
  jmp __while_24328_start
__while_24328_end:
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
__for_24463_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_24463_end
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
__for_24463_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24463_start
__for_24463_end:
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
__for_24515_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_24515_end
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
__for_24515_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24515_start
__for_24515_end:
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
__if_24549_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_24549_end
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
__if_24549_end:
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
__if_24582_start:
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
  jf R0, __if_24582_end
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
__if_24582_end:
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
__if_24645_start:
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
  jf R0, __if_24645_end
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
__for_24667_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_24667_end
__if_24677_start:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_24677_end
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
  jmp __for_24667_end
__if_24677_end:
__for_24667_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_24667_start
__for_24667_end:
__if_24645_end:
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
__for_24707_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_24707_end
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
__for_24707_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24707_start
__for_24707_end:
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
__if_24771_start:
  mov R0, [BP+3]
  ine R0, 0
  jf R0, __if_24771_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2BufferMove
__if_24771_end:
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
__if_24924_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_24924_end
  mov R0, [BP+2]
  jmp __function_b2ContactEdgeAt_return
__if_24924_end:
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
  jt R0, __LogicalOr_ShortCircuit_24950
  mov R1, [BP+2]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24950:
  mov [BP-1], R0
  mov R0, [BP+3]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_24960
  mov R1, [BP+3]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24960:
  mov [BP-2], R0
__if_24963_start:
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_24965
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_24965:
  jf R0, __if_24963_end
  mov R0, 0
  jmp __function_b2CanCollide_return
__if_24963_end:
  mov R0, 1
__function_b2CanCollide_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCollisionRank:
  push BP
  mov BP, SP
__if_24973_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_24973_end
  mov R0, 0
  jmp __function_b2ShapeCollisionRank_return
__if_24973_end:
__if_24979_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_24979_end
  mov R0, 1
  jmp __function_b2ShapeCollisionRank_return
__if_24979_end:
__if_24985_start:
  mov R0, [BP+2]
  ieq R0, 3
  jf R0, __if_24985_end
  mov R0, 2
  jmp __function_b2ShapeCollisionRank_return
__if_24985_end:
__if_24991_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_24991_end
  mov R0, 3
  jmp __function_b2ShapeCollisionRank_return
__if_24991_end:
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
__if_25025_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_25025_else
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
  jmp __if_25025_end
__if_25025_else:
__if_25039_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_25039_else
__if_25044_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25044_else
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
  jmp __if_25044_end
__if_25044_else:
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
__if_25044_end:
  jmp __if_25039_end
__if_25039_else:
__if_25066_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_25066_else
__if_25071_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25071_else
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
  jmp __if_25071_end
__if_25071_else:
__if_25084_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25084_else
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
  jmp __if_25084_end
__if_25084_else:
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
__if_25084_end:
__if_25071_end:
  jmp __if_25066_end
__if_25066_else:
__if_25106_start:
  mov R0, [BP-1]
  ieq R0, 4
  jf R0, __if_25106_else
__if_25111_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25111_else
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
  jmp __if_25111_end
__if_25111_else:
__if_25124_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25124_else
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
  jmp __if_25124_end
__if_25124_else:
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
__if_25124_end:
__if_25111_end:
  jmp __if_25106_end
__if_25106_else:
__if_25165_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25165_else
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
  jmp __if_25165_end
__if_25165_else:
__if_25178_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25178_else
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
  jmp __if_25178_end
__if_25178_else:
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
__if_25178_end:
__if_25165_end:
__if_25106_end:
__if_25066_end:
__if_25039_end:
__if_25025_end:
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
__if_25287_start:
  mov R0, [BP+3]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_25292
  mov R1, [BP+4]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_25292:
  jf R0, __if_25287_else
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
  jmp __if_25287_end
__if_25287_else:
__if_25308_start:
  mov R0, [BP+3]
  ige R0, 2
  jf R0, __LogicalAnd_ShortCircuit_25313
  mov R1, [BP+7]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_25313:
  jf R0, __if_25308_end
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
__if_25308_end:
__if_25287_end:
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
__if_25443_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_25443_end
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
__if_25443_end:
__if_25465_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_25465_end
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
__if_25465_end:
__if_25487_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_25487_end
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
__if_25487_end:
__if_25506_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_25506_end
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
__if_25506_end:
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
__if_25558_start:
  mov R0, [BP-25]
  jf R0, __if_25558_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 65536
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25558_end
__if_25558_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25558_end:
__if_25575_start:
  mov R0, [BP-25]
  jf R0, __LogicalAnd_ShortCircuit_25577
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  jt R1, __LogicalOr_ShortCircuit_25581
  mov R3, [BP+6]
  iadd R3, 22
  mov R2, [R3]
  or R1, R2
__LogicalOr_ShortCircuit_25581:
  and R0, R1
__LogicalAnd_ShortCircuit_25577:
  jf R0, __if_25575_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 1048576
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25575_end
__if_25575_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -1048577
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25575_end:
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
__if_25613_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __if_25613_end
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
__if_25613_end:
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
__if_26026_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_26026_end
  mov R0, [BP+2]
  iadd R0, 4
  jmp __function_b2JointEdgeAt_return
__if_26026_end:
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
  jf R0, __LogicalAnd_ShortCircuit_26404
  mov R2, [BP+3]
  iadd R2, 23
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_26404:
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

__function_b2World_GetContactHitEventCount:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  iadd R1, 73
  iadd R1, 1
  mov R0, [R1]
__function_b2World_GetContactHitEventCount_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2World_GetContactHitEvents:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
__function_b2World_GetContactHitEvents_return:
  pop R1
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
__for_26814_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_26814_end
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
__for_26814_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26814_start
__for_26814_end:
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
__for_26992_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26992_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
__if_27012_start:
  mov R1, [BP-2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27012_end
  mov R2, [BP-2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_27012_end:
__if_27027_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27027_end
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
__if_27027_end:
__if_27042_start:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27042_end
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
__if_27042_end:
__if_27057_start:
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27057_end
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
__if_27057_end:
__if_27072_start:
  mov R1, [BP-2]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27072_end
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
__if_27072_end:
__for_26992_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26992_start
__for_26992_end:
__if_27087_start:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27087_end
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
__if_27087_end:
__if_27102_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27102_end
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
__if_27102_end:
__if_27117_start:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27117_end
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
__if_27117_end:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2DestroyBroadPhase
__if_27136_start:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27136_end
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
__if_27136_end:
__if_27151_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27151_end
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
__if_27151_end:
  mov R0, 0
  mov [BP-1], R0
__for_27166_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27166_end
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_27186_start:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27186_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27186_end:
__if_27196_start:
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27196_end
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
__if_27196_end:
__if_27208_start:
  mov R1, [BP-2]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27208_end
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
__if_27208_end:
__for_27166_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_27166_start
__for_27166_end:
__if_27220_start:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27220_end
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
__if_27220_end:
__if_27235_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27235_end
  mov R2, [BP+2]
  iadd R2, 65
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27235_end:
__if_27245_start:
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27245_end
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
__if_27245_end:
__if_27260_start:
  mov R1, [BP+2]
  iadd R1, 70
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27260_end
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
__if_27260_end:
__if_27275_start:
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27275_end
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
__if_27275_end:
__if_27290_start:
  mov R1, [BP+2]
  iadd R1, 76
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27290_end
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
__if_27290_end:
__if_27305_start:
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27305_end
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
__if_27305_end:
__if_27320_start:
  mov R1, [BP+2]
  iadd R1, 82
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27320_end
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
__if_27320_end:
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
__if_27365_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_27365_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
  mov R0, 1
  jmp __function_b2WakeBody_return
__if_27365_end:
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
__if_27388_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_27388_end
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
__if_27388_end:
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
__if_27543_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_27543_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_27543_end:
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
__if_27582_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27582_end
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
__if_27582_end:
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
__if_27623_start:
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27623_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27623_end:
__if_27633_start:
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27633_end
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
__if_27633_end:
__if_27645_start:
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27645_end
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
__if_27645_end:
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
__if_27724_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_27724_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27724_end:
__if_27730_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_27730_end
  mov R0, [BP+4]
  jmp __function_b2MergeIslands_return
__if_27730_end:
__if_27738_start:
  mov R0, [BP+4]
  ieq R0, -1
  jf R0, __if_27738_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27738_end:
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
__if_27766_start:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_27766_else
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
  jmp __if_27766_end
__if_27766_else:
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__if_27766_end:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_27792_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27792_end
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
__for_27792_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27792_start
__for_27792_end:
  mov R0, 0
  mov [BP-6], R0
__for_27854_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27854_end
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
__for_27854_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27854_start
__for_27854_end:
  mov R0, 0
  mov [BP-6], R0
__for_27917_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27917_end
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
__for_27917_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27917_start
__for_27917_end:
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
__if_28136_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28136_end
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
__if_28136_end:
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
__if_28312_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_28312_end
  jmp __function_b2UnlinkJoint_return
__if_28312_end:
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
__if_28342_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28342_end
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
__if_28342_end:
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
__if_28441_start:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_28441_end
  jmp __function_b2RemoveBodyFromIsland_return
__if_28441_end:
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
__if_28471_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28471_end
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
__if_28471_end:
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
__if_28515_start:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28515_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2DestroyIsland
__if_28515_end:
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
__while_28526_start:
__while_28526_continue:
  mov R0, [BP+2]
  mov R1, [BP+3]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ine R0, R1
  jf R0, __while_28526_end
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
  jmp __while_28526_start
__while_28526_end:
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
__if_28565_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_28565_end
  jmp __function_b2IslandUnion_return
__if_28565_end:
__if_28570_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_28570_else
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28570_end
__if_28570_else:
__if_28583_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  igt R0, R1
  jf R0, __if_28583_else
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28583_end
__if_28583_else:
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
__if_28583_end:
__if_28570_end:
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
__if_28658_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_28658_end
  jmp __function_b2SplitIsland_return
__if_28658_end:
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
__for_28673_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28673_end
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
__for_28673_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28673_start
__for_28673_end:
  mov R0, 0
  mov [BP-13], R0
__for_28693_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28693_end
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
__if_28725_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28732
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28732:
  jf R0, __if_28725_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28725_end:
__for_28693_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28693_start
__for_28693_end:
  mov R0, 0
  mov [BP-13], R0
__for_28742_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28742_end
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
__if_28774_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28781
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28781:
  jf R0, __if_28774_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28774_end:
__for_28742_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28742_start
__for_28742_end:
  mov R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
__for_28797_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28797_end
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
__if_28814_start:
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-13]
  ieq R0, R1
  jf R0, __if_28814_end
  mov R0, [BP-14]
  iadd R0, 1
  mov [BP-14], R0
__if_28814_end:
__for_28797_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28797_start
__for_28797_end:
__if_28825_start:
  mov R0, [BP-14]
  ieq R0, 1
  jf R0, __if_28825_end
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
__if_28825_end:
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
__for_28881_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28881_end
  mov R0, -1
  mov R1, [BP-15]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_28881_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28881_start
__for_28881_end:
  mov R0, 0
  mov [BP-13], R0
__for_28897_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28897_end
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
__if_28912_start:
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov R0, [R0]
  ieq R0, -1
  jf R0, __if_28912_end
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
__if_28912_end:
__for_28897_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28897_start
__for_28897_end:
  mov R0, 0
  mov [BP-13], R0
__for_28932_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28932_end
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
__for_28932_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28932_start
__for_28932_end:
  mov R0, 0
  mov [BP-13], R0
__for_29007_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_29007_end
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
__if_29031_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_29031_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_29031_end:
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
__for_29007_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_29007_start
__for_29007_end:
  mov R0, 0
  mov [BP-13], R0
__for_29100_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_29100_end
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
__if_29124_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_29124_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_29124_end:
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
__for_29100_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_29100_start
__for_29100_end:
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
__for_29232_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_29232_end
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
__if_29260_start:
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_29266
  mov R1, [BP-4]
  mov R2, [BP-2]
  igt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_29266:
  jf R0, __if_29260_end
  mov R0, [BP-4]
  mov [BP-2], R0
__if_29260_end:
__for_29232_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_29232_start
__for_29232_end:
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
__if_29438_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29438_end
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
__if_29438_end:
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
  jt R0, __LogicalOr_ShortCircuit_29511
  mov R2, [BP+3]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_29511:
  jf R0, __LogicalAnd_ShortCircuit_29516
  mov R2, [BP+3]
  iadd R2, 19
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_29516:
  mov [BP-1], R0
__if_29521_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29521_else
  mov R0, 1
  mov [BP-2], R0
  jmp __if_29521_end
__if_29521_else:
__if_29530_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29530_else
  mov R0, 0
  mov [BP-2], R0
  jmp __if_29530_end
__if_29530_else:
__if_29539_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_29539_else
  mov R0, 2
  mov [BP-2], R0
  jmp __if_29539_end
__if_29539_else:
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
__if_29554_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29554_end
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
__if_29554_end:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov [R1], R0
__if_29539_end:
__if_29530_end:
__if_29521_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__if_29696_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  jf R0, __if_29696_end
  mov R0, [BP-4]
  or R0, 1
  mov [BP-4], R0
__if_29696_end:
__if_29704_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  jf R0, __if_29704_end
  mov R0, [BP-4]
  or R0, 2
  mov [BP-4], R0
__if_29704_end:
__if_29712_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  jf R0, __if_29712_end
  mov R0, [BP-4]
  or R0, 4
  mov [BP-4], R0
__if_29712_end:
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
__if_29831_start:
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  jf R0, __if_29831_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 16
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29831_end:
__if_29841_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_29841_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 128
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29841_end:
__if_29851_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29851_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 512
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29851_end:
__if_29863_start:
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  jf R0, __if_29863_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 2048
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29863_end:
__if_29873_start:
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  jf R0, __if_29873_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 4096
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29873_end:
__if_29883_start:
  mov R0, [BP-2]
  ieq R0, 2
  jf R0, __if_29883_end
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
__if_29883_end:
__if_29948_start:
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29948_end
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
__if_29948_end:
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
__if_30108_start:
  mov R0, [BP-2]
  ige R0, 2
  jf R0, __if_30108_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2CreateIslandForBody
__if_30108_end:
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
__while_30198_start:
__while_30198_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30198_end
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
  jmp __while_30198_start
__while_30198_end:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_30237_start:
__while_30237_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_30237_end
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
  jmp __while_30237_start
__while_30237_end:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__while_30276_start:
__while_30276_continue:
  mov R0, [BP-4]
  ine R0, -1
  jf R0, __while_30276_end
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
  jmp __while_30276_start
__while_30276_end:
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
__if_30321_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_30321_else
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-6], R0
__if_30334_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  ine R0, R1
  jf R0, __if_30334_end
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
__if_30334_end:
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_30321_end
__if_30321_else:
__if_30360_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __LogicalAnd_ShortCircuit_30368
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_30368:
  jf R0, __if_30360_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2DestroySolverSet
__if_30360_end:
__if_30321_end:
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
__if_30441_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_30441_end
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
__if_30458_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_30458_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30468_start:
__while_30468_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30468_end
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
  jmp __while_30468_start
__while_30468_end:
__if_30458_end:
  jmp __function_b2UpdateBodyMassData_return
__if_30441_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30519_start:
__while_30519_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30519_end
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
  jmp __while_30519_start
__while_30519_end:
__if_30567_start:
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30567_end
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
__if_30567_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30596_start:
__while_30596_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30596_end
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
__if_30617_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_30617_end
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
__if_30617_end:
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_30596_start
__while_30596_end:
__if_30657_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30657_else
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 13
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  jmp __if_30657_end
__if_30657_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_30657_end:
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
__if_30701_start:
  mov R0, [BP-7]
  ine R0, -1
  jf R0, __if_30701_end
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
__if_30701_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30743_start:
__while_30743_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30743_end
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
  jmp __while_30743_start
__while_30743_end:
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
__if_30798_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30798_end
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
__if_30798_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_30849_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_30849_else
  mov R13, [BP-2]
  iadd R13, 30
  mov R12, [BP+5]
  mov CR, 3
  movs
  jmp __if_30849_end
__if_30849_else:
__if_30859_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_30859_else
  mov R13, [BP-2]
  iadd R13, 33
  mov R12, [BP+5]
  mov CR, 5
  movs
  jmp __if_30859_end
__if_30859_else:
__if_30869_start:
  mov R0, [BP+6]
  ieq R0, 3
  jf R0, __if_30869_else
  mov R13, [BP-2]
  iadd R13, 38
  mov R12, [BP+5]
  mov CR, 36
  movs
  jmp __if_30869_end
__if_30869_else:
__if_30879_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_30879_else
  mov R13, [BP-2]
  iadd R13, 74
  mov R12, [BP+5]
  mov CR, 4
  movs
  jmp __if_30879_end
__if_30879_else:
__if_30889_start:
  mov R0, [BP+6]
  ieq R0, 4
  jf R0, __if_30889_end
  mov R13, [BP-2]
  iadd R13, 78
  mov R12, [BP+5]
  mov CR, 9
  movs
__if_30889_end:
__if_30879_end:
__if_30869_end:
__if_30859_end:
__if_30849_end:
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
__if_30982_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_30982_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_30982_end
__if_30982_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_30982_end:
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
__if_31024_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __if_31024_end
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
__if_31024_end:
__if_31155_start:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31155_end
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
__if_31155_end:
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
__if_31219_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31219_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31219_end:
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
__if_31261_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31261_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31261_end:
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
__if_31345_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31345_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31345_end:
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
__if_31690_start:
  mov R0, [BP+4]
  jf R0, __if_31690_end
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_31697_start:
__while_31697_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31697_end
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
__if_31728_start:
  mov R1, [BP-6]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_31735
  mov R2, [BP-6]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_31735:
  jf R0, __if_31728_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_31728_end:
  jmp __while_31697_start
__while_31697_end:
__if_31690_end:
__if_31742_start:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31742_end
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
__if_31742_end:
__if_31759_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31759_end
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
__if_31759_end:
__if_31776_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_31776_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
__if_31776_end:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__if_31793_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31793_end
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
__if_31793_end:
__if_31813_start:
  mov R1, [BP+3]
  iadd R1, 26
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31813_end
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
__if_31813_end:
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  mov [R1], R0
__if_31849_start:
  mov R0, [BP+5]
  jf R0, __if_31849_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31849_end:
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
__while_31923_start:
__while_31923_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31923_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_31938_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31938_end
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
__if_31938_end:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  jmp __while_31923_start
__while_31923_end:
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
__if_32293_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32293_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Body_GetLinearVelocity_return
__if_32293_end:
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
__if_32325_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32325_end
  mov R0, 0.000000
  jmp __function_b2Body_GetAngularVelocity_return
__if_32325_end:
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
__if_32343_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_32343_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_32343_end:
__if_32349_start:
  mov R2, [BP+4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  fgt R1, 0.000000
  mov R0, R1
  jf R0, __if_32349_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32349_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_32362_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32362_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_32362_end:
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
__if_32381_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_32381_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_32381_end:
__if_32387_start:
  mov R0, [BP+4]
  fne R0, 0.000000
  jf R0, __if_32387_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32387_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_32399_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32399_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_32399_end:
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
__if_32472_start:
  mov R0, [BP+5]
  jf R0, __if_32472_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32472_end:
__if_32477_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32477_end
  jmp __function_b2Body_ApplyForceToCenter_return
__if_32477_end:
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
__if_32506_start:
  mov R0, [BP+5]
  jf R0, __if_32506_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32506_end:
__if_32511_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32511_end
  jmp __function_b2Body_ApplyTorque_return
__if_32511_end:
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
__if_32603_start:
  mov R0, [BP+5]
  jf R0, __if_32603_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32603_end:
__if_32608_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32608_end
  jmp __function_b2Body_ApplyLinearImpulseToCenter_return
__if_32608_end:
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
__while_33451_start:
__while_33451_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_33451_end
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
__if_33482_start:
  mov R1, [BP-10]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_33489
  mov R2, [BP-10]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-2]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_33489:
  jf R0, __if_33482_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_33482_end:
  jmp __while_33451_start
__while_33451_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
__if_33503_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33503_else
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
__if_33523_start:
  mov R0, [BP+5]
  jf R0, __if_33523_else
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
  jmp __if_33523_end
__if_33523_else:
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
__if_33523_end:
  jmp __if_33503_end
__if_33503_else:
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
__if_33503_end:
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
__if_33578_start:
  mov R0, [BP+4]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  feq R0, R1
  jf R0, __if_33578_end
  jmp __function_b2Shape_SetDensity_return
__if_33578_end:
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_33588_start:
  mov R0, [BP+5]
  jf R0, __if_33588_end
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
__if_33588_end:
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
__if_33845_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_33845_end
  mov R1, [BP-1]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__if_33845_end:
__function_b2SyncBodyFlags_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_EnableHitEvents:
  push BP
  mov BP, SP
  isub SP, 5
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_34924_start:
__while_34924_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_34924_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP+4]
  mov R1, [BP-3]
  iadd R1, 22
  mov [R1], R0
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_34924_start
__while_34924_end:
__function_b2Body_EnableHitEvents_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransferBody:
  push BP
  mov BP, SP
  isub SP, 8
__if_35040_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_35040_end
  jmp __function_b2TransferBody_return
__if_35040_end:
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
__if_35119_start:
  mov R1, [BP+4]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_35119_else
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_35132_start:
  mov R0, [BP-1]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_35132_end
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
__if_35132_end:
  mov R0, [BP-4]
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_35119_end
__if_35119_else:
__if_35152_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_35152_end
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
__if_35152_end:
__if_35119_end:
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
__if_35222_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_35222_end
  jmp __function_b2TransferJoint_return
__if_35222_end:
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
__if_35281_start:
  mov R0, [BP-1]
  mov R1, [BP-3]
  ine R0, R1
  jf R0, __if_35281_end
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
__if_35281_end:
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
__while_35341_start:
__while_35341_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_35341_end
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
  jmp __while_35341_start
__while_35341_end:
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
__while_35383_start:
__while_35383_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_35383_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_35398_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_35398_end
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
__if_35398_end:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_35383_start
__while_35383_end:
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
__while_35437_start:
__while_35437_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_35437_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
__if_35452_start:
  mov R0, [BP+4]
  ieq R0, 0
  jf R0, __if_35452_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_35452_end
__if_35452_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_35452_end:
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
  jmp __while_35437_start
__while_35437_end:
__function_b2CreateBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_EnableSleeping:
  push BP
  mov BP, SP
  isub SP, 3
__if_36317_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 51
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_36317_end
  jmp __function_b2World_EnableSleeping_return
__if_36317_end:
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 51
  mov [R1], R0
__if_36327_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_36327_end
  mov R0, 3
  mov [BP-1], R0
__for_36334_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_36334_end
__if_36346_start:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_36346_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_36346_end:
__for_36334_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_36334_start
__for_36334_end:
__if_36327_end:
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
__if_36424_start:
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
  jf R0, __if_36424_end
  mov R0, 1
  jmp __function_b2OverlapFilterCallback_return
__if_36424_end:
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
__if_36466_start:
  mov R0, [BP+4]
  ine R0, -1
  jf R0, __if_36466_end
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
__if_36466_end:
  mov R0, 0
  mov [BP-7], R0
__for_36497_start:
  mov R0, [BP-7]
  ilt R0, 3
  jf R0, __for_36497_end
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
__for_36497_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_36497_start
__for_36497_end:
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
__if_36566_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36577
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
__LogicalAnd_ShortCircuit_36577:
  mov R0, R1
  jf R0, __if_36566_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2RayCastClosestCallback_return
__if_36566_end:
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
__if_36649_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_36649_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_36649_end
__if_36649_else:
__if_36662_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_36662_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_36662_end
__if_36662_else:
__if_36675_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_36675_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_36675_end
__if_36675_else:
__if_36688_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_36688_end
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
__if_36688_end:
__if_36675_end:
__if_36662_end:
__if_36649_end:
__if_36702_start:
  mov R0, [BP-12]
  jf R0, __LogicalAnd_ShortCircuit_36705
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36705:
  jf R0, __if_36702_end
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
__if_36702_end:
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
__if_36820_start:
  mov R0, [BP+5]
  ine R0, -1
  jf R0, __if_36820_end
  mov R1, [BP+5]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-16], R0
__if_36820_end:
  mov R0, 0
  mov [BP-17], R0
__for_36830_start:
  mov R0, [BP-17]
  ilt R0, 3
  jf R0, __for_36830_end
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
__if_36858_start:
  mov R0, [BP-2]
  jf R0, __if_36858_end
  mov R0, [BP-4]
  mov [BP-11], R0
__if_36858_end:
__for_36830_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_36830_start
__for_36830_end:
  lea R13, [BP+6]
  mov R13, [R13]
  lea R12, [BP-8]
  mov CR, 7
  movs
__if_36873_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_36873_end
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
__if_36873_end:
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
__if_36919_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36930
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
__LogicalAnd_ShortCircuit_36930:
  mov R0, R1
  jf R0, __if_36919_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2ShapeCastClosestCallback_return
__if_36919_end:
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
__if_36985_start:
  mov R0, [BP-29]
  jf R0, __LogicalAnd_ShortCircuit_36988
  mov R1, [BP-31]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36988:
  jf R0, __if_36985_end
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
__if_36985_end:
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
__if_37485_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37496
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
__LogicalAnd_ShortCircuit_37496:
  mov R0, R1
  jf R0, __if_37485_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2WorldRayCastCallback_return
__if_37485_end:
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
__if_37568_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_37568_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_37568_end
__if_37568_else:
__if_37581_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_37581_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_37581_end
__if_37581_else:
__if_37594_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_37594_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_37594_end
__if_37594_else:
__if_37607_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_37607_end
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
__if_37607_end:
__if_37594_end:
__if_37581_end:
__if_37568_end:
__if_37621_start:
  mov R0, [BP-12]
  jf R0, __if_37621_end
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
__if_37656_start:
  mov R0, [BP-26]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37661
  mov R1, [BP-26]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37661:
  jf R0, __if_37656_end
  mov R0, [BP-26]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37656_end:
  mov R0, [BP-26]
  jmp __function_b2WorldRayCastCallback_return
__if_37621_end:
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
__if_37791_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37802
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
__LogicalAnd_ShortCircuit_37802:
  mov R0, R1
  jf R0, __if_37791_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2WorldShapeCastCallback_return
__if_37791_end:
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
__if_37857_start:
  mov R0, [BP-29]
  jf R0, __if_37857_end
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
__if_37892_start:
  mov R0, [BP-43]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37897
  mov R1, [BP-43]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37897:
  jf R0, __if_37892_end
  mov R0, [BP-43]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37892_end:
  mov R0, [BP-43]
  jmp __function_b2WorldShapeCastCallback_return
__if_37857_end:
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
__if_38181_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38192
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
__LogicalAnd_ShortCircuit_38192:
  mov R0, R1
  jf R0, __if_38181_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_38181_end:
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
__if_38256_start:
  mov R0, [BP-56]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_38256_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_38256_end:
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
__if_38271_start:
  mov R0, [BP-64]
  ieq R0, 0
  jf R0, __if_38271_end
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_38271_end:
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
__if_38596_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_38596_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38596_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_38610_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_38610_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38610_end:
  lea R12, [BP-67]
  lea DR, [BP-69]
  mov CR, 2
  movs
__if_38621_start:
  mov R0, [BP-61]
  feq R0, 0.000000
  jf R0, __if_38621_end
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  call __function_b2GetShapeCentroid
__if_38621_end:
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
__if_38650_start:
  lea R2, [BP-71]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-72]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_38650_else
  lea R1, [BP-71]
  mov [SP], R1
  lea R1, [BP-89]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R13, [BP-71]
  lea R12, [BP-89]
  mov CR, 2
  movs
  jmp __if_38650_end
__if_38650_else:
  mov R0, 1.000000
  mov [BP-71], R0
  mov R0, 0.000000
  mov [BP-70], R0
__if_38650_end:
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
__if_38692_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_38700
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_38700:
  jf R0, __if_38692_end
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
__if_38692_end:
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
__if_38939_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38950
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
__LogicalAnd_ShortCircuit_38950:
  mov R0, R1
  jf R0, __if_38939_end
  mov R0, 1
  jmp __function_b2MoverCollideCallback_return
__if_38939_end:
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
__if_38981_start:
  mov R1, [BP-6]
  jf R1, __LogicalAnd_ShortCircuit_38984
  lea R3, [BP-11]
  mov [SP], R3
  call __function_b2IsNormalized
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_38984:
  mov R0, R1
  jf R0, __if_38981_end
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
__if_38981_end:
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
__if_39146_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_39157
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
__LogicalAnd_ShortCircuit_39157:
  mov R0, R1
  jf R0, __if_39146_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_39146_end:
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
__if_39197_start:
  mov R0, [BP-30]
  feq R0, 0.000000
  jf R0, __if_39197_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_39197_end:
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
__if_39410_start:
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
  jf R0, __if_39410_end
  jmp __function_b2CreateContact_return
__if_39410_end:
__if_39419_start:
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
  jf R0, __if_39419_end
  mov R0, [BP+3]
  mov [BP-12], R0
  mov R0, [BP+4]
  mov [BP+3], R0
  mov R0, [BP-12]
  mov [BP+4], R0
__if_39419_end:
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
__if_39457_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_39464
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  or R0, R1
__LogicalOr_ShortCircuit_39464:
  jf R0, __if_39457_else
  mov R0, 2
  mov [BP-3], R0
  jmp __if_39457_end
__if_39457_else:
  mov R0, 1
  mov [BP-3], R0
__if_39457_end:
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
__if_39487_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_39487_end
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
__if_39487_end:
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
__if_39597_start:
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  and R0, 4096
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_39610
  mov R2, [BP-2]
  iadd R2, 18
  mov R1, [R2]
  and R1, 4096
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_39610:
  jf R0, __if_39597_end
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_39597_end:
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
__if_39653_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39653_end
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
__if_39653_end:
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
__if_39725_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39725_end
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
__if_39725_end:
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
__if_39863_start:
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39863_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_39863_end:
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
__if_39898_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39898_end
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
__if_39898_end:
__if_39927_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39927_end
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
__if_39927_end:
__if_39956_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_39956_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_39956_end:
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
__if_39995_start:
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39995_end
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
__if_39995_end:
__if_40024_start:
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40024_end
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
__if_40024_end:
__if_40053_start:
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_40053_end
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
__if_40053_end:
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
__if_40096_start:
  mov R0, [BP-8]
  mov R1, [BP-9]
  ine R0, R1
  jf R0, __if_40096_end
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
__if_40096_end:
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
__if_40171_start:
  mov R0, [BP+4]
  jf R0, __LogicalAnd_ShortCircuit_40173
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_40173:
  jf R0, __if_40171_end
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
__if_40171_end:
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
__if_40233_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 64
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_40233_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40233_end:
__if_40241_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_40248
  mov R2, [BP+3]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 33
  iadd R3, 1
  mov R2, [R3]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_40248:
  jf R0, __if_40241_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40241_end:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
__if_40266_start:
  mov R1, [BP-1]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_40266_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40266_end:
__if_40275_start:
  mov R1, [BP-1]
  iadd R1, 15
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_40275_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40275_end:
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
__while_40602_start:
__while_40602_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40602_end
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
__if_40633_start:
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
  jf R0, __if_40633_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_40633_end:
  jmp __while_40602_start
__while_40602_end:
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
__while_40662_start:
__while_40662_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40662_end
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
__if_40695_start:
  mov R0, [BP-6]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_40701
  mov R2, [BP-5]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_40701:
  jf R0, __if_40695_end
  mov R0, 0
  jmp __function_b2ShouldBodiesCollide_return
__if_40695_end:
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
  jmp __while_40662_start
__while_40662_end:
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
__if_40747_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 1
  jt R0, __LogicalOr_ShortCircuit_40754
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 1
  or R0, R1
__LogicalOr_ShortCircuit_40754:
  jf R0, __if_40747_else
  mov R0, 1
  mov [BP-3], R0
  jmp __if_40747_end
__if_40747_else:
__if_40760_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_40767
  mov R2, [BP-2]
  iadd R2, 19
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_40767:
  jf R0, __if_40760_else
  mov R0, 0
  mov [BP-3], R0
  jmp __if_40760_end
__if_40760_else:
  mov R0, 2
  mov [BP-3], R0
__if_40760_end:
__if_40747_end:
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
__if_40790_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_40790_end
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
__if_40790_end:
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
__if_40928_start:
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40928_end
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
__if_40928_end:
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
__if_40999_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40999_end
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
__if_40999_end:
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
__if_41142_start:
  mov R0, [BP+8]
  ieq R0, 0
  jf R0, __if_41142_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContactsBetweenBodies
__if_41142_end:
__if_41150_start:
  mov R0, [BP-3]
  ige R0, 2
  jf R0, __if_41150_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2LinkJoint
__if_41150_end:
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
__if_41171_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41171_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkJoint
__if_41171_end:
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
__if_41213_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41213_end
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
__if_41213_end:
__if_41242_start:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41242_end
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
__if_41242_end:
__if_41271_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_41271_end
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
__if_41271_end:
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
__if_41294_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41294_end
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
__if_41294_end:
__if_41323_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41323_end
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
__if_41323_end:
__if_41352_start:
  mov R1, [BP-5]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_41352_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 8
  mov [R1], R0
__if_41352_end:
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
__if_41395_start:
  mov R0, [BP-7]
  mov R1, [BP-8]
  ine R0, R1
  jf R0, __if_41395_end
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
__if_41395_end:
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
__if_41470_start:
  mov R0, [BP+4]
  jf R0, __if_41470_end
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
__if_41470_end:
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
__if_42245_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_42245_end
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
__if_42245_end:
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
__if_44863_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44863_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44863_end
__if_44863_else:
__if_44877_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44877_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44877_end
__if_44877_else:
__if_44891_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44891_else
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
  jmp __if_44891_end
__if_44891_else:
__if_44917_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_44917_else
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
  jmp __if_44917_end
__if_44917_else:
__if_45004_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_45004_else
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
  jmp __if_45004_end
__if_45004_else:
__if_45072_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_45072_else
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
  jmp __if_45072_end
__if_45072_else:
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_45072_end:
__if_45004_end:
__if_44917_end:
__if_44891_end:
__if_44877_end:
__if_44863_end:
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
__if_45156_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_45156_end
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
__if_45156_end:
__if_45180_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_45180_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45180_end:
__if_45193_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_45193_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45193_end:
__if_45205_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_45205_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 12
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45205_end:
__if_45217_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_45217_end
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
__if_45217_end:
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
__if_46000_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46000_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_46000_end:
__if_46015_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46015_end
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
__if_46015_end:
__if_46030_start:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46030_end
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
__if_46030_end:
__if_46045_start:
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46045_end
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
__if_46045_end:
__if_46060_start:
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46060_end
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
__if_46060_end:
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
__if_46164_start:
  mov R0, [BP+3]
  ilt R0, 3
  jf R0, __if_46164_end
  jmp __function_b2WakeSolverSet_return
__if_46164_end:
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
__for_46187_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46187_end
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
__for_46187_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46187_start
__for_46187_end:
  mov R0, 0
  mov [BP-3], R0
__for_46325_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46325_end
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
__for_46325_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46325_start
__for_46325_end:
  mov R0, 0
  mov [BP-3], R0
__for_46401_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46401_end
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
__for_46401_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46401_start
__for_46401_end:
  mov R0, 0
  mov [BP-3], R0
__for_46477_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46477_end
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
__for_46477_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46477_start
__for_46477_end:
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
__for_46568_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_46568_end
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
__if_46647_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46654
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_46654:
  jf R0, __if_46647_end
  jmp __for_46568_continue
__if_46647_end:
__if_46658_start:
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
  jf R0, __if_46658_end
__if_46669_start:
  mov R1, [BP-8]
  jf R1, __LogicalAnd_ShortCircuit_46671
  mov R3, [BP-6]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2ShouldReportContactEvents
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_46671:
  mov R0, R1
  jf R0, __if_46669_end
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
__if_46669_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __for_46568_continue
__if_46658_end:
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
__if_46698_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46698_else
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  jmp __if_46698_end
__if_46698_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46698_end:
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
__if_46724_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46724_else
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  jmp __if_46724_end
__if_46724_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46724_end:
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
__if_46784_start:
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
  jf R0, __if_46784_else
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
  jmp __if_46784_end
__if_46784_else:
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
__if_46784_end:
__if_46824_start:
  mov R0, [BP-19]
  jf R0, __LogicalAnd_ShortCircuit_46826
  mov R1, [BP-8]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_46826:
  jf R0, __if_46824_else
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  or R0, 1
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46838_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46838_end
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
__if_46838_end:
__if_46850_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46850_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46850_end:
__if_46859_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46859_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46859_end:
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
__if_46886_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46886_end
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46886_end:
__if_46896_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46896_end
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46896_end:
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
  jmp __if_46824_end
__if_46824_else:
__if_46929_start:
  mov R0, [BP-19]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_46934
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_46934:
  jf R0, __if_46929_end
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  and R0, -2
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46944_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46944_end
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
__if_46944_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_46929_end:
__if_46824_end:
__if_46959_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_46959_end
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
__if_46959_end:
__if_46978_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_46978_end
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
__if_46978_end:
__for_46568_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_46568_start
__for_46568_end:
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
__if_47034_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47034_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47034_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  and R0, 3
  mov [BP-5], R0
__if_47049_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_47049_else
__if_47054_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_47060
  mov R1, [BP-4]
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_47060:
  jf R0, __if_47054_end
__if_47065_start:
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
  jf R0, __if_47065_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47065_end:
__if_47054_end:
  jmp __if_47049_end
__if_47049_else:
__if_47077_start:
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
  jf R0, __if_47077_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47077_end:
__if_47049_end:
__if_47088_start:
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
  jf R0, __if_47088_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47088_end:
__if_47102_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_47102_else
  mov R0, [BP+3]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-7], R0
  jmp __if_47102_end
__if_47102_else:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP+3]
  mov [BP-7], R0
__if_47102_end:
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
__if_47139_start:
  mov R1, [BP-8]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47139_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47139_end:
__if_47147_start:
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
  jf R0, __if_47147_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47147_end:
__if_47157_start:
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
  jf R0, __if_47157_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47157_end:
__if_47169_start:
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
  jf R0, __if_47169_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47169_end:
__if_47180_start:
  mov R1, [BP-8]
  iadd R1, 24
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_47183
  mov R2, [BP-9]
  iadd R2, 24
  mov R1, [R2]
  or R0, R1
__LogicalOr_ShortCircuit_47183:
  jf R0, __if_47180_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47180_end:
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
__for_47207_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_47207_end
  mov R2, [BP-1]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-4], R0
__if_47223_start:
  mov R0, [BP-4]
  ieq R0, -1
  jf R0, __if_47223_end
  jmp __for_47207_continue
__if_47223_end:
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
__if_47277_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_47277_end
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
__if_47277_end:
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
__for_47207_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_47207_start
__for_47207_end:
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
__if_47362_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47362_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47362_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_47377_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47377_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47377_end:
__if_47386_start:
  mov R1, [BP-4]
  iadd R1, 25
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_47386_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47386_end:
__if_47393_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47393_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47393_end:
__if_47398_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47398_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47398_end:
__if_47406_start:
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
  jf R0, __if_47406_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47406_end:
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
__if_47466_start:
  mov R0, [BP-59]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R1, 10.000000
  flt R0, R1
  jf R0, __if_47466_end
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
__if_47466_end:
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
__for_47516_start:
  mov R0, [BP-2]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_47516_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_47534_start:
  mov R1, [BP-3]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47534_end
  jmp __for_47516_continue
__if_47534_end:
__if_47542_start:
  mov R1, [BP-3]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_47542_end
  jmp __for_47516_continue
__if_47542_end:
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
  jf R0, __LogicalAnd_ShortCircuit_47578
  mov R2, [BP-3]
  iadd R2, 25
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_47578:
  mov [BP-12], R0
__if_47581_start:
  mov R0, [BP-12]
  jf R0, __if_47581_end
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
__for_47603_start:
  mov R0, [BP-25]
  ilt R0, 3
  jf R0, __for_47603_end
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
__for_47603_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_47603_start
__for_47603_end:
__if_47581_end:
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
__for_47647_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47647_end
  mov R0, [BP-16]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47665_start:
  mov R0, [BP-18]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47665_end
__if_47674_start:
  mov R0, [BP-14]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47674_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47665_end
__if_47674_end:
__for_47665_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47665_start
__for_47665_end:
__if_47685_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47685_end
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47685_end:
__for_47647_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47647_start
__for_47647_end:
  mov R0, 0
  mov [BP-17], R0
__for_47696_start:
  mov R0, [BP-17]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47696_end
  mov R0, [BP-14]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47714_start:
  mov R0, [BP-18]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47714_end
__if_47723_start:
  mov R0, [BP-16]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47723_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47714_end
__if_47723_end:
__for_47714_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47714_start
__for_47714_end:
__if_47734_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47734_end
  mov R1, [BP+2]
  iadd R1, 79
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47734_end:
__for_47696_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47696_start
__for_47696_end:
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
__for_47756_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47756_end
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
__for_47756_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47756_start
__for_47756_end:
  mov R0, [BP-13]
  mov R1, [BP-3]
  iadd R1, 27
  mov [R1], R0
__for_47516_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_47516_start
__for_47516_end:
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
__for_47810_start:
  mov R0, [BP-7]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_47810_end
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
__if_47864_start:
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_47864_else
  mov R1, [BP-8]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-15], R0
  jmp __if_47864_end
__if_47864_else:
  mov R0, 0.000000
  mov [BP-15], R0
__if_47864_end:
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
__for_47810_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_47810_start
__for_47810_end:
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
__for_47973_start:
  mov R0, [BP-6]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_47973_end
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
__if_47997_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  jf R0, __if_47997_end
  mov R0, 0.000000
  mov [BP-9], R0
__if_47997_end:
__if_48009_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 2
  ine R0, 0
  jf R0, __if_48009_end
  mov R0, 0.000000
  mov [BP-8], R0
__if_48009_end:
__if_48021_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 4
  ine R0, 0
  jf R0, __if_48021_end
  mov R0, 0.000000
  mov [BP-10], R0
__if_48021_end:
__if_48032_start:
  lea R2, [BP-9]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-4]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_48032_end
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
__if_48032_end:
__if_48066_start:
  mov R0, [BP-10]
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-5]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_48077
  mov R2, [BP-7]
  iadd R2, 3
  mov R1, [R2]
  and R1, 128
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_48077:
  jf R0, __if_48066_end
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
__if_48066_end:
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
__for_47973_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_47973_start
__for_47973_end:
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
__if_48165_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_48165_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48165_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_48180_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_48180_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48180_end:
__if_48189_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_48189_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48189_end:
__if_48197_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_48197_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48197_end:
__if_48202_start:
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
  jf R0, __if_48202_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48202_end:
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
__if_48228_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_48228_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48228_end:
__if_48238_start:
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
  jf R0, __if_48238_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48238_end:
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
__if_48310_start:
  mov R0, [BP-64]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_48317
  mov R1, [BP-64]
  mov R3, [BP-1]
  iadd R3, 13
  mov R2, [R3]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_48317:
  jf R0, __if_48310_end
  mov R0, [BP-64]
  mov R1, [BP-1]
  iadd R1, 13
  mov [R1], R0
__if_48310_end:
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
__while_48408_start:
__while_48408_continue:
  mov R0, [BP-34]
  ine R0, -1
  jf R0, __while_48408_end
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
__if_48427_start:
  mov R1, [BP-35]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_48427_end
  jmp __while_48408_continue
__if_48427_end:
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
__if_48514_start:
  mov R0, [BP-25]
  jf R0, __if_48514_end
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
__if_48514_end:
  jmp __while_48408_start
__while_48408_end:
__if_48547_start:
  mov R0, [BP-11]
  flt R0, 1.000000
  jf R0, __if_48547_else
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
  jmp __if_48547_end
__if_48547_else:
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
__if_48547_end:
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
__while_48656_start:
__while_48656_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_48656_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_48671_start:
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48671_end
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
__if_48737_start:
  mov R2, [BP-3]
  iadd R2, 13
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2AABB_Contains
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_48737_end
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
__if_48737_end:
__if_48671_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_48656_start
__while_48656_end:
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
__for_48833_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48833_end
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
__if_48953_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_48963
  mov R2, [BP-6]
  iadd R2, 23
  mov R1, [R2]
  and R1, 2048
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_48963:
  jt R0, __LogicalOr_ShortCircuit_48967
  mov R1, [BP-21]
  mov R3, [BP-14]
  iadd R3, 14
  mov R2, [R3]
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_48967:
  jf R0, __if_48953_else
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
  jmp __if_48953_end
__if_48953_else:
  mov R1, [BP-14]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
__if_48953_end:
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
  jf R0, __LogicalAnd_ShortCircuit_49043
  mov R2, [BP-14]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_49043:
  jf R0, __LogicalAnd_ShortCircuit_49049
  mov R1, [BP-28]
  mov R3, [BP-6]
  iadd R3, 17
  mov R2, [R3]
  fmul R2, 0.500000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_49049:
  mov [BP-29], R0
__if_49055_start:
  mov R0, [BP-29]
  jf R0, __if_49055_else
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_49065_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_49065_end
  jmp __for_48833_continue
__if_49065_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  jmp __if_49055_end
__if_49055_else:
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
__if_49055_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_48833_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48833_start
__for_48833_end:
  mov R0, 0
  mov [BP-5], R0
__for_49093_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_49093_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
__if_49109_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 24
  ine R0, 24
  jf R0, __if_49109_end
  jmp __for_49093_continue
__if_49109_end:
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
__for_49093_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_49093_start
__for_49093_end:
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
__if_49280_start:
  mov R0, [BP-9]
  fgt R0, 0.000000
  jf R0, __if_49280_else
  mov R0, 1.000000
  mov R1, [BP-9]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  jmp __if_49280_end
__if_49280_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_49280_end:
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
__if_49323_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_49323_else
  mov R0, 1.000000
  mov R1, [BP-12]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  jmp __if_49323_end
__if_49323_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_49323_end:
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
__for_49418_start:
  mov R0, [BP-6]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_49418_end
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
__if_49439_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_49439_end
  jmp __for_49418_continue
__if_49439_end:
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
__if_49524_start:
  mov R0, [BP-9]
  ieq R0, -1
  jt R0, __LogicalOr_ShortCircuit_49531
  mov R1, [BP-10]
  ieq R1, -1
  or R0, R1
__LogicalOr_ShortCircuit_49531:
  jf R0, __if_49524_else
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 3
  movs
  jmp __if_49524_end
__if_49524_else:
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 3
  movs
__if_49524_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
__if_49552_start:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __if_49552_end
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
__if_49552_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-17], R0
__if_49577_start:
  mov R0, [BP-10]
  ine R0, -1
  jf R0, __if_49577_end
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
__if_49577_end:
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
__if_49607_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_49607_end
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
__if_49607_end:
__if_49641_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_49641_end
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
__if_49641_end:
__for_49418_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_49418_start
__for_49418_end:
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
__for_49852_start:
  mov R0, [BP-11]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_49852_end
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
__if_49882_start:
  mov R0, [BP-13]
  ieq R0, -1
  jf R0, __if_49882_else
  lea R0, [BP-10]
  mov [BP-15], R0
  jmp __if_49882_end
__if_49882_else:
  mov R0, [BP-2]
  mov R1, [BP-13]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49882_end:
__if_49900_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_49900_else
  lea R0, [BP-10]
  mov [BP-16], R0
  jmp __if_49900_end
__if_49900_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49900_end:
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
__if_49949_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_49949_end
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
__if_49949_end:
__if_49980_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_49980_end
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
__if_49980_end:
__if_50011_start:
  mov R0, [BP-13]
  ine R0, -1
  jf R0, __if_50011_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_50011_end:
__if_50026_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50026_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50026_end:
__for_49852_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_49852_start
__for_49852_end:
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
__if_50165_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __if_50165_else
  mov R0, [BP-11]
  mov R1, [BP+12]
  fmul R0, R1
  mov [BP-12], R0
  jmp __if_50165_end
__if_50165_else:
__if_50175_start:
  mov R0, [BP+14]
  jf R0, __if_50175_end
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
__if_50175_end:
__if_50165_end:
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
__if_50285_start:
  mov R0, [BP-23]
  flt R0, 0.000000
  jf R0, __if_50285_end
  mov R0, 0.000000
  mov [BP-23], R0
__if_50285_end:
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
__for_50647_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50647_end
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
__if_50677_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50677_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50677_end
__if_50677_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50677_end:
__if_50695_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50695_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50695_end
__if_50695_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50695_end:
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
__if_50774_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50774_end
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
__if_50774_end:
__if_50815_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50815_end
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
__if_50815_end:
__if_50856_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_50856_end
__if_50861_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50861_end
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
__if_50861_end:
__if_50894_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50894_end
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
__if_50894_end:
__if_50856_end:
__if_50927_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50927_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50927_end:
__if_50942_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_50942_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_50942_end:
__for_50647_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50647_start
__for_50647_end:
__function_b2SolveContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitutionPoint:
  push BP
  mov BP, SP
  isub SP, 17
__if_50970_start:
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+5]
  fsgn R1
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_50978
  mov R2, [BP+2]
  iadd R2, 8
  mov R1, [R2]
  feq R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_50978:
  jf R0, __if_50970_end
  jmp __function_b2ApplyRestitutionPoint_return
__if_50970_end:
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
__for_51226_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_51226_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
__if_51242_start:
  mov R1, [BP-13]
  iadd R1, 32
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_51242_end
  jmp __for_51226_continue
__if_51242_end:
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
__if_51262_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_51262_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_51262_end
__if_51262_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51262_end:
__if_51280_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_51280_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_51280_end
__if_51280_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_51280_end:
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
__if_51316_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_51316_end
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
__if_51316_end:
__if_51348_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_51348_end
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
__if_51348_end:
__if_51380_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_51380_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_51380_end:
__if_51395_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_51395_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_51395_end:
__for_51226_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_51226_start
__for_51226_end:
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
__for_51429_start:
  mov R0, [BP-3]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_51429_end
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
__if_51453_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_51453_end
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
__if_51453_end:
__if_51503_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_51503_end
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
__if_51503_end:
__for_51429_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_51429_start
__for_51429_end:
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
__if_51677_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51677_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_51677_end
__if_51677_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_51677_end:
__if_51693_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51693_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_51693_end
__if_51693_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_51693_end:
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
__if_51828_start:
  mov R0, [BP-30]
  fgt R0, 0.000000
  jf R0, __if_51828_else
  mov R0, 1.000000
  mov R1, [BP-30]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_51828_end
__if_51828_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_51828_end:
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
__if_51892_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51892_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51892_end
__if_51892_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51892_end:
__if_51912_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51912_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_51912_end
__if_51912_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51912_end:
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
__if_52019_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52019_end
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
__if_52019_end:
__if_52055_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52055_end
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
__if_52055_end:
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
__if_52135_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52135_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_52135_end
__if_52135_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_52135_end:
__if_52155_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52155_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_52155_end
__if_52155_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_52155_end:
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
__if_52262_start:
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_52265
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 6
  mov R2, [R3]
  flt R1, R2
  jt R1, __LogicalOr_ShortCircuit_52274
  mov R3, [BP-14]
  iadd R3, 26
  mov R2, [R3]
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_52274:
  and R0, R1
__LogicalAnd_ShortCircuit_52265:
  jf R0, __if_52262_else
__if_52278_start:
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_52278_end
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
__if_52278_end:
__if_52452_start:
  mov R1, [BP-14]
  iadd R1, 27
  mov R0, [R1]
  jf R0, __if_52452_end
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
__if_52452_end:
__if_52599_start:
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  jf R0, __if_52599_end
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
__if_52669_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52669_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52669_end
__if_52669_else:
__if_52678_start:
  mov R0, [BP+6]
  jf R0, __if_52678_end
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
__if_52678_end:
__if_52669_end:
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
__if_52855_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52855_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52855_end
__if_52855_else:
__if_52864_start:
  mov R0, [BP+6]
  jf R0, __if_52864_end
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
__if_52864_end:
__if_52855_end:
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
__if_52599_end:
  jmp __if_52262_end
__if_52262_else:
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
__if_53042_start:
  mov R0, [BP+6]
  jf R0, __if_53042_end
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
__if_53042_end:
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
__if_52262_end:
__if_53142_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53142_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_53142_end:
__if_53158_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53158_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_53158_end:
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
__if_53276_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53276_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_53276_end
__if_53276_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_53276_end:
__if_53292_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53292_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_53292_end
__if_53292_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_53292_end:
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
__if_53395_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_53395_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_53395_end
__if_53395_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_53395_end:
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
__if_53459_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53459_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53459_end
__if_53459_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53459_end:
__if_53479_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53479_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53479_end
__if_53479_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53479_end:
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
__if_53534_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53534_end
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
__if_53534_end:
__if_53575_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53575_end
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
__if_53575_end:
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
__if_53660_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53660_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53660_end
__if_53660_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53660_end:
__if_53680_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53680_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53680_end
__if_53680_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53680_end:
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
__if_53755_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53758
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53758:
  jf R0, __if_53755_end
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
__if_53755_end:
__if_53835_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53838
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53838:
  jf R0, __if_53835_end
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
__if_53835_end:
__if_53899_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53902
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53902:
  jf R0, __if_53899_end
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
__if_53928_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_53928_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_53928_end
__if_53928_else:
__if_53937_start:
  mov R0, [BP+6]
  jf R0, __if_53937_end
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
__if_53937_end:
__if_53928_end:
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
__if_54026_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_54026_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_54026_end
__if_54026_else:
__if_54035_start:
  mov R0, [BP+6]
  jf R0, __if_54035_end
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
__if_54035_end:
__if_54026_end:
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
__if_53899_end:
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
__if_54184_start:
  mov R0, [BP+6]
  jf R0, __if_54184_end
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
__if_54184_end:
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
__if_54435_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54435_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_54435_end:
__if_54451_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54451_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_54451_end:
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
__if_54569_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54569_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_54569_end
__if_54569_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_54569_end:
__if_54585_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54585_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_54585_end
__if_54585_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_54585_end:
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
__if_54688_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_54688_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_54688_end
__if_54688_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_54688_end:
__if_54702_start:
  mov R1, [BP-13]
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54702_else
  mov R13, [BP-13]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54702_end
__if_54702_else:
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
__if_54702_end:
__if_54721_start:
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54721_else
  mov R13, [BP-13]
  iadd R13, 7
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54721_end
__if_54721_else:
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
__if_54721_end:
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
__if_54781_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54781_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54781_end
__if_54781_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54781_end:
__if_54801_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54801_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54801_end
__if_54801_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54801_end:
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
__if_54843_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54843_end
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
__if_54843_end:
__if_54885_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54885_end
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
__if_54885_end:
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
__if_54969_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54969_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54969_end
__if_54969_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54969_end:
__if_54989_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54989_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54989_end
__if_54989_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54989_end:
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
__if_55071_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_55073
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_55073:
  jf R0, __if_55071_end
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
__if_55071_end:
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
__if_55173_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_55175
  mov R2, [BP-14]
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_55175:
  jf R0, __if_55173_end
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
__if_55173_end:
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
__if_55472_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55472_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_55472_end:
__if_55488_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55488_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_55488_end:
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
__if_55606_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55606_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_55606_end
__if_55606_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_55606_end:
__if_55622_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55622_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_55622_end
__if_55622_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_55622_end:
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
__if_55800_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55800_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55800_end
__if_55800_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55800_end:
__if_55820_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55820_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55820_end
__if_55820_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55820_end:
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
__if_56025_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56025_end
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
__if_56025_end:
__if_56057_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56057_end
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
__if_56057_end:
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
__if_56133_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_56133_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_56133_end
__if_56133_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_56133_end:
__if_56153_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_56153_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_56153_end
__if_56153_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_56153_end:
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
__if_56341_start:
  mov R0, [BP-48]
  fgt R0, 0.000000
  jf R0, __if_56341_else
  mov R0, 1.000000
  mov R1, [BP-48]
  fdiv R0, R1
  mov [BP-49], R0
  jmp __if_56341_end
__if_56341_else:
  mov R0, 0.000000
  mov [BP-49], R0
__if_56341_end:
__if_56353_start:
  mov R1, [BP-14]
  iadd R1, 28
  mov R0, [R1]
  jf R0, __if_56353_end
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
__if_56353_end:
__if_56485_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __if_56485_end
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
__if_56485_end:
__if_56607_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_56607_end
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
__if_56628_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56628_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56642_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56642_else
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
  jmp __if_56642_end
__if_56642_else:
__if_56657_start:
  mov R0, [BP+6]
  jf R0, __if_56657_end
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
__if_56657_end:
__if_56642_end:
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
  jmp __if_56628_end
__if_56628_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 4
  mov [R1], R0
__if_56628_end:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-86], R0
__if_56803_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56803_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56817_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56817_else
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
  jmp __if_56817_end
__if_56817_else:
__if_56832_start:
  mov R0, [BP+6]
  jf R0, __if_56832_end
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
__if_56832_end:
__if_56817_end:
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
  jmp __if_56803_end
__if_56803_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 5
  mov [R1], R0
__if_56803_end:
__if_56607_end:
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
__if_57043_start:
  mov R0, [BP+6]
  jf R0, __if_57043_end
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
__if_57043_end:
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
__if_57111_start:
  mov R0, [BP-66]
  feq R0, 0.000000
  jf R0, __if_57111_end
  mov R0, 1.000000
  mov [BP-66], R0
__if_57111_end:
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
__if_57275_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57275_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_57275_end:
__if_57291_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57291_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_57291_end:
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
__if_57409_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_57409_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
  jmp __if_57409_end
__if_57409_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
__if_57409_end:
__if_57425_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_57425_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
  jmp __if_57425_end
__if_57425_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
__if_57425_end:
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
__if_57620_start:
  mov R0, [BP-36]
  fgt R0, 0.000000
  jf R0, __if_57620_else
  mov R0, 1.000000
  mov R1, [BP-36]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_57620_end
__if_57620_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_57620_end:
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
__if_57665_start:
  mov R0, [BP-39]
  fgt R0, 0.000000
  jf R0, __if_57665_else
  mov R0, 1.000000
  mov R1, [BP-39]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_57665_end
__if_57665_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_57665_end:
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
__if_57693_start:
  mov R0, [BP-40]
  fgt R0, 0.000000
  jf R0, __if_57693_else
  mov R0, 1.000000
  mov R1, [BP-40]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_57693_end
__if_57693_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_57693_end:
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
__if_57748_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57748_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57748_end
__if_57748_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57748_end:
__if_57768_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57768_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57768_end
__if_57768_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57768_end:
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
__if_57988_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57988_end
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
__if_57988_end:
__if_58020_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58020_end
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
__if_58020_end:
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
__if_58096_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58096_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_58096_end
__if_58096_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_58096_end:
__if_58116_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58116_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_58116_end
__if_58116_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_58116_end:
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
__if_58282_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_58285
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_58285:
  jf R0, __if_58282_end
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
__if_58282_end:
__if_58346_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_58346_end
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
__if_58346_end:
__if_58476_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __if_58476_end
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
__if_58496_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58496_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58496_end
__if_58496_else:
__if_58505_start:
  mov R0, [BP+6]
  jf R0, __if_58505_end
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
__if_58505_end:
__if_58496_end:
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
__if_58658_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58658_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58658_end
__if_58658_else:
__if_58667_start:
  mov R0, [BP+6]
  jf R0, __if_58667_end
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
__if_58667_end:
__if_58658_end:
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
__if_58476_end:
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
__if_58821_start:
  mov R0, [BP+6]
  jf R0, __if_58821_end
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
__if_58821_end:
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
__if_58968_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58968_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_58968_end:
__if_58984_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58984_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_58984_end:
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
__if_59102_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_59102_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_59102_end
__if_59102_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_59102_end:
__if_59118_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_59118_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_59118_end
__if_59118_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_59118_end:
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
__if_59330_start:
  mov R0, [BP-26]
  fgt R0, 0.000000
  jf R0, __if_59330_else
  mov R0, 1.000000
  mov R1, [BP-26]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
  jmp __if_59330_end
__if_59330_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
__if_59330_end:
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
__if_59385_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59385_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_59385_end
__if_59385_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_59385_end:
__if_59405_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59405_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59405_end
__if_59405_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59405_end:
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
__if_59465_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59465_end
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
__if_59465_end:
__if_59504_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59504_end
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
__if_59504_end:
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
__if_59585_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59585_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_59585_end
__if_59585_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_59585_end:
__if_59605_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59605_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59605_end
__if_59605_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59605_end:
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
__if_59639_start:
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59646
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59646:
  jf R0, __if_59639_end
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
__if_59639_end:
__if_59766_start:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59766_end
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
__if_59766_end:
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
__if_59851_start:
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59858
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59858:
  jf R0, __if_59851_end
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
__if_60122_start:
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
  jf R0, __if_60122_end
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
__if_60122_end:
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
__if_59851_end:
__if_60222_start:
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_60222_end
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
__if_60335_start:
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
  jf R0, __if_60335_end
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
__if_60335_end:
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
__if_60222_end:
__if_60435_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_60435_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_60435_end:
__if_60451_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_60451_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_60451_end:
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
__for_60486_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60486_end
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
__if_60520_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60520_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareDistanceJoint
  jmp __if_60520_end
__if_60520_else:
__if_60529_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60529_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareRevoluteJoint
  jmp __if_60529_end
__if_60529_else:
__if_60538_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60538_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWeldJoint
  jmp __if_60538_end
__if_60538_else:
__if_60547_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60547_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PreparePrismaticJoint
  jmp __if_60547_end
__if_60547_else:
__if_60556_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60556_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWheelJoint
  jmp __if_60556_end
__if_60556_else:
__if_60565_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60565_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareMotorJoint
__if_60565_end:
__if_60556_end:
__if_60547_end:
__if_60538_end:
__if_60529_end:
__if_60520_end:
__for_60486_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60486_start
__for_60486_end:
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
__for_60591_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60591_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60609_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60609_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartDistanceJoint
  jmp __if_60609_end
__if_60609_else:
__if_60617_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60617_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartRevoluteJoint
  jmp __if_60617_end
__if_60617_else:
__if_60625_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60625_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWeldJoint
  jmp __if_60625_end
__if_60625_else:
__if_60633_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60633_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartPrismaticJoint
  jmp __if_60633_end
__if_60633_else:
__if_60641_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60641_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWheelJoint
  jmp __if_60641_end
__if_60641_else:
__if_60649_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60649_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartMotorJoint
__if_60649_end:
__if_60641_end:
__if_60633_end:
__if_60625_end:
__if_60617_end:
__if_60609_end:
__for_60591_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60591_start
__for_60591_end:
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
__for_60677_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60677_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60695_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60695_else
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
  jmp __if_60695_end
__if_60695_else:
__if_60706_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60706_else
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
  jmp __if_60706_end
__if_60706_else:
__if_60717_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60717_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2SolveWeldJoint
  jmp __if_60717_end
__if_60717_else:
__if_60726_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60726_else
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
  jmp __if_60726_end
__if_60726_else:
__if_60737_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60737_else
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
  jmp __if_60737_end
__if_60737_else:
__if_60748_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60748_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2SolveMotorJoint
__if_60748_end:
__if_60737_end:
__if_60726_end:
__if_60717_end:
__if_60706_end:
__if_60695_end:
__for_60677_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60677_start
__for_60677_end:
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
__if_60774_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_60774_end
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
__if_60774_end:
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
__for_60905_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60905_end
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
__if_60992_start:
  mov R0, [BP-10]
  mov R1, [BP-12]
  ine R0, R1
  jf R0, __if_60992_end
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
__if_60992_end:
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
__for_60905_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60905_start
__for_60905_end:
  mov R0, 0
  mov [BP-5], R0
__for_61024_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61024_end
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
__if_61101_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_61101_end
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
__if_61101_end:
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
__for_61024_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_61024_start
__for_61024_end:
  mov R0, 0
  mov [BP-5], R0
__for_61151_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61151_end
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
__if_61228_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_61228_end
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
__if_61228_end:
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
__for_61151_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_61151_start
__for_61151_end:
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
__if_61326_start:
  mov R0, [BP-6]
  mov R1, [BP-7]
  ine R0, R1
  jf R0, __if_61326_end
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
__if_61326_end:
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
__if_61375_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_61375_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_61375_end:
__function_b2TrySleepIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSleep:
  push BP
  mov BP, SP
  isub SP, 9
__if_61420_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_61420_end
  jmp __function_b2UpdateSleep_return
__if_61420_end:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
__while_61437_start:
__while_61437_continue:
  mov R0, [BP-1]
  ige R0, 0
  jf R0, __while_61437_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
__if_61450_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_61450_end
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_61437_continue
__if_61450_end:
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
__for_61490_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61490_end
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
__if_61512_start:
  mov R1, [BP-7]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_61512_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61490_end
__if_61512_end:
__if_61522_start:
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  flt R0, 0.500000
  jf R0, __if_61522_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61490_end
__if_61522_end:
__for_61490_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_61490_start
__for_61490_end:
__if_61532_start:
  mov R0, [BP-5]
  jf R0, __if_61532_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2TrySleepIsland
__if_61532_end:
  mov R0, [BP-1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_61437_start
__while_61437_end:
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
__for_61563_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_61563_end
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 49
  iadd R0, R1
  mov [BP-5], R0
__if_61581_start:
  mov R1, [BP-5]
  iadd R1, 41
  mov R0, [R1]
  and R0, 1048576
  ieq R0, 0
  jf R0, __if_61581_end
  jmp __for_61563_continue
__if_61581_end:
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, -1
  mov [BP-7], R0
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_61602_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_61602_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61616_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61626
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61626:
  jf R0, __if_61616_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__if_61616_end:
__if_61602_end:
__if_61636_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_61636_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61650_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61660
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 12
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61660:
  jf R0, __if_61650_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-7], R0
__if_61650_end:
__if_61636_end:
__if_61670_start:
  mov R0, [BP-7]
  ieq R0, -1
  jf R0, __if_61670_end
  jmp __for_61563_continue
__if_61670_end:
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
__if_61716_start:
  mov R1, [BP-11]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_61723
  mov R2, [BP-12]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_61723:
  jf R0, __if_61716_else
__if_61727_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61727_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_61727_end
__if_61727_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  iadd R12, 2
  mov CR, 2
  movs
__if_61727_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
  jmp __if_61716_end
__if_61716_else:
__if_61758_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61758_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  mov CR, 2
  movs
  jmp __if_61758_end
__if_61758_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  mov CR, 2
  movs
__if_61758_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
__if_61716_end:
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
__for_61563_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_61563_start
__for_61563_end:
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
__if_61840_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_61840_end
  mov R0, 1
  mov [BP+4], R0
__if_61840_end:
  mov R0, [BP+3]
  mov R1, [BP+4]
  cif R1
  fdiv R0, R1
  mov [BP-3], R0
__if_61854_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_61854_else
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
  jmp __if_61854_end
__if_61854_else:
  mov R0, 0.000000
  mov [BP-4], R0
__if_61854_end:
  mov R0, [BP-4]
  mov R1, [BP+2]
  iadd R1, 55
  mov [R1], R0
__if_61872_start:
  mov R0, [BP+3]
  fgt R0, 0.000000
  jf R0, __if_61872_else
  mov R0, 1.000000
  mov R1, [BP+3]
  fdiv R0, R1
  mov [BP-5], R0
  jmp __if_61872_end
__if_61872_else:
  mov R0, 0.000000
  mov [BP-5], R0
__if_61872_end:
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
__if_61930_start:
  mov R0, [BP-2]
  igt R0, 0
  jf R0, __if_61930_end
__if_61935_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_61935_end
__if_61941_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_61941_end
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
__if_61941_end:
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
__if_61935_end:
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
__if_61930_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_b2PrepareJoints
  mov R0, 0
  mov [BP-17], R0
__for_61983_start:
  mov R0, [BP-17]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_61983_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2IntegrateVelocities
__if_61996_start:
  mov R1, [BP+2]
  iadd R1, 53
  mov R0, [R1]
  jf R0, __if_61996_end
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
__if_61996_end:
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
__for_61983_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_61983_start
__for_61983_end:
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
__if_62047_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  jf R0, __if_62047_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSplitIsland
__if_62053_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_62053_end
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
__if_62053_end:
__if_62047_end:
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
__if_62077_start:
  mov R0, [BP+3]
  fle R0, 0.000000
  jf R0, __if_62077_end
  jmp __function_b2World_Step_return
__if_62077_end:
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

__function_vb2_Quit:
  push BP
  mov BP, SP
  isub SP, 1
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2DestroyWorld
__function_vb2_Quit_return:
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
__if_62374_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_62374_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62374_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_62393_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_62398
  mov R1, [BP-1]
  mov R2, [22]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_62398:
  jf R0, __if_62393_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62393_end:
  mov R0, [21]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
__if_62415_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_62415_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62415_end:
__if_62424_start:
  mov R1, [BP-3]
  iadd R1, 20
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_62424_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62424_end:
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

__function_vb2_GetBodyId:
  push BP
  mov BP, SP
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_vb2_ResolveBody
__function_vb2_GetBodyId_return:
  iadd SP, 2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_Exists:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 2
  mov R1, [BP+2]
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_vb2_ResolveBody
__function_vb2_Exists_return:
  iadd SP, 2
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
__if_62471_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62471_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62471_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-4], R0
__if_62487_start:
  mov R1, [BP-4]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_62487_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62487_end:
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

__function_vb2_Destroy:
  push BP
  mov BP, SP
  isub SP, 5
__if_62748_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62748_end
  jmp __function_vb2_Destroy_return
__if_62748_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2DestroyBody
__function_vb2_Destroy_return:
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
__if_62765_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62765_end
  mov R0, 0.000000
  jmp __function_vb2_GetX_return
__if_62765_end:
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
__if_62790_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62790_end
  mov R0, 0.000000
  jmp __function_vb2_GetY_return
__if_62790_end:
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

__function_vb2_GetAngle:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62815_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62815_end
  mov R0, 0.000000
  jmp __function_vb2_GetAngle_return
__if_62815_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetRotation
  lea R1, [BP-5]
  mov [SP], R1
  call __function_b2Rot_GetAngle
__function_vb2_GetAngle_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_GetVX:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62841_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62841_end
  mov R0, 0.000000
  jmp __function_vb2_GetVX_return
__if_62841_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetLinearVelocity
  mov R0, [BP-5]
__function_vb2_GetVX_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_GetVY:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62866_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62866_end
  mov R0, 0.000000
  jmp __function_vb2_GetVY_return
__if_62866_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetLinearVelocity
  mov R0, [BP-4]
__function_vb2_GetVY_return:
  iadd SP, 3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_IsAwake:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
__if_62910_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62910_end
  mov R0, 0
  jmp __function_vb2_IsAwake_return
__if_62910_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2Body_IsAwake
__function_vb2_IsAwake_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_vb2_SetVelocity:
  push BP
  mov BP, SP
  isub SP, 8
__if_63010_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63010_end
  jmp __function_vb2_SetVelocity_return
__if_63010_end:
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
  call __function_b2Body_SetLinearVelocity
__function_vb2_SetVelocity_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetFriction:
  push BP
  mov BP, SP
  isub SP, 6
__if_63179_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63179_end
  jmp __function_vb2_SetFriction_return
__if_63179_end:
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
__if_63198_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63198_end
  jmp __function_vb2_SetBounce_return
__if_63198_end:
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

__function_vb2_SetDensity:
  push BP
  mov BP, SP
  isub SP, 7
__if_63217_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63217_end
  jmp __function_vb2_SetDensity_return
__if_63217_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  mov R1, 1
  mov [SP+3], R1
  call __function_b2Shape_SetDensity
__function_vb2_SetDensity_return:
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
__if_63309_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_63309_end
  mov R0, -1
  jmp __function_vb2_BodyOfShape_return
__if_63309_end:
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

__function_vb2_PointPickCallback:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  isub SP, 3
__if_63413_start:
  mov R0, [global_vb2_pickShape]
  ine R0, -1
  jf R0, __if_63413_end
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_63413_end:
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
__if_63439_start:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Shape_TestPoint
  jf R0, __if_63439_end
  mov R0, [BP+3]
  mov [global_vb2_pickShape], R0
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_63439_end:
  mov R0, 1
__function_vb2_PointPickCallback_return:
  iadd SP, 3
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
__if_63567_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_63567_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63567_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_63586_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_63591
  mov R1, [BP-1]
  mov R2, [58]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_63591:
  jf R0, __if_63586_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63586_end:
  mov R0, [57]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 17
  iadd R0, R1
  mov [BP-3], R0
__if_63608_start:
  mov R1, [BP-3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_63608_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63608_end:
__if_63617_start:
  mov R1, [BP-3]
  iadd R1, 15
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_63617_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63617_end:
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

__function_DefineRegions:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, 0
  mov [SP], R1
  call __function_select_region
  mov R1, 162
  mov [SP], R1
  mov R1, 182
  mov [SP+1], R1
  mov R1, 201
  mov [SP+2], R1
  mov R1, 221
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 1
  mov [SP], R1
  call __function_select_region
  mov R1, 285
  mov [SP], R1
  mov R1, 182
  mov [SP+1], R1
  mov R1, 324
  mov [SP+2], R1
  mov R1, 221
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 2
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 342
  mov [SP+1], R1
  mov R1, 40
  mov [SP+2], R1
  mov R1, 381
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 3
  mov [SP], R1
  call __function_select_region
  mov R1, 81
  mov [SP], R1
  mov R1, 302
  mov [SP+1], R1
  mov R1, 120
  mov [SP+2], R1
  mov R1, 341
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 6
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 182
  mov [SP+1], R1
  mov R1, 40
  mov [SP+2], R1
  mov R1, 221
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, 41
  mov [SP], R1
  mov R1, 302
  mov [SP+1], R1
  mov R1, 80
  mov [SP+2], R1
  mov R1, 341
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 5
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 302
  mov [SP+1], R1
  mov R1, 40
  mov [SP+2], R1
  mov R1, 341
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 7
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 160
  mov [SP+2], R1
  mov R1, 180
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 8
  mov [SP], R1
  call __function_select_region
  mov R1, 486
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 486
  mov [SP+2], R1
  mov R1, 360
  mov [SP+3], R1
  call __function_define_region_topleft
  mov R1, 9
  mov [SP], R1
  call __function_select_region
  mov R1, 1
  mov [SP], R1
  mov R1, 467
  mov [SP+1], R1
  mov R1, 120
  mov [SP+2], R1
  mov R1, 580
  mov [SP+3], R1
  call __function_define_region_center
  mov R1, 10
  mov [SP], R1
  call __function_select_region
  mov R1, 344
  mov [SP], R1
  mov R1, 184
  mov [SP+1], R1
  mov R1, 482
  mov [SP+2], R1
  mov R1, 340
  mov [SP+3], R1
  call __function_define_region_center
__function_DefineRegions_return:
  mov SP, BP
  pop BP
  ret

__function_AddBlock:
  push BP
  mov BP, SP
  isub SP, 4
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP+3]
  mov [SP+1], R2
  mov R2, [BP+4]
  mov [SP+2], R2
  mov R2, [BP+5]
  mov [SP+3], R2
  call __function_vb2_Box
  mov R1, R0
  mov R2, global_BlockBody
  mov R3, [global_BlockCount]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+4]
  mov R1, global_BlockHW
  mov R2, [global_BlockCount]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+5]
  mov R1, global_BlockHH
  mov R2, [global_BlockCount]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+6]
  mov R1, global_BlockRegion
  mov R2, [global_BlockCount]
  iadd R1, R2
  mov [R1], R0
  mov R0, [global_BlockCount]
  iadd R0, 1
  mov [global_BlockCount], R0
__function_AddBlock_return:
  mov SP, BP
  pop BP
  ret

__function_AddPig:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 0.900000
  mov [SP+2], R1
  mov R1, 0.900000
  mov [SP+3], R1
  call __function_vb2_Box
  mov [BP-1], R0
__if_64109_start:
  mov R1, [BP-1]
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  call __function_vb2_GetBodyId
  jf R0, __if_64109_end
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-4]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2Body_EnableHitEvents
__if_64109_end:
  mov R0, [BP-1]
  mov R1, global_PigBody
  mov R2, [global_PigCount]
  iadd R1, R2
  mov [R1], R0
  mov R0, 0
  mov R1, global_PoofFrames
  mov R2, [global_PigCount]
  iadd R1, R2
  mov [R1], R0
  mov R0, [global_PigCount]
  iadd R0, 1
  mov [global_PigCount], R0
__function_AddPig_return:
  mov SP, BP
  pop BP
  ret

__function_BuildLevel:
  push BP
  mov BP, SP
  isub SP, 5
  call __function_vb2_Init
  mov R1, 1
  mov [SP], R1
  call __function_vb2_EnableSleep
  mov R1, 0.000000
  mov [SP], R1
  mov R1, -2.000000
  mov [SP+1], R1
  mov R1, 20.000000
  mov [SP+2], R1
  call __function_vb2_SetCamera
  mov R1, 0.000000
  mov [SP], R1
  mov R1, -8.000000
  mov [SP+1], R1
  mov R1, 20.000000
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  call __function_vb2_Wall
  mov R0, 0
  mov [global_BlockCount], R0
  mov R0, 0
  mov [global_PigCount], R0
  mov R1, 6.000000
  mov [SP], R1
  mov R1, -6.000000
  mov [SP+1], R1
  mov R1, 1.000000
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_AddBlock
  mov R1, 6.000000
  mov [SP], R1
  mov R1, -4.000000
  mov [SP+1], R1
  mov R1, 1.000000
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_AddBlock
  mov R1, 10.000000
  mov [SP], R1
  mov R1, -6.000000
  mov [SP+1], R1
  mov R1, 1.000000
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_AddBlock
  mov R1, 10.000000
  mov [SP], R1
  mov R1, -4.000000
  mov [SP+1], R1
  mov R1, 1.000000
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_AddBlock
  mov R1, 8.000000
  mov [SP], R1
  mov R1, -2.600000
  mov [SP+1], R1
  mov R1, 3.000000
  mov [SP+2], R1
  mov R1, 0.400000
  mov [SP+3], R1
  mov R1, 3
  mov [SP+4], R1
  call __function_AddBlock
  mov R1, 8.000000
  mov [SP], R1
  mov R1, -6.100000
  mov [SP+1], R1
  call __function_AddPig
  mov R1, 8.000000
  mov [SP], R1
  mov R1, -1.300000
  mov [SP+1], R1
  call __function_AddPig
  mov R1, 13.500000
  mov [SP], R1
  mov R1, -6.100000
  mov [SP+1], R1
  call __function_AddPig
  mov R0, -1
  mov [global_Bird], R0
  mov R0, 3
  mov [global_BirdsLeft], R0
  mov R0, 0
  mov [global_Score], R0
  mov R0, 0
  mov [global_GameState], R0
  mov R0, -1.800000
  mov [global_AimOX], R0
  mov R0, -0.600000
  mov [global_AimOY], R0
__function_BuildLevel_return:
  mov SP, BP
  pop BP
  ret

__function_AlivePigs:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  isub SP, 1
  mov R0, 0
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__for_64232_start:
  mov R0, [BP-2]
  mov R1, [global_PigCount]
  ilt R0, R1
  jf R0, __for_64232_end
__if_64241_start:
  mov R1, global_PigBody
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  mov [SP], R1
  call __function_vb2_Exists
  jf R0, __if_64241_end
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__if_64241_end:
__for_64232_continue:
  mov R0, [BP-2]
  mov R1, R0
  iadd R1, 1
  mov [BP-2], R1
  jmp __for_64232_start
__for_64232_end:
  mov R0, [BP-1]
__function_AlivePigs_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_KillPig:
  push BP
  mov BP, SP
  isub SP, 1
  mov R2, global_PigBody
  mov R3, [BP+2]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_GetX
  mov R1, R0
  mov R2, global_PoofX
  mov R3, [BP+2]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R2, global_PigBody
  mov R3, [BP+2]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_GetY
  mov R1, R0
  mov R2, global_PoofY
  mov R3, [BP+2]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, 50
  mov R1, global_PoofFrames
  mov R2, [BP+2]
  iadd R1, R2
  mov [R1], R0
  mov R1, global_PigBody
  mov R2, [BP+2]
  iadd R1, R2
  mov R1, [R1]
  mov [SP], R1
  call __function_vb2_Destroy
  mov R0, [global_Score]
  iadd R0, 500
  mov [global_Score], R0
__function_KillPig_return:
  mov SP, BP
  pop BP
  ret

__function_CheckPigs:
  push BP
  mov BP, SP
  isub SP, 8
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2World_GetContactHitEventCount
  mov [BP-1], R0
  mov R1, global_vb2_world
  mov [SP], R1
  call __function_b2World_GetContactHitEvents
  mov [BP-2], R0
  mov R0, 0
  mov [BP-3], R0
__for_64298_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_64298_end
__if_64308_start:
  mov R1, [BP-2]
  mov R2, [BP-3]
  imul R2, 7
  iadd R1, R2
  iadd R1, 6
  mov R0, [R1]
  flt R0, 3.000000
  jf R0, __if_64308_end
  jmp __for_64298_continue
__if_64308_end:
  mov R2, [BP-2]
  mov R3, [BP-3]
  imul R3, 7
  iadd R2, R3
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_BodyOfShape
  mov [BP-5], R0
  mov R2, [BP-2]
  mov R3, [BP-3]
  imul R3, 7
  iadd R2, R3
  iadd R2, 5
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_BodyOfShape
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__for_64332_start:
  mov R0, [BP-7]
  mov R1, [global_PigCount]
  ilt R0, R1
  jf R0, __for_64332_end
__if_64342_start:
  mov R2, global_PigBody
  mov R3, [BP-7]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_Exists
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_64342_end
  jmp __for_64332_continue
__if_64342_end:
__if_64350_start:
  mov R0, global_PigBody
  mov R1, [BP-7]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-5]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_64359
  mov R1, global_PigBody
  mov R2, [BP-7]
  iadd R1, R2
  mov R1, [R1]
  mov R2, [BP-6]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_64359:
  jf R0, __if_64350_end
  mov R1, [BP-7]
  mov [SP], R1
  call __function_KillPig
__if_64350_end:
__for_64332_continue:
  mov R0, [BP-7]
  mov R1, R0
  iadd R1, 1
  mov [BP-7], R1
  jmp __for_64332_start
__for_64332_end:
__for_64298_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_64298_start
__for_64298_end:
  mov R0, 0
  mov [BP-4], R0
__for_64366_start:
  mov R0, [BP-4]
  mov R1, [global_PigCount]
  ilt R0, R1
  jf R0, __for_64366_end
__if_64375_start:
  mov R2, global_PigBody
  mov R3, [BP-4]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_Exists
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_64380
  mov R3, global_PigBody
  mov R4, [BP-4]
  iadd R3, R4
  mov R3, [R3]
  mov [SP], R3
  call __function_vb2_GetY
  mov R2, R0
  flt R2, -12.000000
  and R1, R2
__LogicalAnd_ShortCircuit_64380:
  mov R0, R1
  jf R0, __if_64375_end
  mov R1, [BP-4]
  mov [SP], R1
  call __function_KillPig
__if_64375_end:
__for_64366_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_64366_start
__for_64366_end:
__function_CheckPigs_return:
  mov SP, BP
  pop BP
  ret

__function_LaunchBird:
  push BP
  mov BP, SP
  isub SP, 3
  mov R2, [global_AimOX]
  fadd R2, -10.000000
  mov [SP], R2
  mov R2, [global_AimOY]
  fadd R2, -3.400000
  mov [SP+1], R2
  mov R2, 0.900000
  mov [SP+2], R2
  call __function_vb2_Ball
  mov R1, R0
  mov [global_Bird], R1
  mov R0, R1
  mov R1, [global_Bird]
  mov [SP], R1
  mov R1, 2.000000
  mov [SP+1], R1
  call __function_vb2_SetDensity
  mov R1, [global_Bird]
  mov [SP], R1
  mov R1, 0.800000
  mov [SP+1], R1
  call __function_vb2_SetFriction
  mov R1, [global_Bird]
  mov [SP], R1
  mov R1, 0.150000
  mov [SP+1], R1
  call __function_vb2_SetBounce
  mov R1, [global_Bird]
  mov [SP], R1
  mov R1, [global_AimOX]
  fsgn R1
  fmul R1, 8.000000
  mov [SP+1], R1
  mov R1, [global_AimOY]
  fsgn R1
  fmul R1, 8.000000
  mov [SP+2], R1
  call __function_vb2_SetVelocity
  mov R0, [global_BirdsLeft]
  isub R0, 1
  mov [global_BirdsLeft], R0
  mov R0, 1
  mov [global_GameState], R0
  mov R0, 0
  mov [global_FlyFrames], R0
  mov R0, 0
  mov [global_SlowFrames], R0
__function_LaunchBird_return:
  mov SP, BP
  pop BP
  ret

__function_DrawBodySprite:
  push BP
  mov BP, SP
  isub SP, 4
__if_64441_start:
  mov R2, [BP+2]
  mov [SP], R2
  call __function_vb2_Exists
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_64441_end
  jmp __function_DrawBodySprite_return
__if_64441_end:
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, [BP+3]
  mov [SP], R1
  call __function_select_region
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R2, [BP+2]
  mov [SP], R2
  call __function_vb2_GetAngle
  mov R1, R0
  fsgn R1
  mov [BP-1], R1
  mov R1, [BP-1]
  mov [SP], R1
  call __function_set_drawing_angle
  mov R1, [BP+4]
  fmul R1, 2.000000
  fmul R1, 20.000000
  fdiv R1, 40.000000
  mov [SP], R1
  mov R1, [BP+5]
  fmul R1, 2.000000
  fmul R1, 20.000000
  fdiv R1, 40.000000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R3, [BP+2]
  mov [SP], R3
  call __function_vb2_GetY
  mov R2, R0
  mov [BP-1], R2
  mov R2, [BP-1]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-1], R1
  mov R3, [BP+2]
  mov [SP], R3
  call __function_vb2_GetX
  mov R2, R0
  mov [BP-2], R2
  mov R2, [BP-2]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-2], R1
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_draw_region_rotozoomed_at
__function_DrawBodySprite_return:
  mov SP, BP
  pop BP
  ret

__function_DrawSpriteWorld:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, [BP+4]
  mov [SP], R1
  call __function_select_region
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, [BP+5]
  mov [SP], R1
  mov R1, [BP+5]
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R2, [BP+3]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-1], R1
  mov R2, [BP+2]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-2], R1
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__function_DrawSpriteWorld_return:
  mov SP, BP
  pop BP
  ret

__function_DrawBackground:
  push BP
  mov BP, SP
  isub SP, 4
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 8
  mov [SP], R1
  call __function_select_region
  mov R1, 640.000000
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 7
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 160
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 320
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 480
  mov [SP], R1
  mov R1, 180
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, -7.000000
  mov [SP], R1
  call __function_vb2_ScreenY
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__for_64532_start:
  mov R0, [BP-2]
  ilt R0, 640
  jf R0, __for_64532_end
  mov R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 5
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 40
  mov [SP+1], R1
  call __function_draw_region_at
__for_64532_continue:
  mov R0, [BP-2]
  iadd R0, 40
  mov [BP-2], R0
  jmp __for_64532_start
__for_64532_end:
__function_DrawBackground_return:
  mov SP, BP
  pop BP
  ret

__function_DrawSlingshot:
  push BP
  mov BP, SP
  isub SP, 10
  mov R1, -10.000000
  mov [SP], R1
  call __function_vb2_ScreenX
  mov [BP-1], R0
  mov R1, -7.000000
  mov [SP], R1
  call __function_vb2_ScreenY
  mov [BP-2], R0
  mov R1, -3.400000
  mov [SP], R1
  call __function_vb2_ScreenY
  mov [BP-3], R0
__if_64576_start:
  mov R0, [BP+4]
  jf R0, __if_64576_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_vb2_ScreenX
  mov [BP-4], R0
  mov R1, [BP+3]
  mov [SP], R1
  call __function_vb2_ScreenY
  mov [BP-5], R0
  mov R2, 120
  mov [SP], R2
  mov R2, 30
  mov [SP+1], R2
  mov R2, 30
  mov [SP+2], R2
  call __function_make_color_rgb
  mov R1, R0
  mov [BP-6], R1
  mov R1, [BP-6]
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, [BP-1]
  isub R1, 8
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  call __function_draw_line
  mov R1, [BP-1]
  iadd R1, 8
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  call __function_draw_line
__if_64576_end:
  mov R1, -14663552
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, [BP-1]
  isub R1, 3
  mov [SP], R1
  mov R1, [BP-3]
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 3
  mov [SP+2], R1
  mov R1, [BP-2]
  mov [SP+3], R1
  call __function_draw_rectangle
  mov R1, [BP-1]
  isub R1, 1
  mov [SP], R1
  mov R1, [BP-3]
  iadd R1, 12
  mov [SP+1], R1
  mov R1, [BP-1]
  isub R1, 8
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_draw_line
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP], R1
  mov R1, [BP-3]
  iadd R1, 12
  mov [SP+1], R1
  mov R1, [BP-1]
  iadd R1, 8
  mov [SP+2], R1
  mov R1, [BP-3]
  mov [SP+3], R1
  call __function_draw_line
__function_DrawSlingshot_return:
  mov SP, BP
  pop BP
  ret

__function_DrawAimPreview:
  push BP
  mov BP, SP
  isub SP, 11
  mov R0, [global_AimOX]
  fsgn R0
  fmul R0, 8.000000
  mov [BP-1], R0
  mov R0, [global_AimOY]
  fsgn R0
  fmul R0, 8.000000
  mov [BP-2], R0
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R0, 0.150000
  mov [BP-3], R0
__for_64660_start:
  mov R0, [BP-3]
  flt R0, 1.400000
  jf R0, __for_64660_end
  mov R0, [BP+2]
  mov R1, [BP-1]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  mov [BP-4], R0
  mov R0, [BP+3]
  mov R1, [BP-2]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-3]
  fmul R1, 5.000000
  mov R2, [BP-3]
  fmul R1, R2
  fsub R0, R1
  mov [BP-5], R0
  mov R1, [BP-4]
  mov [SP], R1
  call __function_vb2_ScreenX
  mov [BP-6], R0
  mov R1, [BP-5]
  mov [SP], R1
  call __function_vb2_ScreenY
  mov [BP-7], R0
  mov R1, [BP-6]
  isub R1, 1
  mov [SP], R1
  mov R1, [BP-7]
  isub R1, 1
  mov [SP+1], R1
  mov R1, [BP-6]
  iadd R1, 1
  mov [SP+2], R1
  mov R1, [BP-7]
  iadd R1, 1
  mov [SP+3], R1
  call __function_draw_rectangle
__for_64660_continue:
  mov R0, [BP-3]
  fadd R0, 0.100000
  mov [BP-3], R0
  jmp __for_64660_start
__for_64660_end:
__function_DrawAimPreview_return:
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

__function_main:
  push BP
  mov BP, SP
  isub SP, 17
  call __function_DefineRegions
  call __function_BuildLevel
  mov R1, 0
  mov [SP], R1
  call __function_select_gamepad
__while_64734_start:
__while_64734_continue:
  mov R0, 1
  jf R0, __while_64734_end
__if_64737_start:
  call __function_gamepad_button_start
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  jf R0, __if_64737_end
  call __function_vb2_Quit
  call __function_BuildLevel
__if_64737_end:
__if_64744_start:
  mov R0, [global_GameState]
  ieq R0, 0
  jf R0, __if_64744_end
__if_64749_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_64749_end
  mov R0, [global_AimOX]
  fsub R0, 0.050000
  mov [global_AimOX], R0
__if_64749_end:
__if_64758_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_64758_end
  mov R0, [global_AimOX]
  fadd R0, 0.050000
  mov [global_AimOX], R0
__if_64758_end:
__if_64767_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_64767_end
  mov R0, [global_AimOY]
  fadd R0, 0.050000
  mov [global_AimOY], R0
__if_64767_end:
__if_64776_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_64776_end
  mov R0, [global_AimOY]
  fsub R0, 0.050000
  mov [global_AimOY], R0
__if_64776_end:
__if_64785_start:
  mov R0, [global_AimOX]
  fgt R0, -0.200000
  jf R0, __if_64785_end
  mov R0, -0.200000
  mov [global_AimOX], R0
__if_64785_end:
__if_64794_start:
  mov R0, [global_AimOY]
  fgt R0, 2.400000
  jf R0, __if_64794_end
  mov R0, 2.400000
  mov [global_AimOY], R0
__if_64794_end:
__if_64801_start:
  mov R0, [global_AimOY]
  flt R0, -2.400000
  jf R0, __if_64801_end
  mov R0, -2.400000
  mov [global_AimOY], R0
__if_64801_end:
  mov R1, [global_AimOX]
  mov R2, [global_AimOX]
  fmul R1, R2
  mov R2, [global_AimOY]
  mov R3, [global_AimOY]
  fmul R2, R3
  fadd R1, R2
  mov [SP], R1
  call __function_sqrt
  mov [BP-7], R0
__if_64820_start:
  mov R0, [BP-7]
  fgt R0, 2.600000
  jf R0, __if_64820_end
  mov R0, [global_AimOX]
  fmul R0, 2.600000
  mov R1, [BP-7]
  fdiv R0, R1
  mov [global_AimOX], R0
  mov R0, [global_AimOY]
  fmul R0, 2.600000
  mov R1, [BP-7]
  fdiv R0, R1
  mov [global_AimOY], R0
__if_64820_end:
__if_64839_start:
  mov R0, [BP-7]
  flt R0, 0.600000
  jf R0, __if_64839_end
  mov R0, [global_AimOX]
  fmul R0, 0.600000
  mov R1, [BP-7]
  fdiv R0, R1
  mov [global_AimOX], R0
  mov R0, [global_AimOY]
  fmul R0, 0.600000
  mov R1, [BP-7]
  fdiv R0, R1
  mov [global_AimOY], R0
__if_64839_end:
__if_64858_start:
  call __function_gamepad_button_a
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  jf R0, __if_64858_end
  call __function_LaunchBird
__if_64858_end:
__if_64744_end:
  call __function_vb2_Step
  call __function_CheckPigs
__if_64865_start:
  mov R1, [global_GameState]
  ine R1, 2
  jf R1, __LogicalAnd_ShortCircuit_64870
  call __function_AlivePigs
  mov R2, R0
  ieq R2, 0
  and R1, R2
__LogicalAnd_ShortCircuit_64870:
  mov R0, R1
  jf R0, __if_64865_end
  mov R0, [global_Score]
  mov R1, [global_BirdsLeft]
  imul R1, 1000
  iadd R0, R1
  mov [global_Score], R0
  mov R0, 2
  mov [global_GameState], R0
__if_64865_end:
__if_64884_start:
  mov R0, [global_GameState]
  ieq R0, 1
  jf R0, __if_64884_end
  mov R0, [global_FlyFrames]
  iadd R0, 1
  mov [global_FlyFrames], R0
  mov R1, [global_Bird]
  mov [SP], R1
  call __function_vb2_GetVX
  mov [BP-7], R0
  mov R1, [global_Bird]
  mov [SP], R1
  call __function_vb2_GetVY
  mov [BP-8], R0
__if_64902_start:
  mov R0, [BP-7]
  mov R1, [BP-7]
  fmul R0, R1
  mov R1, [BP-8]
  mov R2, [BP-8]
  fmul R1, R2
  fadd R0, R1
  flt R0, 0.160000
  jf R0, __if_64902_else
  mov R0, [global_SlowFrames]
  iadd R0, 1
  mov [global_SlowFrames], R0
  jmp __if_64902_end
__if_64902_else:
  mov R0, 0
  mov [global_SlowFrames], R0
__if_64902_end:
  mov R1, [global_Bird]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-9], R0
  mov R1, [global_Bird]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-10], R0
  mov R0, 0
  mov [BP-11], R0
__if_64931_start:
  mov R2, [global_Bird]
  mov [SP], R2
  call __function_vb2_Exists
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_64931_else
  mov R0, 1
  mov [BP-11], R0
  jmp __if_64931_end
__if_64931_else:
__if_64939_start:
  mov R0, [BP-9]
  fgt R0, 22.000000
  jt R0, __LogicalOr_ShortCircuit_64944
  mov R1, [BP-9]
  flt R1, -22.000000
  or R0, R1
__LogicalOr_ShortCircuit_64944:
  jf R0, __if_64939_else
  mov R0, 1
  mov [BP-11], R0
  jmp __if_64939_end
__if_64939_else:
__if_64951_start:
  mov R0, [BP-10]
  flt R0, -12.000000
  jf R0, __if_64951_else
  mov R0, 1
  mov [BP-11], R0
  jmp __if_64951_end
__if_64951_else:
__if_64959_start:
  mov R2, [global_Bird]
  mov [SP], R2
  call __function_vb2_IsAwake
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_64959_else
  mov R0, 1
  mov [BP-11], R0
  jmp __if_64959_end
__if_64959_else:
__if_64967_start:
  mov R0, [global_SlowFrames]
  igt R0, 45
  jf R0, __if_64967_else
  mov R0, 1
  mov [BP-11], R0
  jmp __if_64967_end
__if_64967_else:
__if_64974_start:
  mov R0, [global_FlyFrames]
  igt R0, 600
  jf R0, __if_64974_end
  mov R0, 1
  mov [BP-11], R0
__if_64974_end:
__if_64967_end:
__if_64959_end:
__if_64951_end:
__if_64939_end:
__if_64931_end:
__if_64981_start:
  call __function_gamepad_button_a
  mov R1, R0
  ieq R1, 1
  jf R1, __LogicalAnd_ShortCircuit_64986
  mov R2, [global_FlyFrames]
  igt R2, 20
  and R1, R2
__LogicalAnd_ShortCircuit_64986:
  mov R0, R1
  jf R0, __if_64981_end
  mov R0, 1
  mov [BP-11], R0
__if_64981_end:
__if_64992_start:
  mov R0, [BP-11]
  jf R0, __if_64992_end
  mov R1, [global_Bird]
  mov [SP], R1
  call __function_vb2_Destroy
  mov R0, -1
  mov [global_Bird], R0
__if_65001_start:
  mov R0, [global_BirdsLeft]
  ieq R0, 0
  jf R0, __if_65001_else
  mov R0, 3
  mov [global_GameState], R0
  jmp __if_65001_end
__if_65001_else:
  mov R0, 0
  mov [global_GameState], R0
__if_65001_end:
__if_64992_end:
__if_64884_end:
  call __function_DrawBackground
  mov R0, [global_AimOX]
  fadd R0, -10.000000
  mov [BP-1], R0
  mov R0, [global_AimOY]
  fadd R0, -3.400000
  mov [BP-2], R0
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [global_GameState]
  ieq R1, 0
  mov [SP+2], R1
  call __function_DrawSlingshot
__if_65030_start:
  mov R0, [global_GameState]
  ieq R0, 0
  jf R0, __if_65030_end
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_DrawAimPreview
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  mov R1, 0.900000
  mov [SP+3], R1
  call __function_DrawSpriteWorld
__if_65030_end:
  mov R0, [global_BirdsLeft]
  mov [BP-3], R0
__if_65052_start:
  mov R0, [global_GameState]
  ieq R0, 0
  jf R0, __if_65052_end
  mov R0, [BP-3]
  isub R0, 1
  mov [BP-3], R0
__if_65052_end:
  mov R0, 0
  mov [BP-4], R0
__for_65063_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_65063_end
  mov R1, [BP-4]
  cif R1
  fmul R1, 2.000000
  fsgn R1
  fadd R1, -12.400000
  mov [SP], R1
  mov R1, -6.100000
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  mov R1, 0.900000
  mov [SP+3], R1
  call __function_DrawSpriteWorld
__for_65063_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_65063_start
__for_65063_end:
  mov R0, 0
  mov [BP-5], R0
__for_65089_start:
  mov R0, [BP-5]
  mov R1, [global_BlockCount]
  ilt R0, R1
  jf R0, __for_65089_end
  mov R1, global_BlockBody
  mov R2, [BP-5]
  iadd R1, R2
  mov R1, [R1]
  mov [SP], R1
  mov R1, global_BlockRegion
  mov R2, [BP-5]
  iadd R1, R2
  mov R1, [R1]
  mov [SP+1], R1
  mov R1, global_BlockHW
  mov R2, [BP-5]
  iadd R1, R2
  mov R1, [R1]
  mov [SP+2], R1
  mov R1, global_BlockHH
  mov R2, [BP-5]
  iadd R1, R2
  mov R1, [R1]
  mov [SP+3], R1
  call __function_DrawBodySprite
__for_65089_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_65089_start
__for_65089_end:
  mov R0, 0
  mov [BP-6], R0
__for_65113_start:
  mov R0, [BP-6]
  mov R1, [global_PigCount]
  ilt R0, R1
  jf R0, __for_65113_end
  mov R1, global_PigBody
  mov R2, [BP-6]
  iadd R1, R2
  mov R1, [R1]
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  mov R1, 0.900000
  mov [SP+2], R1
  mov R1, 0.900000
  mov [SP+3], R1
  call __function_DrawBodySprite
__for_65113_continue:
  mov R0, [BP-6]
  mov R1, R0
  iadd R1, 1
  mov [BP-6], R1
  jmp __for_65113_start
__for_65113_end:
__if_65129_start:
  mov R0, [global_Bird]
  ine R0, -1
  jf R0, __if_65129_end
  mov R1, [global_Bird]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 0.900000
  mov [SP+2], R1
  mov R1, 0.900000
  mov [SP+3], R1
  call __function_DrawBodySprite
__if_65129_end:
  mov R0, 0
  mov [BP-6], R0
__for_65139_start:
  mov R0, [BP-6]
  mov R1, [global_PigCount]
  ilt R0, R1
  jf R0, __for_65139_end
__if_65149_start:
  mov R0, global_PoofFrames
  mov R1, [BP-6]
  iadd R0, R1
  mov R0, [R0]
  ile R0, 0
  jf R0, __if_65149_end
  jmp __for_65139_continue
__if_65149_end:
  mov R0, global_PoofFrames
  mov R1, [BP-6]
  iadd R0, R1
  mov R0, [R0]
  isub R0, 1
  mov R1, global_PoofFrames
  mov R2, [BP-6]
  iadd R1, R2
  mov [R1], R0
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, 6
  mov [SP], R1
  call __function_select_region
  mov R2, 255
  mov [SP], R2
  mov R2, 255
  mov [SP+1], R2
  mov R2, 255
  mov [SP+2], R2
  mov R2, global_PoofFrames
  mov R3, [BP-6]
  iadd R2, R3
  mov R2, [R2]
  imul R2, 5
  mov [SP+3], R2
  call __function_make_color_rgba
  mov R1, R0
  mov [BP-12], R1
  mov R1, [BP-12]
  mov [SP], R1
  call __function_set_multiply_color
  mov R2, global_PoofY
  mov R3, [BP-6]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-12], R1
  mov R2, global_PoofX
  mov R3, [BP-6]
  iadd R2, R3
  mov R2, [R2]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-13], R1
  mov R1, [BP-13]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_draw_region_at
__for_65139_continue:
  mov R0, [BP-6]
  mov R1, R0
  iadd R1, 1
  mov [BP-6], R1
  jmp __for_65139_start
__for_65139_end:
  mov R1, -1
  mov [SP], R1
  call __function_set_multiply_color
  mov R1, 8
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, __literal_string_65193
  mov [SP+2], R1
  call __function_print_at
  mov R1, 168
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, __literal_string_65197
  mov [SP+2], R1
  call __function_print_at
  mov R1, 232
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, [global_Score]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, 340
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, __literal_string_65205
  mov [SP+2], R1
  call __function_print_at
  mov R1, 404
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, [global_BirdsLeft]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, 470
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, __literal_string_65213
  mov [SP+2], R1
  call __function_print_at
  call __function_AlivePigs
  mov R1, R0
  mov [BP-12], R1
  mov R1, 524
  mov [SP], R1
  mov R1, 4
  mov [SP+1], R1
  mov R1, [BP-12]
  mov [SP+2], R1
  call __function_ShowInt
  mov R1, 8
  mov [SP], R1
  mov R1, 340
  mov [SP+1], R1
  mov R1, __literal_string_65221
  mov [SP+2], R1
  call __function_print_at
__if_65222_start:
  mov R0, [global_GameState]
  ieq R0, 2
  jf R0, __if_65222_else
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 0.500000
  mov [SP+1], R1
  mov R1, 9
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  call __function_DrawSpriteWorld
  mov R1, 260
  mov [SP], R1
  mov R1, 230
  mov [SP+1], R1
  mov R1, __literal_string_65235
  mov [SP+2], R1
  call __function_print_at
  mov R1, 215
  mov [SP], R1
  mov R1, 254
  mov [SP+1], R1
  mov R1, __literal_string_65239
  mov [SP+2], R1
  call __function_print_at
  jmp __if_65222_end
__if_65222_else:
__if_65240_start:
  mov R0, [global_GameState]
  ieq R0, 3
  jf R0, __if_65240_end
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 0.500000
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  mov R1, 1.000000
  mov [SP+3], R1
  call __function_DrawSpriteWorld
  mov R1, 220
  mov [SP], R1
  mov R1, 244
  mov [SP+1], R1
  mov R1, __literal_string_65253
  mov [SP+2], R1
  call __function_print_at
__if_65240_end:
__if_65222_end:
  call __function_end_frame
  jmp __while_64734_start
__while_64734_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_1203:
  string "0123456789ABCDEF"
__literal_string_1240:
  string "-2147483648"
__literal_string_65193:
  string "ANGRY BLOCKS"
__literal_string_65197:
  string "SCORE"
__literal_string_65205:
  string "BIRDS"
__literal_string_65213:
  string "PIGS"
__literal_string_65221:
  string "DPAD AIM   A LAUNCH   START RESTART"
__literal_string_65235:
  string "LEVEL CLEAR!"
__literal_string_65239:
  string "PRESS START TO PLAY AGAIN"
__literal_string_65253:
  string "OUT OF BIRDS - PRESS START"
