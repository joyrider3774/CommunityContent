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
__if_748_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  flt R0, R1
  jf R0, __if_748_end
  mov R0, [BP+3]
  jmp __function_b2ClampFloat_return
__if_748_end:
__if_754_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  fgt R0, R1
  jf R0, __if_754_end
  mov R0, [BP+4]
  jmp __function_b2ClampFloat_return
__if_754_end:
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
__if_1141_start:
  mov R0, [BP-1]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_1141_end
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Normalize_return
__if_1141_end:
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
__if_1210_start:
  mov R0, [BP-1]
  fgt R0, 0.000000
  jf R0, __if_1210_end
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
__if_1210_end:
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
__if_1703_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_1703_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2GetLengthAndNormalize_return
__if_1703_end:
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
__if_1744_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_1749
  mov R1, [BP+3]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_1749:
  jf R0, __if_1744_end
  mov R0, 0.000000
  jmp __function_b2Atan2_return
__if_1744_end:
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
__if_1880_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_1880_end
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
__if_1880_end:
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
__if_1965_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_1965_end
  mov R0, 1.000000
  mov R1, [BP-4]
  fdiv R0, R1
  mov [BP-5], R0
__if_1965_end:
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
  jf R0, __LogicalAnd_ShortCircuit_2008
  mov R1, [BP-1]
  flt R1, 1.000600
  and R0, R1
__LogicalAnd_ShortCircuit_2008:
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
__if_2100_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2100_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2100_end:
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
__if_2172_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_2172_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_2172_end:
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
  jf R0, __LogicalAnd_ShortCircuit_2229
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2229:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2240
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2240:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2251
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2251:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_2262
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
__LogicalAnd_ShortCircuit_2262:
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
__if_2378_start:
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_2378_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_2378_end:
__if_2388_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_2388_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_2388_end:
__if_2398_start:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_2398_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_2398_end:
__if_2408_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_2408_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_2408_end:
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
__if_2479_start:
  mov R0, [BP+2]
  mov R1, [BP+2]
  fne R0, R1
  jf R0, __if_2479_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_2479_end:
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
__if_2498_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fgt R0, R1
  jf R0, __if_2498_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_2498_end:
__if_2504_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fsgn R1
  flt R0, R1
  jf R0, __if_2504_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_2504_end:
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
  jf R1, __LogicalAnd_ShortCircuit_2519
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_b2IsValidFloat
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_2519:
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
__if_2525_start:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_2525_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_2525_end:
__if_2532_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_2532_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_2532_end:
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
__if_3612_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_3614
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_3614:
  jf R0, __if_3612_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_3623_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3623_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_3623_end:
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
__if_3612_end:
__if_3642_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_3644
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_3644:
  jf R0, __if_3642_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_3652_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_3652_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_3652_end:
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
__if_3642_end:
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
__if_3674_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_3674_end
  jmp __function_reduce_malloc_block_return
__if_3674_end:
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
__if_3717_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3717_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_3717_end:
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
__if_3736_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_3736_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_3736_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_3746_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_3749
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_3749:
  jf R0, __if_3746_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_3746_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_3761_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_3761_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_3761_end:
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
__if_3776_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3776_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_3776_end:
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
__if_3791_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_3791_end
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
__if_3791_end:
__if_3826_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_3826_end
  mov R0, -1
  jmp __function_malloc_return
__if_3826_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_3835_start:
__while_3835_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_3835_end
__if_3838_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_3841
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3841:
  jf R0, __if_3838_end
  jmp __while_3835_end
__if_3838_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_3835_start
__while_3835_end:
__if_3851_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_3851_end
  mov R0, -1
  jmp __function_malloc_return
__if_3851_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_3861_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_3861_else
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
__if_3906_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_3906_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_3906_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_3861_end
__if_3861_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_3861_end:
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
__if_3931_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_3931_end
  jmp __function_free_return
__if_3931_end:
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
__if_3959_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_3959_end
  mov R0, -1
  jmp __function_calloc_return
__if_3959_end:
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
__if_3973_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_3973_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_3973_end:
__if_3979_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_3979_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_3979_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_3998_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_3998_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_3998_end:
__if_4004_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_4004_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4004_end
__if_4004_else:
__if_4015_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_4015_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_4015_end
__if_4015_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_4026_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_4026_end
  mov R0, -1
  jmp __function_realloc_return
__if_4026_end:
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
__if_4015_end:
__if_4004_end:
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
__if_4113_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_4118
  mov R1, [BP-8]
  mov R2, [BP-11]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_4118:
  jf R0, __if_4113_else
__if_4122_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4122_else
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
  jmp __if_4122_end
__if_4122_else:
__if_4141_start:
  mov R0, [BP-8]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4141_else
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
  jmp __if_4141_end
__if_4141_else:
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4141_end:
__if_4122_end:
  jmp __if_4113_end
__if_4113_else:
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
__if_4188_start:
  mov R0, [BP-13]
  fne R0, 0.000000
  jf R0, __if_4188_end
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
__if_4188_end:
  mov R0, [BP-12]
  mov R1, [BP-14]
  fmul R0, R1
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-8]
  fdiv R0, R1
  mov [BP-15], R0
__if_4218_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jf R0, __if_4218_else
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
  jmp __if_4218_end
__if_4218_else:
__if_4235_start:
  mov R0, [BP-15]
  fgt R0, 1.000000
  jf R0, __if_4235_end
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
__if_4235_end:
__if_4218_end:
  mov R0, [BP-14]
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-15]
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4113_end:
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
__for_4300_start:
  mov R0, [BP-1]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_4300_end
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
__for_4300_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4300_start
__for_4300_end:
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
__if_4381_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_4381_end
  mov R0, [BP+2]
  jmp __function_b2SimplexVertexPtr_return
__if_4381_end:
__if_4389_start:
  mov R0, [BP+3]
  ieq R0, 1
  jf R0, __if_4389_end
  mov R0, [BP+2]
  iadd R0, 9
  jmp __function_b2SimplexVertexPtr_return
__if_4389_end:
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
__for_4492_start:
  mov R0, [BP-4]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_4492_end
  mov R1, [BP+2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-5], R0
__if_4511_start:
  mov R0, [BP-5]
  mov R1, [BP-3]
  fgt R0, R1
  jf R0, __if_4511_end
  mov R0, [BP-4]
  mov [BP-2], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_4511_end:
__for_4492_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_4492_start
__for_4492_end:
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
__for_4534_start:
  mov R0, [BP-1]
  mov R2, [BP+5]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_4534_end
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
__for_4534_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4534_start
__for_4534_end:
__if_4595_start:
  mov R1, [BP+5]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_4595_end
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
__if_4595_end:
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
__for_4654_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_4654_end
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
__for_4654_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4654_start
__for_4654_end:
__function_b2MakeSimplexCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeWitnessPoints:
  push BP
  mov BP, SP
  isub SP, 7
__if_4688_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_4688_else
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
  jmp __if_4688_end
__if_4688_else:
__if_4706_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_4706_else
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
  jmp __if_4706_end
__if_4706_else:
__if_4744_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_4744_else
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
  jmp __if_4744_end
__if_4744_else:
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
__if_4744_end:
__if_4706_end:
__if_4688_end:
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
__if_4817_start:
  mov R0, [BP-7]
  fle R0, 0.000000
  jf R0, __if_4817_end
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
__if_4817_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_4843_start:
  mov R0, [BP-8]
  fle R0, 0.000000
  jf R0, __if_4843_end
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
__if_4843_end:
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
__if_5065_start:
  mov R0, [BP-12]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5070
  mov R1, [BP-18]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5070:
  jf R0, __if_5065_end
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
__if_5065_end:
__if_5088_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5093
  mov R1, [BP-12]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5093:
  jf R0, __LogicalAnd_ShortCircuit_5097
  mov R1, [BP-31]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5097:
  jf R0, __if_5088_end
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
__if_5088_end:
__if_5149_start:
  mov R0, [BP-17]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5154
  mov R1, [BP-18]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5154:
  jf R0, __LogicalAnd_ShortCircuit_5158
  mov R1, [BP-30]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5158:
  jf R0, __if_5149_end
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
__if_5149_end:
__if_5215_start:
  mov R0, [BP-11]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5220
  mov R1, [BP-24]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5220:
  jf R0, __if_5215_end
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
__if_5215_end:
__if_5243_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5248
  mov R1, [BP-23]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5248:
  jf R0, __if_5243_end
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
__if_5243_end:
__if_5271_start:
  mov R0, [BP-23]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5276
  mov R1, [BP-24]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5276:
  jf R0, __LogicalAnd_ShortCircuit_5280
  mov R1, [BP-29]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5280:
  jf R0, __if_5271_end
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
__if_5271_end:
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
__for_5403_start:
  mov R0, [BP-61]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_5403_end
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
__for_5403_continue:
  mov R0, [BP-61]
  mov R1, R0
  iadd R1, 1
  mov [BP-61], R1
  jmp __for_5403_start
__for_5403_end:
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
__while_5463_start:
__while_5463_continue:
  mov R0, [BP-58]
  mov R1, [BP-57]
  ilt R0, R1
  jf R0, __while_5463_end
  mov R0, [BP-20]
  mov [BP-61], R0
  mov R0, 0
  mov [BP-68], R0
__for_5472_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_5472_end
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
__for_5472_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_5472_start
__for_5472_end:
  mov R0, 0.000000
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-62], R0
__if_5510_start:
  mov R0, [BP-20]
  ieq R0, 1
  jf R0, __if_5510_else
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __if_5510_end
__if_5510_else:
__if_5522_start:
  mov R0, [BP-20]
  ieq R0, 2
  jf R0, __if_5522_else
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex2
  jmp __if_5522_end
__if_5522_else:
__if_5532_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_5532_end
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex3
__if_5532_end:
__if_5522_end:
__if_5510_end:
__if_5542_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_5542_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_5542_end:
__if_5558_start:
  lea R2, [BP-63]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-56]
  flt R1, R2
  mov R0, R1
  jf R0, __if_5558_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_5558_end:
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
__for_5640_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_5640_end
__if_5650_start:
  mov R1, [BP-64]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov R1, [R1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_5659
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  lea R2, [BP-55]
  mov R3, [BP-68]
  iadd R2, R3
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_5659:
  jf R0, __if_5650_end
  mov R0, 1
  mov [BP-67], R0
  jmp __for_5640_end
__if_5650_end:
__for_5640_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_5640_start
__for_5640_end:
__if_5669_start:
  mov R0, [BP-67]
  jf R0, __if_5669_end
  jmp __while_5463_end
__if_5669_end:
  mov R0, [BP-20]
  iadd R0, 1
  mov [BP-20], R0
  jmp __while_5463_start
__while_5463_end:
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
__if_5718_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  jf R0, __if_5718_end
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
__if_5718_end:
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
__for_5904_start:
  mov R0, [BP-56]
  ilt R0, 20
  jf R0, __for_5904_end
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
__if_5930_start:
  mov R0, [BP-59]
  mov R1, [BP-3]
  mov R2, [BP-4]
  fadd R1, R2
  flt R0, R1
  jf R0, __if_5930_end
__if_5938_start:
  mov R0, [BP-56]
  ieq R0, 0
  jf R0, __if_5938_else
__if_5943_start:
  mov R1, [BP+2]
  iadd R1, 43
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_5946
  mov R1, [BP-59]
  mov R2, [BP-1]
  fmul R2, 2.000000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_5946:
  jf R0, __if_5943_else
  mov R0, [BP-59]
  mov R1, [BP-1]
  fsub R0, R1
  mov [BP-3], R0
  jmp __if_5943_end
__if_5943_else:
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
__if_5943_end:
  jmp __if_5938_end
__if_5938_else:
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
__if_5938_end:
__if_5930_end:
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
__if_6040_start:
  mov R0, [BP-66]
  fge R0, 0.000000
  jf R0, __if_6040_end
  jmp __function_b2ShapeCast_return
__if_6040_end:
  mov R0, [BP-12]
  mov R1, [BP-3]
  mov R2, [BP-59]
  fsub R1, R2
  mov R2, [BP-66]
  fdiv R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_6056_start:
  mov R0, [BP-12]
  mov R2, [BP+2]
  iadd R2, 42
  mov R1, [R2]
  fge R0, R1
  jf R0, __if_6056_end
  jmp __function_b2ShapeCast_return
__if_6056_end:
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
__for_5904_continue:
  mov R0, [BP-56]
  iadd R0, 1
  mov [BP-56], R0
  jmp __for_5904_start
__for_5904_end:
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
__if_6232_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_6232_end
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
__if_6232_end:
__if_6297_start:
  mov R0, [BP+2]
  iadd R0, 1
  mov R0, [R0]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  ieq R0, R1
  jf R0, __if_6297_end
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
__if_6425_start:
  lea R2, [BP-45]
  mov [SP], R2
  lea R2, [BP-37]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_6425_end
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
__if_6425_end:
  jmp __function_b2MakeSeparationFunction_return
__if_6297_end:
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
__if_6564_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-19]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_6564_end
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
__if_6564_end:
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
__if_6608_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_6608_else
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
  jmp __if_6608_end
__if_6608_else:
__if_6709_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_6709_else
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
  jmp __if_6709_end
__if_6709_else:
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
__if_6709_end:
__if_6608_end:
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
__if_6905_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_6905_else
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
  jmp __if_6905_end
__if_6905_else:
__if_6959_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_6959_else
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
  jmp __if_6959_end
__if_6959_else:
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
__if_6959_end:
__if_6905_end:
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
__while_7174_start:
__while_7174_continue:
  mov R0, [BP-78]
  jf R0, __while_7174_end
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
__if_7246_start:
  mov R0, [BP-89]
  fle R0, 0.000000
  jf R0, __if_7246_end
  mov R0, 2
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_7246_end:
__if_7261_start:
  mov R0, [BP-89]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_7261_end
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
__if_7261_end:
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
__while_7340_start:
__while_7340_continue:
  mov R0, [BP-132]
  jf R0, __while_7340_end
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
__if_7357_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_7357_end
  mov R0, 4
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-23]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_7340_end
__if_7357_end:
__if_7376_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  fgt R0, R1
  jf R0, __if_7376_end
  mov R0, [BP-130]
  mov [BP-27], R0
  jmp __while_7340_end
__if_7376_end:
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
__if_7395_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  flt R0, R1
  jf R0, __if_7395_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_7340_end
__if_7395_end:
__if_7414_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_7414_end
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
  jmp __while_7340_end
__if_7414_end:
  mov R0, 0
  mov [BP-137], R0
  mov R0, [BP-27]
  mov [BP-138], R0
  mov R0, [BP-130]
  mov [BP-139], R0
  mov R0, 1
  mov [BP-140], R0
__while_7481_start:
__while_7481_continue:
  mov R0, [BP-140]
  jf R0, __while_7481_end
__if_7486_start:
  mov R0, [BP-137]
  and R0, 1
  ine R0, 0
  jf R0, __if_7486_else
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
  jmp __if_7486_end
__if_7486_else:
  mov R0, [BP-138]
  mov R1, [BP-139]
  fadd R0, R1
  fmul R0, 0.500000
  mov [BP-141], R0
__if_7486_end:
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
__if_7532_start:
  mov R2, [BP-142]
  mov R3, [BP-25]
  fsub R2, R3
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, [BP-26]
  flt R1, R2
  mov R0, R1
  jf R0, __if_7532_end
  mov R0, [BP-141]
  mov [BP-130], R0
  jmp __while_7481_end
__if_7532_end:
__if_7544_start:
  mov R0, [BP-142]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_7544_else
  mov R0, [BP-141]
  mov [BP-138], R0
  mov R0, [BP-142]
  mov [BP-136], R0
  jmp __if_7544_end
__if_7544_else:
  mov R0, [BP-141]
  mov [BP-139], R0
  mov R0, [BP-142]
  mov [BP-135], R0
__if_7544_end:
__if_7562_start:
  mov R0, [BP-137]
  ieq R0, 50
  jf R0, __if_7562_end
  jmp __while_7481_end
__if_7562_end:
  jmp __while_7481_start
__while_7481_end:
  mov R0, [BP-131]
  iadd R0, 1
  mov [BP-131], R0
__if_7572_start:
  mov R0, [BP-131]
  ieq R0, 8
  jf R0, __if_7572_end
  jmp __while_7340_end
__if_7572_end:
  jmp __while_7340_start
__while_7340_end:
__if_7577_start:
  mov R0, [BP-129]
  jf R0, __if_7577_end
  jmp __while_7174_end
__if_7577_end:
__if_7580_start:
  mov R0, [BP-29]
  mov R1, [BP-28]
  ieq R0, R1
  jf R0, __if_7580_end
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
  jmp __while_7174_end
__if_7580_end:
  jmp __while_7174_start
__while_7174_end:
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
__for_8014_start:
  mov R0, [BP-8]
  mov R1, [BP+3]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_8014_end
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
__for_8014_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_8014_start
__for_8014_end:
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
__if_8217_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_8217_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakeOffsetRoundedPolygon_return
__if_8217_end:
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
__for_8252_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8252_end
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
__for_8252_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8252_start
__for_8252_end:
  mov R0, 0
  mov [BP-5], R0
__for_8275_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8275_end
  mov R0, 0
  mov [BP-6], R0
__if_8289_start:
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_8289_end
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-6], R0
__if_8289_end:
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
__for_8275_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8275_start
__for_8275_end:
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
__for_8359_start:
  mov R0, [BP-3]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8359_end
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
__for_8359_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_8359_start
__for_8359_end:
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
__if_8591_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_8591_end
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
__if_8591_end:
__if_8617_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_8617_end
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
__if_8617_end:
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
__if_8666_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_8666_else
  mov R0, 1.412000
  mov [BP-27], R0
  mov R0, 0
  mov [BP-28], R0
__for_8674_start:
  mov R0, [BP-28]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_8674_end
  mov R0, [BP-28]
  isub R0, 1
  mov [BP-29], R0
__if_8689_start:
  mov R0, [BP-28]
  ieq R0, 0
  jf R0, __if_8689_end
  mov R0, [BP-17]
  isub R0, 1
  mov [BP-29], R0
__if_8689_end:
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
__for_8674_continue:
  mov R0, [BP-28]
  mov R1, R0
  iadd R1, 1
  mov [BP-28], R1
  jmp __for_8674_start
__for_8674_end:
  jmp __if_8666_end
__if_8666_else:
  mov R0, 0
  mov [BP-27], R0
__for_8742_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_8742_end
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
__for_8742_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_8742_start
__for_8742_end:
__if_8666_end:
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
__for_8785_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_8785_end
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
__for_8785_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_8785_start
__for_8785_end:
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
__for_9119_start:
  mov R0, [BP-8]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9119_end
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
__for_9119_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_9119_start
__for_9119_end:
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
__if_9357_start:
  mov R0, [BP-8]
  feq R0, 0.000000
  jf R0, __if_9357_end
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
__if_9357_end:
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
__if_9468_start:
  mov R0, [BP-7]
  feq R0, 0.000000
  jf R0, __if_9468_end
__if_9473_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_9473_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_9473_end:
  jmp __function_b2RayCastCircle_return
__if_9468_end:
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
__if_9515_start:
  mov R0, [BP-13]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __if_9515_end
  jmp __function_b2RayCastCircle_return
__if_9515_end:
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
__if_9531_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_9537
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-15]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_9537:
  jf R0, __if_9531_end
__if_9543_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_9543_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_9543_end:
  jmp __function_b2RayCastCircle_return
__if_9531_end:
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
__if_9649_start:
  mov R0, [BP-7]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_9649_end
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
__if_9649_end:
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
__if_9713_start:
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
  jf R0, __if_9713_end
__if_9724_start:
  mov R0, [BP-16]
  flt R0, 0.000000
  jf R0, __if_9724_end
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
__if_9724_end:
__if_9746_start:
  mov R0, [BP-16]
  mov R1, [BP-7]
  fgt R0, R1
  jf R0, __if_9746_end
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
__if_9746_end:
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
__if_9713_end:
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
__if_9816_start:
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  fsgn R0
  mov R1, [BP-25]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_9825
  mov R1, [BP-25]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_9825:
  jf R0, __if_9816_end
  jmp __function_b2RayCastCapsule_return
__if_9816_end:
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
__if_9893_start:
  mov R0, [BP-31]
  mov R1, [BP-32]
  flt R0, R1
  jf R0, __if_9893_else
  mov R0, [BP-31]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-27]
  mov CR, 2
  movs
  jmp __if_9893_end
__if_9893_else:
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
__if_9893_end:
__if_9916_start:
  mov R0, [BP-33]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_9922
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-22]
  fmul R1, R2
  mov R2, [BP-33]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_9922:
  jf R0, __if_9916_end
  jmp __function_b2RayCastCapsule_return
__if_9916_end:
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
__if_9945_start:
  mov R0, [BP-36]
  flt R0, 0.000000
  jf R0, __if_9945_else
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
  jmp __if_9945_end
__if_9945_else:
__if_9967_start:
  mov R0, [BP-7]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __if_9967_else
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
  jmp __if_9967_end
__if_9967_else:
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
__if_9967_end:
__if_9945_end:
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
__if_10058_start:
  mov R0, [BP+4]
  jf R0, __if_10058_end
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
__if_10083_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-29]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_10083_end
  jmp __function_b2RayCastSegment_return
__if_10083_end:
__if_10058_end:
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
__if_10128_start:
  mov R0, [BP-11]
  feq R0, 0.000000
  jf R0, __if_10128_end
  jmp __function_b2RayCastSegment_return
__if_10128_end:
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
__if_10163_start:
  mov R0, [BP-19]
  feq R0, 0.000000
  jf R0, __if_10163_end
  jmp __function_b2RayCastSegment_return
__if_10163_end:
  mov R0, [BP-18]
  mov R1, [BP-19]
  fdiv R0, R1
  mov [BP-20], R0
__if_10173_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10179
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-20]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10179:
  jf R0, __if_10173_end
  jmp __function_b2RayCastSegment_return
__if_10173_end:
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
__if_10209_start:
  mov R0, [BP-25]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10214
  mov R1, [BP-11]
  mov R2, [BP-25]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10214:
  jf R0, __if_10209_end
  jmp __function_b2RayCastSegment_return
__if_10209_end:
__if_10218_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_10218_end
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Neg
__if_10218_end:
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
__if_10267_start:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  fne R0, 0.000000
  jf R0, __if_10267_end
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
__if_10267_end:
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
__for_10350_start:
  mov R0, [BP-10]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_10350_end
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
__if_10405_start:
  mov R0, [BP-20]
  feq R0, 0.000000
  jf R0, __if_10405_else
__if_10410_start:
  mov R0, [BP-19]
  flt R0, 0.000000
  jf R0, __if_10410_end
  jmp __function_b2RayCastPolygon_return
__if_10410_end:
  jmp __if_10405_end
__if_10405_else:
__if_10416_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_10421
  mov R1, [BP-19]
  mov R2, [BP-7]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_10421:
  jf R0, __if_10416_else
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-10]
  mov [BP-9], R0
  jmp __if_10416_end
__if_10416_else:
__if_10435_start:
  mov R0, [BP-20]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_10440
  mov R1, [BP-19]
  mov R2, [BP-8]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_10440:
  jf R0, __if_10435_end
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-8], R0
__if_10435_end:
__if_10416_end:
__if_10405_end:
__if_10451_start:
  mov R0, [BP-8]
  mov R1, [BP-7]
  flt R0, R1
  jf R0, __if_10451_end
  jmp __function_b2RayCastPolygon_return
__if_10451_end:
__for_10350_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_10350_start
__for_10350_end:
__if_10456_start:
  mov R0, [BP-9]
  ige R0, 0
  jf R0, __if_10456_else
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
  jmp __if_10456_end
__if_10456_else:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10456_end:
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
__if_10744_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_10744_end
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
__if_10744_end:
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
__if_10846_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_10846_end
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
__if_10846_end:
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
__if_10949_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_10949_end
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
__if_10949_end:
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
__if_11048_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11048_end
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
__if_11048_end:
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
__if_11093_start:
  mov R0, [BP+5]
  ieq R0, 0
  jf R0, __if_11093_end
  jmp __function_b2RecurseHull_return
__if_11093_end:
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
__if_11138_start:
  mov R0, [BP-25]
  fgt R0, 0.000000
  jf R0, __if_11138_end
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
__if_11138_end:
  mov R0, 1
  mov [BP-62], R0
__for_11152_start:
  mov R0, [BP-62]
  mov R1, [BP+5]
  ilt R0, R1
  jf R0, __for_11152_end
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
__if_11177_start:
  mov R0, [BP-63]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_11177_end
  mov R0, [BP-62]
  mov [BP-22], R0
  mov R0, [BP-63]
  mov [BP-25], R0
__if_11177_end:
__if_11188_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_11188_end
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
__if_11188_end:
__for_11152_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11152_start
__for_11152_end:
__if_11202_start:
  mov R1, [BP-25]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 2.000000
  flt R1, R2
  mov R0, R1
  jf R0, __if_11202_end
  jmp __function_b2RecurseHull_return
__if_11202_end:
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
__for_11237_start:
  mov R0, [BP-62]
  mov R1, [BP-28]
  ilt R0, R1
  jf R0, __for_11237_end
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
__for_11237_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11237_start
__for_11237_end:
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
__for_11271_start:
  mov R0, [BP-62]
  mov R1, [BP-45]
  ilt R0, R1
  jf R0, __for_11271_end
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
__for_11271_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11271_start
__for_11271_end:
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
__if_12186_start:
  mov R1, [BP-12]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_12186_end
  jmp __function_b2CollideCircles_return
__if_12186_end:
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
__if_12319_start:
  mov R0, [BP-11]
  flt R0, 0.000000
  jf R0, __if_12319_else
  lea R13, [BP-16]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_12319_end
__if_12319_else:
__if_12327_start:
  mov R0, [BP-14]
  flt R0, 0.000000
  jf R0, __if_12327_else
  lea R13, [BP-16]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_12327_end
__if_12327_else:
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
__if_12327_end:
__if_12319_end:
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
__if_12388_start:
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_12388_end
  jmp __function_b2CollideCapsuleAndCircle_return
__if_12388_end:
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
__for_12508_start:
  mov R0, [BP-10]
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __for_12508_end
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
__if_12540_start:
  mov R0, [BP-29]
  mov R1, [BP-8]
  fgt R0, R1
  jf R0, __if_12540_end
  mov R0, [BP-29]
  mov [BP-8], R0
  mov R0, [BP-10]
  mov [BP-7], R0
__if_12540_end:
__for_12508_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_12508_start
__for_12508_end:
__if_12551_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_12551_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_12551_end:
  mov R0, [BP-7]
  mov [BP-11], R0
__if_12563_start:
  mov R0, [BP-11]
  iadd R0, 1
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __if_12563_else
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-12], R0
  jmp __if_12563_end
__if_12563_else:
  mov R0, 0
  mov [BP-12], R0
__if_12563_end:
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
__if_12639_start:
  mov R0, [BP-21]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_12644
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_12644:
  jf R0, __if_12639_else
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
__if_12674_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_12674_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_12674_end:
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
  jmp __if_12639_end
__if_12639_else:
__if_12746_start:
  mov R0, [BP-26]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_12751
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_12751:
  jf R0, __if_12746_else
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
__if_12781_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_12781_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_12781_end:
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
  jmp __if_12746_end
__if_12746_else:
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
__if_12746_end:
__if_12639_end:
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
__if_13079_start:
  mov R0, [BP-27]
  fne R0, 0.000000
  jf R0, __if_13079_end
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
__if_13079_end:
  mov R0, [BP-26]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-25]
  fadd R0, R1
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-29], R0
__if_13108_start:
  mov R0, [BP-29]
  flt R0, 0.000000
  jf R0, __if_13108_else
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
  jmp __if_13108_end
__if_13108_else:
__if_13125_start:
  mov R0, [BP-29]
  fgt R0, 1.000000
  jf R0, __if_13125_end
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
__if_13125_end:
__if_13108_end:
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
__if_13195_start:
  mov R0, [BP-34]
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fgt R0, R1
  jf R0, __if_13195_end
  jmp __function_b2CollideCapsules_return
__if_13195_end:
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
  jf R0, __LogicalAnd_ShortCircuit_13264
  mov R1, [BP-49]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13264:
  jt R0, __LogicalOr_ShortCircuit_13267
  mov R1, [BP-48]
  mov R2, [BP-40]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_13273
  mov R2, [BP-49]
  mov R3, [BP-40]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_13273:
  or R0, R1
__LogicalOr_ShortCircuit_13267:
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
  jf R0, __LogicalAnd_ShortCircuit_13311
  mov R1, [BP-52]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13311:
  jt R0, __LogicalOr_ShortCircuit_13314
  mov R1, [BP-51]
  mov R2, [BP-41]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_13320
  mov R2, [BP-52]
  mov R3, [BP-41]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_13320:
  or R0, R1
__LogicalOr_ShortCircuit_13314:
  mov [BP-53], R0
__if_13323_start:
  mov R0, [BP-50]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_13328
  mov R1, [BP-53]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_13328:
  jf R0, __if_13323_end
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
__if_13382_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_13382_else
  mov R0, [BP-62]
  mov [BP-56], R0
  jmp __if_13382_end
__if_13382_else:
  mov R0, [BP-63]
  mov [BP-56], R0
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Neg
__if_13382_end:
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
__if_13449_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_13449_else
  mov R0, [BP-62]
  mov [BP-59], R0
  jmp __if_13449_end
__if_13449_else:
  mov R0, [BP-63]
  mov [BP-59], R0
  lea R1, [BP-58]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Neg
__if_13449_end:
__if_13466_start:
  mov R1, [BP-56]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 0.100000
  fadd R1, R2
  mov R2, [BP-59]
  fge R1, R2
  mov R0, R1
  jf R0, __if_13466_else
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
__if_13488_start:
  mov R0, [BP-48]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13493
  mov R1, [BP-49]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13493:
  jf R0, __if_13488_else
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
  jmp __if_13488_end
__if_13488_else:
__if_13512_start:
  mov R0, [BP-49]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13517
  mov R1, [BP-48]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13517:
  jf R0, __if_13512_end
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
__if_13512_end:
__if_13488_end:
__if_13536_start:
  mov R0, [BP-48]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_13541
  mov R1, [BP-49]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13541:
  jf R0, __if_13536_else
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
  jmp __if_13536_end
__if_13536_else:
__if_13560_start:
  mov R0, [BP-49]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_13565
  mov R1, [BP-48]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13565:
  jf R0, __if_13560_end
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
__if_13560_end:
__if_13536_end:
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
__if_13612_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_13622
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_13622:
  mov R0, R1
  jf R0, __if_13612_end
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
__if_13612_end:
  jmp __if_13466_end
__if_13466_else:
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
__if_13744_start:
  mov R0, [BP-51]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13749
  mov R1, [BP-52]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13749:
  jf R0, __if_13744_else
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
  jmp __if_13744_end
__if_13744_else:
__if_13768_start:
  mov R0, [BP-52]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13773
  mov R1, [BP-51]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13773:
  jf R0, __if_13768_end
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
__if_13768_end:
__if_13744_end:
__if_13792_start:
  mov R0, [BP-51]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_13797
  mov R1, [BP-52]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13797:
  jf R0, __if_13792_else
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
  jmp __if_13792_end
__if_13792_else:
__if_13816_start:
  mov R0, [BP-52]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_13821
  mov R1, [BP-51]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13821:
  jf R0, __if_13816_end
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
__if_13816_end:
__if_13792_end:
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
__if_13868_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_13878
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_13878:
  mov R0, R1
  jf R0, __if_13868_end
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
__if_13868_end:
__if_13466_end:
__if_13323_end:
__if_13987_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_13987_end
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
__if_14002_start:
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-21]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_14002_else
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Normalize
  jmp __if_14002_end
__if_14002_else:
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
__if_14002_end:
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
__if_14043_start:
  mov R0, [BP-28]
  feq R0, 0.000000
  jf R0, __if_14043_else
  mov R0, 0
  mov [BP-60], R0
  jmp __if_14043_end
__if_14043_else:
  mov R0, 1
  mov [BP-60], R0
__if_14043_end:
__if_14055_start:
  mov R0, [BP-29]
  feq R0, 0.000000
  jf R0, __if_14055_else
  mov R0, 0
  mov [BP-61], R0
  jmp __if_14055_end
__if_14055_else:
  mov R0, 1
  mov [BP-61], R0
__if_14055_end:
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
__if_13987_end:
__if_14114_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_14114_end
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
__if_14114_end:
__if_14136_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_14136_end
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
__if_14136_end:
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
__if_14272_start:
  mov R0, [BP-13]
  flt R0, 0.000000
  jf R0, __if_14272_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14272_end:
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
__if_14302_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __if_14302_else
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
__if_14324_start:
  mov R0, [BP-35]
  fle R0, 0.000000
  jf R0, __if_14324_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14324_end:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_14302_end
__if_14302_else:
__if_14332_start:
  mov R0, [BP-16]
  fle R0, 0.000000
  jf R0, __if_14332_else
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
__if_14363_start:
  mov R0, [BP-37]
  fgt R0, 0.000000
  jf R0, __if_14363_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14363_end:
  lea R13, [BP-19]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_14332_end
__if_14332_else:
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
__if_14405_start:
  mov R0, [BP-33]
  fgt R0, 0.000000
  jf R0, __if_14405_else
  mov R1, 1.000000
  mov R2, [BP-33]
  fdiv R1, R2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_14405_end
__if_14405_else:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
__if_14405_end:
__if_14332_end:
__if_14302_end:
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
__if_14449_start:
  mov R1, [BP-26]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_14449_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14449_end:
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
__for_14610_start:
  mov R0, [BP-5]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_14610_end
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
__for_14640_start:
  mov R0, [BP-11]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_14640_end
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
__if_14677_start:
  mov R0, [BP-14]
  mov R1, [BP-10]
  flt R0, R1
  jf R0, __if_14677_end
  mov R0, [BP-14]
  mov [BP-10], R0
__if_14677_end:
__for_14640_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_14640_start
__for_14640_end:
__if_14684_start:
  mov R0, [BP-10]
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_14684_end
  mov R0, [BP-10]
  mov [BP-4], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_14684_end:
__for_14610_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_14610_start
__for_14610_end:
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
__if_14722_start:
  mov R0, [BP+6]
  jf R0, __if_14722_else
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+2]
  mov [BP-4], R0
  mov R0, [BP+5]
  mov [BP-2], R0
__if_14734_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_14734_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_14734_end
__if_14734_else:
  mov R0, 0
  mov [BP-3], R0
__if_14734_end:
  mov R0, [BP+4]
  mov [BP-5], R0
__if_14752_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_14752_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_14752_end
__if_14752_else:
  mov R0, 0
  mov [BP-6], R0
__if_14752_end:
  jmp __if_14722_end
__if_14722_else:
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-4], R0
  mov R0, [BP+4]
  mov [BP-2], R0
__if_14777_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_14777_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_14777_end
__if_14777_else:
  mov R0, 0
  mov [BP-3], R0
__if_14777_end:
  mov R0, [BP+5]
  mov [BP-5], R0
__if_14795_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_14795_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_14795_end
__if_14795_else:
  mov R0, 0
  mov [BP-6], R0
__if_14795_end:
__if_14722_end:
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
__if_14919_start:
  mov R0, [BP-21]
  mov R1, [BP-19]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_14924
  mov R1, [BP-20]
  mov R2, [BP-22]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_14924:
  jf R0, __if_14919_end
  jmp __function_b2ClipPolygons_return
__if_14919_end:
__if_14930_start:
  mov R0, [BP-22]
  mov R1, [BP-19]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14935
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14935:
  jf R0, __if_14930_else
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
  jmp __if_14930_end
__if_14930_else:
  lea R13, [BP-24]
  lea R12, [BP-16]
  mov CR, 2
  movs
__if_14930_end:
__if_14990_start:
  mov R0, [BP-21]
  mov R1, [BP-20]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14995
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14995:
  jf R0, __if_14990_else
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
  jmp __if_14990_end
__if_14990_else:
  lea R13, [BP-26]
  lea R12, [BP-14]
  mov CR, 2
  movs
__if_14990_end:
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
__if_15167_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_15167_else
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
  jmp __if_15167_end
__if_15167_else:
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
__if_15167_end:
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
__for_15418_start:
  mov R0, [BP-46]
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_15418_end
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
__for_15418_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_15418_start
__for_15418_end:
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
__for_15467_start:
  mov R0, [BP-46]
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_15467_end
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
__for_15467_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_15467_start
__for_15467_end:
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
__if_15532_start:
  mov R0, [BP-85]
  mov R1, [BP-4]
  mov R2, [BP-88]
  fadd R1, R2
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_15539
  mov R1, [BP-87]
  mov R2, [BP-4]
  mov R3, [BP-88]
  fadd R2, R3
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_15539:
  jf R0, __if_15532_end
  jmp __function_b2CollidePolygons_return
__if_15532_end:
__if_15547_start:
  mov R0, [BP-85]
  mov R1, [BP-87]
  fge R0, R1
  jf R0, __if_15547_else
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
__for_15574_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_15574_end
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
__if_15594_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_15594_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-86], R0
__if_15594_end:
__for_15574_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_15574_start
__for_15574_end:
  jmp __if_15547_end
__if_15547_else:
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
__for_15628_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_15628_end
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
__if_15648_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_15648_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-84], R0
__if_15648_end:
__for_15628_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_15628_start
__for_15628_end:
__if_15547_end:
__if_15659_start:
  mov R0, [BP-85]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_15666
  mov R1, [BP-87]
  mov R2, [BP-3]
  fmul R2, 0.100000
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_15666:
  jf R0, __if_15659_else
  mov R0, [BP-84]
  mov [BP-90], R0
__if_15677_start:
  mov R0, [BP-84]
  iadd R0, 1
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15677_else
  mov R0, [BP-84]
  iadd R0, 1
  mov [BP-91], R0
  jmp __if_15677_end
__if_15677_else:
  mov R0, 0
  mov [BP-91], R0
__if_15677_end:
  mov R0, [BP-86]
  mov [BP-92], R0
__if_15697_start:
  mov R0, [BP-86]
  iadd R0, 1
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15697_else
  mov R0, [BP-86]
  iadd R0, 1
  mov [BP-93], R0
  jmp __if_15697_end
__if_15697_else:
  mov R0, 0
  mov [BP-93], R0
__if_15697_end:
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
__if_15759_start:
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_15759_end
  jmp __function_b2CollidePolygons_return
__if_15759_end:
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
__if_15779_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_15779_end
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
__if_15779_end:
__if_15793_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_15793_end
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
__if_15793_end:
__if_15807_start:
  mov R0, [BP-110]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fadd R0, R1
  mov R1, [BP-111]
  flt R0, R1
  jf R0, __if_15807_end
  mov R0, 1.000000
  mov R1, [BP-109]
  fdiv R0, R1
  mov [BP-112], R0
__if_15821_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_15828
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_15828:
  jf R0, __if_15821_else
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
  jmp __if_15821_end
__if_15821_else:
__if_15928_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_15935
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_15935:
  jf R0, __if_15928_else
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
  jmp __if_15928_end
__if_15928_else:
__if_16035_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16042
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16042:
  jf R0, __if_16035_else
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
  jmp __if_16035_end
__if_16035_else:
__if_16142_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16149
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16149:
  jf R0, __if_16142_end
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
__if_16142_end:
__if_16035_end:
__if_15928_end:
__if_15821_end:
__if_15807_end:
  jmp __if_15659_end
__if_15659_else:
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
__if_15659_end:
__if_16257_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16257_end
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
__if_16257_end:
__if_16279_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16279_end
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
__if_16279_end:
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
__if_16365_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fle R1, 0.000000
  mov R0, R1
  jf R0, __if_16365_else
__if_16374_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jf R0, __if_16374_end
__if_16378_start:
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
  jf R0, __if_16378_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_16378_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_16374_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
  jmp __if_16365_end
__if_16365_else:
__if_16393_start:
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  jf R0, __if_16393_end
__if_16397_start:
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
  jf R0, __if_16397_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_16397_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_16393_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
__if_16365_end:
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
__if_16477_start:
  mov R0, [BP-9]
  mov R1, [BP-3]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16482
  mov R1, [BP-6]
  mov R2, [BP-12]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16482:
  jf R0, __if_16477_end
  jmp __function_b2ClipSegments_return
__if_16477_end:
__if_16488_start:
  mov R0, [BP-12]
  mov R1, [BP-3]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_16493
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_16493:
  jf R0, __if_16488_else
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
  jmp __if_16488_end
__if_16488_else:
  lea R13, [BP-14]
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
__if_16488_end:
__if_16525_start:
  mov R0, [BP-9]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_16530
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_16530:
  jf R0, __if_16525_else
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
  jmp __if_16525_end
__if_16525_else:
  lea R13, [BP-16]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__if_16525_end:
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
__if_16844_start:
  mov R0, [BP-51]
  jf R0, __if_16844_end
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-72], R1
  mov R0, R1
__if_16844_end:
__if_16857_start:
  mov R0, [BP-50]
  jf R0, __if_16857_end
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
__if_16857_end:
__if_16880_start:
  mov R0, [BP-71]
  jf R0, __LogicalAnd_ShortCircuit_16882
  mov R1, [BP-72]
  and R0, R1
__LogicalAnd_ShortCircuit_16882:
  jf R0, __LogicalAnd_ShortCircuit_16885
  mov R1, [BP-73]
  and R0, R1
__LogicalAnd_ShortCircuit_16885:
  jf R0, __if_16880_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_16880_end:
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
__if_16937_start:
  mov R1, [BP-117]
  mov R2, [BP-40]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 4.000000
  fadd R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_16937_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_16937_end:
  lea R12, [BP-68]
  lea DR, [BP-125]
  mov CR, 2
  movs
__if_16954_start:
  mov R0, [BP-51]
  jf R0, __if_16954_end
  lea R13, [BP-125]
  lea R12, [BP-55]
  mov CR, 2
  movs
__if_16954_end:
  lea R12, [BP-68]
  lea DR, [BP-127]
  mov CR, 2
  movs
__if_16964_start:
  mov R0, [BP-50]
  jf R0, __if_16964_end
  lea R13, [BP-127]
  lea R12, [BP-53]
  mov CR, 2
  movs
__if_16964_end:
  mov R0, -1
  mov [BP-128], R0
  mov R0, -1
  mov [BP-129], R0
__if_16979_start:
  mov R1, [BP-71]
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_16985
  mov R2, [BP-117]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 0.100000
  fgt R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_16985:
  mov R0, R1
  jf R0, __if_16979_else
__if_16994_start:
  mov R1, [BP+5]
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_16994_else
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
__if_17031_start:
  mov R0, [BP-144]
  ieq R0, 0
  jf R0, __if_17031_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17031_end:
__if_17036_start:
  mov R0, [BP-144]
  ieq R0, 1
  jf R0, __if_17036_end
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
__if_17036_end:
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-128], R0
  jmp __if_16994_end
__if_16994_else:
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
__if_17125_start:
  mov R0, [BP-136]
  mov R1, [BP-137]
  ieq R0, R1
  jf R0, __if_17125_else
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
__if_17170_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  fgt R0, R1
  jf R0, __if_17170_end
  mov R0, [BP-138]
  mov [BP-148], R0
__if_17170_end:
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
__if_17197_start:
  mov R0, [BP-151]
  ieq R0, 0
  jf R0, __if_17197_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17197_end:
__if_17202_start:
  mov R0, [BP-151]
  ieq R0, 1
  jf R0, __if_17202_end
  mov R0, [BP-148]
  mov [BP-138], R0
__if_17210_start:
  mov R0, [BP-148]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17210_else
  mov R0, [BP-148]
  iadd R0, 1
  mov [BP-139], R0
  jmp __if_17210_end
__if_17210_else:
  mov R0, 0
  mov [BP-139], R0
__if_17210_end:
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
__if_17268_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  flt R0, R1
  jf R0, __if_17268_else
__if_17273_start:
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
  jf R0, __if_17273_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17273_end:
  jmp __if_17268_end
__if_17268_else:
__if_17287_start:
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
  jf R0, __if_17287_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17287_end:
__if_17268_end:
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
__if_17344_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_17344_end
  lea R1, [BP-141]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_17344_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17202_end:
  mov R0, [BP-148]
  mov [BP-129], R0
  jmp __if_17125_end
__if_17125_else:
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
__if_17404_start:
  mov R0, [BP-148]
  mov R1, [BP-149]
  flt R0, R1
  jf R0, __if_17404_else
  mov R0, [BP-138]
  mov [BP-128], R0
  jmp __if_17404_end
__if_17404_else:
  mov R0, [BP-139]
  mov [BP-128], R0
__if_17404_end:
__if_17125_end:
__if_16994_end:
  jmp __if_16979_end
__if_16979_else:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-136], R0
  mov R0, 0
  mov [BP-137], R0
__for_17423_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_17423_end
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
__if_17455_start:
  mov R0, [BP-144]
  mov R1, [BP-136]
  flt R0, R1
  jf R0, __if_17455_end
  mov R0, [BP-144]
  mov [BP-136], R0
  mov R0, [BP-137]
  mov [BP-128], R0
__if_17455_end:
__for_17423_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_17423_start
__for_17423_end:
__if_17466_start:
  mov R0, [BP-51]
  jf R0, __if_17466_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_17476_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_17476_end
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
__if_17509_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_17509_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_17509_end:
__for_17476_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_17476_start
__for_17476_end:
__if_17516_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_17516_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_17516_end:
__if_17466_end:
__if_17528_start:
  mov R0, [BP-50]
  jf R0, __if_17528_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_17538_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_17538_end
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
__if_17571_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_17571_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_17571_end:
__for_17538_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_17538_start
__for_17538_end:
__if_17578_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_17578_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_17578_end:
__if_17528_end:
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-138], R0
  mov R0, -1
  mov [BP-139], R0
  mov R0, 0
  mov [BP-137], R0
__for_17601_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_17601_end
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
__if_17624_start:
  lea R2, [BP-57]
  mov [SP], R2
  lea R2, [BP-143]
  mov [SP+1], R2
  call __function_b2ClassifyNormal
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __if_17624_end
  jmp __for_17601_continue
__if_17624_end:
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
__if_17670_start:
  mov R0, [BP-150]
  mov R1, [BP-138]
  fgt R0, R1
  jf R0, __if_17670_end
  mov R0, [BP-150]
  mov [BP-138], R0
  mov R0, [BP-137]
  mov [BP-139], R0
__if_17670_end:
__for_17601_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_17601_start
__for_17601_end:
__if_17681_start:
  mov R0, [BP-138]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_17681_end
  mov R0, [BP-139]
  mov [BP-140], R0
__if_17691_start:
  mov R0, [BP-140]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17691_else
  mov R0, [BP-140]
  iadd R0, 1
  mov [BP-141], R0
  jmp __if_17691_end
__if_17691_else:
  mov R0, 0
  mov [BP-141], R0
__if_17691_end:
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
__if_17755_start:
  mov R0, [BP-152]
  mov R1, [BP-153]
  flt R0, R1
  jf R0, __if_17755_else
__if_17760_start:
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
  jf R0, __if_17760_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17760_end:
  jmp __if_17755_end
__if_17755_else:
__if_17774_start:
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
  jf R0, __if_17774_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17774_end:
__if_17755_end:
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
__if_17831_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_17831_end
  lea R1, [BP-147]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_17831_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17681_end:
__if_17843_start:
  mov R0, [BP-128]
  ieq R0, -1
  jf R0, __if_17843_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17843_end:
__if_16979_end:
__if_17853_start:
  mov R0, [BP-129]
  ine R0, -1
  jf R0, __if_17853_else
  mov R0, [BP-129]
  mov [BP-130], R0
__if_17862_start:
  mov R0, [BP-130]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17862_else
  mov R0, [BP-130]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_17862_end
__if_17862_else:
  mov R0, 0
  mov [BP-131], R0
__if_17862_end:
  jmp __if_17853_end
__if_17853_else:
  mov R0, [BP-128]
  mov [BP-136], R0
__if_17882_start:
  mov R0, [BP-136]
  igt R0, 0
  jf R0, __if_17882_else
  mov R0, [BP-136]
  isub R0, 1
  mov [BP-137], R0
  jmp __if_17882_end
__if_17882_else:
  mov R0, [BP-41]
  isub R0, 1
  mov [BP-137], R0
__if_17882_end:
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
__if_17922_start:
  mov R0, [BP-142]
  mov R1, [BP-143]
  flt R0, R1
  jf R0, __if_17922_else
  mov R0, [BP-137]
  mov [BP-130], R0
  mov R0, [BP-136]
  mov [BP-131], R0
  jmp __if_17922_end
__if_17922_else:
  mov R0, [BP-136]
  mov [BP-130], R0
__if_17937_start:
  mov R0, [BP-136]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17937_else
  mov R0, [BP-136]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_17937_end
__if_17937_else:
  mov R0, 0
  mov [BP-131], R0
__if_17937_end:
__if_17922_end:
__if_17853_end:
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
__if_18066_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_18066_end
  mov R0, 32
  jmp __function_b2CLZ32_return
__if_18066_end:
  mov R0, 0
  mov [BP-1], R0
  mov R0, 31
  mov [BP-2], R0
__for_18077_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_18077_end
__if_18087_start:
  mov R0, [BP+2]
  mov R1, [BP-2]
  isgn R1
  shl R0, R1
  and R0, 1
  ine R0, 0
  jf R0, __if_18087_end
  mov R0, [BP-1]
  jmp __function_b2CLZ32_return
__if_18087_end:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__for_18077_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_18077_start
__for_18077_end:
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
__if_18135_start:
  mov R0, [BP+2]
  ile R0, 1
  jf R0, __if_18135_end
  mov R0, 1
  jmp __function_b2RoundUpPowerOf2_return
__if_18135_end:
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

__function_islower:
  push BP
  mov BP, SP
  push R1
__if_18258_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_18263
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_18263:
  jf R0, __if_18258_end
  mov R0, 1
  jmp __function_islower_return
__if_18258_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_18274
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_18274:
  jf R0, __LogicalAnd_ShortCircuit_18278
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_18278:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_18283_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_18288
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_18288:
  jf R0, __if_18283_end
  mov R0, 1
  jmp __function_isupper_return
__if_18283_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_18299
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_18299:
  jf R0, __LogicalAnd_ShortCircuit_18303
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_18303:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_18434_start:
__while_18434_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_18434_end
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
  jmp __while_18434_start
__while_18434_end:
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
__while_18487_start:
__while_18487_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_18487_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_18487_start
__while_18487_end:
__while_18492_start:
__while_18492_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_18492_end
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
  jmp __while_18492_start
__while_18492_end:
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
  mov SR, __literal_string_18556
  mov CR, 17
  movs
  lea R0, [BP-50]
  mov [BP-51], R0
__if_18565_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_18570
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_18570:
  jf R0, __if_18565_end
  jmp __function_itoa_return
__if_18565_end:
__if_18574_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_18579
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_18579:
  jf R0, __if_18574_else
__if_18583_start:
  mov R0, [BP+2]
  ieq R0, 0x80000000
  jf R0, __if_18583_end
  lea DR, [BP-63]
  mov SR, __literal_string_18593
  mov CR, 12
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_strcpy
  jmp __function_itoa_return
__if_18583_end:
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
  jmp __if_18574_end
__if_18574_else:
__if_18608_start:
  mov R0, [BP+2]
  ilt R0, 0
  jf R0, __if_18608_end
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
__if_18664_start:
  mov R0, [BP+2]
  bnot R0
  jf R0, __if_18664_end
  jmp __label_18684_digits_stored
__if_18664_end:
__if_18608_end:
__if_18574_end:
__do_18668_start:
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
__do_18668_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_18668_start
__do_18668_end:
__label_18684_digits_stored:
__do_18685_start:
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
__do_18685_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_18685_start
__do_18685_end:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__function_itoa_return:
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
__if_21800_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_21808
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21808:
  jf R0, __if_21800_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jmp __function_b2ShouldShapesCollide_return
__if_21800_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_21831
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21831:
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
  jf R0, __LogicalAnd_ShortCircuit_21868
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_21868:
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
__if_21882_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21882_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleAABB
  jmp __if_21882_end
__if_21882_else:
__if_21893_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_21893_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleAABB
  jmp __if_21893_end
__if_21893_else:
__if_21904_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_21904_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputePolygonAABB
  jmp __if_21904_end
__if_21904_else:
__if_21915_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_21915_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_21915_end
__if_21915_else:
__if_21926_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_21926_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_21926_end
__if_21926_else:
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
__if_21926_end:
__if_21915_end:
__if_21904_end:
__if_21893_end:
__if_21882_end:
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
__if_21970_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21970_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCircle
  jmp __function_b2ShapeTestPoint_return
  jmp __if_21970_end
__if_21970_else:
__if_21982_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_21982_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCapsule
  jmp __function_b2ShapeTestPoint_return
  jmp __if_21982_end
__if_21982_else:
__if_21994_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_21994_end
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInPolygon
  jmp __function_b2ShapeTestPoint_return
__if_21994_end:
__if_21982_end:
__if_21970_end:
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
__if_22033_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22033_end
  jmp __function_b2ShapeCastShape_return
__if_22033_end:
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
__for_22056_start:
  mov R0, [BP-25]
  mov R2, [BP-23]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22056_end
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
__for_22056_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_22056_start
__for_22056_end:
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__if_22092_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22092_else
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCircle
  jmp __if_22092_end
__if_22092_else:
__if_22104_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22104_else
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCapsule
  jmp __if_22104_end
__if_22104_else:
__if_22116_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22116_else
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastPolygon
  jmp __if_22116_end
__if_22116_else:
__if_22128_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22128_else
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
  jmp __if_22128_end
__if_22128_else:
__if_22140_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22140_end
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
__if_22140_end:
__if_22128_end:
__if_22116_end:
__if_22104_end:
__if_22092_end:
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
__if_22199_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22199_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCircle
  jmp __if_22199_end
__if_22199_else:
__if_22211_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22211_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCapsule
  jmp __if_22211_end
__if_22211_else:
__if_22223_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22223_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndPolygon
  jmp __if_22223_end
__if_22223_else:
__if_22235_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22235_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22235_end
__if_22235_else:
__if_22247_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22247_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22247_end
__if_22247_else:
  jmp __function_b2CollideMover_return
__if_22247_end:
__if_22235_end:
__if_22223_end:
__if_22211_end:
__if_22199_end:
__if_22261_start:
  mov R1, [BP+5]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22261_end
  jmp __function_b2CollideMover_return
__if_22261_end:
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
__if_22285_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22285_else
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
  jmp __if_22285_end
__if_22285_else:
__if_22300_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22300_else
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
  jmp __if_22300_end
__if_22300_else:
__if_22315_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22315_else
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
  jmp __if_22315_end
__if_22315_else:
__if_22331_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22331_else
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
  jmp __if_22331_end
__if_22331_else:
__if_22344_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22344_else
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
  jmp __if_22344_end
__if_22344_else:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 16
  mov [R1], R0
__if_22344_end:
__if_22331_end:
__if_22315_end:
__if_22300_end:
__if_22285_end:
__function_b2MakeShapeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShapeCentroid:
  push BP
  mov BP, SP
  isub SP, 4
__if_22365_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22365_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 30
  mov CR, 2
  movs
  jmp __if_22365_end
__if_22365_else:
__if_22376_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22376_else
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
  jmp __if_22376_end
__if_22376_else:
__if_22392_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22392_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 38
  iadd R12, 32
  mov CR, 2
  movs
  jmp __if_22392_end
__if_22392_else:
__if_22403_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22403_else
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
  jmp __if_22403_end
__if_22403_else:
__if_22419_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22419_else
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
  jmp __if_22419_end
__if_22419_else:
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_22419_end:
__if_22403_end:
__if_22392_end:
__if_22376_end:
__if_22365_end:
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
__if_22444_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22444_end
  mov R1, [BP+2]
  iadd R1, 30
  iadd R1, 2
  mov R0, [R1]
  fmul R0, 2.000000
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_22444_end:
__if_22455_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22455_end
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
__if_22455_end:
__if_22489_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22489_end
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
__for_22513_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22513_end
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
__for_22513_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_22513_start
__for_22513_end:
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
__if_22489_end:
__if_22559_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22559_end
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
__if_22559_end:
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
__if_22591_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22591_else
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
  jmp __if_22591_end
__if_22591_else:
__if_22603_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22603_else
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
  jmp __if_22603_end
__if_22603_else:
__if_22615_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22615_else
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
  jmp __if_22615_end
__if_22615_else:
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
__if_22615_end:
__if_22603_end:
__if_22591_end:
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
__if_22658_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22658_else
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
  jmp __if_22658_end
__if_22658_else:
__if_22706_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22706_else
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
  jmp __if_22706_end
__if_22706_else:
__if_22739_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22739_end
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
__for_22765_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_22765_end
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
__for_22765_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_22765_start
__for_22765_end:
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
__if_22739_end:
__if_22706_end:
__if_22658_end:
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
__if_22914_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_22914_end
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
__if_22914_end:
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
__if_22948_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_22948_end
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
__if_22948_end:
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
__if_23066_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23066_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  call __function_b2GrowBitSet
__if_23066_end:
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
__if_23101_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23101_end
  jmp __function_b2ClearBit_return
__if_23101_end:
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
__if_23134_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23134_end
  mov R0, 0
  jmp __function_b2GetBit_return
__if_23134_end:
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
  jt R0, __LogicalOr_ShortCircuit_23286
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+3]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ine R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_23286:
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
__while_23306_start:
__while_23306_continue:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_23310
  mov R4, [BP+2]
  mov R3, [R4]
  mov R4, [BP-2]
  imul R4, 2
  iadd R3, R4
  mov R2, [R3]
  mov R3, [BP+3]
  ieq R2, R3
  jf R2, __LogicalAnd_ShortCircuit_23325
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
__LogicalAnd_ShortCircuit_23325:
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_23310:
  mov R0, R1
  jf R0, __while_23306_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
  jmp __while_23306_start
__while_23306_end:
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
__if_23345_start:
  mov R0, [BP+2]
  igt R0, 16
  jf R0, __if_23345_else
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2RoundUpPowerOf2
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_23345_end
__if_23345_else:
  mov R0, 16
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_23345_end:
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
__for_23494_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_23494_end
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
__if_23516_start:
  mov R0, [BP-4]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23521
  mov R1, [BP-5]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23521:
  jf R0, __if_23516_end
  jmp __for_23494_continue
__if_23516_end:
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
__for_23494_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_23494_start
__for_23494_end:
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
__if_23545_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __if_23545_else
  mov R0, [BP+2]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_23545_end
__if_23545_else:
  mov R0, [BP+3]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
__if_23545_end:
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
  jf R0, __LogicalAnd_ShortCircuit_23607
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
__LogicalAnd_ShortCircuit_23607:
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
__if_23637_start:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2SlotOccupied
  jf R0, __if_23637_end
  mov R0, 1
  jmp __function_b2AddKey_return
__if_23637_end:
__if_23643_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23643_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2GrowTable
__if_23643_end:
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
__if_23687_start:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_23687_end
  mov R0, 0
  jmp __function_b2RemoveKey_return
__if_23687_end:
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
__while_23723_start:
__while_23723_continue:
  mov R0, 1
  jf R0, __while_23723_end
  mov R0, [BP-6]
  iadd R0, 1
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-6], R0
__if_23737_start:
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_23750
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_23750:
  jf R0, __if_23737_end
  jmp __while_23723_end
__if_23737_end:
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
__if_23775_start:
  mov R0, [BP-4]
  mov R1, [BP-6]
  ile R0, R1
  jf R0, __if_23775_else
__if_23780_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_23785
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_23785:
  jf R0, __if_23780_end
  jmp __while_23723_continue
__if_23780_end:
  jmp __if_23775_end
__if_23775_else:
__if_23790_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jt R0, __LogicalOr_ShortCircuit_23795
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_23795:
  jf R0, __if_23790_end
  jmp __while_23723_continue
__if_23790_end:
__if_23775_end:
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
  jmp __while_23723_start
__while_23723_end:
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
__for_23858_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_23858_end
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
__for_23858_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23858_start
__for_23858_end:
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
__for_23910_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_23910_end
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
__for_23910_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_23910_start
__for_23910_end:
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
__if_23944_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_23944_end
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
__if_23944_end:
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
__if_23977_start:
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
  jf R0, __if_23977_end
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
__if_23977_end:
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
__if_24040_start:
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
  jf R0, __if_24040_end
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
__for_24062_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_24062_end
__if_24072_start:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_24072_end
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
  jmp __for_24062_end
__if_24072_end:
__for_24062_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_24062_start
__for_24062_end:
__if_24040_end:
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
__for_24102_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_24102_end
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
__for_24102_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24102_start
__for_24102_end:
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
__if_24166_start:
  mov R0, [BP+3]
  ine R0, 0
  jf R0, __if_24166_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2BufferMove
__if_24166_end:
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
__if_24319_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_24319_end
  mov R0, [BP+2]
  jmp __function_b2ContactEdgeAt_return
__if_24319_end:
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
  jt R0, __LogicalOr_ShortCircuit_24345
  mov R1, [BP+2]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24345:
  mov [BP-1], R0
  mov R0, [BP+3]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_24355
  mov R1, [BP+3]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_24355:
  mov [BP-2], R0
__if_24358_start:
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_24360
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_24360:
  jf R0, __if_24358_end
  mov R0, 0
  jmp __function_b2CanCollide_return
__if_24358_end:
  mov R0, 1
__function_b2CanCollide_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCollisionRank:
  push BP
  mov BP, SP
__if_24368_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_24368_end
  mov R0, 0
  jmp __function_b2ShapeCollisionRank_return
__if_24368_end:
__if_24374_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_24374_end
  mov R0, 1
  jmp __function_b2ShapeCollisionRank_return
__if_24374_end:
__if_24380_start:
  mov R0, [BP+2]
  ieq R0, 3
  jf R0, __if_24380_end
  mov R0, 2
  jmp __function_b2ShapeCollisionRank_return
__if_24380_end:
__if_24386_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_24386_end
  mov R0, 3
  jmp __function_b2ShapeCollisionRank_return
__if_24386_end:
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
__if_24420_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_24420_else
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
  jmp __if_24420_end
__if_24420_else:
__if_24434_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_24434_else
__if_24439_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24439_else
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
  jmp __if_24439_end
__if_24439_else:
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
__if_24439_end:
  jmp __if_24434_end
__if_24434_else:
__if_24461_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_24461_else
__if_24466_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24466_else
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
  jmp __if_24466_end
__if_24466_else:
__if_24479_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24479_else
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
  jmp __if_24479_end
__if_24479_else:
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
__if_24479_end:
__if_24466_end:
  jmp __if_24461_end
__if_24461_else:
__if_24501_start:
  mov R0, [BP-1]
  ieq R0, 4
  jf R0, __if_24501_else
__if_24506_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24506_else
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
  jmp __if_24506_end
__if_24506_else:
__if_24519_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24519_else
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
  jmp __if_24519_end
__if_24519_else:
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
__if_24519_end:
__if_24506_end:
  jmp __if_24501_end
__if_24501_else:
__if_24560_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_24560_else
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
  jmp __if_24560_end
__if_24560_else:
__if_24573_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_24573_else
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
  jmp __if_24573_end
__if_24573_else:
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
__if_24573_end:
__if_24560_end:
__if_24501_end:
__if_24461_end:
__if_24434_end:
__if_24420_end:
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
__if_24682_start:
  mov R0, [BP+3]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_24687
  mov R1, [BP+4]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24687:
  jf R0, __if_24682_else
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
  jmp __if_24682_end
__if_24682_else:
__if_24703_start:
  mov R0, [BP+3]
  ige R0, 2
  jf R0, __LogicalAnd_ShortCircuit_24708
  mov R1, [BP+7]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24708:
  jf R0, __if_24703_end
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
__if_24703_end:
__if_24682_end:
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
__if_24838_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_24838_end
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
__if_24838_end:
__if_24860_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_24860_end
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
__if_24860_end:
__if_24882_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_24882_end
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
__if_24882_end:
__if_24901_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_24901_end
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
__if_24901_end:
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
__if_24953_start:
  mov R0, [BP-25]
  jf R0, __if_24953_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 65536
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_24953_end
__if_24953_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_24953_end:
__if_24970_start:
  mov R0, [BP-25]
  jf R0, __LogicalAnd_ShortCircuit_24972
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  jt R1, __LogicalOr_ShortCircuit_24976
  mov R3, [BP+6]
  iadd R3, 22
  mov R2, [R3]
  or R1, R2
__LogicalOr_ShortCircuit_24976:
  and R0, R1
__LogicalAnd_ShortCircuit_24972:
  jf R0, __if_24970_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 1048576
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_24970_end
__if_24970_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -1048577
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_24970_end:
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
__if_25008_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __if_25008_end
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
__if_25008_end:
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
__if_25421_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_25421_end
  mov R0, [BP+2]
  iadd R0, 4
  jmp __function_b2JointEdgeAt_return
__if_25421_end:
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
  jf R0, __LogicalAnd_ShortCircuit_25799
  mov R2, [BP+3]
  iadd R2, 23
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_25799:
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
__for_26209_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_26209_end
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
__for_26209_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26209_start
__for_26209_end:
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
__for_26387_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26387_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
__if_26407_start:
  mov R1, [BP-2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26407_end
  mov R2, [BP-2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_26407_end:
__if_26422_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26422_end
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
__if_26422_end:
__if_26437_start:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26437_end
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
__if_26437_end:
__if_26452_start:
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26452_end
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
__if_26452_end:
__if_26467_start:
  mov R1, [BP-2]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26467_end
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
__if_26467_end:
__for_26387_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26387_start
__for_26387_end:
__if_26482_start:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26482_end
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
__if_26482_end:
__if_26497_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26497_end
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
__if_26497_end:
__if_26512_start:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26512_end
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
__if_26512_end:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2DestroyBroadPhase
__if_26531_start:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26531_end
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
__if_26531_end:
__if_26546_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26546_end
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
__if_26546_end:
  mov R0, 0
  mov [BP-1], R0
__for_26561_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_26561_end
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_26581_start:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26581_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26581_end:
__if_26591_start:
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26591_end
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
__if_26591_end:
__if_26603_start:
  mov R1, [BP-2]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26603_end
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
__if_26603_end:
__for_26561_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26561_start
__for_26561_end:
__if_26615_start:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26615_end
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
__if_26615_end:
__if_26630_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26630_end
  mov R2, [BP+2]
  iadd R2, 65
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_26630_end:
__if_26640_start:
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26640_end
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
__if_26640_end:
__if_26655_start:
  mov R1, [BP+2]
  iadd R1, 70
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26655_end
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
__if_26655_end:
__if_26670_start:
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26670_end
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
__if_26670_end:
__if_26685_start:
  mov R1, [BP+2]
  iadd R1, 76
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26685_end
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
__if_26685_end:
__if_26700_start:
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26700_end
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
__if_26700_end:
__if_26715_start:
  mov R1, [BP+2]
  iadd R1, 82
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_26715_end
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
__if_26715_end:
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
__if_26760_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_26760_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
  mov R0, 1
  jmp __function_b2WakeBody_return
__if_26760_end:
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
__if_26783_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_26783_end
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
__if_26783_end:
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
__if_26938_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_26938_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_26938_end:
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
__if_26977_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_26977_end
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
__if_26977_end:
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
__if_27018_start:
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27018_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27018_end:
__if_27028_start:
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27028_end
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
__if_27028_end:
__if_27040_start:
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27040_end
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
__if_27040_end:
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
__if_27119_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_27119_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27119_end:
__if_27125_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_27125_end
  mov R0, [BP+4]
  jmp __function_b2MergeIslands_return
__if_27125_end:
__if_27133_start:
  mov R0, [BP+4]
  ieq R0, -1
  jf R0, __if_27133_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27133_end:
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
__if_27161_start:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_27161_else
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
  jmp __if_27161_end
__if_27161_else:
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__if_27161_end:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_27187_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27187_end
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
__for_27187_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27187_start
__for_27187_end:
  mov R0, 0
  mov [BP-6], R0
__for_27249_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27249_end
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
__for_27249_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27249_start
__for_27249_end:
  mov R0, 0
  mov [BP-6], R0
__for_27312_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27312_end
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
__for_27312_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27312_start
__for_27312_end:
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
__if_27531_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27531_end
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
__if_27531_end:
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
__if_27707_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27707_end
  jmp __function_b2UnlinkJoint_return
__if_27707_end:
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
__if_27737_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27737_end
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
__if_27737_end:
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
__if_27836_start:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_27836_end
  jmp __function_b2RemoveBodyFromIsland_return
__if_27836_end:
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
__if_27866_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27866_end
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
__if_27866_end:
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
__if_27910_start:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_27910_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2DestroyIsland
__if_27910_end:
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
__while_27921_start:
__while_27921_continue:
  mov R0, [BP+2]
  mov R1, [BP+3]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ine R0, R1
  jf R0, __while_27921_end
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
  jmp __while_27921_start
__while_27921_end:
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
__if_27960_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_27960_end
  jmp __function_b2IslandUnion_return
__if_27960_end:
__if_27965_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_27965_else
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  jmp __if_27965_end
__if_27965_else:
__if_27978_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  igt R0, R1
  jf R0, __if_27978_else
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  jmp __if_27978_end
__if_27978_else:
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
__if_27978_end:
__if_27965_end:
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
__if_28053_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_28053_end
  jmp __function_b2SplitIsland_return
__if_28053_end:
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
__for_28068_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28068_end
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
__for_28068_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28068_start
__for_28068_end:
  mov R0, 0
  mov [BP-13], R0
__for_28088_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28088_end
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
__if_28120_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28127
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28127:
  jf R0, __if_28120_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28120_end:
__for_28088_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28088_start
__for_28088_end:
  mov R0, 0
  mov [BP-13], R0
__for_28137_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28137_end
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
__if_28169_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28176
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28176:
  jf R0, __if_28169_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28169_end:
__for_28137_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28137_start
__for_28137_end:
  mov R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
__for_28192_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28192_end
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
__if_28209_start:
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-13]
  ieq R0, R1
  jf R0, __if_28209_end
  mov R0, [BP-14]
  iadd R0, 1
  mov [BP-14], R0
__if_28209_end:
__for_28192_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28192_start
__for_28192_end:
__if_28220_start:
  mov R0, [BP-14]
  ieq R0, 1
  jf R0, __if_28220_end
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
__if_28220_end:
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
__for_28276_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28276_end
  mov R0, -1
  mov R1, [BP-15]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_28276_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28276_start
__for_28276_end:
  mov R0, 0
  mov [BP-13], R0
__for_28292_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28292_end
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
__if_28307_start:
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov R0, [R0]
  ieq R0, -1
  jf R0, __if_28307_end
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
__if_28307_end:
__for_28292_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28292_start
__for_28292_end:
  mov R0, 0
  mov [BP-13], R0
__for_28327_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28327_end
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
__for_28327_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28327_start
__for_28327_end:
  mov R0, 0
  mov [BP-13], R0
__for_28402_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28402_end
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
__if_28426_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28426_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28426_end:
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
__for_28402_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28402_start
__for_28402_end:
  mov R0, 0
  mov [BP-13], R0
__for_28495_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28495_end
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
__if_28519_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_28519_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_28519_end:
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
__for_28495_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28495_start
__for_28495_end:
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
__for_28627_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_28627_end
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
__if_28655_start:
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_28661
  mov R1, [BP-4]
  mov R2, [BP-2]
  igt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_28661:
  jf R0, __if_28655_end
  mov R0, [BP-4]
  mov [BP-2], R0
__if_28655_end:
__for_28627_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_28627_start
__for_28627_end:
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
__if_28833_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_28833_end
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
__if_28833_end:
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
  jt R0, __LogicalOr_ShortCircuit_28906
  mov R2, [BP+3]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_28906:
  jf R0, __LogicalAnd_ShortCircuit_28911
  mov R2, [BP+3]
  iadd R2, 19
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_28911:
  mov [BP-1], R0
__if_28916_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28916_else
  mov R0, 1
  mov [BP-2], R0
  jmp __if_28916_end
__if_28916_else:
__if_28925_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28925_else
  mov R0, 0
  mov [BP-2], R0
  jmp __if_28925_end
__if_28925_else:
__if_28934_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_28934_else
  mov R0, 2
  mov [BP-2], R0
  jmp __if_28934_end
__if_28934_else:
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
__if_28949_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_28949_end
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
__if_28949_end:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov [R1], R0
__if_28934_end:
__if_28925_end:
__if_28916_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__if_29091_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  jf R0, __if_29091_end
  mov R0, [BP-4]
  or R0, 1
  mov [BP-4], R0
__if_29091_end:
__if_29099_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  jf R0, __if_29099_end
  mov R0, [BP-4]
  or R0, 2
  mov [BP-4], R0
__if_29099_end:
__if_29107_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  jf R0, __if_29107_end
  mov R0, [BP-4]
  or R0, 4
  mov [BP-4], R0
__if_29107_end:
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
__if_29226_start:
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  jf R0, __if_29226_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 16
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29226_end:
__if_29236_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_29236_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 128
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29236_end:
__if_29246_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29246_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 512
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29246_end:
__if_29258_start:
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  jf R0, __if_29258_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 2048
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29258_end:
__if_29268_start:
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  jf R0, __if_29268_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 4096
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29268_end:
__if_29278_start:
  mov R0, [BP-2]
  ieq R0, 2
  jf R0, __if_29278_end
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
__if_29278_end:
__if_29343_start:
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29343_end
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
__if_29343_end:
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
__if_29503_start:
  mov R0, [BP-2]
  ige R0, 2
  jf R0, __if_29503_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2CreateIslandForBody
__if_29503_end:
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
__while_29593_start:
__while_29593_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29593_end
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
  jmp __while_29593_start
__while_29593_end:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_29632_start:
__while_29632_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_29632_end
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
  jmp __while_29632_start
__while_29632_end:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__while_29671_start:
__while_29671_continue:
  mov R0, [BP-4]
  ine R0, -1
  jf R0, __while_29671_end
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
  jmp __while_29671_start
__while_29671_end:
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
__if_29716_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29716_else
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-6], R0
__if_29729_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  ine R0, R1
  jf R0, __if_29729_end
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
__if_29729_end:
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_29716_end
__if_29716_else:
__if_29755_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __LogicalAnd_ShortCircuit_29763
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_29763:
  jf R0, __if_29755_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2DestroySolverSet
__if_29755_end:
__if_29716_end:
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
__if_29836_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_29836_end
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
__if_29853_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_29853_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29863_start:
__while_29863_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29863_end
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
  jmp __while_29863_start
__while_29863_end:
__if_29853_end:
  jmp __function_b2UpdateBodyMassData_return
__if_29836_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29914_start:
__while_29914_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29914_end
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
  jmp __while_29914_start
__while_29914_end:
__if_29962_start:
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_29962_end
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
__if_29962_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_29991_start:
__while_29991_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_29991_end
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
__if_30012_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_30012_end
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
__if_30012_end:
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_29991_start
__while_29991_end:
__if_30052_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30052_else
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 13
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  jmp __if_30052_end
__if_30052_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_30052_end:
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
__if_30096_start:
  mov R0, [BP-7]
  ine R0, -1
  jf R0, __if_30096_end
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
__if_30096_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30138_start:
__while_30138_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30138_end
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
  jmp __while_30138_start
__while_30138_end:
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
__if_30193_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30193_end
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
__if_30193_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_30244_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_30244_else
  mov R13, [BP-2]
  iadd R13, 30
  mov R12, [BP+5]
  mov CR, 3
  movs
  jmp __if_30244_end
__if_30244_else:
__if_30254_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_30254_else
  mov R13, [BP-2]
  iadd R13, 33
  mov R12, [BP+5]
  mov CR, 5
  movs
  jmp __if_30254_end
__if_30254_else:
__if_30264_start:
  mov R0, [BP+6]
  ieq R0, 3
  jf R0, __if_30264_else
  mov R13, [BP-2]
  iadd R13, 38
  mov R12, [BP+5]
  mov CR, 36
  movs
  jmp __if_30264_end
__if_30264_else:
__if_30274_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_30274_else
  mov R13, [BP-2]
  iadd R13, 74
  mov R12, [BP+5]
  mov CR, 4
  movs
  jmp __if_30274_end
__if_30274_else:
__if_30284_start:
  mov R0, [BP+6]
  ieq R0, 4
  jf R0, __if_30284_end
  mov R13, [BP-2]
  iadd R13, 78
  mov R12, [BP+5]
  mov CR, 9
  movs
__if_30284_end:
__if_30274_end:
__if_30264_end:
__if_30254_end:
__if_30244_end:
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
__if_30377_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_30377_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_30377_end
__if_30377_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_30377_end:
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
__if_30419_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __if_30419_end
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
__if_30419_end:
__if_30550_start:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_30550_end
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
__if_30550_end:
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
__if_30614_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30614_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30614_end:
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
__if_30656_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30656_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30656_end:
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
__if_30740_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_30740_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_30740_end:
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
__if_31085_start:
  mov R0, [BP+4]
  jf R0, __if_31085_end
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_31092_start:
__while_31092_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31092_end
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
__if_31123_start:
  mov R1, [BP-6]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_31130
  mov R2, [BP-6]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_31130:
  jf R0, __if_31123_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_31123_end:
  jmp __while_31092_start
__while_31092_end:
__if_31085_end:
__if_31137_start:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31137_end
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
__if_31137_end:
__if_31154_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31154_end
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
__if_31154_end:
__if_31171_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_31171_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
__if_31171_end:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__if_31188_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31188_end
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
__if_31188_end:
__if_31208_start:
  mov R1, [BP+3]
  iadd R1, 26
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31208_end
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
__if_31208_end:
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  mov [R1], R0
__if_31244_start:
  mov R0, [BP+5]
  jf R0, __if_31244_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31244_end:
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
__while_31318_start:
__while_31318_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31318_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_31333_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31333_end
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
__if_31333_end:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  jmp __while_31318_start
__while_31318_end:
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
__if_31688_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31688_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Body_GetLinearVelocity_return
__if_31688_end:
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
__if_31720_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31720_end
  mov R0, 0.000000
  jmp __function_b2Body_GetAngularVelocity_return
__if_31720_end:
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
__if_31738_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_31738_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_31738_end:
__if_31744_start:
  mov R2, [BP+4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  fgt R1, 0.000000
  mov R0, R1
  jf R0, __if_31744_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31744_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31757_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31757_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_31757_end:
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
__if_31776_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_31776_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_31776_end:
__if_31782_start:
  mov R0, [BP+4]
  fne R0, 0.000000
  jf R0, __if_31782_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31782_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_31794_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_31794_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_31794_end:
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
__if_31867_start:
  mov R0, [BP+5]
  jf R0, __if_31867_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31867_end:
__if_31872_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_31872_end
  jmp __function_b2Body_ApplyForceToCenter_return
__if_31872_end:
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
__if_31901_start:
  mov R0, [BP+5]
  jf R0, __if_31901_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31901_end:
__if_31906_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_31906_end
  jmp __function_b2Body_ApplyTorque_return
__if_31906_end:
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
__if_31998_start:
  mov R0, [BP+5]
  jf R0, __if_31998_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_31998_end:
__if_32003_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32003_end
  jmp __function_b2Body_ApplyLinearImpulseToCenter_return
__if_32003_end:
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
__while_32846_start:
__while_32846_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_32846_end
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
__if_32877_start:
  mov R1, [BP-10]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_32884
  mov R2, [BP-10]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-2]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_32884:
  jf R0, __if_32877_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_32877_end:
  jmp __while_32846_start
__while_32846_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
__if_32898_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_32898_else
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
__if_32918_start:
  mov R0, [BP+5]
  jf R0, __if_32918_else
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
  jmp __if_32918_end
__if_32918_else:
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
__if_32918_end:
  jmp __if_32898_end
__if_32898_else:
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
__if_32898_end:
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
__if_32973_start:
  mov R0, [BP+4]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  feq R0, R1
  jf R0, __if_32973_end
  jmp __function_b2Shape_SetDensity_return
__if_32973_end:
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_32983_start:
  mov R0, [BP+5]
  jf R0, __if_32983_end
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
__if_32983_end:
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
__if_33240_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_33240_end
  mov R1, [BP-1]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__if_33240_end:
__function_b2SyncBodyFlags_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransferBody:
  push BP
  mov BP, SP
  isub SP, 8
__if_34435_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_34435_end
  jmp __function_b2TransferBody_return
__if_34435_end:
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
__if_34514_start:
  mov R1, [BP+4]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_34514_else
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_34527_start:
  mov R0, [BP-1]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_34527_end
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
__if_34527_end:
  mov R0, [BP-4]
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_34514_end
__if_34514_else:
__if_34547_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_34547_end
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
__if_34547_end:
__if_34514_end:
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
__if_34617_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_34617_end
  jmp __function_b2TransferJoint_return
__if_34617_end:
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
__if_34676_start:
  mov R0, [BP-1]
  mov R1, [BP-3]
  ine R0, R1
  jf R0, __if_34676_end
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
__if_34676_end:
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
__while_34736_start:
__while_34736_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_34736_end
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
  jmp __while_34736_start
__while_34736_end:
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
__while_34778_start:
__while_34778_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_34778_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_34793_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_34793_end
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
__if_34793_end:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_34778_start
__while_34778_end:
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
__while_34832_start:
__while_34832_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_34832_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
__if_34847_start:
  mov R0, [BP+4]
  ieq R0, 0
  jf R0, __if_34847_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_34847_end
__if_34847_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_34847_end:
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
  jmp __while_34832_start
__while_34832_end:
__function_b2CreateBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_EnableSleeping:
  push BP
  mov BP, SP
  isub SP, 3
__if_35712_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 51
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_35712_end
  jmp __function_b2World_EnableSleeping_return
__if_35712_end:
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 51
  mov [R1], R0
__if_35722_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_35722_end
  mov R0, 3
  mov [BP-1], R0
__for_35729_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_35729_end
__if_35741_start:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_35741_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_35741_end:
__for_35729_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_35729_start
__for_35729_end:
__if_35722_end:
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
__if_35819_start:
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
  jf R0, __if_35819_end
  mov R0, 1
  jmp __function_b2OverlapFilterCallback_return
__if_35819_end:
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
__if_35861_start:
  mov R0, [BP+4]
  ine R0, -1
  jf R0, __if_35861_end
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
__if_35861_end:
  mov R0, 0
  mov [BP-7], R0
__for_35892_start:
  mov R0, [BP-7]
  ilt R0, 3
  jf R0, __for_35892_end
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
__for_35892_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_35892_start
__for_35892_end:
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
__if_35961_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_35972
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
__LogicalAnd_ShortCircuit_35972:
  mov R0, R1
  jf R0, __if_35961_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2RayCastClosestCallback_return
__if_35961_end:
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
__if_36044_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_36044_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_36044_end
__if_36044_else:
__if_36057_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_36057_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_36057_end
__if_36057_else:
__if_36070_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_36070_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_36070_end
__if_36070_else:
__if_36083_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_36083_end
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
__if_36083_end:
__if_36070_end:
__if_36057_end:
__if_36044_end:
__if_36097_start:
  mov R0, [BP-12]
  jf R0, __LogicalAnd_ShortCircuit_36100
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36100:
  jf R0, __if_36097_end
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
__if_36097_end:
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
__if_36215_start:
  mov R0, [BP+5]
  ine R0, -1
  jf R0, __if_36215_end
  mov R1, [BP+5]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-16], R0
__if_36215_end:
  mov R0, 0
  mov [BP-17], R0
__for_36225_start:
  mov R0, [BP-17]
  ilt R0, 3
  jf R0, __for_36225_end
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
__if_36253_start:
  mov R0, [BP-2]
  jf R0, __if_36253_end
  mov R0, [BP-4]
  mov [BP-11], R0
__if_36253_end:
__for_36225_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_36225_start
__for_36225_end:
  lea R13, [BP+6]
  mov R13, [R13]
  lea R12, [BP-8]
  mov CR, 7
  movs
__if_36268_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_36268_end
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
__if_36268_end:
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
__if_36314_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36325
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
__LogicalAnd_ShortCircuit_36325:
  mov R0, R1
  jf R0, __if_36314_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2ShapeCastClosestCallback_return
__if_36314_end:
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
__if_36380_start:
  mov R0, [BP-29]
  jf R0, __LogicalAnd_ShortCircuit_36383
  mov R1, [BP-31]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36383:
  jf R0, __if_36380_end
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
__if_36380_end:
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
__if_36880_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36891
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
__LogicalAnd_ShortCircuit_36891:
  mov R0, R1
  jf R0, __if_36880_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2WorldRayCastCallback_return
__if_36880_end:
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
__if_36963_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_36963_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_36963_end
__if_36963_else:
__if_36976_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_36976_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_36976_end
__if_36976_else:
__if_36989_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_36989_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_36989_end
__if_36989_else:
__if_37002_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_37002_end
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
__if_37002_end:
__if_36989_end:
__if_36976_end:
__if_36963_end:
__if_37016_start:
  mov R0, [BP-12]
  jf R0, __if_37016_end
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
__if_37051_start:
  mov R0, [BP-26]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37056
  mov R1, [BP-26]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37056:
  jf R0, __if_37051_end
  mov R0, [BP-26]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37051_end:
  mov R0, [BP-26]
  jmp __function_b2WorldRayCastCallback_return
__if_37016_end:
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
__if_37186_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37197
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
__LogicalAnd_ShortCircuit_37197:
  mov R0, R1
  jf R0, __if_37186_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2WorldShapeCastCallback_return
__if_37186_end:
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
__if_37252_start:
  mov R0, [BP-29]
  jf R0, __if_37252_end
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
__if_37287_start:
  mov R0, [BP-43]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37292
  mov R1, [BP-43]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37292:
  jf R0, __if_37287_end
  mov R0, [BP-43]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37287_end:
  mov R0, [BP-43]
  jmp __function_b2WorldShapeCastCallback_return
__if_37252_end:
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
__if_37576_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37587
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
__LogicalAnd_ShortCircuit_37587:
  mov R0, R1
  jf R0, __if_37576_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_37576_end:
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
__if_37651_start:
  mov R0, [BP-56]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_37651_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_37651_end:
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
__if_37666_start:
  mov R0, [BP-64]
  ieq R0, 0
  jf R0, __if_37666_end
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_37666_end:
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
__if_37991_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_37991_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_37991_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_38005_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_38005_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38005_end:
  lea R12, [BP-67]
  lea DR, [BP-69]
  mov CR, 2
  movs
__if_38016_start:
  mov R0, [BP-61]
  feq R0, 0.000000
  jf R0, __if_38016_end
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  call __function_b2GetShapeCentroid
__if_38016_end:
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
__if_38045_start:
  lea R2, [BP-71]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-72]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_38045_else
  lea R1, [BP-71]
  mov [SP], R1
  lea R1, [BP-89]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R13, [BP-71]
  lea R12, [BP-89]
  mov CR, 2
  movs
  jmp __if_38045_end
__if_38045_else:
  mov R0, 1.000000
  mov [BP-71], R0
  mov R0, 0.000000
  mov [BP-70], R0
__if_38045_end:
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
__if_38087_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_38095
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_38095:
  jf R0, __if_38087_end
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
__if_38087_end:
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
__if_38334_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38345
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
__LogicalAnd_ShortCircuit_38345:
  mov R0, R1
  jf R0, __if_38334_end
  mov R0, 1
  jmp __function_b2MoverCollideCallback_return
__if_38334_end:
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
__if_38376_start:
  mov R1, [BP-6]
  jf R1, __LogicalAnd_ShortCircuit_38379
  lea R3, [BP-11]
  mov [SP], R3
  call __function_b2IsNormalized
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_38379:
  mov R0, R1
  jf R0, __if_38376_end
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
__if_38376_end:
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
__if_38541_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38552
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
__LogicalAnd_ShortCircuit_38552:
  mov R0, R1
  jf R0, __if_38541_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_38541_end:
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
__if_38592_start:
  mov R0, [BP-30]
  feq R0, 0.000000
  jf R0, __if_38592_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_38592_end:
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
__if_38805_start:
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
  jf R0, __if_38805_end
  jmp __function_b2CreateContact_return
__if_38805_end:
__if_38814_start:
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
  jf R0, __if_38814_end
  mov R0, [BP+3]
  mov [BP-12], R0
  mov R0, [BP+4]
  mov [BP+3], R0
  mov R0, [BP-12]
  mov [BP+4], R0
__if_38814_end:
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
__if_38852_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_38859
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  or R0, R1
__LogicalOr_ShortCircuit_38859:
  jf R0, __if_38852_else
  mov R0, 2
  mov [BP-3], R0
  jmp __if_38852_end
__if_38852_else:
  mov R0, 1
  mov [BP-3], R0
__if_38852_end:
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
__if_38882_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_38882_end
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
__if_38882_end:
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
__if_38992_start:
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  and R0, 4096
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_39005
  mov R2, [BP-2]
  iadd R2, 18
  mov R1, [R2]
  and R1, 4096
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_39005:
  jf R0, __if_38992_end
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_38992_end:
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
__if_39048_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39048_end
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
__if_39048_end:
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
__if_39120_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39120_end
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
__if_39120_end:
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
__if_39258_start:
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39258_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_39258_end:
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
__if_39293_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39293_end
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
__if_39293_end:
__if_39322_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39322_end
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
__if_39322_end:
__if_39351_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_39351_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_39351_end:
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
__if_39390_start:
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39390_end
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
__if_39390_end:
__if_39419_start:
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39419_end
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
__if_39419_end:
__if_39448_start:
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_39448_end
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
__if_39448_end:
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
__if_39491_start:
  mov R0, [BP-8]
  mov R1, [BP-9]
  ine R0, R1
  jf R0, __if_39491_end
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
__if_39491_end:
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
__if_39566_start:
  mov R0, [BP+4]
  jf R0, __LogicalAnd_ShortCircuit_39568
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_39568:
  jf R0, __if_39566_end
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
__if_39566_end:
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
__if_39628_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 64
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_39628_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39628_end:
__if_39636_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_39643
  mov R2, [BP+3]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 33
  iadd R3, 1
  mov R2, [R3]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_39643:
  jf R0, __if_39636_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39636_end:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
__if_39661_start:
  mov R1, [BP-1]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_39661_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39661_end:
__if_39670_start:
  mov R1, [BP-1]
  iadd R1, 15
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_39670_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_39670_end:
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
__while_39997_start:
__while_39997_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_39997_end
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
__if_40028_start:
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
  jf R0, __if_40028_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_40028_end:
  jmp __while_39997_start
__while_39997_end:
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
__while_40057_start:
__while_40057_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40057_end
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
__if_40090_start:
  mov R0, [BP-6]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_40096
  mov R2, [BP-5]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_40096:
  jf R0, __if_40090_end
  mov R0, 0
  jmp __function_b2ShouldBodiesCollide_return
__if_40090_end:
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
  jmp __while_40057_start
__while_40057_end:
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
__if_40142_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 1
  jt R0, __LogicalOr_ShortCircuit_40149
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 1
  or R0, R1
__LogicalOr_ShortCircuit_40149:
  jf R0, __if_40142_else
  mov R0, 1
  mov [BP-3], R0
  jmp __if_40142_end
__if_40142_else:
__if_40155_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_40162
  mov R2, [BP-2]
  iadd R2, 19
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_40162:
  jf R0, __if_40155_else
  mov R0, 0
  mov [BP-3], R0
  jmp __if_40155_end
__if_40155_else:
  mov R0, 2
  mov [BP-3], R0
__if_40155_end:
__if_40142_end:
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
__if_40185_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_40185_end
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
__if_40185_end:
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
__if_40323_start:
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40323_end
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
__if_40323_end:
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
__if_40394_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40394_end
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
__if_40394_end:
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
__if_40537_start:
  mov R0, [BP+8]
  ieq R0, 0
  jf R0, __if_40537_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContactsBetweenBodies
__if_40537_end:
__if_40545_start:
  mov R0, [BP-3]
  ige R0, 2
  jf R0, __if_40545_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2LinkJoint
__if_40545_end:
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
__if_40566_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40566_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkJoint
__if_40566_end:
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
__if_40608_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40608_end
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
__if_40608_end:
__if_40637_start:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40637_end
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
__if_40637_end:
__if_40666_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_40666_end
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
__if_40666_end:
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
__if_40689_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40689_end
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
__if_40689_end:
__if_40718_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40718_end
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
__if_40718_end:
__if_40747_start:
  mov R1, [BP-5]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_40747_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 8
  mov [R1], R0
__if_40747_end:
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
__if_40790_start:
  mov R0, [BP-7]
  mov R1, [BP-8]
  ine R0, R1
  jf R0, __if_40790_end
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
__if_40790_end:
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
__if_40865_start:
  mov R0, [BP+4]
  jf R0, __if_40865_end
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
__if_40865_end:
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
__if_41640_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_41640_end
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
__if_41640_end:
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
__if_44258_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44258_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44258_end
__if_44258_else:
__if_44272_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44272_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44272_end
__if_44272_else:
__if_44286_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44286_else
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
  jmp __if_44286_end
__if_44286_else:
__if_44312_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_44312_else
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
  jmp __if_44312_end
__if_44312_else:
__if_44399_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_44399_else
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
  jmp __if_44399_end
__if_44399_else:
__if_44467_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_44467_else
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
  jmp __if_44467_end
__if_44467_else:
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_44467_end:
__if_44399_end:
__if_44312_end:
__if_44286_end:
__if_44272_end:
__if_44258_end:
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
__if_44551_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44551_end
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
__if_44551_end:
__if_44575_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_44575_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44575_end:
__if_44588_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_44588_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44588_end:
__if_44600_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44600_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 12
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_44600_end:
__if_44612_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44612_end
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
__if_44612_end:
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
__if_45395_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45395_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_45395_end:
__if_45410_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45410_end
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
__if_45410_end:
__if_45425_start:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45425_end
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
__if_45425_end:
__if_45440_start:
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45440_end
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
__if_45440_end:
__if_45455_start:
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_45455_end
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
__if_45455_end:
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
__if_45559_start:
  mov R0, [BP+3]
  ilt R0, 3
  jf R0, __if_45559_end
  jmp __function_b2WakeSolverSet_return
__if_45559_end:
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
__for_45582_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45582_end
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
__for_45582_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45582_start
__for_45582_end:
  mov R0, 0
  mov [BP-3], R0
__for_45720_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45720_end
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
__for_45720_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45720_start
__for_45720_end:
  mov R0, 0
  mov [BP-3], R0
__for_45796_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45796_end
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
__for_45796_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45796_start
__for_45796_end:
  mov R0, 0
  mov [BP-3], R0
__for_45872_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_45872_end
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
__for_45872_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_45872_start
__for_45872_end:
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
__for_45963_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_45963_end
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
__if_46042_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46049
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_46049:
  jf R0, __if_46042_end
  jmp __for_45963_continue
__if_46042_end:
__if_46053_start:
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
  jf R0, __if_46053_end
__if_46064_start:
  mov R1, [BP-8]
  jf R1, __LogicalAnd_ShortCircuit_46066
  mov R3, [BP-6]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2ShouldReportContactEvents
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_46066:
  mov R0, R1
  jf R0, __if_46064_end
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
__if_46064_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __for_45963_continue
__if_46053_end:
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
__if_46093_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46093_else
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  jmp __if_46093_end
__if_46093_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46093_end:
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
__if_46119_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46119_else
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  jmp __if_46119_end
__if_46119_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46119_end:
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
__if_46179_start:
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
  jf R0, __if_46179_else
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
  jmp __if_46179_end
__if_46179_else:
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
__if_46179_end:
__if_46219_start:
  mov R0, [BP-19]
  jf R0, __LogicalAnd_ShortCircuit_46221
  mov R1, [BP-8]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_46221:
  jf R0, __if_46219_else
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  or R0, 1
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46233_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46233_end
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
__if_46233_end:
__if_46245_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46245_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46245_end:
__if_46254_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46254_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46254_end:
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
__if_46281_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46281_end
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46281_end:
__if_46291_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46291_end
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46291_end:
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
  jmp __if_46219_end
__if_46219_else:
__if_46324_start:
  mov R0, [BP-19]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_46329
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_46329:
  jf R0, __if_46324_end
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  and R0, -2
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46339_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46339_end
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
__if_46339_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_46324_end:
__if_46219_end:
__if_46354_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_46354_end
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
__if_46354_end:
__if_46373_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_46373_end
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
__if_46373_end:
__for_45963_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_45963_start
__for_45963_end:
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
__if_46429_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46429_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46429_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  and R0, 3
  mov [BP-5], R0
__if_46444_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_46444_else
__if_46449_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46455
  mov R1, [BP-4]
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_46455:
  jf R0, __if_46449_end
__if_46460_start:
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
  jf R0, __if_46460_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46460_end:
__if_46449_end:
  jmp __if_46444_end
__if_46444_else:
__if_46472_start:
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
  jf R0, __if_46472_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46472_end:
__if_46444_end:
__if_46483_start:
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
  jf R0, __if_46483_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46483_end:
__if_46497_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_46497_else
  mov R0, [BP+3]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-7], R0
  jmp __if_46497_end
__if_46497_else:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP+3]
  mov [BP-7], R0
__if_46497_end:
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
__if_46534_start:
  mov R1, [BP-8]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46534_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46534_end:
__if_46542_start:
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
  jf R0, __if_46542_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46542_end:
__if_46552_start:
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
  jf R0, __if_46552_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46552_end:
__if_46564_start:
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
  jf R0, __if_46564_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46564_end:
__if_46575_start:
  mov R1, [BP-8]
  iadd R1, 24
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_46578
  mov R2, [BP-9]
  iadd R2, 24
  mov R1, [R2]
  or R0, R1
__LogicalOr_ShortCircuit_46578:
  jf R0, __if_46575_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_46575_end:
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
__for_46602_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_46602_end
  mov R2, [BP-1]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-4], R0
__if_46618_start:
  mov R0, [BP-4]
  ieq R0, -1
  jf R0, __if_46618_end
  jmp __for_46602_continue
__if_46618_end:
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
__if_46672_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_46672_end
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
__if_46672_end:
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
__for_46602_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46602_start
__for_46602_end:
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
__if_46757_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46757_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46757_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_46772_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46772_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46772_end:
__if_46781_start:
  mov R1, [BP-4]
  iadd R1, 25
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_46781_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46781_end:
__if_46788_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_46788_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46788_end:
__if_46793_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_46793_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46793_end:
__if_46801_start:
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
  jf R0, __if_46801_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_46801_end:
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
__if_46861_start:
  mov R0, [BP-59]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R1, 10.000000
  flt R0, R1
  jf R0, __if_46861_end
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
__if_46861_end:
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
__for_46911_start:
  mov R0, [BP-2]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_46911_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_46929_start:
  mov R1, [BP-3]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_46929_end
  jmp __for_46911_continue
__if_46929_end:
__if_46937_start:
  mov R1, [BP-3]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_46937_end
  jmp __for_46911_continue
__if_46937_end:
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
  jf R0, __LogicalAnd_ShortCircuit_46973
  mov R2, [BP-3]
  iadd R2, 25
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_46973:
  mov [BP-12], R0
__if_46976_start:
  mov R0, [BP-12]
  jf R0, __if_46976_end
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
__for_46998_start:
  mov R0, [BP-25]
  ilt R0, 3
  jf R0, __for_46998_end
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
__for_46998_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_46998_start
__for_46998_end:
__if_46976_end:
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
__for_47042_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47042_end
  mov R0, [BP-16]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47060_start:
  mov R0, [BP-18]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47060_end
__if_47069_start:
  mov R0, [BP-14]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47069_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47060_end
__if_47069_end:
__for_47060_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47060_start
__for_47060_end:
__if_47080_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47080_end
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47080_end:
__for_47042_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47042_start
__for_47042_end:
  mov R0, 0
  mov [BP-17], R0
__for_47091_start:
  mov R0, [BP-17]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47091_end
  mov R0, [BP-14]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47109_start:
  mov R0, [BP-18]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47109_end
__if_47118_start:
  mov R0, [BP-16]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47118_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47109_end
__if_47118_end:
__for_47109_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47109_start
__for_47109_end:
__if_47129_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47129_end
  mov R1, [BP+2]
  iadd R1, 79
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47129_end:
__for_47091_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47091_start
__for_47091_end:
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
__for_47151_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47151_end
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
__for_47151_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47151_start
__for_47151_end:
  mov R0, [BP-13]
  mov R1, [BP-3]
  iadd R1, 27
  mov [R1], R0
__for_46911_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_46911_start
__for_46911_end:
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
__for_47205_start:
  mov R0, [BP-7]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_47205_end
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
__if_47259_start:
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_47259_else
  mov R1, [BP-8]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-15], R0
  jmp __if_47259_end
__if_47259_else:
  mov R0, 0.000000
  mov [BP-15], R0
__if_47259_end:
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
__for_47205_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_47205_start
__for_47205_end:
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
__for_47368_start:
  mov R0, [BP-6]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_47368_end
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
__if_47392_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  jf R0, __if_47392_end
  mov R0, 0.000000
  mov [BP-9], R0
__if_47392_end:
__if_47404_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 2
  ine R0, 0
  jf R0, __if_47404_end
  mov R0, 0.000000
  mov [BP-8], R0
__if_47404_end:
__if_47416_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 4
  ine R0, 0
  jf R0, __if_47416_end
  mov R0, 0.000000
  mov [BP-10], R0
__if_47416_end:
__if_47427_start:
  lea R2, [BP-9]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-4]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_47427_end
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
__if_47427_end:
__if_47461_start:
  mov R0, [BP-10]
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-5]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_47472
  mov R2, [BP-7]
  iadd R2, 3
  mov R1, [R2]
  and R1, 128
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_47472:
  jf R0, __if_47461_end
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
__if_47461_end:
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
__for_47368_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_47368_start
__for_47368_end:
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
__if_47560_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47560_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47560_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_47575_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47575_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47575_end:
__if_47584_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47584_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47584_end:
__if_47592_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47592_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47592_end:
__if_47597_start:
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
  jf R0, __if_47597_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47597_end:
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
__if_47623_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_47623_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47623_end:
__if_47633_start:
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
  jf R0, __if_47633_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_47633_end:
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
__if_47705_start:
  mov R0, [BP-64]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_47712
  mov R1, [BP-64]
  mov R3, [BP-1]
  iadd R3, 13
  mov R2, [R3]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_47712:
  jf R0, __if_47705_end
  mov R0, [BP-64]
  mov R1, [BP-1]
  iadd R1, 13
  mov [R1], R0
__if_47705_end:
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
__while_47803_start:
__while_47803_continue:
  mov R0, [BP-34]
  ine R0, -1
  jf R0, __while_47803_end
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
__if_47822_start:
  mov R1, [BP-35]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47822_end
  jmp __while_47803_continue
__if_47822_end:
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
__if_47909_start:
  mov R0, [BP-25]
  jf R0, __if_47909_end
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
__if_47909_end:
  jmp __while_47803_start
__while_47803_end:
__if_47942_start:
  mov R0, [BP-11]
  flt R0, 1.000000
  jf R0, __if_47942_else
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
  jmp __if_47942_end
__if_47942_else:
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
__if_47942_end:
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
__while_48051_start:
__while_48051_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_48051_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_48066_start:
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48066_end
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
__if_48132_start:
  mov R2, [BP-3]
  iadd R2, 13
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2AABB_Contains
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_48132_end
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
__if_48132_end:
__if_48066_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_48051_start
__while_48051_end:
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
__for_48228_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48228_end
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
__if_48348_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_48358
  mov R2, [BP-6]
  iadd R2, 23
  mov R1, [R2]
  and R1, 2048
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_48358:
  jt R0, __LogicalOr_ShortCircuit_48362
  mov R1, [BP-21]
  mov R3, [BP-14]
  iadd R3, 14
  mov R2, [R3]
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_48362:
  jf R0, __if_48348_else
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
  jmp __if_48348_end
__if_48348_else:
  mov R1, [BP-14]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
__if_48348_end:
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
  jf R0, __LogicalAnd_ShortCircuit_48438
  mov R2, [BP-14]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_48438:
  jf R0, __LogicalAnd_ShortCircuit_48444
  mov R1, [BP-28]
  mov R3, [BP-6]
  iadd R3, 17
  mov R2, [R3]
  fmul R2, 0.500000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_48444:
  mov [BP-29], R0
__if_48450_start:
  mov R0, [BP-29]
  jf R0, __if_48450_else
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_48460_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_48460_end
  jmp __for_48228_continue
__if_48460_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  jmp __if_48450_end
__if_48450_else:
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
__if_48450_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_48228_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48228_start
__for_48228_end:
  mov R0, 0
  mov [BP-5], R0
__for_48488_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48488_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
__if_48504_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 24
  ine R0, 24
  jf R0, __if_48504_end
  jmp __for_48488_continue
__if_48504_end:
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
__for_48488_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48488_start
__for_48488_end:
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
__if_48675_start:
  mov R0, [BP-9]
  fgt R0, 0.000000
  jf R0, __if_48675_else
  mov R0, 1.000000
  mov R1, [BP-9]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  jmp __if_48675_end
__if_48675_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_48675_end:
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
__if_48718_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_48718_else
  mov R0, 1.000000
  mov R1, [BP-12]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  jmp __if_48718_end
__if_48718_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_48718_end:
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
__for_48813_start:
  mov R0, [BP-6]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48813_end
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
__if_48834_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_48834_end
  jmp __for_48813_continue
__if_48834_end:
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
__if_48919_start:
  mov R0, [BP-9]
  ieq R0, -1
  jt R0, __LogicalOr_ShortCircuit_48926
  mov R1, [BP-10]
  ieq R1, -1
  or R0, R1
__LogicalOr_ShortCircuit_48926:
  jf R0, __if_48919_else
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 3
  movs
  jmp __if_48919_end
__if_48919_else:
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 3
  movs
__if_48919_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
__if_48947_start:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __if_48947_end
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
__if_48947_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-17], R0
__if_48972_start:
  mov R0, [BP-10]
  ine R0, -1
  jf R0, __if_48972_end
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
__if_48972_end:
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
__if_49002_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_49002_end
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
__if_49002_end:
__if_49036_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_49036_end
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
__if_49036_end:
__for_48813_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_48813_start
__for_48813_end:
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
__for_49247_start:
  mov R0, [BP-11]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_49247_end
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
__if_49277_start:
  mov R0, [BP-13]
  ieq R0, -1
  jf R0, __if_49277_else
  lea R0, [BP-10]
  mov [BP-15], R0
  jmp __if_49277_end
__if_49277_else:
  mov R0, [BP-2]
  mov R1, [BP-13]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49277_end:
__if_49295_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_49295_else
  lea R0, [BP-10]
  mov [BP-16], R0
  jmp __if_49295_end
__if_49295_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49295_end:
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
__if_49344_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_49344_end
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
__if_49344_end:
__if_49375_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_49375_end
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
__if_49375_end:
__if_49406_start:
  mov R0, [BP-13]
  ine R0, -1
  jf R0, __if_49406_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_49406_end:
__if_49421_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_49421_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_49421_end:
__for_49247_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_49247_start
__for_49247_end:
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
__if_49560_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __if_49560_else
  mov R0, [BP-11]
  mov R1, [BP+12]
  fmul R0, R1
  mov [BP-12], R0
  jmp __if_49560_end
__if_49560_else:
__if_49570_start:
  mov R0, [BP+14]
  jf R0, __if_49570_end
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
__if_49570_end:
__if_49560_end:
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
__if_49680_start:
  mov R0, [BP-23]
  flt R0, 0.000000
  jf R0, __if_49680_end
  mov R0, 0.000000
  mov [BP-23], R0
__if_49680_end:
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
__for_50042_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50042_end
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
__if_50072_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50072_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50072_end
__if_50072_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50072_end:
__if_50090_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50090_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50090_end
__if_50090_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50090_end:
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
__if_50169_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50169_end
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
__if_50169_end:
__if_50210_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50210_end
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
__if_50210_end:
__if_50251_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_50251_end
__if_50256_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50256_end
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
__if_50256_end:
__if_50289_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50289_end
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
__if_50289_end:
__if_50251_end:
__if_50322_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50322_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50322_end:
__if_50337_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_50337_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_50337_end:
__for_50042_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50042_start
__for_50042_end:
__function_b2SolveContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitutionPoint:
  push BP
  mov BP, SP
  isub SP, 17
__if_50365_start:
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+5]
  fsgn R1
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_50373
  mov R2, [BP+2]
  iadd R2, 8
  mov R1, [R2]
  feq R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_50373:
  jf R0, __if_50365_end
  jmp __function_b2ApplyRestitutionPoint_return
__if_50365_end:
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
__for_50621_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50621_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
__if_50637_start:
  mov R1, [BP-13]
  iadd R1, 32
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_50637_end
  jmp __for_50621_continue
__if_50637_end:
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
__if_50657_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50657_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50657_end
__if_50657_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50657_end:
__if_50675_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50675_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50675_end
__if_50675_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50675_end:
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
__if_50711_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50711_end
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
__if_50711_end:
__if_50743_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50743_end
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
__if_50743_end:
__if_50775_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50775_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50775_end:
__if_50790_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_50790_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_50790_end:
__for_50621_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50621_start
__for_50621_end:
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
__for_50824_start:
  mov R0, [BP-3]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50824_end
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
__if_50848_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50848_end
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
__if_50848_end:
__if_50898_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50898_end
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
__if_50898_end:
__for_50824_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_50824_start
__for_50824_end:
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
__if_51072_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51072_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_51072_end
__if_51072_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_51072_end:
__if_51088_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51088_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_51088_end
__if_51088_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_51088_end:
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
__if_51223_start:
  mov R0, [BP-30]
  fgt R0, 0.000000
  jf R0, __if_51223_else
  mov R0, 1.000000
  mov R1, [BP-30]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_51223_end
__if_51223_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_51223_end:
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
__if_51287_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51287_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51287_end
__if_51287_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51287_end:
__if_51307_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51307_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_51307_end
__if_51307_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51307_end:
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
__if_51414_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51414_end
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
__if_51414_end:
__if_51450_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_51450_end
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
__if_51450_end:
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
__if_51530_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51530_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51530_end
__if_51530_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51530_end:
__if_51550_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51550_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_51550_end
__if_51550_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51550_end:
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
__if_51657_start:
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_51660
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 6
  mov R2, [R3]
  flt R1, R2
  jt R1, __LogicalOr_ShortCircuit_51669
  mov R3, [BP-14]
  iadd R3, 26
  mov R2, [R3]
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_51669:
  and R0, R1
__LogicalAnd_ShortCircuit_51660:
  jf R0, __if_51657_else
__if_51673_start:
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_51673_end
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
__if_51673_end:
__if_51847_start:
  mov R1, [BP-14]
  iadd R1, 27
  mov R0, [R1]
  jf R0, __if_51847_end
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
__if_51847_end:
__if_51994_start:
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  jf R0, __if_51994_end
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
__if_52064_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52064_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52064_end
__if_52064_else:
__if_52073_start:
  mov R0, [BP+6]
  jf R0, __if_52073_end
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
__if_52073_end:
__if_52064_end:
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
__if_52250_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52250_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52250_end
__if_52250_else:
__if_52259_start:
  mov R0, [BP+6]
  jf R0, __if_52259_end
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
__if_52259_end:
__if_52250_end:
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
__if_51994_end:
  jmp __if_51657_end
__if_51657_else:
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
__if_52437_start:
  mov R0, [BP+6]
  jf R0, __if_52437_end
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
__if_52437_end:
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
__if_51657_end:
__if_52537_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52537_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_52537_end:
__if_52553_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52553_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_52553_end:
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
__if_52671_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52671_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_52671_end
__if_52671_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_52671_end:
__if_52687_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_52687_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_52687_end
__if_52687_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_52687_end:
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
__if_52790_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_52790_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_52790_end
__if_52790_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_52790_end:
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
__if_52854_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52854_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_52854_end
__if_52854_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_52854_end:
__if_52874_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52874_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_52874_end
__if_52874_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_52874_end:
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
__if_52929_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52929_end
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
__if_52929_end:
__if_52970_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52970_end
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
__if_52970_end:
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
__if_53055_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53055_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53055_end
__if_53055_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53055_end:
__if_53075_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53075_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53075_end
__if_53075_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53075_end:
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
__if_53150_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53153
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53153:
  jf R0, __if_53150_end
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
__if_53150_end:
__if_53230_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53233
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53233:
  jf R0, __if_53230_end
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
__if_53230_end:
__if_53294_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53297
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53297:
  jf R0, __if_53294_end
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
__if_53323_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_53323_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_53323_end
__if_53323_else:
__if_53332_start:
  mov R0, [BP+6]
  jf R0, __if_53332_end
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
__if_53332_end:
__if_53323_end:
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
__if_53421_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_53421_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_53421_end
__if_53421_else:
__if_53430_start:
  mov R0, [BP+6]
  jf R0, __if_53430_end
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
__if_53430_end:
__if_53421_end:
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
__if_53294_end:
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
__if_53579_start:
  mov R0, [BP+6]
  jf R0, __if_53579_end
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
__if_53579_end:
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
__if_53830_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53830_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_53830_end:
__if_53846_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53846_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_53846_end:
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
__if_53964_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53964_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_53964_end
__if_53964_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_53964_end:
__if_53980_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53980_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_53980_end
__if_53980_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_53980_end:
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
__if_54083_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_54083_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_54083_end
__if_54083_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_54083_end:
__if_54097_start:
  mov R1, [BP-13]
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54097_else
  mov R13, [BP-13]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54097_end
__if_54097_else:
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
__if_54097_end:
__if_54116_start:
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54116_else
  mov R13, [BP-13]
  iadd R13, 7
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54116_end
__if_54116_else:
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
__if_54116_end:
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
__if_54176_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54176_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54176_end
__if_54176_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54176_end:
__if_54196_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54196_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54196_end
__if_54196_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54196_end:
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
__if_54238_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54238_end
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
__if_54238_end:
__if_54280_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54280_end
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
__if_54280_end:
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
__if_54364_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54364_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54364_end
__if_54364_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54364_end:
__if_54384_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54384_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54384_end
__if_54384_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54384_end:
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
__if_54466_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_54468
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_54468:
  jf R0, __if_54466_end
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
__if_54466_end:
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
__if_54568_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_54570
  mov R2, [BP-14]
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_54570:
  jf R0, __if_54568_end
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
__if_54568_end:
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
__if_54867_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54867_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_54867_end:
__if_54883_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54883_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_54883_end:
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
__if_55001_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55001_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_55001_end
__if_55001_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_55001_end:
__if_55017_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55017_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_55017_end
__if_55017_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_55017_end:
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
__if_55195_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55195_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55195_end
__if_55195_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55195_end:
__if_55215_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55215_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55215_end
__if_55215_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55215_end:
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
__if_55420_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55420_end
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
__if_55420_end:
__if_55452_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55452_end
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
__if_55452_end:
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
__if_55528_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55528_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55528_end
__if_55528_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55528_end:
__if_55548_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55548_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55548_end
__if_55548_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55548_end:
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
__if_55736_start:
  mov R0, [BP-48]
  fgt R0, 0.000000
  jf R0, __if_55736_else
  mov R0, 1.000000
  mov R1, [BP-48]
  fdiv R0, R1
  mov [BP-49], R0
  jmp __if_55736_end
__if_55736_else:
  mov R0, 0.000000
  mov [BP-49], R0
__if_55736_end:
__if_55748_start:
  mov R1, [BP-14]
  iadd R1, 28
  mov R0, [R1]
  jf R0, __if_55748_end
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
__if_55748_end:
__if_55880_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __if_55880_end
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
__if_55880_end:
__if_56002_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_56002_end
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
__if_56023_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56023_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56037_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56037_else
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
  jmp __if_56037_end
__if_56037_else:
__if_56052_start:
  mov R0, [BP+6]
  jf R0, __if_56052_end
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
__if_56052_end:
__if_56037_end:
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
  jmp __if_56023_end
__if_56023_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 4
  mov [R1], R0
__if_56023_end:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-86], R0
__if_56198_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56198_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56212_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56212_else
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
  jmp __if_56212_end
__if_56212_else:
__if_56227_start:
  mov R0, [BP+6]
  jf R0, __if_56227_end
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
__if_56227_end:
__if_56212_end:
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
  jmp __if_56198_end
__if_56198_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 5
  mov [R1], R0
__if_56198_end:
__if_56002_end:
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
__if_56438_start:
  mov R0, [BP+6]
  jf R0, __if_56438_end
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
__if_56438_end:
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
__if_56506_start:
  mov R0, [BP-66]
  feq R0, 0.000000
  jf R0, __if_56506_end
  mov R0, 1.000000
  mov [BP-66], R0
__if_56506_end:
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
__if_56670_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56670_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_56670_end:
__if_56686_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56686_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_56686_end:
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
__if_56804_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_56804_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
  jmp __if_56804_end
__if_56804_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
__if_56804_end:
__if_56820_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_56820_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
  jmp __if_56820_end
__if_56820_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
__if_56820_end:
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
__if_57015_start:
  mov R0, [BP-36]
  fgt R0, 0.000000
  jf R0, __if_57015_else
  mov R0, 1.000000
  mov R1, [BP-36]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_57015_end
__if_57015_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_57015_end:
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
__if_57060_start:
  mov R0, [BP-39]
  fgt R0, 0.000000
  jf R0, __if_57060_else
  mov R0, 1.000000
  mov R1, [BP-39]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_57060_end
__if_57060_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_57060_end:
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
__if_57088_start:
  mov R0, [BP-40]
  fgt R0, 0.000000
  jf R0, __if_57088_else
  mov R0, 1.000000
  mov R1, [BP-40]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_57088_end
__if_57088_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_57088_end:
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
__if_57143_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57143_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57143_end
__if_57143_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57143_end:
__if_57163_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57163_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57163_end
__if_57163_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57163_end:
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
__if_57383_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57383_end
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
__if_57383_end:
__if_57415_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57415_end
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
__if_57415_end:
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
__if_57491_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57491_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57491_end
__if_57491_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57491_end:
__if_57511_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57511_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57511_end
__if_57511_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57511_end:
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
__if_57677_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_57680
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_57680:
  jf R0, __if_57677_end
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
__if_57677_end:
__if_57741_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_57741_end
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
__if_57741_end:
__if_57871_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __if_57871_end
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
__if_57891_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_57891_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_57891_end
__if_57891_else:
__if_57900_start:
  mov R0, [BP+6]
  jf R0, __if_57900_end
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
__if_57900_end:
__if_57891_end:
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
__if_58053_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58053_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58053_end
__if_58053_else:
__if_58062_start:
  mov R0, [BP+6]
  jf R0, __if_58062_end
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
__if_58062_end:
__if_58053_end:
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
__if_57871_end:
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
__if_58216_start:
  mov R0, [BP+6]
  jf R0, __if_58216_end
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
__if_58216_end:
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
__if_58363_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58363_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_58363_end:
__if_58379_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58379_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_58379_end:
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
__if_58497_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_58497_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_58497_end
__if_58497_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_58497_end:
__if_58513_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_58513_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_58513_end
__if_58513_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_58513_end:
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
__if_58725_start:
  mov R0, [BP-26]
  fgt R0, 0.000000
  jf R0, __if_58725_else
  mov R0, 1.000000
  mov R1, [BP-26]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
  jmp __if_58725_end
__if_58725_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
__if_58725_end:
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
__if_58780_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58780_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_58780_end
__if_58780_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_58780_end:
__if_58800_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58800_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_58800_end
__if_58800_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_58800_end:
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
__if_58860_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58860_end
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
__if_58860_end:
__if_58899_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58899_end
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
__if_58899_end:
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
__if_58980_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58980_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_58980_end
__if_58980_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_58980_end:
__if_59000_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59000_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59000_end
__if_59000_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59000_end:
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
__if_59034_start:
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59041
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59041:
  jf R0, __if_59034_end
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
__if_59034_end:
__if_59161_start:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59161_end
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
__if_59161_end:
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
__if_59246_start:
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59253
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59253:
  jf R0, __if_59246_end
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
__if_59517_start:
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
  jf R0, __if_59517_end
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
__if_59517_end:
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
__if_59246_end:
__if_59617_start:
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59617_end
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
__if_59730_start:
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
  jf R0, __if_59730_end
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
__if_59730_end:
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
__if_59617_end:
__if_59830_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59830_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_59830_end:
__if_59846_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59846_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_59846_end:
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
__for_59881_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_59881_end
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
__if_59915_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_59915_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareDistanceJoint
  jmp __if_59915_end
__if_59915_else:
__if_59924_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_59924_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareRevoluteJoint
  jmp __if_59924_end
__if_59924_else:
__if_59933_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_59933_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWeldJoint
  jmp __if_59933_end
__if_59933_else:
__if_59942_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_59942_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PreparePrismaticJoint
  jmp __if_59942_end
__if_59942_else:
__if_59951_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_59951_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWheelJoint
  jmp __if_59951_end
__if_59951_else:
__if_59960_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_59960_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareMotorJoint
__if_59960_end:
__if_59951_end:
__if_59942_end:
__if_59933_end:
__if_59924_end:
__if_59915_end:
__for_59881_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_59881_start
__for_59881_end:
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
__for_59986_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_59986_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60004_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60004_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartDistanceJoint
  jmp __if_60004_end
__if_60004_else:
__if_60012_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60012_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartRevoluteJoint
  jmp __if_60012_end
__if_60012_else:
__if_60020_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60020_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWeldJoint
  jmp __if_60020_end
__if_60020_else:
__if_60028_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60028_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartPrismaticJoint
  jmp __if_60028_end
__if_60028_else:
__if_60036_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60036_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWheelJoint
  jmp __if_60036_end
__if_60036_else:
__if_60044_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60044_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartMotorJoint
__if_60044_end:
__if_60036_end:
__if_60028_end:
__if_60020_end:
__if_60012_end:
__if_60004_end:
__for_59986_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_59986_start
__for_59986_end:
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
__for_60072_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60072_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60090_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60090_else
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
  jmp __if_60090_end
__if_60090_else:
__if_60101_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60101_else
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
  jmp __if_60101_end
__if_60101_else:
__if_60112_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60112_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2SolveWeldJoint
  jmp __if_60112_end
__if_60112_else:
__if_60121_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60121_else
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
  jmp __if_60121_end
__if_60121_else:
__if_60132_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60132_else
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
  jmp __if_60132_end
__if_60132_else:
__if_60143_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60143_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2SolveMotorJoint
__if_60143_end:
__if_60132_end:
__if_60121_end:
__if_60112_end:
__if_60101_end:
__if_60090_end:
__for_60072_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60072_start
__for_60072_end:
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
__if_60169_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_60169_end
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
__if_60169_end:
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
__for_60300_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60300_end
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
__if_60387_start:
  mov R0, [BP-10]
  mov R1, [BP-12]
  ine R0, R1
  jf R0, __if_60387_end
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
__if_60387_end:
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
__for_60300_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60300_start
__for_60300_end:
  mov R0, 0
  mov [BP-5], R0
__for_60419_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60419_end
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
__if_60496_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_60496_end
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
__if_60496_end:
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
__for_60419_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60419_start
__for_60419_end:
  mov R0, 0
  mov [BP-5], R0
__for_60546_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60546_end
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
__if_60623_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_60623_end
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
__if_60623_end:
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
__for_60546_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60546_start
__for_60546_end:
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
__if_60721_start:
  mov R0, [BP-6]
  mov R1, [BP-7]
  ine R0, R1
  jf R0, __if_60721_end
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
__if_60721_end:
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
__if_60770_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_60770_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_60770_end:
__function_b2TrySleepIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSleep:
  push BP
  mov BP, SP
  isub SP, 9
__if_60815_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60815_end
  jmp __function_b2UpdateSleep_return
__if_60815_end:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
__while_60832_start:
__while_60832_continue:
  mov R0, [BP-1]
  ige R0, 0
  jf R0, __while_60832_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
__if_60845_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_60845_end
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_60832_continue
__if_60845_end:
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
__for_60885_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60885_end
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
__if_60907_start:
  mov R1, [BP-7]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_60907_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_60885_end
__if_60907_end:
__if_60917_start:
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  flt R0, 0.500000
  jf R0, __if_60917_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_60885_end
__if_60917_end:
__for_60885_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_60885_start
__for_60885_end:
__if_60927_start:
  mov R0, [BP-5]
  jf R0, __if_60927_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2TrySleepIsland
__if_60927_end:
  mov R0, [BP-1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_60832_start
__while_60832_end:
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
__for_60958_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_60958_end
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 49
  iadd R0, R1
  mov [BP-5], R0
__if_60976_start:
  mov R1, [BP-5]
  iadd R1, 41
  mov R0, [R1]
  and R0, 1048576
  ieq R0, 0
  jf R0, __if_60976_end
  jmp __for_60958_continue
__if_60976_end:
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, -1
  mov [BP-7], R0
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_60997_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_60997_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61011_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61021
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61021:
  jf R0, __if_61011_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__if_61011_end:
__if_60997_end:
__if_61031_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_61031_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61045_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61055
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 12
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61055:
  jf R0, __if_61045_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-7], R0
__if_61045_end:
__if_61031_end:
__if_61065_start:
  mov R0, [BP-7]
  ieq R0, -1
  jf R0, __if_61065_end
  jmp __for_60958_continue
__if_61065_end:
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
__if_61111_start:
  mov R1, [BP-11]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_61118
  mov R2, [BP-12]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_61118:
  jf R0, __if_61111_else
__if_61122_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61122_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_61122_end
__if_61122_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  iadd R12, 2
  mov CR, 2
  movs
__if_61122_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
  jmp __if_61111_end
__if_61111_else:
__if_61153_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61153_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  mov CR, 2
  movs
  jmp __if_61153_end
__if_61153_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  mov CR, 2
  movs
__if_61153_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
__if_61111_end:
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
__for_60958_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_60958_start
__for_60958_end:
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
__if_61235_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_61235_end
  mov R0, 1
  mov [BP+4], R0
__if_61235_end:
  mov R0, [BP+3]
  mov R1, [BP+4]
  cif R1
  fdiv R0, R1
  mov [BP-3], R0
__if_61249_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_61249_else
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
  jmp __if_61249_end
__if_61249_else:
  mov R0, 0.000000
  mov [BP-4], R0
__if_61249_end:
  mov R0, [BP-4]
  mov R1, [BP+2]
  iadd R1, 55
  mov [R1], R0
__if_61267_start:
  mov R0, [BP+3]
  fgt R0, 0.000000
  jf R0, __if_61267_else
  mov R0, 1.000000
  mov R1, [BP+3]
  fdiv R0, R1
  mov [BP-5], R0
  jmp __if_61267_end
__if_61267_else:
  mov R0, 0.000000
  mov [BP-5], R0
__if_61267_end:
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
__if_61325_start:
  mov R0, [BP-2]
  igt R0, 0
  jf R0, __if_61325_end
__if_61330_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_61330_end
__if_61336_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_61336_end
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
__if_61336_end:
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
__if_61330_end:
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
__if_61325_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_b2PrepareJoints
  mov R0, 0
  mov [BP-17], R0
__for_61378_start:
  mov R0, [BP-17]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_61378_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2IntegrateVelocities
__if_61391_start:
  mov R1, [BP+2]
  iadd R1, 53
  mov R0, [R1]
  jf R0, __if_61391_end
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
__if_61391_end:
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
__for_61378_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_61378_start
__for_61378_end:
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
__if_61442_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  jf R0, __if_61442_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSplitIsland
__if_61448_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_61448_end
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
__if_61448_end:
__if_61442_end:
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
__if_61472_start:
  mov R0, [BP+3]
  fle R0, 0.000000
  jf R0, __if_61472_end
  jmp __function_b2World_Step_return
__if_61472_end:
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
__if_61769_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_61769_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61769_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_61788_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_61793
  mov R1, [BP-1]
  mov R2, [22]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_61793:
  jf R0, __if_61788_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61788_end:
  mov R0, [21]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
__if_61810_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_61810_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61810_end:
__if_61819_start:
  mov R1, [BP-3]
  iadd R1, 20
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_61819_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_61819_end:
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
__if_61866_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_61866_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_61866_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-4], R0
__if_61882_start:
  mov R1, [BP-4]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_61882_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_61882_end:
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

__function_vb2_GetX:
  push BP
  mov BP, SP
  isub SP, 5
  push R1
  push R2
  isub SP, 3
__if_62160_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62160_end
  mov R0, 0.000000
  jmp __function_vb2_GetX_return
__if_62160_end:
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
__if_62185_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62185_end
  mov R0, 0.000000
  jmp __function_vb2_GetY_return
__if_62185_end:
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

__function_vb2_SetBounce:
  push BP
  mov BP, SP
  isub SP, 6
__if_62593_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62593_end
  jmp __function_vb2_SetBounce_return
__if_62593_end:
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
__if_62704_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_62704_end
  mov R0, -1
  jmp __function_vb2_BodyOfShape_return
__if_62704_end:
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
__if_62808_start:
  mov R0, [global_vb2_pickShape]
  ine R0, -1
  jf R0, __if_62808_end
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_62808_end:
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
__if_62834_start:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Shape_TestPoint
  jf R0, __if_62834_end
  mov R0, [BP+3]
  mov [global_vb2_pickShape], R0
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_62834_end:
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
__if_62962_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_62962_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_62962_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_62981_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_62986
  mov R1, [BP-1]
  mov R2, [58]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_62986:
  jf R0, __if_62981_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_62981_end:
  mov R0, [57]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 17
  iadd R0, R1
  mov [BP-3], R0
__if_63003_start:
  mov R1, [BP-3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_63003_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63003_end:
__if_63012_start:
  mov R1, [BP-3]
  iadd R1, 15
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_63012_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63012_end:
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
  isub SP, 8
  call __function_vb2_Init
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  mov R1, 20.000000
  mov [SP+2], R1
  call __function_vb2_SetCamera
  mov R1, 0.000000
  mov [SP], R1
  mov R1, -7.000000
  mov [SP+1], R1
  mov R1, 12.000000
  mov [SP+2], R1
  mov R1, 0.500000
  mov [SP+3], R1
  call __function_vb2_Wall
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 6.000000
  mov [SP+1], R1
  mov R1, 0.500000
  mov [SP+2], R1
  call __function_vb2_Ball
  mov [BP-1], R0
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, 0.700000
  mov [SP+1], R1
  call __function_vb2_SetBounce
__while_63354_start:
__while_63354_continue:
  mov R0, 1
  jf R0, __while_63354_end
  call __function_vb2_Step
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
  mov R1, __literal_string_63365
  mov [SP+2], R1
  call __function_print_at
  mov R0, -12.000000
  mov [BP-2], R0
__for_63368_start:
  mov R0, [BP-2]
  fle R0, 12.000000
  jf R0, __for_63368_end
  mov R2, -6.500000
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-3], R1
  mov R2, [BP-2]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-4], R1
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, __literal_string_63387
  mov [SP+2], R1
  call __function_print_at
__for_63368_continue:
  mov R0, [BP-2]
  fadd R0, 0.500000
  mov [BP-2], R0
  jmp __for_63368_start
__for_63368_end:
  mov R3, [BP-1]
  mov [SP], R3
  call __function_vb2_GetY
  mov R2, R0
  mov [BP-3], R2
  mov R2, [BP-3]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  isub R1, 5
  mov [BP-3], R1
  mov R3, [BP-1]
  mov [SP], R3
  call __function_vb2_GetX
  mov R2, R0
  mov [BP-4], R2
  mov R2, [BP-4]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  isub R1, 4
  mov [BP-4], R1
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, __literal_string_63399
  mov [SP+2], R1
  call __function_print_at
  call __function_end_frame
  jmp __while_63354_start
__while_63354_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_18556:
  string "0123456789ABCDEF"
__literal_string_18593:
  string "-2147483648"
__literal_string_63365:
  string "LESSON 1: HELLO, GRAVITY"
__literal_string_63387:
  string "="
__literal_string_63399:
  string "O"
