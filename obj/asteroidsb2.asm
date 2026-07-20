; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_malloc_start_address 0
  %define global_malloc_end_address 1
  %define global_malloc_first_block 2
  %define global_b2_two_pow_23 3
  %define global_b2Vec2_zero 4
  %define global_b2Rot_identity 6
  %define global_b2Transform_identity 8
  %define global_b2Mat22_zero 12
  %define global_b2_lengthUnitsPerMeter 16
  %define global_vb2_world 17
  %define global_vb2_camX 101
  %define global_vb2_camY 102
  %define global_vb2_camPPM 103
  %define global_vb2_lastHit 104
  %define global_vb2_pickX 111
  %define global_vb2_pickY 112
  %define global_vb2_pickShape 113
  %define global_score 114
  %define global_maxScore 115
  %define global_lives 116
  %define global_isAlive 117
  %define global_numberBuffer 118
  %define global_asteroidShapes 130
  %define global_asteroids 190
  %define global_bullets 334
  %define global_shipHandle 370
  %define global_shipAngle 371
  %define global_invulnFrames 372
  %define global_spawnTimer 373
  %define global_asteroidDead 374
  %define global_asteroidScored 410
  %define global_bulletSpent 446

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 1048576
  mov [global_malloc_start_address], R0
  mov R0, 3145727
  mov [global_malloc_end_address], R0
  mov R0, -1
  mov [global_malloc_first_block], R0
  mov R0, 8388608.000000
  mov [global_b2_two_pow_23], R0
  mov R0, 0.000000
  mov [global_b2Vec2_zero], R0
  mov R0, 0.000000
  mov [5], R0
  mov R0, 1.000000
  mov [global_b2Rot_identity], R0
  mov R0, 0.000000
  mov [7], R0
  mov R0, 0.000000
  mov [global_b2Transform_identity], R0
  mov R0, 0.000000
  mov [9], R0
  mov R0, 1.000000
  mov [10], R0
  mov R0, 0.000000
  mov [11], R0
  mov R0, 0.000000
  mov [global_b2Mat22_zero], R0
  mov R0, 0.000000
  mov [13], R0
  mov R0, 0.000000
  mov [14], R0
  mov R0, 0.000000
  mov [15], R0
  mov R0, 1.000000
  mov [global_b2_lengthUnitsPerMeter], R0
  mov R0, 0
  mov [global_score], R0
  mov R0, 0
  mov [global_maxScore], R0
  mov R0, 3
  mov [global_lives], R0
  mov R0, 1
  mov [global_isAlive], R0
  mov R0, -20
  mov [global_asteroidShapes], R0
  mov R0, 0
  mov [131], R0
  mov R0, -10
  mov [132], R0
  mov R0, 20
  mov [133], R0
  mov R0, 10
  mov [134], R0
  mov R0, 20
  mov [135], R0
  mov R0, 20
  mov [136], R0
  mov R0, 0
  mov [137], R0
  mov R0, 10
  mov [138], R0
  mov R0, -20
  mov [139], R0
  mov R0, -10
  mov [140], R0
  mov R0, -20
  mov [141], R0
  mov R0, -20
  mov [142], R0
  mov R0, 10
  mov [143], R0
  mov R0, 0
  mov [144], R0
  mov R0, 20
  mov [145], R0
  mov R0, 10
  mov [146], R0
  mov R0, 0
  mov [147], R0
  mov R0, 20
  mov [148], R0
  mov R0, 0
  mov [149], R0
  mov R0, 0
  mov [150], R0
  mov R0, -20
  mov [151], R0
  mov R0, -10
  mov [152], R0
  mov R0, -20
  mov [153], R0
  mov R0, -9
  mov [154], R0
  mov R0, 9
  mov [155], R0
  mov R0, 0
  mov [156], R0
  mov R0, 6
  mov [157], R0
  mov R0, 9
  mov [158], R0
  mov R0, 9
  mov [159], R0
  mov R0, 6
  mov [160], R0
  mov R0, -6
  mov [161], R0
  mov R0, 0
  mov [162], R0
  mov R0, -3
  mov [163], R0
  mov R0, -6
  mov [164], R0
  mov R0, -6
  mov [165], R0
  mov R0, 0
  mov [166], R0
  mov R0, 9
  mov [167], R0
  mov R0, 6
  mov [168], R0
  mov R0, 3
  mov [169], R0
  mov R0, 12
  mov [170], R0
  mov R0, 6
  mov [171], R0
  mov R0, 0
  mov [172], R0
  mov R0, -6
  mov [173], R0
  mov R0, -12
  mov [174], R0
  mov R0, 6
  mov [175], R0
  mov R0, -6
  mov [176], R0
  mov R0, 3
  mov [177], R0
  mov R0, -10
  mov [178], R0
  mov R0, 0
  mov [179], R0
  mov R0, -5
  mov [180], R0
  mov R0, 10
  mov [181], R0
  mov R0, 5
  mov [182], R0
  mov R0, 10
  mov [183], R0
  mov R0, 10
  mov [184], R0
  mov R0, 0
  mov [185], R0
  mov R0, 5
  mov [186], R0
  mov R0, -10
  mov [187], R0
  mov R0, -5
  mov [188], R0
  mov R0, -10
  mov [189], R0
  mov R0, -1
  mov [global_shipHandle], R0
  mov R0, 0.000000
  mov [global_shipAngle], R0
  mov R0, 0
  mov [global_invulnFrames], R0
  mov R0, 0
  mov [global_spawnTimer], R0
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
__if_864_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_866
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_866:
  jf R0, __if_864_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_875_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_875_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_875_end:
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
__if_864_end:
__if_894_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_896
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_896:
  jf R0, __if_894_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_904_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_904_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_904_end:
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
__if_894_end:
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
__if_926_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_926_end
  jmp __function_reduce_malloc_block_return
__if_926_end:
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
__if_969_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_969_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_969_end:
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
__if_988_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_988_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_988_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_998_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_1001
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_1001:
  jf R0, __if_998_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_998_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_1013_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_1013_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_1013_end:
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
__if_1028_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1028_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1028_end:
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
__if_1043_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_1043_end
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
__if_1043_end:
__if_1078_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_1078_end
  mov R0, -1
  jmp __function_malloc_return
__if_1078_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_1087_start:
__while_1087_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_1087_end
__if_1090_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_1093
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1093:
  jf R0, __if_1090_end
  jmp __while_1087_end
__if_1090_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_1087_start
__while_1087_end:
__if_1103_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_1103_end
  mov R0, -1
  jmp __function_malloc_return
__if_1103_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_1113_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_1113_else
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
__if_1158_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1158_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1158_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_1113_end
__if_1113_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_1113_end:
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
__if_1183_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1183_end
  jmp __function_free_return
__if_1183_end:
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
__if_1211_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_1211_end
  mov R0, -1
  jmp __function_calloc_return
__if_1211_end:
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
__if_1225_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1225_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_1225_end:
__if_1231_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_1231_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_1231_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_1250_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_1250_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_1250_end:
__if_1256_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_1256_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1256_end
__if_1256_else:
__if_1267_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_1267_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1267_end
__if_1267_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_1278_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_1278_end
  mov R0, -1
  jmp __function_realloc_return
__if_1278_end:
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
__if_1267_end:
__if_1256_end:
__function_realloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rand:
  push BP
  mov BP, SP
  in R0, RNG_CurrentValue
__function_rand_return:
  mov SP, BP
  pop BP
  ret

__function_select_sound:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedSound, R0
__function_select_sound_return:
  mov SP, BP
  pop BP
  ret

__function_set_sound_loop:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SoundPlayWithLoop, R0
__function_set_sound_loop_return:
  mov SP, BP
  pop BP
  ret

__function_stop_channel:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out SPU_SelectedChannel, R0
  out SPU_Command, SPUCommand_StopSelectedChannel
__function_stop_channel_return:
  mov SP, BP
  pop BP
  ret

__function_play_sound_in_channel:
  push BP
  mov BP, SP
  mov R0, [BP+3]
  out SPU_SelectedChannel, R0
  mov R0, [BP+2]
  out SPU_ChannelAssignedSound, R0
  out SPU_Command, SPUCommand_PlaySelectedChannel
__function_play_sound_in_channel_return:
  mov SP, BP
  pop BP
  ret

__function_play_sound:
  push BP
  mov BP, SP
  push R1
  mov R0, 0
__play_sound_begin_loop:
  out SPU_SelectedChannel, R0
  in R1, SPU_ChannelState
  ieq R1, 0x40
  jt R1, __play_sound_channel_found
  iadd R0, 1
  mov R1, R0
  ige R1, 16
  jf R1, __play_sound_begin_loop
  mov R0, -1
  jmp __play_sound_exit
__play_sound_channel_found:
  mov R1, [BP+2]
  out SPU_ChannelAssignedSound, R1
  out SPU_Command, SPUCommand_PlaySelectedChannel
__play_sound_exit:
  pop R1
__function_play_sound_return:
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
__if_1433_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_1438
  mov R1, [BP+3]
  mov R2, [BP+5]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1438:
  jf R0, __if_1433_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  jmp __function_draw_line_return
__if_1433_end:
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
__if_1946_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  flt R0, R1
  jf R0, __if_1946_end
  mov R0, [BP+3]
  jmp __function_b2ClampFloat_return
__if_1946_end:
__if_1952_start:
  mov R0, [BP+2]
  mov R1, [BP+4]
  fgt R0, R1
  jf R0, __if_1952_end
  mov R0, [BP+4]
  jmp __function_b2ClampFloat_return
__if_1952_end:
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
__if_2339_start:
  mov R0, [BP-1]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2339_end
  mov R0, 0.000000
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Normalize_return
__if_2339_end:
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
__if_2408_start:
  mov R0, [BP-1]
  fgt R0, 0.000000
  jf R0, __if_2408_end
  mov R0, 1.000000
  mov R1, [BP-1]
  fdiv R0, R1
  mov [BP-2], R0
__if_2408_end:
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
__if_2901_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_2901_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2GetLengthAndNormalize_return
__if_2901_end:
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
__if_2942_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_2947
  mov R1, [BP+3]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_2947:
  jf R0, __if_2942_end
  mov R0, 0.000000
  jmp __function_b2Atan2_return
__if_2942_end:
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
__if_3078_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_3078_end
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
__if_3078_end:
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
__if_3163_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_3163_end
  mov R0, 1.000000
  mov R1, [BP-4]
  fdiv R0, R1
  mov [BP-5], R0
__if_3163_end:
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
  jf R0, __LogicalAnd_ShortCircuit_3206
  mov R1, [BP-1]
  flt R1, 1.000600
  and R0, R1
__LogicalAnd_ShortCircuit_3206:
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
__if_3298_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_3298_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_3298_end:
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
__if_3370_start:
  mov R0, [BP-5]
  fne R0, 0.000000
  jf R0, __if_3370_end
  mov R0, 1.000000
  mov R1, [BP-5]
  fdiv R0, R1
  mov [BP-5], R0
__if_3370_end:
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
  jf R0, __LogicalAnd_ShortCircuit_3427
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3427:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3438
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3438:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3449
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 2
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_3449:
  mov [BP-1], R0
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_3460
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
__LogicalAnd_ShortCircuit_3460:
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
__if_3576_start:
  mov R1, [BP+3]
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3576_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3576_end:
__if_3586_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3586_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3586_end:
__if_3596_start:
  mov R1, [BP+2]
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3596_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3596_end:
__if_3606_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  iadd R2, 1
  mov R1, [R2]
  fgt R0, R1
  jf R0, __if_3606_end
  mov R0, 0
  jmp __function_b2AABB_Overlaps_return
__if_3606_end:
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
__if_3677_start:
  mov R0, [BP+2]
  mov R1, [BP+2]
  fne R0, R1
  jf R0, __if_3677_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3677_end:
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
__if_3696_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fgt R0, R1
  jf R0, __if_3696_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3696_end:
__if_3702_start:
  mov R0, [BP+2]
  mov R1, [BP-1]
  fsgn R1
  flt R0, R1
  jf R0, __if_3702_end
  mov R0, 0
  jmp __function_b2IsValidFloat_return
__if_3702_end:
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
  jf R1, __LogicalAnd_ShortCircuit_3717
  mov R4, [BP+2]
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_b2IsValidFloat
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_3717:
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
__if_3723_start:
  mov R3, [BP+2]
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3723_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3723_end:
__if_3730_start:
  mov R3, [BP+2]
  iadd R3, 1
  mov R2, [R3]
  mov [SP], R2
  call __function_b2IsValidFloat
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_3730_end
  mov R0, 0
  jmp __function_b2IsValidRotation_return
__if_3730_end:
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
__if_4810_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_4815
  mov R1, [BP-8]
  mov R2, [BP-11]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_4815:
  jf R0, __if_4810_else
__if_4819_start:
  mov R0, [BP-7]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4819_else
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
  jmp __if_4819_end
__if_4819_else:
__if_4838_start:
  mov R0, [BP-8]
  mov R1, [BP-11]
  fge R0, R1
  jf R0, __if_4838_else
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
  jmp __if_4838_end
__if_4838_else:
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4838_end:
__if_4819_end:
  jmp __if_4810_end
__if_4810_else:
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
__if_4885_start:
  mov R0, [BP-13]
  fne R0, 0.000000
  jf R0, __if_4885_end
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
__if_4885_end:
  mov R0, [BP-12]
  mov R1, [BP-14]
  fmul R0, R1
  mov R1, [BP-10]
  fadd R0, R1
  mov R1, [BP-8]
  fdiv R0, R1
  mov [BP-15], R0
__if_4915_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jf R0, __if_4915_else
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
  jmp __if_4915_end
__if_4915_else:
__if_4932_start:
  mov R0, [BP-15]
  fgt R0, 1.000000
  jf R0, __if_4932_end
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
__if_4932_end:
__if_4915_end:
  mov R0, [BP-14]
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
  mov R0, [BP-15]
  mov R1, [BP+6]
  iadd R1, 5
  mov [R1], R0
__if_4810_end:
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
__for_4997_start:
  mov R0, [BP-1]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_4997_end
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
__for_4997_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_4997_start
__for_4997_end:
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
__if_5078_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_5078_end
  mov R0, [BP+2]
  jmp __function_b2SimplexVertexPtr_return
__if_5078_end:
__if_5086_start:
  mov R0, [BP+3]
  ieq R0, 1
  jf R0, __if_5086_end
  mov R0, [BP+2]
  iadd R0, 9
  jmp __function_b2SimplexVertexPtr_return
__if_5086_end:
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
__for_5189_start:
  mov R0, [BP-4]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_5189_end
  mov R1, [BP+2]
  mov R2, [BP-4]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-5], R0
__if_5208_start:
  mov R0, [BP-5]
  mov R1, [BP-3]
  fgt R0, R1
  jf R0, __if_5208_end
  mov R0, [BP-4]
  mov [BP-2], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_5208_end:
__for_5189_continue:
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
  jmp __for_5189_start
__for_5189_end:
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
__for_5231_start:
  mov R0, [BP-1]
  mov R2, [BP+5]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5231_end
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
__for_5231_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5231_start
__for_5231_end:
__if_5292_start:
  mov R1, [BP+5]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_5292_end
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
__if_5292_end:
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
__for_5351_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 27
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_5351_end
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
__for_5351_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_5351_start
__for_5351_end:
__function_b2MakeSimplexCache_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeWitnessPoints:
  push BP
  mov BP, SP
  isub SP, 7
__if_5385_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_5385_else
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
  jmp __if_5385_end
__if_5385_else:
__if_5403_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_5403_else
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
  jmp __if_5403_end
__if_5403_else:
__if_5441_start:
  mov R1, [BP+2]
  iadd R1, 27
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_5441_else
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
  jmp __if_5441_end
__if_5441_else:
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
__if_5441_end:
__if_5403_end:
__if_5385_end:
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
__if_5514_start:
  mov R0, [BP-7]
  fle R0, 0.000000
  jf R0, __if_5514_end
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
__if_5514_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-6]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-8], R0
__if_5540_start:
  mov R0, [BP-8]
  fle R0, 0.000000
  jf R0, __if_5540_end
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
__if_5540_end:
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
__if_5762_start:
  mov R0, [BP-12]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5767
  mov R1, [BP-18]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5767:
  jf R0, __if_5762_end
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
__if_5762_end:
__if_5785_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5790
  mov R1, [BP-12]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5790:
  jf R0, __LogicalAnd_ShortCircuit_5794
  mov R1, [BP-31]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5794:
  jf R0, __if_5785_end
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
__if_5785_end:
__if_5846_start:
  mov R0, [BP-17]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5851
  mov R1, [BP-18]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5851:
  jf R0, __LogicalAnd_ShortCircuit_5855
  mov R1, [BP-30]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5855:
  jf R0, __if_5846_end
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
__if_5846_end:
__if_5912_start:
  mov R0, [BP-11]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5917
  mov R1, [BP-24]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5917:
  jf R0, __if_5912_end
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
__if_5912_end:
__if_5940_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5945
  mov R1, [BP-23]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5945:
  jf R0, __if_5940_end
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
__if_5940_end:
__if_5968_start:
  mov R0, [BP-23]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_5973
  mov R1, [BP-24]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5973:
  jf R0, __LogicalAnd_ShortCircuit_5977
  mov R1, [BP-29]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_5977:
  jf R0, __if_5968_end
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
__if_5968_end:
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
__for_6100_start:
  mov R0, [BP-61]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_6100_end
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
__for_6100_continue:
  mov R0, [BP-61]
  mov R1, R0
  iadd R1, 1
  mov [BP-61], R1
  jmp __for_6100_start
__for_6100_end:
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
__while_6160_start:
__while_6160_continue:
  mov R0, [BP-58]
  mov R1, [BP-57]
  ilt R0, R1
  jf R0, __while_6160_end
  mov R0, [BP-20]
  mov [BP-61], R0
  mov R0, 0
  mov [BP-68], R0
__for_6169_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6169_end
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
__for_6169_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6169_start
__for_6169_end:
  mov R0, 0.000000
  mov [BP-63], R0
  mov R0, 0.000000
  mov [BP-62], R0
__if_6207_start:
  mov R0, [BP-20]
  ieq R0, 1
  jf R0, __if_6207_else
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2Neg
  jmp __if_6207_end
__if_6207_else:
__if_6219_start:
  mov R0, [BP-20]
  ieq R0, 2
  jf R0, __if_6219_else
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex2
  jmp __if_6219_end
__if_6219_else:
__if_6229_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6229_end
  lea R1, [BP-47]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_b2SolveSimplex3
__if_6229_end:
__if_6219_end:
__if_6207_end:
__if_6239_start:
  mov R0, [BP-20]
  ieq R0, 3
  jf R0, __if_6239_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6239_end:
__if_6255_start:
  lea R2, [BP-63]
  mov [SP], R2
  lea R2, [BP-63]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-56]
  flt R1, R2
  mov R0, R1
  jf R0, __if_6255_end
  lea R1, [BP-47]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP+2], R1
  call __function_b2ComputeWitnessPoints
  jmp __function_b2ShapeDistance_return
__if_6255_end:
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
__for_6337_start:
  mov R0, [BP-68]
  mov R1, [BP-61]
  ilt R0, R1
  jf R0, __for_6337_end
__if_6347_start:
  mov R1, [BP-64]
  iadd R1, 7
  mov R0, [R1]
  lea R1, [BP-52]
  mov R2, [BP-68]
  iadd R1, R2
  mov R1, [R1]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_6356
  mov R2, [BP-64]
  iadd R2, 8
  mov R1, [R2]
  lea R2, [BP-55]
  mov R3, [BP-68]
  iadd R2, R3
  mov R2, [R2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6356:
  jf R0, __if_6347_end
  mov R0, 1
  mov [BP-67], R0
  jmp __for_6337_end
__if_6347_end:
__for_6337_continue:
  mov R0, [BP-68]
  mov R1, R0
  iadd R1, 1
  mov [BP-68], R1
  jmp __for_6337_start
__for_6337_end:
__if_6366_start:
  mov R0, [BP-67]
  jf R0, __if_6366_end
  jmp __while_6160_end
__if_6366_end:
  mov R0, [BP-20]
  iadd R0, 1
  mov [BP-20], R0
  jmp __while_6160_start
__while_6160_end:
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
__if_6415_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  jf R0, __if_6415_end
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
__if_6415_end:
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
__for_6601_start:
  mov R0, [BP-56]
  ilt R0, 20
  jf R0, __for_6601_end
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
__if_6627_start:
  mov R0, [BP-59]
  mov R1, [BP-3]
  mov R2, [BP-4]
  fadd R1, R2
  flt R0, R1
  jf R0, __if_6627_end
__if_6635_start:
  mov R0, [BP-56]
  ieq R0, 0
  jf R0, __if_6635_else
__if_6640_start:
  mov R1, [BP+2]
  iadd R1, 43
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_6643
  mov R1, [BP-59]
  mov R2, [BP-1]
  fmul R2, 2.000000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_6643:
  jf R0, __if_6640_else
  mov R0, [BP-59]
  mov R1, [BP-1]
  fsub R0, R1
  mov [BP-3], R0
  jmp __if_6640_end
__if_6640_else:
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
__if_6640_end:
  jmp __if_6635_end
__if_6635_else:
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
__if_6635_end:
__if_6627_end:
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-61]
  mov [SP+1], R1
  call __function_b2Dot
  mov [BP-66], R0
__if_6737_start:
  mov R0, [BP-66]
  fge R0, 0.000000
  jf R0, __if_6737_end
  jmp __function_b2ShapeCast_return
__if_6737_end:
  mov R0, [BP-12]
  mov R1, [BP-3]
  mov R2, [BP-59]
  fsub R1, R2
  mov R2, [BP-66]
  fdiv R1, R2
  fadd R0, R1
  mov [BP-12], R0
__if_6753_start:
  mov R0, [BP-12]
  mov R2, [BP+2]
  iadd R2, 42
  mov R1, [R2]
  fge R0, R1
  jf R0, __if_6753_end
  jmp __function_b2ShapeCast_return
__if_6753_end:
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
__for_6601_continue:
  mov R0, [BP-56]
  iadd R0, 1
  mov [BP-56], R0
  jmp __for_6601_start
__for_6601_end:
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
__if_6929_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_6929_end
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
__if_6929_end:
__if_6994_start:
  mov R0, [BP+2]
  iadd R0, 1
  mov R0, [R0]
  mov R1, [BP+2]
  iadd R1, 1
  iadd R1, 1
  mov R1, [R1]
  ieq R0, R1
  jf R0, __if_6994_end
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
__if_7122_start:
  lea R2, [BP-45]
  mov [SP], R2
  lea R2, [BP-37]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7122_end
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
__if_7122_end:
  jmp __function_b2MakeSeparationFunction_return
__if_6994_end:
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
__if_7261_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-19]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_7261_end
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
__if_7261_end:
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
__if_7305_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7305_else
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
  jmp __if_7305_end
__if_7305_else:
__if_7406_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7406_else
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
  jmp __if_7406_end
__if_7406_else:
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
__if_7406_end:
__if_7305_end:
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
__if_7602_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_7602_else
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
  jmp __if_7602_end
__if_7602_else:
__if_7656_start:
  mov R1, [BP+2]
  iadd R1, 26
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_7656_else
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
  jmp __if_7656_end
__if_7656_else:
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
__if_7656_end:
__if_7602_end:
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
__while_7871_start:
__while_7871_continue:
  mov R0, [BP-78]
  jf R0, __while_7871_end
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
__if_7943_start:
  mov R0, [BP-89]
  fle R0, 0.000000
  jf R0, __if_7943_end
  mov R0, 2
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  jmp __function_b2TimeOfImpact_return
__if_7943_end:
__if_7958_start:
  mov R0, [BP-89]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_7958_end
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
__if_7958_end:
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
__while_8037_start:
__while_8037_continue:
  mov R0, [BP-132]
  jf R0, __while_8037_end
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
__if_8054_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_8054_end
  mov R0, 4
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-23]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8037_end
__if_8054_end:
__if_8073_start:
  mov R0, [BP-135]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  fgt R0, R1
  jf R0, __if_8073_end
  mov R0, [BP-130]
  mov [BP-27], R0
  jmp __while_8037_end
__if_8073_end:
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
__if_8092_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fsub R1, R2
  flt R0, R1
  jf R0, __if_8092_end
  mov R0, 1
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP-27]
  mov R1, [BP+3]
  iadd R1, 5
  mov [R1], R0
  mov R0, 1
  mov [BP-129], R0
  jmp __while_8037_end
__if_8092_end:
__if_8111_start:
  mov R0, [BP-136]
  mov R1, [BP-25]
  mov R2, [BP-26]
  fadd R1, R2
  fle R0, R1
  jf R0, __if_8111_end
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
  jmp __while_8037_end
__if_8111_end:
  mov R0, 0
  mov [BP-137], R0
  mov R0, [BP-27]
  mov [BP-138], R0
  mov R0, [BP-130]
  mov [BP-139], R0
  mov R0, 1
  mov [BP-140], R0
__while_8178_start:
__while_8178_continue:
  mov R0, [BP-140]
  jf R0, __while_8178_end
__if_8183_start:
  mov R0, [BP-137]
  and R0, 1
  ine R0, 0
  jf R0, __if_8183_else
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
  jmp __if_8183_end
__if_8183_else:
  mov R0, [BP-138]
  mov R1, [BP-139]
  fadd R0, R1
  fmul R0, 0.500000
  mov [BP-141], R0
__if_8183_end:
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
__if_8229_start:
  mov R2, [BP-142]
  mov R3, [BP-25]
  fsub R2, R3
  mov [SP], R2
  call __function_b2AbsFloat
  mov R1, R0
  mov R2, [BP-26]
  flt R1, R2
  mov R0, R1
  jf R0, __if_8229_end
  mov R0, [BP-141]
  mov [BP-130], R0
  jmp __while_8178_end
__if_8229_end:
__if_8241_start:
  mov R0, [BP-142]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_8241_else
  mov R0, [BP-141]
  mov [BP-138], R0
  mov R0, [BP-142]
  mov [BP-136], R0
  jmp __if_8241_end
__if_8241_else:
  mov R0, [BP-141]
  mov [BP-139], R0
  mov R0, [BP-142]
  mov [BP-135], R0
__if_8241_end:
__if_8259_start:
  mov R0, [BP-137]
  ieq R0, 50
  jf R0, __if_8259_end
  jmp __while_8178_end
__if_8259_end:
  jmp __while_8178_start
__while_8178_end:
  mov R0, [BP-131]
  iadd R0, 1
  mov [BP-131], R0
__if_8269_start:
  mov R0, [BP-131]
  ieq R0, 8
  jf R0, __if_8269_end
  jmp __while_8037_end
__if_8269_end:
  jmp __while_8037_start
__while_8037_end:
__if_8274_start:
  mov R0, [BP-129]
  jf R0, __if_8274_end
  jmp __while_7871_end
__if_8274_end:
__if_8277_start:
  mov R0, [BP-29]
  mov R1, [BP-28]
  ieq R0, R1
  jf R0, __if_8277_end
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
  jmp __while_7871_end
__if_8277_end:
  jmp __while_7871_start
__while_7871_end:
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
__for_8711_start:
  mov R0, [BP-8]
  mov R1, [BP+3]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_8711_end
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
__for_8711_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_8711_start
__for_8711_end:
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

__function_b2MakePolygon:
  push BP
  mov BP, SP
  isub SP, 9
__if_8801_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_8801_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakePolygon_return
__if_8801_end:
  mov R1, [BP+4]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 36
  mov [SP+2], R1
  call __function_memset
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  mov R1, [BP+4]
  iadd R1, 35
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+4]
  iadd R1, 34
  mov [R1], R0
  mov R0, 0
  mov [BP-1], R0
__for_8824_start:
  mov R0, [BP-1]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8824_end
  mov R13, [BP+4]
  mov R1, [BP-1]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+2]
  mov R1, [BP-1]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
__for_8824_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_8824_start
__for_8824_end:
  mov R0, 0
  mov [BP-1], R0
__for_8843_start:
  mov R0, [BP-1]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8843_end
  mov R0, 0
  mov [BP-2], R0
__if_8857_start:
  mov R0, [BP-1]
  iadd R0, 1
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_8857_end
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-2], R0
__if_8857_end:
  mov R1, [BP+4]
  mov R2, [BP-2]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  mov R1, [BP+4]
  mov R2, [BP-1]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, 1.000000
  mov [SP+1], R1
  lea R1, [BP-6]
  mov [SP+2], R1
  call __function_b2CrossVS
  lea R1, [BP-6]
  mov [SP], R1
  mov R1, [BP+4]
  iadd R1, 16
  mov R2, [BP-1]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2Normalize
__for_8843_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_8843_start
__for_8843_end:
  mov R1, [BP+4]
  mov [SP], R1
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP+4]
  iadd R1, 32
  mov [SP+2], R1
  call __function_b2ComputePolygonCentroid
__function_b2MakePolygon_return:
  mov SP, BP
  pop BP
  ret

__function_b2MakeOffsetRoundedPolygon:
  push BP
  mov BP, SP
  isub SP, 13
__if_8914_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_8914_end
  mov R1, 0.500000
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2MakeSquare
  jmp __function_b2MakeOffsetRoundedPolygon_return
__if_8914_end:
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
__for_8949_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8949_end
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
__for_8949_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8949_start
__for_8949_end:
  mov R0, 0
  mov [BP-5], R0
__for_8972_start:
  mov R0, [BP-5]
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_8972_end
  mov R0, 0
  mov [BP-6], R0
__if_8986_start:
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+6]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_8986_end
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-6], R0
__if_8986_end:
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
__for_8972_continue:
  mov R0, [BP-5]
  mov R1, R0
  iadd R1, 1
  mov [BP-5], R1
  jmp __for_8972_start
__for_8972_end:
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
__for_9056_start:
  mov R0, [BP-3]
  mov R2, [BP+4]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9056_end
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
__for_9056_continue:
  mov R0, [BP-3]
  mov R1, R0
  iadd R1, 1
  mov [BP-3], R1
  jmp __for_9056_start
__for_9056_end:
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
__if_9288_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_9288_end
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
__if_9288_end:
__if_9314_start:
  mov R1, [BP+2]
  iadd R1, 35
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_9314_end
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
__if_9314_end:
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
__if_9363_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_9363_else
  mov R0, 1.412000
  mov [BP-27], R0
  mov R0, 0
  mov [BP-28], R0
__for_9371_start:
  mov R0, [BP-28]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9371_end
  mov R0, [BP-28]
  isub R0, 1
  mov [BP-29], R0
__if_9386_start:
  mov R0, [BP-28]
  ieq R0, 0
  jf R0, __if_9386_end
  mov R0, [BP-17]
  isub R0, 1
  mov [BP-29], R0
__if_9386_end:
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
__for_9371_continue:
  mov R0, [BP-28]
  mov R1, R0
  iadd R1, 1
  mov [BP-28], R1
  jmp __for_9371_start
__for_9371_end:
  jmp __if_9363_end
__if_9363_else:
  mov R0, 0
  mov [BP-27], R0
__for_9439_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  ilt R0, R1
  jf R0, __for_9439_end
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
__for_9439_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9439_start
__for_9439_end:
__if_9363_end:
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
__for_9482_start:
  mov R0, [BP-27]
  mov R1, [BP-17]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_9482_end
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
__for_9482_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_9482_start
__for_9482_end:
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
__for_9816_start:
  mov R0, [BP-8]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_9816_end
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
__for_9816_continue:
  mov R0, [BP-8]
  mov R1, R0
  iadd R1, 1
  mov [BP-8], R1
  jmp __for_9816_start
__for_9816_end:
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
__if_10054_start:
  mov R0, [BP-8]
  feq R0, 0.000000
  jf R0, __if_10054_end
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
__if_10054_end:
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
__if_10165_start:
  mov R0, [BP-7]
  feq R0, 0.000000
  jf R0, __if_10165_end
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
__if_10165_end:
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
__if_10212_start:
  mov R0, [BP-13]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __if_10212_end
  jmp __function_b2RayCastCircle_return
__if_10212_end:
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
__if_10228_start:
  mov R0, [BP-15]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10234
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-7]
  fmul R1, R2
  mov R2, [BP-15]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10234:
  jf R0, __if_10228_end
__if_10240_start:
  lea R2, [BP-4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-6]
  flt R1, R2
  mov R0, R1
  jf R0, __if_10240_end
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_10240_end:
  jmp __function_b2RayCastCircle_return
__if_10228_end:
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
__if_10346_start:
  mov R0, [BP-7]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  flt R0, R1
  jf R0, __if_10346_end
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
__if_10346_end:
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
__if_10410_start:
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
  jf R0, __if_10410_end
__if_10421_start:
  mov R0, [BP-16]
  flt R0, 0.000000
  jf R0, __if_10421_end
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
__if_10421_end:
__if_10443_start:
  mov R0, [BP-16]
  mov R1, [BP-7]
  fgt R0, R1
  jf R0, __if_10443_end
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
__if_10443_end:
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
__if_10410_end:
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
__if_10513_start:
  mov R0, 1.000000
  mov R1, [global_b2_two_pow_23]
  fdiv R0, R1
  fsgn R0
  mov R1, [BP-25]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_10522
  mov R1, [BP-25]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_10522:
  jf R0, __if_10513_end
  jmp __function_b2RayCastCapsule_return
__if_10513_end:
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
__if_10590_start:
  mov R0, [BP-31]
  mov R1, [BP-32]
  flt R0, R1
  jf R0, __if_10590_else
  mov R0, [BP-31]
  mov [BP-33], R0
  lea R13, [BP-35]
  lea R12, [BP-27]
  mov CR, 2
  movs
  jmp __if_10590_end
__if_10590_else:
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
__if_10590_end:
__if_10613_start:
  mov R0, [BP-33]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10619
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-22]
  fmul R1, R2
  mov R2, [BP-33]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10619:
  jf R0, __if_10613_end
  jmp __function_b2RayCastCapsule_return
__if_10613_end:
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
__if_10642_start:
  mov R0, [BP-36]
  flt R0, 0.000000
  jf R0, __if_10642_else
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
  jmp __if_10642_end
__if_10642_else:
__if_10664_start:
  mov R0, [BP-7]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __if_10664_else
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
  jmp __if_10664_end
__if_10664_else:
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
__if_10664_end:
__if_10642_end:
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
__if_10755_start:
  mov R0, [BP+4]
  jf R0, __if_10755_end
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
__if_10780_start:
  lea R2, [BP-27]
  mov [SP], R2
  lea R2, [BP-29]
  mov [SP+1], R2
  call __function_b2Cross
  mov R1, R0
  flt R1, 0.000000
  mov R0, R1
  jf R0, __if_10780_end
  jmp __function_b2RayCastSegment_return
__if_10780_end:
__if_10755_end:
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
__if_10825_start:
  mov R0, [BP-11]
  feq R0, 0.000000
  jf R0, __if_10825_end
  jmp __function_b2RayCastSegment_return
__if_10825_end:
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
__if_10860_start:
  mov R0, [BP-19]
  feq R0, 0.000000
  jf R0, __if_10860_end
  jmp __function_b2RayCastSegment_return
__if_10860_end:
  mov R0, [BP-18]
  mov R1, [BP-19]
  fdiv R0, R1
  mov [BP-20], R0
__if_10870_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10876
  mov R2, [BP+3]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-20]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10876:
  jf R0, __if_10870_end
  jmp __function_b2RayCastSegment_return
__if_10870_end:
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
__if_10906_start:
  mov R0, [BP-25]
  flt R0, 0.000000
  jt R0, __LogicalOr_ShortCircuit_10911
  mov R1, [BP-11]
  mov R2, [BP-25]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_10911:
  jf R0, __if_10906_end
  jmp __function_b2RayCastSegment_return
__if_10906_end:
__if_10915_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_10915_end
  lea R1, [BP-15]
  mov [SP], R1
  lea R1, [BP-15]
  mov [SP+1], R1
  call __function_b2Neg
__if_10915_end:
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
__if_10964_start:
  mov R1, [BP+2]
  iadd R1, 34
  mov R0, [R1]
  fne R0, 0.000000
  jf R0, __if_10964_end
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
__if_10964_end:
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
__for_11047_start:
  mov R0, [BP-10]
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_11047_end
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
__if_11102_start:
  mov R0, [BP-20]
  feq R0, 0.000000
  jf R0, __if_11102_else
__if_11107_start:
  mov R0, [BP-19]
  flt R0, 0.000000
  jf R0, __if_11107_end
  jmp __function_b2RayCastPolygon_return
__if_11107_end:
  jmp __if_11102_end
__if_11102_else:
__if_11113_start:
  mov R0, [BP-20]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11118
  mov R1, [BP-19]
  mov R2, [BP-7]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11118:
  jf R0, __if_11113_else
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-7], R0
  mov R0, [BP-10]
  mov [BP-9], R0
  jmp __if_11113_end
__if_11113_else:
__if_11132_start:
  mov R0, [BP-20]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_11137
  mov R1, [BP-19]
  mov R2, [BP-8]
  mov R3, [BP-20]
  fmul R2, R3
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_11137:
  jf R0, __if_11132_end
  mov R0, [BP-19]
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-8], R0
__if_11132_end:
__if_11113_end:
__if_11102_end:
__if_11148_start:
  mov R0, [BP-8]
  mov R1, [BP-7]
  flt R0, R1
  jf R0, __if_11148_end
  jmp __function_b2RayCastPolygon_return
__if_11148_end:
__for_11047_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_11047_start
__for_11047_end:
__if_11153_start:
  mov R0, [BP-9]
  ige R0, 0
  jf R0, __if_11153_else
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
  jmp __if_11153_end
__if_11153_else:
  mov R13, [BP+4]
  iadd R13, 2
  mov R12, [BP+3]
  mov CR, 2
  movs
  mov R0, 1
  mov R1, [BP+4]
  iadd R1, 6
  mov [R1], R0
__if_11153_end:
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
__if_11441_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11441_end
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
__if_11441_end:
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
__if_11543_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11543_end
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
__if_11543_end:
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
__if_11646_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11646_end
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
__if_11646_end:
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
__if_11745_start:
  mov R0, [BP-52]
  mov R1, [BP-42]
  fle R0, R1
  jf R0, __if_11745_end
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
__if_11745_end:
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
__if_11790_start:
  mov R0, [BP+5]
  ieq R0, 0
  jf R0, __if_11790_end
  jmp __function_b2RecurseHull_return
__if_11790_end:
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
__if_11835_start:
  mov R0, [BP-25]
  fgt R0, 0.000000
  jf R0, __if_11835_end
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
__if_11835_end:
  mov R0, 1
  mov [BP-62], R0
__for_11849_start:
  mov R0, [BP-62]
  mov R1, [BP+5]
  ilt R0, R1
  jf R0, __for_11849_end
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
__if_11874_start:
  mov R0, [BP-63]
  mov R1, [BP-25]
  fgt R0, R1
  jf R0, __if_11874_end
  mov R0, [BP-62]
  mov [BP-22], R0
  mov R0, [BP-63]
  mov [BP-25], R0
__if_11874_end:
__if_11885_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_11885_end
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
__if_11885_end:
__for_11849_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11849_start
__for_11849_end:
__if_11899_start:
  mov R1, [BP-25]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 2.000000
  flt R1, R2
  mov R0, R1
  jf R0, __if_11899_end
  jmp __function_b2RecurseHull_return
__if_11899_end:
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
__for_11934_start:
  mov R0, [BP-62]
  mov R1, [BP-28]
  ilt R0, R1
  jf R0, __for_11934_end
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
__for_11934_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11934_start
__for_11934_end:
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
__for_11968_start:
  mov R0, [BP-62]
  mov R1, [BP-45]
  ilt R0, R1
  jf R0, __for_11968_end
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
__for_11968_continue:
  mov R0, [BP-62]
  mov R1, R0
  iadd R1, 1
  mov [BP-62], R1
  jmp __for_11968_start
__for_11968_end:
__function_b2RecurseHull_return:
  mov SP, BP
  pop BP
  ret

__function_b2ComputeHull:
  push BP
  mov BP, SP
  isub SP, 129
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 16
  mov [R1], R0
__if_12000_start:
  mov R0, [BP+3]
  ilt R0, 3
  jt R0, __LogicalOr_ShortCircuit_12005
  mov R1, [BP+3]
  igt R1, 8
  or R0, R1
__LogicalOr_ShortCircuit_12005:
  jf R0, __if_12000_end
  jmp __function_b2ComputeHull_return
__if_12000_end:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, 8
  mov [SP+1], R2
  call __function_b2MinInt
  mov R1, R0
  mov [BP+3], R1
  mov R0, R1
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-4], R0
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-3], R0
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-2], R0
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-1], R0
  mov R0, 0
  mov [BP-21], R0
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  mov R0, R1
  mov [BP-22], R0
  mov R0, [BP-22]
  fmul R0, 16.000000
  mov R1, [BP-22]
  fmul R0, R1
  mov [BP-23], R0
  mov R0, 0
  mov [BP-107], R0
__for_12069_start:
  mov R0, [BP-107]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __for_12069_end
  lea R1, [BP-4]
  mov [SP], R1
  mov R1, [BP+2]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2Min
  lea R1, [BP-2]
  mov [SP], R1
  mov R1, [BP+2]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  lea R1, [BP-2]
  mov [SP+2], R1
  call __function_b2Max
  mov R12, [BP+2]
  mov R1, [BP-107]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-109]
  mov CR, 2
  movs
  mov R0, 1
  mov [BP-110], R0
  mov R0, 0
  mov [BP-111], R0
__for_12109_start:
  mov R0, [BP-111]
  mov R1, [BP-107]
  ilt R0, R1
  jf R0, __for_12109_end
  mov R12, [BP+2]
  mov R1, [BP-111]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-113]
  mov CR, 2
  movs
  lea R1, [BP-109]
  mov [SP], R1
  lea R1, [BP-113]
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-114], R0
__if_12131_start:
  mov R0, [BP-114]
  mov R1, [BP-23]
  flt R0, R1
  jf R0, __if_12131_end
  mov R0, 0
  mov [BP-110], R0
  jmp __for_12109_end
__if_12131_end:
__for_12109_continue:
  mov R0, [BP-111]
  mov R1, R0
  iadd R1, 1
  mov [BP-111], R1
  jmp __for_12109_start
__for_12109_end:
__if_12140_start:
  mov R0, [BP-110]
  jf R0, __if_12140_end
  lea R13, [BP-20]
  mov R1, [BP-21]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-109]
  mov CR, 2
  movs
  mov R0, [BP-21]
  mov R1, R0
  iadd R1, 1
  mov [BP-21], R1
__if_12140_end:
__for_12069_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12069_start
__for_12069_end:
__if_12150_start:
  mov R0, [BP-21]
  ilt R0, 3
  jf R0, __if_12150_end
  jmp __function_b2ComputeHull_return
__if_12150_end:
  lea R1, [BP-4]
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  call __function_b2AABB_Center
  mov R0, 0
  mov [BP-26], R0
  lea R1, [BP-25]
  mov [SP], R1
  lea R1, [BP-20]
  mov R2, [BP-26]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-27], R0
  mov R0, 1
  mov [BP-107], R0
__for_12174_start:
  mov R0, [BP-107]
  mov R1, [BP-21]
  ilt R0, R1
  jf R0, __for_12174_end
  lea R1, [BP-25]
  mov [SP], R1
  lea R1, [BP-20]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-108], R0
__if_12193_start:
  mov R0, [BP-108]
  mov R1, [BP-27]
  fgt R0, R1
  jf R0, __if_12193_end
  mov R0, [BP-107]
  mov [BP-26], R0
  mov R0, [BP-108]
  mov [BP-27], R0
__if_12193_end:
__for_12174_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12174_start
__for_12174_end:
  lea R12, [BP-20]
  mov R1, [BP-26]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-29]
  mov CR, 2
  movs
  lea R13, [BP-20]
  mov R1, [BP-26]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-20]
  mov R1, [BP-21]
  isub R1, 1
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-21]
  isub R0, 1
  mov [BP-21], R0
  mov R0, 0
  mov [BP-30], R0
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-20]
  mov R2, [BP-30]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-31], R0
  mov R0, 1
  mov [BP-107], R0
__for_12235_start:
  mov R0, [BP-107]
  mov R1, [BP-21]
  ilt R0, R1
  jf R0, __for_12235_end
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-20]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [SP+1], R1
  call __function_b2DistanceSquared
  mov [BP-108], R0
__if_12254_start:
  mov R0, [BP-108]
  mov R1, [BP-31]
  fgt R0, R1
  jf R0, __if_12254_end
  mov R0, [BP-107]
  mov [BP-30], R0
  mov R0, [BP-108]
  mov [BP-31], R0
__if_12254_end:
__for_12235_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12235_start
__for_12235_end:
  lea R12, [BP-20]
  mov R1, [BP-30]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-33]
  mov CR, 2
  movs
  lea R13, [BP-20]
  mov R1, [BP-30]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-20]
  mov R1, [BP-21]
  isub R1, 1
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-21]
  isub R0, 1
  mov [BP-21], R0
  mov R0, 0
  mov [BP-50], R0
  mov R0, 0
  mov [BP-67], R0
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-69]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-69]
  mov [SP], R1
  lea R1, [BP-71]
  mov [SP+1], R1
  call __function_b2Normalize
  mov R0, 0
  mov [BP-107], R0
__for_12312_start:
  mov R0, [BP-107]
  mov R1, [BP-21]
  ilt R0, R1
  jf R0, __for_12312_end
  lea R1, [BP-20]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-109]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-109]
  mov [SP], R1
  lea R1, [BP-71]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-110], R0
__if_12340_start:
  mov R0, [BP-110]
  mov R1, [BP-22]
  fmul R1, 2.000000
  fge R0, R1
  jf R0, __if_12340_else
  lea R13, [BP-49]
  mov R1, [BP-50]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-20]
  mov R1, [BP-107]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-50]
  mov R1, R0
  iadd R1, 1
  mov [BP-50], R1
  jmp __if_12340_end
__if_12340_else:
__if_12356_start:
  mov R0, [BP-110]
  mov R1, [BP-22]
  fmul R1, -2.000000
  fle R0, R1
  jf R0, __if_12356_end
  lea R13, [BP-66]
  mov R1, [BP-67]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-20]
  mov R1, [BP-107]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R0, [BP-67]
  mov R1, R0
  iadd R1, 1
  mov [BP-67], R1
__if_12356_end:
__if_12340_end:
__for_12312_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12312_start
__for_12312_end:
  lea R1, [BP-29]
  mov [SP], R1
  lea R1, [BP-33]
  mov [SP+1], R1
  lea R1, [BP-49]
  mov [SP+2], R1
  mov R1, [BP-50]
  mov [SP+3], R1
  lea R1, [BP-88]
  mov [SP+4], R1
  call __function_b2RecurseHull
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-29]
  mov [SP+1], R1
  lea R1, [BP-66]
  mov [SP+2], R1
  mov R1, [BP-67]
  mov [SP+3], R1
  lea R1, [BP-105]
  mov [SP+4], R1
  call __function_b2RecurseHull
__if_12395_start:
  mov R0, [BP-72]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_12402
  mov R1, [BP-89]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_12402:
  jf R0, __if_12395_end
  jmp __function_b2ComputeHull_return
__if_12395_end:
  mov R13, [BP+4]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-29]
  mov CR, 2
  movs
  mov R2, [BP+4]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, 0
  mov [BP-107], R0
__for_12416_start:
  mov R0, [BP-107]
  mov R1, [BP-72]
  ilt R0, R1
  jf R0, __for_12416_end
  mov R13, [BP+4]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-88]
  mov R1, [BP-107]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R2, [BP+4]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_12416_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12416_start
__for_12416_end:
  mov R13, [BP+4]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-33]
  mov CR, 2
  movs
  mov R2, [BP+4]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
  mov R0, 0
  mov [BP-107], R0
__for_12450_start:
  mov R0, [BP-107]
  mov R1, [BP-89]
  ilt R0, R1
  jf R0, __for_12450_end
  mov R13, [BP+4]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imul R1, 2
  iadd R13, R1
  lea R12, [BP-105]
  mov R1, [BP-107]
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
  mov R2, [BP+4]
  iadd R2, 16
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_12450_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12450_start
__for_12450_end:
  mov R0, 1
  mov [BP-106], R0
__while_12477_start:
__while_12477_continue:
  mov R0, [BP-106]
  jf R0, __LogicalAnd_ShortCircuit_12479
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  igt R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_12479:
  jf R0, __while_12477_end
  mov R0, 0
  mov [BP-106], R0
  mov R0, 0
  mov [BP-107], R0
__for_12488_start:
  mov R0, [BP-107]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_12488_end
  mov R0, [BP-107]
  mov [BP-108], R0
  mov R0, [BP-107]
  iadd R0, 1
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imod R0, R1
  mov [BP-109], R0
  mov R0, [BP-107]
  iadd R0, 2
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  imod R0, R1
  mov [BP-110], R0
  mov R12, [BP+4]
  mov R1, [BP-108]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-112]
  mov CR, 2
  movs
  mov R12, [BP+4]
  mov R1, [BP-109]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-114]
  mov CR, 2
  movs
  mov R12, [BP+4]
  mov R1, [BP-110]
  imul R1, 2
  iadd R12, R1
  lea DR, [BP-116]
  mov CR, 2
  movs
  lea R1, [BP-116]
  mov [SP], R1
  lea R1, [BP-112]
  mov [SP+1], R1
  lea R1, [BP-118]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-118]
  mov [SP], R1
  lea R1, [BP-120]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R1, [BP-114]
  mov [SP], R1
  lea R1, [BP-112]
  mov [SP+1], R1
  lea R1, [BP-122]
  mov [SP+2], R1
  call __function_b2Sub
  lea R1, [BP-122]
  mov [SP], R1
  lea R1, [BP-120]
  mov [SP+1], R1
  call __function_b2Cross
  mov [BP-123], R0
__if_12570_start:
  mov R0, [BP-123]
  mov R1, [BP-22]
  fmul R1, 2.000000
  fle R0, R1
  jf R0, __if_12570_end
  mov R0, [BP-109]
  mov [BP-124], R0
__for_12577_start:
  mov R0, [BP-124]
  mov R2, [BP+4]
  iadd R2, 16
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_12577_end
  mov R13, [BP+4]
  mov R1, [BP-124]
  imul R1, 2
  iadd R13, R1
  mov R12, [BP+4]
  mov R1, [BP-124]
  iadd R1, 1
  imul R1, 2
  iadd R12, R1
  mov CR, 2
  movs
__for_12577_continue:
  mov R0, [BP-124]
  mov R1, R0
  iadd R1, 1
  mov [BP-124], R1
  jmp __for_12577_start
__for_12577_end:
  mov R1, [BP+4]
  iadd R1, 16
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP+4]
  iadd R1, 16
  mov [R1], R0
  mov R0, 1
  mov [BP-106], R0
  jmp __for_12488_end
__if_12570_end:
__for_12488_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_12488_start
__for_12488_end:
  jmp __while_12477_start
__while_12477_end:
__if_12608_start:
  mov R1, [BP+4]
  iadd R1, 16
  mov R0, [R1]
  ilt R0, 3
  jf R0, __if_12608_end
  mov R0, 0
  mov R1, [BP+4]
  iadd R1, 16
  mov [R1], R0
__if_12608_end:
__function_b2ComputeHull_return:
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
__if_12883_start:
  mov R1, [BP-12]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_12883_end
  jmp __function_b2CollideCircles_return
__if_12883_end:
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
__if_13016_start:
  mov R0, [BP-11]
  flt R0, 0.000000
  jf R0, __if_13016_else
  lea R13, [BP-16]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_13016_end
__if_13016_else:
__if_13024_start:
  mov R0, [BP-14]
  flt R0, 0.000000
  jf R0, __if_13024_else
  lea R13, [BP-16]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_13024_end
__if_13024_else:
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
__if_13024_end:
__if_13016_end:
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
__if_13085_start:
  mov R1, [BP-24]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_13085_end
  jmp __function_b2CollideCapsuleAndCircle_return
__if_13085_end:
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
__for_13205_start:
  mov R0, [BP-10]
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __for_13205_end
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
__if_13237_start:
  mov R0, [BP-29]
  mov R1, [BP-8]
  fgt R0, R1
  jf R0, __if_13237_end
  mov R0, [BP-29]
  mov [BP-8], R0
  mov R0, [BP-10]
  mov [BP-7], R0
__if_13237_end:
__for_13205_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_13205_start
__for_13205_end:
__if_13248_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13248_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13248_end:
  mov R0, [BP-7]
  mov [BP-11], R0
__if_13260_start:
  mov R0, [BP-11]
  iadd R0, 1
  mov R1, [BP-9]
  ilt R0, R1
  jf R0, __if_13260_else
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-12], R0
  jmp __if_13260_end
__if_13260_else:
  mov R0, 0
  mov [BP-12], R0
__if_13260_end:
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
__if_13336_start:
  mov R0, [BP-21]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13341
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13341:
  jf R0, __if_13336_else
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
__if_13371_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13371_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13371_end:
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
  jmp __if_13336_end
__if_13336_else:
__if_13443_start:
  mov R0, [BP-26]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_13448
  mov R1, [BP-8]
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_13448:
  jf R0, __if_13443_else
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
__if_13478_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  mov R2, [BP-1]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_13478_end
  jmp __function_b2CollidePolygonAndCircle_return
__if_13478_end:
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
  jmp __if_13443_end
__if_13443_else:
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
__if_13443_end:
__if_13336_end:
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
__if_13776_start:
  mov R0, [BP-27]
  fne R0, 0.000000
  jf R0, __if_13776_end
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
__if_13776_end:
  mov R0, [BP-26]
  mov R1, [BP-28]
  fmul R0, R1
  mov R1, [BP-25]
  fadd R0, R1
  mov R1, [BP-20]
  fdiv R0, R1
  mov [BP-29], R0
__if_13805_start:
  mov R0, [BP-29]
  flt R0, 0.000000
  jf R0, __if_13805_else
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
  jmp __if_13805_end
__if_13805_else:
__if_13822_start:
  mov R0, [BP-29]
  fgt R0, 1.000000
  jf R0, __if_13822_end
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
__if_13822_end:
__if_13805_end:
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
__if_13892_start:
  mov R0, [BP-34]
  mov R1, [BP-38]
  mov R2, [BP-38]
  fmul R1, R2
  fgt R0, R1
  jf R0, __if_13892_end
  jmp __function_b2CollideCapsules_return
__if_13892_end:
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
  jf R0, __LogicalAnd_ShortCircuit_13961
  mov R1, [BP-49]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_13961:
  jt R0, __LogicalOr_ShortCircuit_13964
  mov R1, [BP-48]
  mov R2, [BP-40]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_13970
  mov R2, [BP-49]
  mov R3, [BP-40]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_13970:
  or R0, R1
__LogicalOr_ShortCircuit_13964:
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
  jf R0, __LogicalAnd_ShortCircuit_14008
  mov R1, [BP-52]
  fle R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14008:
  jt R0, __LogicalOr_ShortCircuit_14011
  mov R1, [BP-51]
  mov R2, [BP-41]
  fge R1, R2
  jf R1, __LogicalAnd_ShortCircuit_14017
  mov R2, [BP-52]
  mov R3, [BP-41]
  fge R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_14017:
  or R0, R1
__LogicalOr_ShortCircuit_14011:
  mov [BP-53], R0
__if_14020_start:
  mov R0, [BP-50]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_14025
  mov R1, [BP-53]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_14025:
  jf R0, __if_14020_end
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
__if_14079_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14079_else
  mov R0, [BP-62]
  mov [BP-56], R0
  jmp __if_14079_end
__if_14079_else:
  mov R0, [BP-63]
  mov [BP-56], R0
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Neg
__if_14079_end:
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
__if_14146_start:
  mov R0, [BP-62]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_14146_else
  mov R0, [BP-62]
  mov [BP-59], R0
  jmp __if_14146_end
__if_14146_else:
  mov R0, [BP-63]
  mov [BP-59], R0
  lea R1, [BP-58]
  mov [SP], R1
  lea R1, [BP-58]
  mov [SP+1], R1
  call __function_b2Neg
__if_14146_end:
__if_14163_start:
  mov R1, [BP-56]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 0.100000
  fadd R1, R2
  mov R2, [BP-59]
  fge R1, R2
  mov R0, R1
  jf R0, __if_14163_else
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
__if_14185_start:
  mov R0, [BP-48]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14190
  mov R1, [BP-49]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14190:
  jf R0, __if_14185_else
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
  jmp __if_14185_end
__if_14185_else:
__if_14209_start:
  mov R0, [BP-49]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14214
  mov R1, [BP-48]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14214:
  jf R0, __if_14209_end
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
__if_14209_end:
__if_14185_end:
__if_14233_start:
  mov R0, [BP-48]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14238
  mov R1, [BP-49]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14238:
  jf R0, __if_14233_else
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
  jmp __if_14233_end
__if_14233_else:
__if_14257_start:
  mov R0, [BP-49]
  mov R1, [BP-40]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14262
  mov R1, [BP-48]
  mov R2, [BP-40]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14262:
  jf R0, __if_14257_end
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
__if_14257_end:
__if_14233_end:
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
__if_14309_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14319
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14319:
  mov R0, R1
  jf R0, __if_14309_end
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
__if_14309_end:
  jmp __if_14163_end
__if_14163_else:
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
__if_14441_start:
  mov R0, [BP-51]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14446
  mov R1, [BP-52]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14446:
  jf R0, __if_14441_else
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
  jmp __if_14441_end
__if_14441_else:
__if_14465_start:
  mov R0, [BP-52]
  flt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_14470
  mov R1, [BP-51]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_14470:
  jf R0, __if_14465_end
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
__if_14465_end:
__if_14441_end:
__if_14489_start:
  mov R0, [BP-51]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14494
  mov R1, [BP-52]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14494:
  jf R0, __if_14489_else
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
  jmp __if_14489_end
__if_14489_else:
__if_14513_start:
  mov R0, [BP-52]
  mov R1, [BP-41]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_14518
  mov R1, [BP-51]
  mov R2, [BP-41]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_14518:
  jf R0, __if_14513_end
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
__if_14513_end:
__if_14489_end:
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
__if_14565_start:
  mov R1, [BP-64]
  mov R2, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fadd R2, R3
  fle R1, R2
  jt R1, __LogicalOr_ShortCircuit_14575
  mov R2, [BP-65]
  mov R3, [BP-39]
  call __function_b2GetLengthUnitsPerMeter
  mov R4, R0
  fmul R4, 0.005000
  fadd R3, R4
  fle R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_14575:
  mov R0, R1
  jf R0, __if_14565_end
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
__if_14565_end:
__if_14163_end:
__if_14020_end:
__if_14684_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_14684_end
  lea R1, [BP-33]
  mov [SP], R1
  lea R1, [BP-31]
  mov [SP+1], R1
  lea R1, [BP-55]
  mov [SP+2], R1
  call __function_b2Sub
__if_14699_start:
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-55]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-21]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_14699_else
  lea R1, [BP-55]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2Normalize
  jmp __if_14699_end
__if_14699_else:
  lea R1, [BP-43]
  mov [SP], R1
  lea R1, [BP-55]
  mov [SP+1], R1
  call __function_b2LeftPerp
__if_14699_end:
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
__if_14740_start:
  mov R0, [BP-28]
  feq R0, 0.000000
  jf R0, __if_14740_else
  mov R0, 0
  mov [BP-60], R0
  jmp __if_14740_end
__if_14740_else:
  mov R0, 1
  mov [BP-60], R0
__if_14740_end:
__if_14752_start:
  mov R0, [BP-29]
  feq R0, 0.000000
  jf R0, __if_14752_else
  mov R0, 0
  mov [BP-61], R0
  jmp __if_14752_end
__if_14752_else:
  mov R0, 1
  mov [BP-61], R0
__if_14752_end:
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
__if_14684_end:
__if_14811_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_14811_end
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
__if_14811_end:
__if_14833_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_14833_end
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
__if_14833_end:
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
__if_14969_start:
  mov R0, [BP-13]
  flt R0, 0.000000
  jf R0, __if_14969_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_14969_end:
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
__if_14999_start:
  mov R0, [BP-17]
  fle R0, 0.000000
  jf R0, __if_14999_else
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
__if_15021_start:
  mov R0, [BP-35]
  fle R0, 0.000000
  jf R0, __if_15021_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15021_end:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
  jmp __if_14999_end
__if_14999_else:
__if_15029_start:
  mov R0, [BP-16]
  fle R0, 0.000000
  jf R0, __if_15029_else
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
__if_15060_start:
  mov R0, [BP-37]
  fgt R0, 0.000000
  jf R0, __if_15060_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15060_end:
  lea R13, [BP-19]
  lea R12, [BP-6]
  mov CR, 2
  movs
  jmp __if_15029_end
__if_15029_else:
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
__if_15102_start:
  mov R0, [BP-33]
  fgt R0, 0.000000
  jf R0, __if_15102_else
  mov R1, 1.000000
  mov R2, [BP-33]
  fdiv R1, R2
  mov [SP], R1
  lea R1, [BP-35]
  mov [SP+1], R1
  lea R1, [BP-19]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_15102_end
__if_15102_else:
  lea R13, [BP-19]
  lea R12, [BP-4]
  mov CR, 2
  movs
__if_15102_end:
__if_15029_end:
__if_14999_end:
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
__if_15146_start:
  mov R1, [BP-26]
  call __function_b2GetLengthUnitsPerMeter
  mov R2, R0
  fmul R2, 0.005000
  fmul R2, 4.000000
  fgt R1, R2
  mov R0, R1
  jf R0, __if_15146_end
  jmp __function_b2CollideChainSegmentAndCircle_return
__if_15146_end:
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
__for_15307_start:
  mov R0, [BP-5]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_15307_end
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
__for_15337_start:
  mov R0, [BP-11]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_15337_end
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
__if_15374_start:
  mov R0, [BP-14]
  mov R1, [BP-10]
  flt R0, R1
  jf R0, __if_15374_end
  mov R0, [BP-14]
  mov [BP-10], R0
__if_15374_end:
__for_15337_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_15337_start
__for_15337_end:
__if_15381_start:
  mov R0, [BP-10]
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_15381_end
  mov R0, [BP-10]
  mov [BP-4], R0
  mov R0, [BP-5]
  mov [BP-3], R0
__if_15381_end:
__for_15307_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_15307_start
__for_15307_end:
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
__if_15419_start:
  mov R0, [BP+6]
  jf R0, __if_15419_else
  mov R0, [BP+3]
  mov [BP-1], R0
  mov R0, [BP+2]
  mov [BP-4], R0
  mov R0, [BP+5]
  mov [BP-2], R0
__if_15431_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15431_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15431_end
__if_15431_else:
  mov R0, 0
  mov [BP-3], R0
__if_15431_end:
  mov R0, [BP+4]
  mov [BP-5], R0
__if_15449_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15449_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15449_end
__if_15449_else:
  mov R0, 0
  mov [BP-6], R0
__if_15449_end:
  jmp __if_15419_end
__if_15419_else:
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-4], R0
  mov R0, [BP+4]
  mov [BP-2], R0
__if_15474_start:
  mov R0, [BP+4]
  iadd R0, 1
  mov R2, [BP+2]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15474_else
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP-3], R0
  jmp __if_15474_end
__if_15474_else:
  mov R0, 0
  mov [BP-3], R0
__if_15474_end:
  mov R0, [BP+5]
  mov [BP-5], R0
__if_15492_start:
  mov R0, [BP+5]
  iadd R0, 1
  mov R2, [BP+3]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_15492_else
  mov R0, [BP+5]
  iadd R0, 1
  mov [BP-6], R0
  jmp __if_15492_end
__if_15492_else:
  mov R0, 0
  mov [BP-6], R0
__if_15492_end:
__if_15419_end:
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
__if_15616_start:
  mov R0, [BP-21]
  mov R1, [BP-19]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_15621
  mov R1, [BP-20]
  mov R2, [BP-22]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_15621:
  jf R0, __if_15616_end
  jmp __function_b2ClipPolygons_return
__if_15616_end:
__if_15627_start:
  mov R0, [BP-22]
  mov R1, [BP-19]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15632
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15632:
  jf R0, __if_15627_else
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
  jmp __if_15627_end
__if_15627_else:
  lea R13, [BP-24]
  lea R12, [BP-16]
  mov CR, 2
  movs
__if_15627_end:
__if_15687_start:
  mov R0, [BP-21]
  mov R1, [BP-20]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_15692
  mov R1, [BP-21]
  mov R2, [BP-22]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_15692:
  jf R0, __if_15687_else
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
  jmp __if_15687_end
__if_15687_else:
  lea R13, [BP-26]
  lea R12, [BP-14]
  mov CR, 2
  movs
__if_15687_end:
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
__if_15864_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_15864_else
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
  jmp __if_15864_end
__if_15864_else:
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
__if_15864_end:
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
__for_16115_start:
  mov R0, [BP-46]
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16115_end
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
__for_16115_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16115_start
__for_16115_end:
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
__for_16164_start:
  mov R0, [BP-46]
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_16164_end
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
__for_16164_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16164_start
__for_16164_end:
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
__if_16229_start:
  mov R0, [BP-85]
  mov R1, [BP-4]
  mov R2, [BP-88]
  fadd R1, R2
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16236
  mov R1, [BP-87]
  mov R2, [BP-4]
  mov R3, [BP-88]
  fadd R2, R3
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16236:
  jf R0, __if_16229_end
  jmp __function_b2CollidePolygons_return
__if_16229_end:
__if_16244_start:
  mov R0, [BP-85]
  mov R1, [BP-87]
  fge R0, R1
  jf R0, __if_16244_else
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
__for_16271_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16271_end
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
__if_16291_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16291_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-86], R0
__if_16291_end:
__for_16271_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16271_start
__for_16271_end:
  jmp __if_16244_end
__if_16244_else:
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
__for_16325_start:
  mov R0, [BP-46]
  mov R1, [BP-92]
  ilt R0, R1
  jf R0, __for_16325_end
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
__if_16345_start:
  mov R0, [BP-94]
  mov R1, [BP-93]
  flt R0, R1
  jf R0, __if_16345_end
  mov R0, [BP-94]
  mov [BP-93], R0
  mov R0, [BP-46]
  mov [BP-84], R0
__if_16345_end:
__for_16325_continue:
  mov R0, [BP-46]
  iadd R0, 1
  mov [BP-46], R0
  jmp __for_16325_start
__for_16325_end:
__if_16244_end:
__if_16356_start:
  mov R0, [BP-85]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_16363
  mov R1, [BP-87]
  mov R2, [BP-3]
  fmul R2, 0.100000
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_16363:
  jf R0, __if_16356_else
  mov R0, [BP-84]
  mov [BP-90], R0
__if_16374_start:
  mov R0, [BP-84]
  iadd R0, 1
  mov R2, [BP-45]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16374_else
  mov R0, [BP-84]
  iadd R0, 1
  mov [BP-91], R0
  jmp __if_16374_end
__if_16374_else:
  mov R0, 0
  mov [BP-91], R0
__if_16374_end:
  mov R0, [BP-86]
  mov [BP-92], R0
__if_16394_start:
  mov R0, [BP-86]
  iadd R0, 1
  mov R2, [BP-83]
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_16394_else
  mov R0, [BP-86]
  iadd R0, 1
  mov [BP-93], R0
  jmp __if_16394_end
__if_16394_else:
  mov R0, 0
  mov [BP-93], R0
__if_16394_end:
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
__if_16456_start:
  mov R0, [BP-109]
  mov R1, [BP-88]
  fsub R0, R1
  mov R1, [BP-4]
  fgt R0, R1
  jf R0, __if_16456_end
  jmp __function_b2CollidePolygons_return
__if_16456_end:
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
__if_16476_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16476_end
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
__if_16476_end:
__if_16490_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16490_end
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
__if_16490_end:
__if_16504_start:
  mov R0, [BP-110]
  mov R1, [BP-3]
  fmul R1, 0.100000
  fadd R0, R1
  mov R1, [BP-111]
  flt R0, R1
  jf R0, __if_16504_end
  mov R0, 1.000000
  mov R1, [BP-109]
  fdiv R0, R1
  mov [BP-112], R0
__if_16518_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16525
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16525:
  jf R0, __if_16518_else
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
  jmp __if_16518_end
__if_16518_else:
__if_16625_start:
  mov R0, [BP-104]
  feq R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_16632
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16632:
  jf R0, __if_16625_else
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
  jmp __if_16625_end
__if_16625_else:
__if_16732_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16739
  mov R1, [BP-103]
  feq R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16739:
  jf R0, __if_16732_else
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
  jmp __if_16732_end
__if_16732_else:
__if_16839_start:
  mov R0, [BP-104]
  feq R0, 1.000000
  jf R0, __LogicalAnd_ShortCircuit_16846
  mov R1, [BP-103]
  feq R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_16846:
  jf R0, __if_16839_end
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
__if_16839_end:
__if_16732_end:
__if_16625_end:
__if_16518_end:
__if_16504_end:
  jmp __if_16356_end
__if_16356_else:
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
__if_16356_end:
__if_16954_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_16954_end
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
__if_16954_end:
__if_16976_start:
  mov R1, [BP+5]
  iadd R1, 10
  mov R0, [R1]
  igt R0, 1
  jf R0, __if_16976_end
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
__if_16976_end:
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
__if_17062_start:
  mov R2, [BP+3]
  mov [SP], R2
  mov R2, [BP+2]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  fle R1, 0.000000
  mov R0, R1
  jf R0, __if_17062_else
__if_17071_start:
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jf R0, __if_17071_end
__if_17075_start:
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
  jf R0, __if_17075_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17075_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17071_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
  jmp __if_17062_end
__if_17062_else:
__if_17090_start:
  mov R1, [BP+2]
  iadd R1, 7
  mov R0, [R1]
  jf R0, __if_17090_end
__if_17094_start:
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
  jf R0, __if_17094_end
  mov R0, 0
  jmp __function_b2ClassifyNormal_return
__if_17094_end:
  mov R0, 1
  jmp __function_b2ClassifyNormal_return
__if_17090_end:
  mov R0, 2
  jmp __function_b2ClassifyNormal_return
__if_17062_end:
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
__if_17174_start:
  mov R0, [BP-9]
  mov R1, [BP-3]
  flt R0, R1
  jt R0, __LogicalOr_ShortCircuit_17179
  mov R1, [BP-6]
  mov R2, [BP-12]
  flt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_17179:
  jf R0, __if_17174_end
  jmp __function_b2ClipSegments_return
__if_17174_end:
__if_17185_start:
  mov R0, [BP-12]
  mov R1, [BP-3]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17190
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17190:
  jf R0, __if_17185_else
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
  jmp __if_17185_end
__if_17185_else:
  lea R13, [BP-14]
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17185_end:
__if_17222_start:
  mov R0, [BP-9]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_17227
  mov R1, [BP-9]
  mov R2, [BP-12]
  fsub R1, R2
  mov R2, 1.000000
  mov R3, [global_b2_two_pow_23]
  fdiv R2, R3
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_17227:
  jf R0, __if_17222_else
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
  jmp __if_17222_end
__if_17222_else:
  lea R13, [BP-16]
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 2
  movs
__if_17222_end:
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
__if_17541_start:
  mov R0, [BP-51]
  jf R0, __if_17541_end
  lea R2, [BP-55]
  mov [SP], R2
  lea R2, [BP-70]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  flt R1, 0.000000
  mov [BP-72], R1
  mov R0, R1
__if_17541_end:
__if_17554_start:
  mov R0, [BP-50]
  jf R0, __if_17554_end
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
__if_17554_end:
__if_17577_start:
  mov R0, [BP-71]
  jf R0, __LogicalAnd_ShortCircuit_17579
  mov R1, [BP-72]
  and R0, R1
__LogicalAnd_ShortCircuit_17579:
  jf R0, __LogicalAnd_ShortCircuit_17582
  mov R1, [BP-73]
  and R0, R1
__LogicalAnd_ShortCircuit_17582:
  jf R0, __if_17577_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17577_end:
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
__if_17634_start:
  mov R1, [BP-117]
  mov R2, [BP-40]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 4.000000
  fadd R2, R3
  fgt R1, R2
  mov R0, R1
  jf R0, __if_17634_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17634_end:
  lea R12, [BP-68]
  lea DR, [BP-125]
  mov CR, 2
  movs
__if_17651_start:
  mov R0, [BP-51]
  jf R0, __if_17651_end
  lea R13, [BP-125]
  lea R12, [BP-55]
  mov CR, 2
  movs
__if_17651_end:
  lea R12, [BP-68]
  lea DR, [BP-127]
  mov CR, 2
  movs
__if_17661_start:
  mov R0, [BP-50]
  jf R0, __if_17661_end
  lea R13, [BP-127]
  lea R12, [BP-53]
  mov CR, 2
  movs
__if_17661_end:
  mov R0, -1
  mov [BP-128], R0
  mov R0, -1
  mov [BP-129], R0
__if_17676_start:
  mov R1, [BP-71]
  ieq R1, 0
  jf R1, __LogicalAnd_ShortCircuit_17682
  mov R2, [BP-117]
  call __function_b2GetLengthUnitsPerMeter
  mov R3, R0
  fmul R3, 0.005000
  fmul R3, 0.100000
  fgt R2, R3
  and R1, R2
__LogicalAnd_ShortCircuit_17682:
  mov R0, R1
  jf R0, __if_17676_else
__if_17691_start:
  mov R1, [BP+5]
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_17691_else
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
__if_17728_start:
  mov R0, [BP-144]
  ieq R0, 0
  jf R0, __if_17728_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17728_end:
__if_17733_start:
  mov R0, [BP-144]
  ieq R0, 1
  jf R0, __if_17733_end
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
__if_17733_end:
  mov R0, [BP+5]
  iadd R0, 4
  mov R0, [R0]
  mov [BP-128], R0
  jmp __if_17691_end
__if_17691_else:
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
__if_17822_start:
  mov R0, [BP-136]
  mov R1, [BP-137]
  ieq R0, R1
  jf R0, __if_17822_else
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
__if_17867_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  fgt R0, R1
  jf R0, __if_17867_end
  mov R0, [BP-138]
  mov [BP-148], R0
__if_17867_end:
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
__if_17894_start:
  mov R0, [BP-151]
  ieq R0, 0
  jf R0, __if_17894_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17894_end:
__if_17899_start:
  mov R0, [BP-151]
  ieq R0, 1
  jf R0, __if_17899_end
  mov R0, [BP-148]
  mov [BP-138], R0
__if_17907_start:
  mov R0, [BP-148]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_17907_else
  mov R0, [BP-148]
  iadd R0, 1
  mov [BP-139], R0
  jmp __if_17907_end
__if_17907_else:
  mov R0, 0
  mov [BP-139], R0
__if_17907_end:
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
__if_17965_start:
  mov R0, [BP-146]
  mov R1, [BP-147]
  flt R0, R1
  jf R0, __if_17965_else
__if_17970_start:
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
  jf R0, __if_17970_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17970_end:
  jmp __if_17965_end
__if_17965_else:
__if_17984_start:
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
  jf R0, __if_17984_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17984_end:
__if_17965_end:
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
__if_18041_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18041_end
  lea R1, [BP-141]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18041_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_17899_end:
  mov R0, [BP-148]
  mov [BP-129], R0
  jmp __if_17822_end
__if_17822_else:
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
__if_18101_start:
  mov R0, [BP-148]
  mov R1, [BP-149]
  flt R0, R1
  jf R0, __if_18101_else
  mov R0, [BP-138]
  mov [BP-128], R0
  jmp __if_18101_end
__if_18101_else:
  mov R0, [BP-139]
  mov [BP-128], R0
__if_18101_end:
__if_17822_end:
__if_17691_end:
  jmp __if_17676_end
__if_17676_else:
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-136], R0
  mov R0, 0
  mov [BP-137], R0
__for_18120_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18120_end
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
__if_18152_start:
  mov R0, [BP-144]
  mov R1, [BP-136]
  flt R0, R1
  jf R0, __if_18152_end
  mov R0, [BP-144]
  mov [BP-136], R0
  mov R0, [BP-137]
  mov [BP-128], R0
__if_18152_end:
__for_18120_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18120_start
__for_18120_end:
__if_18163_start:
  mov R0, [BP-51]
  jf R0, __if_18163_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18173_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18173_end
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
__if_18206_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18206_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18206_end:
__for_18173_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18173_start
__for_18173_end:
__if_18213_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18213_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18213_end:
__if_18163_end:
__if_18225_start:
  mov R0, [BP-50]
  jf R0, __if_18225_end
  mov R0, 999999961690316245365415600208216064.000000
  mov [BP-140], R0
  mov R0, 0
  mov [BP-137], R0
__for_18235_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18235_end
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
__if_18268_start:
  mov R0, [BP-145]
  mov R1, [BP-140]
  flt R0, R1
  jf R0, __if_18268_end
  mov R0, [BP-145]
  mov [BP-140], R0
__if_18268_end:
__for_18235_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18235_start
__for_18235_end:
__if_18275_start:
  mov R0, [BP-140]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18275_end
  mov R0, [BP-140]
  mov [BP-136], R0
  mov R0, -1
  mov [BP-128], R0
__if_18275_end:
__if_18225_end:
  mov R0, -999999961690316245365415600208216064.000000
  mov [BP-138], R0
  mov R0, -1
  mov [BP-139], R0
  mov R0, 0
  mov [BP-137], R0
__for_18298_start:
  mov R0, [BP-137]
  mov R1, [BP-41]
  ilt R0, R1
  jf R0, __for_18298_end
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
__if_18321_start:
  lea R2, [BP-57]
  mov [SP], R2
  lea R2, [BP-143]
  mov [SP+1], R2
  call __function_b2ClassifyNormal
  mov R1, R0
  ine R1, 1
  mov R0, R1
  jf R0, __if_18321_end
  jmp __for_18298_continue
__if_18321_end:
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
__if_18367_start:
  mov R0, [BP-150]
  mov R1, [BP-138]
  fgt R0, R1
  jf R0, __if_18367_end
  mov R0, [BP-150]
  mov [BP-138], R0
  mov R0, [BP-137]
  mov [BP-139], R0
__if_18367_end:
__for_18298_continue:
  mov R0, [BP-137]
  iadd R0, 1
  mov [BP-137], R0
  jmp __for_18298_start
__for_18298_end:
__if_18378_start:
  mov R0, [BP-138]
  mov R1, [BP-136]
  fgt R0, R1
  jf R0, __if_18378_end
  mov R0, [BP-139]
  mov [BP-140], R0
__if_18388_start:
  mov R0, [BP-140]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18388_else
  mov R0, [BP-140]
  iadd R0, 1
  mov [BP-141], R0
  jmp __if_18388_end
__if_18388_else:
  mov R0, 0
  mov [BP-141], R0
__if_18388_end:
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
__if_18452_start:
  mov R0, [BP-152]
  mov R1, [BP-153]
  flt R0, R1
  jf R0, __if_18452_else
__if_18457_start:
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
  jf R0, __if_18457_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18457_end:
  jmp __if_18452_end
__if_18452_else:
__if_18471_start:
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
  jf R0, __if_18471_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18471_end:
__if_18452_end:
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
__if_18528_start:
  mov R1, [BP+6]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_18528_end
  lea R1, [BP-147]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_b2Neg
__if_18528_end:
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18378_end:
__if_18540_start:
  mov R0, [BP-128]
  ieq R0, -1
  jf R0, __if_18540_end
  jmp __function_b2CollideChainSegmentAndPolygon_return
__if_18540_end:
__if_17676_end:
__if_18550_start:
  mov R0, [BP-129]
  ine R0, -1
  jf R0, __if_18550_else
  mov R0, [BP-129]
  mov [BP-130], R0
__if_18559_start:
  mov R0, [BP-130]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18559_else
  mov R0, [BP-130]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18559_end
__if_18559_else:
  mov R0, 0
  mov [BP-131], R0
__if_18559_end:
  jmp __if_18550_end
__if_18550_else:
  mov R0, [BP-128]
  mov [BP-136], R0
__if_18579_start:
  mov R0, [BP-136]
  igt R0, 0
  jf R0, __if_18579_else
  mov R0, [BP-136]
  isub R0, 1
  mov [BP-137], R0
  jmp __if_18579_end
__if_18579_else:
  mov R0, [BP-41]
  isub R0, 1
  mov [BP-137], R0
__if_18579_end:
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
__if_18619_start:
  mov R0, [BP-142]
  mov R1, [BP-143]
  flt R0, R1
  jf R0, __if_18619_else
  mov R0, [BP-137]
  mov [BP-130], R0
  mov R0, [BP-136]
  mov [BP-131], R0
  jmp __if_18619_end
__if_18619_else:
  mov R0, [BP-136]
  mov [BP-130], R0
__if_18634_start:
  mov R0, [BP-136]
  mov R1, [BP-41]
  isub R1, 1
  ilt R0, R1
  jf R0, __if_18634_else
  mov R0, [BP-136]
  iadd R0, 1
  mov [BP-131], R0
  jmp __if_18634_end
__if_18634_else:
  mov R0, 0
  mov [BP-131], R0
__if_18634_end:
__if_18619_end:
__if_18550_end:
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
__if_18763_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_18763_end
  mov R0, 32
  jmp __function_b2CLZ32_return
__if_18763_end:
  mov R0, 0
  mov [BP-1], R0
  mov R0, 31
  mov [BP-2], R0
__for_18774_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_18774_end
__if_18784_start:
  mov R0, [BP+2]
  mov R1, [BP-2]
  isgn R1
  shl R0, R1
  and R0, 1
  ine R0, 0
  jf R0, __if_18784_end
  mov R0, [BP-1]
  jmp __function_b2CLZ32_return
__if_18784_end:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
__for_18774_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_18774_start
__for_18774_end:
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
__if_18832_start:
  mov R0, [BP+2]
  ile R0, 1
  jf R0, __if_18832_end
  mov R0, 1
  jmp __function_b2RoundUpPowerOf2_return
__if_18832_end:
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
__if_18955_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_18960
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_18960:
  jf R0, __if_18955_end
  mov R0, 1
  jmp __function_islower_return
__if_18955_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_18971
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_18971:
  jf R0, __LogicalAnd_ShortCircuit_18975
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_18975:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_18980_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_18985
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_18985:
  jf R0, __if_18980_end
  mov R0, 1
  jmp __function_isupper_return
__if_18980_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_18996
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_18996:
  jf R0, __LogicalAnd_ShortCircuit_19000
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_19000:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_19131_start:
__while_19131_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_19131_end
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
  jmp __while_19131_start
__while_19131_end:
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
__while_19184_start:
__while_19184_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_19184_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_19184_start
__while_19184_end:
__while_19189_start:
__while_19189_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_19189_end
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
  jmp __while_19189_start
__while_19189_end:
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
  mov SR, __literal_string_19253
  mov CR, 17
  movs
  lea R0, [BP-50]
  mov [BP-51], R0
__if_19262_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_19267
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_19267:
  jf R0, __if_19262_end
  jmp __function_itoa_return
__if_19262_end:
__if_19271_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_19276
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_19276:
  jf R0, __if_19271_else
__if_19280_start:
  mov R0, [BP+2]
  ieq R0, 0x80000000
  jf R0, __if_19280_end
  lea DR, [BP-63]
  mov SR, __literal_string_19290
  mov CR, 12
  movs
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-63]
  mov [SP+1], R1
  call __function_strcpy
  jmp __function_itoa_return
__if_19280_end:
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
  jmp __if_19271_end
__if_19271_else:
__if_19305_start:
  mov R0, [BP+2]
  ilt R0, 0
  jf R0, __if_19305_end
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
__if_19361_start:
  mov R0, [BP+2]
  bnot R0
  jf R0, __if_19361_end
  jmp __label_19381_digits_stored
__if_19361_end:
__if_19305_end:
__if_19271_end:
__do_19365_start:
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
__do_19365_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_19365_start
__do_19365_end:
__label_19381_digits_stored:
__do_19382_start:
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
__do_19382_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_19382_start
__do_19382_end:
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
__if_19508_start:
  mov R0, [BP-1]
  mov R1, [BP+4]
  ige R0, R1
  jf R0, __if_19508_end
  mov R0, [BP+2]
  jmp __function_b2GrowArray_return
__if_19508_end:
  mov R0, 8
  mov [BP-2], R0
__if_19517_start:
  mov R0, [BP-1]
  ine R0, 0
  jf R0, __if_19517_end
  mov R0, [BP-1]
  imul R0, 2
  mov [BP-2], R0
__if_19517_end:
__if_19526_start:
  mov R0, [BP-2]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __if_19526_end
  mov R0, [BP+4]
  mov [BP-2], R0
__if_19526_end:
__if_19535_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_19535_else
  mov R2, [BP-2]
  mov R3, [BP+5]
  imul R2, R3
  mov [SP], R2
  call __function_b2Alloc
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  jmp __if_19535_end
__if_19535_else:
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
__if_19535_end:
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
__for_19748_start:
  mov R0, [BP-2]
  mov R2, [BP+3]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19748_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R2, [BP+3]
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19748_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_19748_start
__for_19748_end:
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
__if_19824_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_19824_end
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
__for_19888_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  isub R1, 1
  ilt R0, R1
  jf R0, __for_19888_end
  mov R0, [BP-5]
  iadd R0, 1
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-5]
  imul R2, 12
  iadd R1, R2
  iadd R1, 9
  mov [R1], R0
__for_19888_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_19888_start
__for_19888_end:
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
__if_19824_end:
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
__while_20039_start:
__while_20039_continue:
  mov R1, [BP-4]
  mov R2, [BP-19]
  imul R2, 12
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  igt R0, 0
  jf R0, __while_20039_end
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
__if_20066_start:
  mov R0, [BP-22]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_20066_end
  mov R0, [BP-19]
  mov [BP-17], R0
  mov R0, [BP-22]
  mov [BP-18], R0
__if_20066_end:
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
__if_20129_start:
  mov R0, [BP-23]
  jf R0, __if_20129_else
  mov R0, [BP-34]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_20137_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_20137_end
  mov R0, [BP-20]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_20137_end:
  jmp __if_20129_end
__if_20129_else:
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
__if_20129_end:
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
__if_20193_start:
  mov R0, [BP-24]
  jf R0, __if_20193_else
  mov R0, [BP-45]
  mov R1, [BP-16]
  fadd R0, R1
  mov [BP-47], R0
__if_20201_start:
  mov R0, [BP-47]
  mov R1, [BP-18]
  flt R0, R1
  jf R0, __if_20201_end
  mov R0, [BP-21]
  mov [BP-17], R0
  mov R0, [BP-47]
  mov [BP-18], R0
__if_20201_end:
  jmp __if_20193_end
__if_20193_else:
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
__if_20193_end:
__if_20229_start:
  mov R0, [BP-23]
  jf R0, __LogicalAnd_ShortCircuit_20231
  mov R1, [BP-24]
  and R0, R1
__LogicalAnd_ShortCircuit_20231:
  jf R0, __if_20229_end
  jmp __while_20039_end
__if_20229_end:
__if_20234_start:
  mov R0, [BP-18]
  mov R1, [BP-25]
  fle R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20239
  mov R1, [BP-18]
  mov R2, [BP-36]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_20239:
  jf R0, __if_20234_end
  jmp __while_20039_end
__if_20234_end:
__if_20243_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  feq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20248
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_20248:
  jf R0, __if_20243_end
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
__if_20243_end:
__if_20294_start:
  mov R0, [BP-25]
  mov R1, [BP-36]
  flt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_20299
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_20299:
  jf R0, __if_20294_else
  mov R0, [BP-20]
  mov [BP-19], R0
  mov R0, [BP-35]
  mov [BP-10], R0
  mov R0, [BP-34]
  mov [BP-15], R0
  jmp __if_20294_end
__if_20294_else:
  mov R0, [BP-21]
  mov [BP-19], R0
  mov R0, [BP-46]
  mov [BP-10], R0
  mov R0, [BP-45]
  mov [BP-15], R0
__if_20294_end:
  jmp __while_20039_start
__while_20039_end:
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
__if_20328_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_20328_end
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
__if_20328_end:
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
__if_20455_start:
  mov R0, [BP-6]
  ine R0, -1
  jf R0, __if_20455_else
__if_20462_start:
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-5]
  ieq R0, R1
  jf R0, __if_20462_else
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_20462_end
__if_20462_else:
  mov R0, [BP-7]
  mov R1, [BP-8]
  mov R2, [BP-6]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_20462_end:
  jmp __if_20455_end
__if_20455_else:
  mov R0, [BP-7]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_20455_end:
  mov R1, [BP-8]
  mov R2, [BP+3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 8
  mov R0, [R1]
  mov [BP-9], R0
__while_20495_start:
__while_20495_continue:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __while_20495_end
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
  jmp __while_20495_start
__while_20495_end:
__function_b2InsertLeaf_return:
  mov SP, BP
  pop BP
  ret

__function_b2RemoveLeaf:
  push BP
  mov BP, SP
  isub SP, 11
__if_20594_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_20594_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2RemoveLeaf_return
__if_20594_end:
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
__if_20625_start:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_20625_else
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov R0, [R1]
  mov [BP-4], R0
  jmp __if_20625_end
__if_20625_else:
  mov R1, [BP-1]
  mov R2, [BP-2]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__if_20625_end:
__if_20647_start:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __if_20647_else
__if_20654_start:
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_20654_else
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  mov [R1], R0
  jmp __if_20654_end
__if_20654_else:
  mov R0, [BP-4]
  mov R1, [BP-1]
  mov R2, [BP-3]
  imul R2, 12
  iadd R1, R2
  iadd R1, 5
  iadd R1, 1
  mov [R1], R0
__if_20654_end:
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
__while_20688_start:
__while_20688_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_20688_end
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
  jmp __while_20688_start
__while_20688_end:
  jmp __if_20647_end
__if_20647_else:
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
__if_20647_end:
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
__if_20907_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_20907_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20907_end:
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
__while_20930_start:
__while_20930_continue:
  mov R0, [BP-257]
  igt R0, 0
  jf R0, __while_20930_end
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
__if_20958_start:
  mov R1, [BP-259]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2AABB_Overlaps
  jf R0, __if_20958_end
__if_20965_start:
  mov R1, [BP-259]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_20965_else
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
__if_20984_start:
  mov R0, [BP-260]
  ieq R0, 0
  jf R0, __if_20984_end
  jmp __function_b2DynamicTree_QueryAll_return
__if_20984_end:
  jmp __if_20965_end
__if_20965_else:
__if_20990_start:
  mov R0, [BP-257]
  ilt R0, 255
  jf R0, __if_20990_end
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
__if_20990_end:
__if_20965_end:
__if_20958_end:
  jmp __while_20930_start
__while_20930_end:
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
__if_21036_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21036_end
  jmp __function_b2DynamicTree_RayCast_return
__if_21036_end:
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
__while_21149_start:
__while_21149_continue:
  mov R0, [BP-274]
  igt R0, 0
  jf R0, __while_21149_end
  mov R0, [BP-274]
  isub R0, 1
  mov [BP-274], R0
  lea R0, [BP-273]
  mov R1, [BP-274]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-281], R0
__if_21164_start:
  mov R0, [BP-281]
  ieq R0, -1
  jf R0, __if_21164_end
  jmp __while_21149_continue
__if_21164_end:
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
__if_21187_start:
  mov R1, [BP-282]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_21187_end
  jmp __while_21149_continue
__if_21187_end:
__if_21196_start:
  lea R2, [BP-286]
  mov [SP], R2
  lea R2, [BP-17]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_21196_end
  jmp __while_21149_continue
__if_21196_end:
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
__if_21243_start:
  mov R0, [BP-294]
  mov R1, [BP-293]
  flt R0, R1
  jf R0, __if_21243_end
  jmp __while_21149_continue
__if_21243_end:
__if_21248_start:
  mov R1, [BP-282]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_21248_else
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
__if_21273_start:
  mov R0, [BP-295]
  feq R0, 0.000000
  jf R0, __if_21273_end
  jmp __function_b2DynamicTree_RayCast_return
__if_21273_end:
__if_21278_start:
  mov R0, [BP-295]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21283
  mov R1, [BP-295]
  mov R2, [BP-11]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21283:
  jf R0, __if_21278_end
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
__if_21278_end:
  jmp __if_21248_end
__if_21248_else:
__if_21335_start:
  mov R0, [BP-274]
  ilt R0, 255
  jf R0, __if_21335_end
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
__if_21372_start:
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
  jf R0, __if_21372_else
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
  jmp __if_21372_end
__if_21372_else:
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
__if_21372_end:
__if_21335_end:
__if_21248_end:
  jmp __while_21149_start
__while_21149_end:
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
__if_21449_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_21449_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21449_end:
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
__while_21588_start:
__while_21588_continue:
  mov R0, [BP-278]
  igt R0, 0
  jf R0, __while_21588_end
  mov R0, [BP-278]
  isub R0, 1
  mov [BP-278], R0
  lea R0, [BP-277]
  mov R1, [BP-278]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-287], R0
__if_21603_start:
  mov R0, [BP-287]
  ieq R0, -1
  jf R0, __if_21603_end
  jmp __while_21588_continue
__if_21603_end:
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
__if_21626_start:
  mov R1, [BP-288]
  iadd R1, 4
  mov R0, [R1]
  mov R1, [BP+4]
  and R0, R1
  ieq R0, 0
  jf R0, __if_21626_end
  jmp __while_21588_continue
__if_21626_end:
__if_21635_start:
  lea R2, [BP-292]
  mov [SP], R2
  lea R2, [BP-21]
  mov [SP+1], R2
  call __function_b2AABB_Overlaps
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_21635_end
  jmp __while_21588_continue
__if_21635_end:
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
__if_21691_start:
  mov R0, [BP-302]
  mov R1, [BP-301]
  flt R0, R1
  jf R0, __if_21691_end
  jmp __while_21588_continue
__if_21691_end:
__if_21696_start:
  mov R1, [BP-288]
  mov [SP], R1
  call __function_b2IsLeaf
  jf R0, __if_21696_else
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
__if_21721_start:
  mov R0, [BP-303]
  feq R0, 0.000000
  jf R0, __if_21721_end
  jmp __function_b2DynamicTree_BoxCast_return
__if_21721_end:
__if_21726_start:
  mov R0, [BP-303]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_21731
  mov R1, [BP-303]
  mov R2, [BP-15]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_21731:
  jf R0, __if_21726_end
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
__if_21726_end:
  jmp __if_21696_end
__if_21696_else:
__if_21802_start:
  mov R0, [BP-278]
  ilt R0, 255
  jf R0, __if_21802_end
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
__if_21839_start:
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
  jf R0, __if_21839_else
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
  jmp __if_21839_end
__if_21839_else:
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
__if_21839_end:
__if_21802_end:
__if_21696_end:
  jmp __while_21588_start
__while_21588_end:
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
__if_21959_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  igt R0, 0
  jf R0, __if_21959_end
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
__if_21959_end:
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
__if_21994_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_21994_end
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
__if_22014_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-1]
  ile R0, R1
  jf R0, __if_22014_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
__if_22014_end:
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
__if_21994_end:
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
__if_22497_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_22505
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22505:
  jf R0, __if_22497_end
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jmp __function_b2ShouldShapesCollide_return
__if_22497_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  and R0, R1
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_22528
  mov R2, [BP+2]
  mov R1, [R2]
  mov R3, [BP+3]
  iadd R3, 1
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22528:
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
  jf R0, __LogicalAnd_ShortCircuit_22565
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP+3]
  mov R2, [R3]
  and R1, R2
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_22565:
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
__if_22579_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22579_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCircleAABB
  jmp __if_22579_end
__if_22579_else:
__if_22590_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22590_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeCapsuleAABB
  jmp __if_22590_end
__if_22590_else:
__if_22601_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22601_else
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputePolygonAABB
  jmp __if_22601_end
__if_22601_else:
__if_22612_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22612_else
  mov R1, [BP+2]
  iadd R1, 74
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22612_end
__if_22612_else:
__if_22623_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22623_else
  mov R1, [BP+2]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2ComputeSegmentAABB
  jmp __if_22623_end
__if_22623_else:
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
__if_22623_end:
__if_22612_end:
__if_22601_end:
__if_22590_end:
__if_22579_end:
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
__if_22667_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22667_else
  mov R1, [BP+2]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCircle
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22667_end
__if_22667_else:
__if_22679_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22679_else
  mov R1, [BP+2]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInCapsule
  jmp __function_b2ShapeTestPoint_return
  jmp __if_22679_end
__if_22679_else:
__if_22691_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22691_end
  mov R1, [BP+2]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_b2PointInPolygon
  jmp __function_b2ShapeTestPoint_return
__if_22691_end:
__if_22679_end:
__if_22667_end:
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
__if_22730_start:
  mov R1, [BP+2]
  iadd R1, 16
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22730_end
  jmp __function_b2ShapeCastShape_return
__if_22730_end:
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
__for_22753_start:
  mov R0, [BP-25]
  mov R2, [BP-23]
  iadd R2, 16
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_22753_end
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
__for_22753_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_22753_start
__for_22753_end:
  mov R1, [BP+4]
  iadd R1, 2
  mov [SP], R1
  mov R1, [BP+2]
  iadd R1, 18
  mov [SP+1], R1
  lea R1, [BP-4]
  mov [SP+2], R1
  call __function_b2InvRotateVector
__if_22789_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22789_else
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCircle
  jmp __if_22789_end
__if_22789_else:
__if_22801_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22801_else
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastCapsule
  jmp __if_22801_end
__if_22801_else:
__if_22813_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22813_else
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastPolygon
  jmp __if_22813_end
__if_22813_else:
__if_22825_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22825_else
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
  jmp __if_22825_end
__if_22825_else:
__if_22837_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22837_end
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP], R1
  lea R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2ShapeCastSegment
__if_22837_end:
__if_22825_end:
__if_22813_end:
__if_22801_end:
__if_22789_end:
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
__if_22896_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22896_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 30
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCircle
  jmp __if_22896_end
__if_22896_else:
__if_22908_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22908_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 33
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndCapsule
  jmp __if_22908_end
__if_22908_else:
__if_22920_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_22920_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 38
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndPolygon
  jmp __if_22920_end
__if_22920_else:
__if_22932_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_22932_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 74
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22932_end
__if_22932_else:
__if_22944_start:
  mov R1, [BP+3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_22944_else
  lea R1, [BP-5]
  mov [SP], R1
  mov R1, [BP+3]
  iadd R1, 78
  iadd R1, 2
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2CollideMoverAndSegment
  jmp __if_22944_end
__if_22944_else:
  jmp __function_b2CollideMover_return
__if_22944_end:
__if_22932_end:
__if_22920_end:
__if_22908_end:
__if_22896_end:
__if_22958_start:
  mov R1, [BP+5]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22958_end
  jmp __function_b2CollideMover_return
__if_22958_end:
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
__if_22982_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_22982_else
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
  jmp __if_22982_end
__if_22982_else:
__if_22997_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_22997_else
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
  jmp __if_22997_end
__if_22997_else:
__if_23012_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23012_else
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
  jmp __if_23012_end
__if_23012_else:
__if_23028_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_23028_else
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
  jmp __if_23028_end
__if_23028_else:
__if_23041_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_23041_else
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
  jmp __if_23041_end
__if_23041_else:
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 16
  mov [R1], R0
__if_23041_end:
__if_23028_end:
__if_23012_end:
__if_22997_end:
__if_22982_end:
__function_b2MakeShapeProxy_return:
  mov SP, BP
  pop BP
  ret

__function_b2GetShapeCentroid:
  push BP
  mov BP, SP
  isub SP, 4
__if_23062_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23062_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 30
  mov CR, 2
  movs
  jmp __if_23062_end
__if_23062_else:
__if_23073_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23073_else
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
  jmp __if_23073_end
__if_23073_else:
__if_23089_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23089_else
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, [BP+2]
  iadd R12, 38
  iadd R12, 32
  mov CR, 2
  movs
  jmp __if_23089_end
__if_23089_else:
__if_23100_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_23100_else
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
  jmp __if_23100_end
__if_23100_else:
__if_23116_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_23116_else
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
  jmp __if_23116_end
__if_23116_else:
  lea R13, [BP+3]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_23116_end:
__if_23100_end:
__if_23089_end:
__if_23073_end:
__if_23062_end:
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
__if_23141_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23141_end
  mov R1, [BP+2]
  iadd R1, 30
  iadd R1, 2
  mov R0, [R1]
  fmul R0, 2.000000
  jmp __function_b2GetShapeProjectedPerimeter_return
__if_23141_end:
__if_23152_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23152_end
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
__if_23152_end:
__if_23186_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23186_end
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
__for_23210_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 38
  iadd R2, 35
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_23210_end
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
__for_23210_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_23210_start
__for_23210_end:
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
__if_23186_end:
__if_23256_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_23256_end
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
__if_23256_end:
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
__if_23288_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23288_else
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
  jmp __if_23288_end
__if_23288_else:
__if_23300_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23300_else
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
  jmp __if_23300_end
__if_23300_else:
__if_23312_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23312_else
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
  jmp __if_23312_end
__if_23312_else:
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
__if_23312_end:
__if_23300_end:
__if_23288_end:
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
__if_23355_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_23355_else
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
  jmp __if_23355_end
__if_23355_else:
__if_23403_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_23403_else
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
  jmp __if_23403_end
__if_23403_else:
__if_23436_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_23436_end
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
__for_23462_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_23462_end
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
__for_23462_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_23462_start
__for_23462_end:
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
__if_23436_end:
__if_23403_end:
__if_23355_end:
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
__if_23611_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_23611_end
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
__if_23611_end:
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
__if_23645_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_23645_end
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
__if_23645_end:
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
__if_23763_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23763_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 1
  mov [SP+1], R1
  call __function_b2GrowBitSet
__if_23763_end:
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
__if_23798_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23798_end
  jmp __function_b2ClearBit_return
__if_23798_end:
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
__if_23831_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_23831_end
  mov R0, 0
  jmp __function_b2GetBit_return
__if_23831_end:
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
  jt R0, __LogicalOr_ShortCircuit_23983
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP+3]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ine R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_23983:
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
__while_24003_start:
__while_24003_continue:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-2]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  jf R1, __LogicalAnd_ShortCircuit_24007
  mov R4, [BP+2]
  mov R3, [R4]
  mov R4, [BP-2]
  imul R4, 2
  iadd R3, R4
  mov R2, [R3]
  mov R3, [BP+3]
  ieq R2, R3
  jf R2, __LogicalAnd_ShortCircuit_24022
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
__LogicalAnd_ShortCircuit_24022:
  bnot R2
  and R1, R2
__LogicalAnd_ShortCircuit_24007:
  mov R0, R1
  jf R0, __while_24003_end
  mov R0, [BP-2]
  iadd R0, 1
  mov R1, [BP-1]
  isub R1, 1
  and R0, R1
  mov [BP-2], R0
  jmp __while_24003_start
__while_24003_end:
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
__if_24042_start:
  mov R0, [BP+2]
  igt R0, 16
  jf R0, __if_24042_else
  mov R2, [BP+2]
  mov [SP], R2
  call __function_b2RoundUpPowerOf2
  mov R1, R0
  mov R2, [BP+3]
  iadd R2, 1
  mov [R2], R1
  mov R0, R1
  jmp __if_24042_end
__if_24042_else:
  mov R0, 16
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
__if_24042_end:
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
__for_24191_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_24191_end
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
__if_24213_start:
  mov R0, [BP-4]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_24218
  mov R1, [BP-5]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_24218:
  jf R0, __if_24213_end
  jmp __for_24191_continue
__if_24213_end:
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
__for_24191_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_24191_start
__for_24191_end:
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
__if_24242_start:
  mov R0, [BP+2]
  mov R1, [BP+3]
  ilt R0, R1
  jf R0, __if_24242_else
  mov R0, [BP+2]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_24242_end
__if_24242_else:
  mov R0, [BP+3]
  lea R1, [BP+4]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  lea R1, [BP+5]
  mov R1, [R1]
  mov [R1], R0
__if_24242_end:
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
  jf R0, __LogicalAnd_ShortCircuit_24304
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
__LogicalAnd_ShortCircuit_24304:
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
__if_24334_start:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2SlotOccupied
  jf R0, __if_24334_end
  mov R0, 1
  jmp __function_b2AddKey_return
__if_24334_end:
__if_24340_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  imul R0, 2
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_24340_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2GrowTable
__if_24340_end:
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
__if_24384_start:
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP-4]
  mov [SP+1], R2
  call __function_b2SlotOccupied
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_24384_end
  mov R0, 0
  jmp __function_b2RemoveKey_return
__if_24384_end:
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
__while_24420_start:
__while_24420_continue:
  mov R0, 1
  jf R0, __while_24420_end
  mov R0, [BP-6]
  iadd R0, 1
  mov R1, [BP-5]
  isub R1, 1
  and R0, R1
  mov [BP-6], R0
__if_24434_start:
  mov R2, [BP+2]
  mov R1, [R2]
  mov R2, [BP-6]
  imul R2, 2
  iadd R1, R2
  mov R0, [R1]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_24447
  mov R3, [BP+2]
  mov R2, [R3]
  mov R3, [BP-6]
  imul R3, 2
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_24447:
  jf R0, __if_24434_end
  jmp __while_24420_end
__if_24434_end:
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
__if_24472_start:
  mov R0, [BP-4]
  mov R1, [BP-6]
  ile R0, R1
  jf R0, __if_24472_else
__if_24477_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_24482
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_24482:
  jf R0, __if_24477_end
  jmp __while_24420_continue
__if_24477_end:
  jmp __if_24472_end
__if_24472_else:
__if_24487_start:
  mov R0, [BP-4]
  mov R1, [BP-8]
  ilt R0, R1
  jt R0, __LogicalOr_ShortCircuit_24492
  mov R1, [BP-8]
  mov R2, [BP-6]
  ile R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_24492:
  jf R0, __if_24487_end
  jmp __while_24420_continue
__if_24487_end:
__if_24472_end:
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
  jmp __while_24420_start
__while_24420_end:
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
__for_24555_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_24555_end
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
__for_24555_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24555_start
__for_24555_end:
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
__for_24607_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_24607_end
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
__for_24607_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24607_start
__for_24607_end:
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
__if_24641_start:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_24641_end
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
__if_24641_end:
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
__if_24674_start:
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
  jf R0, __if_24674_end
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
__if_24674_end:
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
__if_24737_start:
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
  jf R0, __if_24737_end
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
__for_24759_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_24759_end
__if_24769_start:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-4]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_24769_end
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
  jmp __for_24759_end
__if_24769_end:
__for_24759_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_24759_start
__for_24759_end:
__if_24737_end:
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
__for_24799_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 3
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_24799_end
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
__for_24799_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_24799_start
__for_24799_end:
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
__if_24863_start:
  mov R0, [BP+3]
  ine R0, 0
  jf R0, __if_24863_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2BufferMove
__if_24863_end:
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
__if_25016_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_25016_end
  mov R0, [BP+2]
  jmp __function_b2ContactEdgeAt_return
__if_25016_end:
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
  jt R0, __LogicalOr_ShortCircuit_25042
  mov R1, [BP+2]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_25042:
  mov [BP-1], R0
  mov R0, [BP+3]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_25052
  mov R1, [BP+3]
  ieq R1, 4
  or R0, R1
__LogicalOr_ShortCircuit_25052:
  mov [BP-2], R0
__if_25055_start:
  mov R0, [BP-1]
  jf R0, __LogicalAnd_ShortCircuit_25057
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_25057:
  jf R0, __if_25055_end
  mov R0, 0
  jmp __function_b2CanCollide_return
__if_25055_end:
  mov R0, 1
__function_b2CanCollide_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_b2ShapeCollisionRank:
  push BP
  mov BP, SP
__if_25065_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_25065_end
  mov R0, 0
  jmp __function_b2ShapeCollisionRank_return
__if_25065_end:
__if_25071_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_25071_end
  mov R0, 1
  jmp __function_b2ShapeCollisionRank_return
__if_25071_end:
__if_25077_start:
  mov R0, [BP+2]
  ieq R0, 3
  jf R0, __if_25077_end
  mov R0, 2
  jmp __function_b2ShapeCollisionRank_return
__if_25077_end:
__if_25083_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_25083_end
  mov R0, 3
  jmp __function_b2ShapeCollisionRank_return
__if_25083_end:
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
__if_25117_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_25117_else
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
  jmp __if_25117_end
__if_25117_else:
__if_25131_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_25131_else
__if_25136_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25136_else
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
  jmp __if_25136_end
__if_25136_else:
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
__if_25136_end:
  jmp __if_25131_end
__if_25131_else:
__if_25158_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_25158_else
__if_25163_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25163_else
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
  jmp __if_25163_end
__if_25163_else:
__if_25176_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25176_else
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
  jmp __if_25176_end
__if_25176_else:
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
__if_25176_end:
__if_25163_end:
  jmp __if_25158_end
__if_25158_else:
__if_25198_start:
  mov R0, [BP-1]
  ieq R0, 4
  jf R0, __if_25198_else
__if_25203_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25203_else
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
  jmp __if_25203_end
__if_25203_else:
__if_25216_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25216_else
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
  jmp __if_25216_end
__if_25216_else:
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
__if_25216_end:
__if_25203_end:
  jmp __if_25198_end
__if_25198_else:
__if_25257_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_25257_else
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
  jmp __if_25257_end
__if_25257_else:
__if_25270_start:
  mov R0, [BP-2]
  ieq R0, 1
  jf R0, __if_25270_else
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
  jmp __if_25270_end
__if_25270_else:
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
__if_25270_end:
__if_25257_end:
__if_25198_end:
__if_25158_end:
__if_25131_end:
__if_25117_end:
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
__if_25379_start:
  mov R0, [BP+3]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_25384
  mov R1, [BP+4]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_25384:
  jf R0, __if_25379_else
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
  jmp __if_25379_end
__if_25379_else:
__if_25400_start:
  mov R0, [BP+3]
  ige R0, 2
  jf R0, __LogicalAnd_ShortCircuit_25405
  mov R1, [BP+7]
  mov R2, [BP-1]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_25405:
  jf R0, __if_25400_end
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
__if_25400_end:
__if_25379_end:
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
__if_25535_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_25535_end
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
__if_25535_end:
__if_25557_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_25557_end
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
__if_25557_end:
__if_25579_start:
  mov R0, [BP-12]
  ige R0, 1
  jf R0, __if_25579_end
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
__if_25579_end:
__if_25598_start:
  mov R0, [BP-12]
  ige R0, 2
  jf R0, __if_25598_end
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
__if_25598_end:
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
__if_25650_start:
  mov R0, [BP-25]
  jf R0, __if_25650_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 65536
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25650_end
__if_25650_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -65537
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25650_end:
__if_25667_start:
  mov R0, [BP-25]
  jf R0, __LogicalAnd_ShortCircuit_25669
  mov R2, [BP+3]
  iadd R2, 22
  mov R1, [R2]
  jt R1, __LogicalOr_ShortCircuit_25673
  mov R3, [BP+6]
  iadd R3, 22
  mov R2, [R3]
  or R1, R2
__LogicalOr_ShortCircuit_25673:
  and R0, R1
__LogicalAnd_ShortCircuit_25669:
  jf R0, __if_25667_else
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  or R0, 1048576
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
  jmp __if_25667_end
__if_25667_else:
  mov R1, [BP+2]
  iadd R1, 41
  mov R0, [R1]
  and R0, -1048577
  mov R1, [BP+2]
  iadd R1, 41
  mov [R1], R0
__if_25667_end:
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
__if_25705_start:
  mov R0, [BP+2]
  feq R0, 0.000000
  jf R0, __if_25705_end
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
__if_25705_end:
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
__if_26118_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_26118_end
  mov R0, [BP+2]
  iadd R0, 4
  jmp __function_b2JointEdgeAt_return
__if_26118_end:
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
  jf R0, __LogicalAnd_ShortCircuit_26496
  mov R2, [BP+3]
  iadd R2, 23
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_26496:
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
__for_26906_start:
  mov R0, [BP-1]
  ilt R0, 3
  jf R0, __for_26906_end
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
__for_26906_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_26906_start
__for_26906_end:
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
__for_27084_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27084_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 16
  iadd R0, R1
  mov [BP-2], R0
__if_27104_start:
  mov R1, [BP-2]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27104_end
  mov R2, [BP-2]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_27104_end:
__if_27119_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27119_end
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
__if_27119_end:
__if_27134_start:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27134_end
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
__if_27134_end:
__if_27149_start:
  mov R1, [BP-2]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27149_end
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
__if_27149_end:
__if_27164_start:
  mov R1, [BP-2]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27164_end
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
__if_27164_end:
__for_27084_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_27084_start
__for_27084_end:
__if_27179_start:
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27179_end
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
__if_27179_end:
__if_27194_start:
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27194_end
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
__if_27194_end:
__if_27209_start:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27209_end
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
__if_27209_end:
  mov R1, [BP+2]
  iadd R1, 21
  mov [SP], R1
  call __function_b2DestroyBroadPhase
__if_27228_start:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27228_end
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
__if_27228_end:
__if_27243_start:
  mov R1, [BP+2]
  iadd R1, 40
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27243_end
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
__if_27243_end:
  mov R0, 0
  mov [BP-1], R0
__for_27258_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27258_end
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 13
  iadd R0, R1
  mov [BP-2], R0
__if_27278_start:
  mov R1, [BP-2]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27278_end
  mov R2, [BP-2]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-2]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27278_end:
__if_27288_start:
  mov R1, [BP-2]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27288_end
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
__if_27288_end:
__if_27300_start:
  mov R1, [BP-2]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27300_end
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
__if_27300_end:
__for_27258_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_27258_start
__for_27258_end:
__if_27312_start:
  mov R1, [BP+2]
  iadd R1, 47
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27312_end
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
__if_27312_end:
__if_27327_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27327_end
  mov R2, [BP+2]
  iadd R2, 65
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27327_end:
__if_27337_start:
  mov R1, [BP+2]
  iadd R1, 67
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27337_end
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
__if_27337_end:
__if_27352_start:
  mov R1, [BP+2]
  iadd R1, 70
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27352_end
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
__if_27352_end:
__if_27367_start:
  mov R1, [BP+2]
  iadd R1, 73
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27367_end
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
__if_27367_end:
__if_27382_start:
  mov R1, [BP+2]
  iadd R1, 76
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27382_end
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
__if_27382_end:
__if_27397_start:
  mov R1, [BP+2]
  iadd R1, 79
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27397_end
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
__if_27397_end:
__if_27412_start:
  mov R1, [BP+2]
  iadd R1, 82
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27412_end
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
__if_27412_end:
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
__if_27457_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_27457_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP+3]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
  mov R0, 1
  jmp __function_b2WakeBody_return
__if_27457_end:
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
__if_27480_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 47
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_27480_end
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
__if_27480_end:
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
__if_27635_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_27635_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_27635_end:
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
__if_27674_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_27674_end
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
__if_27674_end:
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov [R1], R0
__if_27715_start:
  mov R1, [BP-1]
  iadd R1, 4
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27715_end
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 6
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2Free
__if_27715_end:
__if_27725_start:
  mov R1, [BP-1]
  iadd R1, 7
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27725_end
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
__if_27725_end:
__if_27737_start:
  mov R1, [BP-1]
  iadd R1, 10
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_27737_end
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
__if_27737_end:
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
__if_27816_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_27816_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27816_end:
__if_27822_start:
  mov R0, [BP+3]
  ieq R0, -1
  jf R0, __if_27822_end
  mov R0, [BP+4]
  jmp __function_b2MergeIslands_return
__if_27822_end:
__if_27830_start:
  mov R0, [BP+4]
  ieq R0, -1
  jf R0, __if_27830_end
  mov R0, [BP+3]
  jmp __function_b2MergeIslands_return
__if_27830_end:
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
__if_27858_start:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_27858_else
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
  jmp __if_27858_end
__if_27858_else:
  mov R0, [BP-2]
  mov [BP-3], R0
  mov R0, [BP-1]
  mov [BP-4], R0
__if_27858_end:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-5], R0
  mov R0, 0
  mov [BP-6], R0
__for_27884_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27884_end
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
__for_27884_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27884_start
__for_27884_end:
  mov R0, 0
  mov [BP-6], R0
__for_27946_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_27946_end
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
__for_27946_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_27946_start
__for_27946_end:
  mov R0, 0
  mov [BP-6], R0
__for_28009_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_28009_end
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
__for_28009_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_28009_start
__for_28009_end:
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
__if_28228_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28228_end
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
__if_28228_end:
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
__if_28404_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_28404_end
  jmp __function_b2UnlinkJoint_return
__if_28404_end:
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
__if_28434_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28434_end
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
__if_28434_end:
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
__if_28533_start:
  mov R1, [BP+3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_28533_end
  jmp __function_b2RemoveBodyFromIsland_return
__if_28533_end:
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
__if_28563_start:
  mov R0, [BP-3]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_28563_end
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
__if_28563_end:
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
__if_28607_start:
  mov R1, [BP-2]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_28607_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2DestroyIsland
__if_28607_end:
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
__while_28618_start:
__while_28618_continue:
  mov R0, [BP+2]
  mov R1, [BP+3]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  ine R0, R1
  jf R0, __while_28618_end
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
  jmp __while_28618_start
__while_28618_end:
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
__if_28657_start:
  mov R0, [BP-1]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_28657_end
  jmp __function_b2IslandUnion_return
__if_28657_end:
__if_28662_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_28662_else
  mov R0, [BP-2]
  mov R1, [BP+2]
  mov R2, [BP-1]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28662_end
__if_28662_else:
__if_28675_start:
  mov R0, [BP+3]
  mov R1, [BP-1]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-2]
  iadd R1, R2
  mov R1, [R1]
  igt R0, R1
  jf R0, __if_28675_else
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov R2, [BP-2]
  iadd R1, R2
  mov [R1], R0
  jmp __if_28675_end
__if_28675_else:
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
__if_28675_end:
__if_28662_end:
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
__if_28750_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_28750_end
  jmp __function_b2SplitIsland_return
__if_28750_end:
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
__for_28765_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28765_end
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
__for_28765_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28765_start
__for_28765_end:
  mov R0, 0
  mov [BP-13], R0
__for_28785_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_28785_end
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
__if_28817_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28824
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28824:
  jf R0, __if_28817_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28817_end:
__for_28785_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28785_start
__for_28785_end:
  mov R0, 0
  mov [BP-13], R0
__for_28834_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_28834_end
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
__if_28866_start:
  mov R0, [BP-16]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_28873
  mov R1, [BP-17]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_28873:
  jf R0, __if_28866_end
  mov R1, [BP-11]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  mov R1, [BP-16]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_b2IslandUnion
__if_28866_end:
__for_28834_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28834_start
__for_28834_end:
  mov R1, [BP-12]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2Free
  mov R0, 0
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
__for_28889_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28889_end
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
__if_28906_start:
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-13]
  ieq R0, R1
  jf R0, __if_28906_end
  mov R0, [BP-14]
  iadd R0, 1
  mov [BP-14], R0
__if_28906_end:
__for_28889_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28889_start
__for_28889_end:
__if_28917_start:
  mov R0, [BP-14]
  ieq R0, 1
  jf R0, __if_28917_end
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
__if_28917_end:
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
__for_28973_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28973_end
  mov R0, -1
  mov R1, [BP-15]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__for_28973_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28973_start
__for_28973_end:
  mov R0, 0
  mov [BP-13], R0
__for_28989_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_28989_end
  mov R0, [BP-11]
  mov R1, [BP-13]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-16], R0
__if_29004_start:
  mov R0, [BP-15]
  mov R1, [BP-16]
  iadd R0, R1
  mov R0, [R0]
  ieq R0, -1
  jf R0, __if_29004_end
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
__if_29004_end:
__for_28989_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_28989_start
__for_28989_end:
  mov R0, 0
  mov [BP-13], R0
__for_29024_start:
  mov R0, [BP-13]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_29024_end
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
__for_29024_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_29024_start
__for_29024_end:
  mov R0, 0
  mov [BP-13], R0
__for_29099_start:
  mov R0, [BP-13]
  mov R1, [BP-5]
  ilt R0, R1
  jf R0, __for_29099_end
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
__if_29123_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_29123_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_29123_end:
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
__for_29099_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_29099_start
__for_29099_end:
  mov R0, 0
  mov [BP-13], R0
__for_29192_start:
  mov R0, [BP-13]
  mov R1, [BP-8]
  ilt R0, R1
  jf R0, __for_29192_end
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
__if_29216_start:
  mov R0, [BP-19]
  ieq R0, -1
  jf R0, __if_29216_end
  mov R2, [BP+2]
  iadd R2, 4
  mov R1, [R2]
  mov R2, [BP-16]
  imul R2, 21
  iadd R1, R2
  iadd R1, 10
  mov R0, [R1]
  mov [BP-19], R0
__if_29216_end:
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
__for_29192_continue:
  mov R0, [BP-13]
  iadd R0, 1
  mov [BP-13], R0
  jmp __for_29192_start
__for_29192_end:
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
__for_29324_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_29324_end
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
__if_29352_start:
  mov R1, [BP-5]
  iadd R1, 3
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_29358
  mov R1, [BP-4]
  mov R2, [BP-2]
  igt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_29358:
  jf R0, __if_29352_end
  mov R0, [BP-4]
  mov [BP-2], R0
__if_29352_end:
__for_29324_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_29324_start
__for_29324_end:
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
__if_29530_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29530_end
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
__if_29530_end:
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
  jt R0, __LogicalOr_ShortCircuit_29603
  mov R2, [BP+3]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_29603:
  jf R0, __LogicalAnd_ShortCircuit_29608
  mov R2, [BP+3]
  iadd R2, 19
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_29608:
  mov [BP-1], R0
__if_29613_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29613_else
  mov R0, 1
  mov [BP-2], R0
  jmp __if_29613_end
__if_29613_else:
__if_29622_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_29622_else
  mov R0, 0
  mov [BP-2], R0
  jmp __if_29622_end
__if_29622_else:
__if_29631_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_29631_else
  mov R0, 2
  mov [BP-2], R0
  jmp __if_29631_end
__if_29631_else:
  mov R2, [BP+2]
  iadd R2, 7
  mov [SP], R2
  call __function_b2AllocId
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
__if_29646_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_29646_end
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
__if_29646_end:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-2]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov [R1], R0
__if_29631_end:
__if_29622_end:
__if_29613_end:
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2AllocId
  mov [BP-3], R0
  mov R0, 0
  mov [BP-4], R0
__if_29788_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  jf R0, __if_29788_end
  mov R0, [BP-4]
  or R0, 1
  mov [BP-4], R0
__if_29788_end:
__if_29796_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  jf R0, __if_29796_end
  mov R0, [BP-4]
  or R0, 2
  mov [BP-4], R0
__if_29796_end:
__if_29804_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  jf R0, __if_29804_end
  mov R0, [BP-4]
  or R0, 4
  mov [BP-4], R0
__if_29804_end:
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
__if_29923_start:
  mov R1, [BP+3]
  iadd R1, 18
  mov R0, [R1]
  jf R0, __if_29923_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 16
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29923_end:
__if_29933_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_29933_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 128
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29933_end:
__if_29943_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_29943_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 512
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29943_end:
__if_29955_start:
  mov R1, [BP+3]
  iadd R1, 16
  mov R0, [R1]
  jf R0, __if_29955_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 2048
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29955_end:
__if_29965_start:
  mov R1, [BP+3]
  iadd R1, 21
  mov R0, [R1]
  jf R0, __if_29965_end
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 4096
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_29965_end:
__if_29975_start:
  mov R0, [BP-2]
  ieq R0, 2
  jf R0, __if_29975_end
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
__if_29975_end:
__if_30040_start:
  mov R0, [BP-3]
  mov R2, [BP+2]
  iadd R2, 4
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30040_end
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
__if_30040_end:
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
__if_30200_start:
  mov R0, [BP-2]
  ige R0, 2
  jf R0, __if_30200_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  call __function_b2CreateIslandForBody
__if_30200_end:
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
__while_30290_start:
__while_30290_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30290_end
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
  jmp __while_30290_start
__while_30290_end:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_30329_start:
__while_30329_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_30329_end
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
  jmp __while_30329_start
__while_30329_end:
  mov R1, [BP-1]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-4], R0
__while_30368_start:
__while_30368_continue:
  mov R0, [BP-4]
  ine R0, -1
  jf R0, __while_30368_end
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
  jmp __while_30368_start
__while_30368_end:
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
__if_30413_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_30413_else
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-6], R0
__if_30426_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  ine R0, R1
  jf R0, __if_30426_end
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
__if_30426_end:
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-5]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_30413_end
__if_30413_else:
__if_30452_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __LogicalAnd_ShortCircuit_30460
  mov R2, [BP-5]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_30460:
  jf R0, __if_30452_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2DestroySolverSet
__if_30452_end:
__if_30413_end:
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
__if_30533_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_30533_end
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
__if_30550_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_30550_end
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30560_start:
__while_30560_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30560_end
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
  jmp __while_30560_start
__while_30560_end:
__if_30550_end:
  jmp __function_b2UpdateBodyMassData_return
__if_30533_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-4]
  mov CR, 2
  movs
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30611_start:
__while_30611_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30611_end
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
  jmp __while_30611_start
__while_30611_end:
__if_30659_start:
  mov R1, [BP+3]
  iadd R1, 12
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30659_end
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
__if_30659_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30688_start:
__while_30688_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30688_end
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
__if_30709_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_30709_end
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
__if_30709_end:
  mov R1, [BP-8]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_30688_start
__while_30688_end:
__if_30749_start:
  mov R1, [BP+3]
  iadd R1, 13
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_30749_else
  mov R0, 1.000000
  mov R2, [BP+3]
  iadd R2, 13
  mov R1, [R2]
  fdiv R0, R1
  mov R1, [BP-1]
  iadd R1, 16
  mov [R1], R0
  jmp __if_30749_end
__if_30749_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 13
  mov [R1], R0
__if_30749_end:
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
__if_30793_start:
  mov R0, [BP-7]
  ine R0, -1
  jf R0, __if_30793_end
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
__if_30793_end:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-2], R0
__while_30835_start:
__while_30835_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_30835_end
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
  jmp __while_30835_start
__while_30835_end:
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
__if_30890_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 18
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_30890_end
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
__if_30890_end:
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_30941_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_30941_else
  mov R13, [BP-2]
  iadd R13, 30
  mov R12, [BP+5]
  mov CR, 3
  movs
  jmp __if_30941_end
__if_30941_else:
__if_30951_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_30951_else
  mov R13, [BP-2]
  iadd R13, 33
  mov R12, [BP+5]
  mov CR, 5
  movs
  jmp __if_30951_end
__if_30951_else:
__if_30961_start:
  mov R0, [BP+6]
  ieq R0, 3
  jf R0, __if_30961_else
  mov R13, [BP-2]
  iadd R13, 38
  mov R12, [BP+5]
  mov CR, 36
  movs
  jmp __if_30961_end
__if_30961_else:
__if_30971_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_30971_else
  mov R13, [BP-2]
  iadd R13, 74
  mov R12, [BP+5]
  mov CR, 4
  movs
  jmp __if_30971_end
__if_30971_else:
__if_30981_start:
  mov R0, [BP+6]
  ieq R0, 4
  jf R0, __if_30981_end
  mov R13, [BP-2]
  iadd R13, 78
  mov R12, [BP+5]
  mov CR, 9
  movs
__if_30981_end:
__if_30971_end:
__if_30961_end:
__if_30951_end:
__if_30941_end:
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
__if_31074_start:
  mov R1, [BP+3]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_31074_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_31074_end
__if_31074_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-2]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_31074_end:
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
__if_31116_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 1
  jf R0, __if_31116_end
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
__if_31116_end:
__if_31247_start:
  mov R1, [BP+3]
  iadd R1, 5
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31247_end
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
__if_31247_end:
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
__if_31311_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31311_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31311_end:
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
__if_31353_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31353_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31353_end:
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
__if_31437_start:
  mov R1, [BP+4]
  iadd R1, 10
  mov R0, [R1]
  jf R0, __if_31437_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31437_end:
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
__if_31782_start:
  mov R0, [BP+4]
  jf R0, __if_31782_end
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
__while_31789_start:
__while_31789_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_31789_end
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
__if_31820_start:
  mov R1, [BP-6]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-1]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_31827
  mov R2, [BP-6]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-1]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_31827:
  jf R0, __if_31820_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 1
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_31820_end:
  jmp __while_31789_start
__while_31789_end:
__if_31782_end:
__if_31834_start:
  mov R1, [BP+3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31834_end
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
__if_31834_end:
__if_31851_start:
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31851_end
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
__if_31851_end:
__if_31868_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 5
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_31868_end
  mov R1, [BP+3]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 5
  mov [R1], R0
__if_31868_end:
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-2]
  iadd R1, 6
  mov [R1], R0
__if_31885_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31885_end
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
__if_31885_end:
__if_31905_start:
  mov R1, [BP+3]
  iadd R1, 26
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_31905_end
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
__if_31905_end:
  mov R1, [BP+2]
  iadd R1, 14
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2FreeId
  mov R0, -1
  mov R1, [BP+3]
  mov [R1], R0
__if_31941_start:
  mov R0, [BP+5]
  jf R0, __if_31941_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_b2UpdateBodyMassData
__if_31941_end:
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
__while_32015_start:
__while_32015_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_32015_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_32030_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_32030_end
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
__if_32030_end:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-3], R0
  jmp __while_32015_start
__while_32015_end:
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
__if_32385_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32385_end
  mov R0, 0.000000
  mov R1, [BP+4]
  mov [R1], R0
  mov R0, 0.000000
  mov R1, [BP+4]
  iadd R1, 1
  mov [R1], R0
  jmp __function_b2Body_GetLinearVelocity_return
__if_32385_end:
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
__if_32417_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32417_end
  mov R0, 0.000000
  jmp __function_b2Body_GetAngularVelocity_return
__if_32417_end:
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
__if_32435_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_32435_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_32435_end:
__if_32441_start:
  mov R2, [BP+4]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  fgt R1, 0.000000
  mov R0, R1
  jf R0, __if_32441_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32441_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_32454_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32454_end
  jmp __function_b2Body_SetLinearVelocity_return
__if_32454_end:
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
__if_32473_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_32473_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_32473_end:
__if_32479_start:
  mov R0, [BP+4]
  fne R0, 0.000000
  jf R0, __if_32479_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32479_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2GetBodyState
  mov [BP-2], R0
__if_32491_start:
  mov R0, [BP-2]
  ieq R0, -1
  jf R0, __if_32491_end
  jmp __function_b2Body_SetAngularVelocity_return
__if_32491_end:
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
__if_32564_start:
  mov R0, [BP+5]
  jf R0, __if_32564_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32564_end:
__if_32569_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32569_end
  jmp __function_b2Body_ApplyForceToCenter_return
__if_32569_end:
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
__if_32598_start:
  mov R0, [BP+5]
  jf R0, __if_32598_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32598_end:
__if_32603_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32603_end
  jmp __function_b2Body_ApplyTorque_return
__if_32603_end:
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
__if_32695_start:
  mov R0, [BP+5]
  jf R0, __if_32695_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_32695_end:
__if_32700_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_32700_end
  jmp __function_b2Body_ApplyLinearImpulseToCenter_return
__if_32700_end:
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
__while_33543_start:
__while_33543_continue:
  mov R0, [BP-3]
  ine R0, -1
  jf R0, __while_33543_end
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
__if_33574_start:
  mov R1, [BP-10]
  iadd R1, 11
  mov R0, [R1]
  mov R1, [BP-2]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_33581
  mov R2, [BP-10]
  iadd R2, 12
  mov R1, [R2]
  mov R2, [BP-2]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_33581:
  jf R0, __if_33574_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-10]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_33574_end:
  jmp __while_33543_start
__while_33543_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  call __function_b2GetBodyTransformQuick
__if_33595_start:
  mov R1, [BP+3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_33595_else
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
__if_33615_start:
  mov R0, [BP+5]
  jf R0, __if_33615_else
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
  jmp __if_33615_end
__if_33615_else:
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
__if_33615_end:
  jmp __if_33595_end
__if_33595_else:
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-7]
  mov [SP+1], R1
  call __function_b2UpdateShapeAABBs
__if_33595_end:
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
__if_33670_start:
  mov R0, [BP+4]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  feq R0, R1
  jf R0, __if_33670_end
  jmp __function_b2Shape_SetDensity_return
__if_33670_end:
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_33680_start:
  mov R0, [BP+5]
  jf R0, __if_33680_end
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
__if_33680_end:
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
__if_33937_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_33937_end
  mov R1, [BP-1]
  iadd R1, 23
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
__if_33937_end:
__function_b2SyncBodyFlags_return:
  mov SP, BP
  pop BP
  ret

__function_b2Body_SetLinearDamping:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-1], R0
  mov R1, [BP+4]
  mov R4, [BP+2]
  mov [SP], R4
  mov R4, [BP-1]
  mov [SP+1], R4
  call __function_b2GetBodySim
  mov R3, R0
  iadd R3, 19
  mov R2, [R3]
  mov R3, [BP+2]
  mov [SP], R3
  mov R3, [BP-1]
  mov [SP+1], R3
  call __function_b2GetBodySim
  mov R2, R0
  iadd R2, 19
  mov [R2], R1
  mov R0, R1
__function_b2Body_SetLinearDamping_return:
  mov SP, BP
  pop BP
  ret

__function_b2TransferBody:
  push BP
  mov BP, SP
  isub SP, 8
__if_35132_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_35132_end
  jmp __function_b2TransferBody_return
__if_35132_end:
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
__if_35211_start:
  mov R1, [BP+4]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_35211_else
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-4], R0
__if_35224_start:
  mov R0, [BP-1]
  mov R1, [BP-4]
  ine R0, R1
  jf R0, __if_35224_end
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
__if_35224_end:
  mov R0, [BP-4]
  mov R1, [BP+4]
  iadd R1, 3
  iadd R1, 1
  mov [R1], R0
  jmp __if_35211_end
__if_35211_else:
__if_35244_start:
  mov R1, [BP+3]
  iadd R1, 15
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_35244_end
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
__if_35244_end:
__if_35211_end:
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
__if_35314_start:
  mov R0, [BP+3]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __if_35314_end
  jmp __function_b2TransferJoint_return
__if_35314_end:
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
__if_35373_start:
  mov R0, [BP-1]
  mov R1, [BP-3]
  ine R0, R1
  jf R0, __if_35373_end
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
__if_35373_end:
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
__while_35433_start:
__while_35433_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_35433_end
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
  jmp __while_35433_start
__while_35433_end:
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
__while_35475_start:
__while_35475_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_35475_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-1]
  imul R1, 87
  iadd R0, R1
  mov [BP-2], R0
__if_35490_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_35490_end
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
__if_35490_end:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_35475_start
__while_35475_end:
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
__while_35529_start:
__while_35529_continue:
  mov R0, [BP-5]
  ine R0, -1
  jf R0, __while_35529_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-5]
  imul R1, 87
  iadd R0, R1
  mov [BP-6], R0
__if_35544_start:
  mov R0, [BP+4]
  ieq R0, 0
  jf R0, __if_35544_else
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.005000
  fmul R1, 4.000000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
  jmp __if_35544_end
__if_35544_else:
  call __function_b2GetLengthUnitsPerMeter
  mov R1, R0
  fmul R1, 0.050000
  mov R2, [BP-6]
  iadd R2, 17
  mov [R2], R1
  mov R0, R1
__if_35544_end:
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
  jmp __while_35529_start
__while_35529_end:
__function_b2CreateBodyProxies_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_EnableContinuous:
  push BP
  mov BP, SP
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 52
  mov [R1], R0
__function_b2World_EnableContinuous_return:
  mov SP, BP
  pop BP
  ret

__function_b2World_EnableSleeping:
  push BP
  mov BP, SP
  isub SP, 3
__if_36409_start:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 51
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_36409_end
  jmp __function_b2World_EnableSleeping_return
__if_36409_end:
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 51
  mov [R1], R0
__if_36419_start:
  mov R0, [BP+3]
  ieq R0, 0
  jf R0, __if_36419_end
  mov R0, 3
  mov [BP-1], R0
__for_36426_start:
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_36426_end
__if_36438_start:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  mov R2, [BP-1]
  imul R2, 16
  iadd R1, R2
  iadd R1, 15
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_36438_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-1]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_36438_end:
__for_36426_continue:
  mov R0, [BP-1]
  iadd R0, 1
  mov [BP-1], R0
  jmp __for_36426_start
__for_36426_end:
__if_36419_end:
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
__if_36516_start:
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
  jf R0, __if_36516_end
  mov R0, 1
  jmp __function_b2OverlapFilterCallback_return
__if_36516_end:
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
__if_36558_start:
  mov R0, [BP+4]
  ine R0, -1
  jf R0, __if_36558_end
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
__if_36558_end:
  mov R0, 0
  mov [BP-7], R0
__for_36589_start:
  mov R0, [BP-7]
  ilt R0, 3
  jf R0, __for_36589_end
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
__for_36589_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_36589_start
__for_36589_end:
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
__if_36658_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_36669
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
__LogicalAnd_ShortCircuit_36669:
  mov R0, R1
  jf R0, __if_36658_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2RayCastClosestCallback_return
__if_36658_end:
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
__if_36741_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_36741_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_36741_end
__if_36741_else:
__if_36754_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_36754_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_36754_end
__if_36754_else:
__if_36767_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_36767_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_36767_end
__if_36767_else:
__if_36780_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_36780_end
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
__if_36780_end:
__if_36767_end:
__if_36754_end:
__if_36741_end:
__if_36794_start:
  mov R0, [BP-12]
  jf R0, __LogicalAnd_ShortCircuit_36797
  mov R1, [BP-14]
  mov R3, [BP+2]
  iadd R3, 4
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_36797:
  jf R0, __if_36794_end
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
__if_36794_end:
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
__if_36912_start:
  mov R0, [BP+5]
  ine R0, -1
  jf R0, __if_36912_end
  mov R1, [BP+5]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-16], R0
__if_36912_end:
  mov R0, 0
  mov [BP-17], R0
__for_36922_start:
  mov R0, [BP-17]
  ilt R0, 3
  jf R0, __for_36922_end
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
__if_36950_start:
  mov R0, [BP-2]
  jf R0, __if_36950_end
  mov R0, [BP-4]
  mov [BP-11], R0
__if_36950_end:
__for_36922_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_36922_start
__for_36922_end:
  lea R13, [BP+6]
  mov R13, [R13]
  lea R12, [BP-8]
  mov CR, 7
  movs
__if_36965_start:
  mov R0, [BP-2]
  ieq R0, 0
  jf R0, __if_36965_end
  mov R0, 0.000000
  mov R1, [BP+6]
  iadd R1, 4
  mov [R1], R0
__if_36965_end:
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
__if_37011_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37022
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
__LogicalAnd_ShortCircuit_37022:
  mov R0, R1
  jf R0, __if_37011_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2ShapeCastClosestCallback_return
__if_37011_end:
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
__if_37077_start:
  mov R0, [BP-29]
  jf R0, __LogicalAnd_ShortCircuit_37080
  mov R1, [BP-31]
  mov R3, [BP+2]
  iadd R3, 6
  mov R2, [R3]
  fle R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_37080:
  jf R0, __if_37077_end
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
__if_37077_end:
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
__if_37577_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37588
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
__LogicalAnd_ShortCircuit_37588:
  mov R0, R1
  jf R0, __if_37577_end
  mov R1, [BP+2]
  iadd R1, 4
  mov R0, [R1]
  jmp __function_b2WorldRayCastCallback_return
__if_37577_end:
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
__if_37660_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_37660_else
  mov R1, [BP-3]
  iadd R1, 30
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCircle
  jmp __if_37660_end
__if_37660_else:
__if_37673_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 1
  jf R0, __if_37673_else
  mov R1, [BP-3]
  iadd R1, 33
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastCapsule
  jmp __if_37673_end
__if_37673_else:
__if_37686_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_37686_else
  mov R1, [BP-3]
  iadd R1, 38
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  lea R1, [BP-18]
  mov [SP+2], R1
  call __function_b2RayCastPolygon
  jmp __if_37686_end
__if_37686_else:
__if_37699_start:
  mov R1, [BP-3]
  iadd R1, 4
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_37699_end
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
__if_37699_end:
__if_37686_end:
__if_37673_end:
__if_37660_end:
__if_37713_start:
  mov R0, [BP-12]
  jf R0, __if_37713_end
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
__if_37748_start:
  mov R0, [BP-26]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37753
  mov R1, [BP-26]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37753:
  jf R0, __if_37748_end
  mov R0, [BP-26]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37748_end:
  mov R0, [BP-26]
  jmp __function_b2WorldRayCastCallback_return
__if_37713_end:
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
__if_37883_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_37894
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
__LogicalAnd_ShortCircuit_37894:
  mov R0, R1
  jf R0, __if_37883_end
  mov R1, [BP+2]
  iadd R1, 6
  mov R0, [R1]
  jmp __function_b2WorldShapeCastCallback_return
__if_37883_end:
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
__if_37949_start:
  mov R0, [BP-29]
  jf R0, __if_37949_end
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
__if_37984_start:
  mov R0, [BP-43]
  fge R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_37989
  mov R1, [BP-43]
  fle R1, 1.000000
  and R0, R1
__LogicalAnd_ShortCircuit_37989:
  jf R0, __if_37984_end
  mov R0, [BP-43]
  mov R1, [BP-1]
  iadd R1, 24
  mov [R1], R0
__if_37984_end:
  mov R0, [BP-43]
  jmp __function_b2WorldShapeCastCallback_return
__if_37949_end:
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
__if_38273_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_38284
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
__LogicalAnd_ShortCircuit_38284:
  mov R0, R1
  jf R0, __if_38273_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_38273_end:
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
__if_38348_start:
  mov R0, [BP-56]
  mov R1, [BP-63]
  fgt R0, R1
  jf R0, __if_38348_end
  mov R0, 1
  jmp __function_b2WorldOverlapCallback_return
__if_38348_end:
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
__if_38363_start:
  mov R0, [BP-64]
  ieq R0, 0
  jf R0, __if_38363_end
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 5
  mov [R1], R0
__if_38363_end:
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
__if_38688_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  mov R3, [BP-1]
  iadd R3, 4
  mov R2, [R3]
  fadd R1, R2
  fgt R0, R1
  jf R0, __if_38688_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38688_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WakeBody
__if_38702_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_38702_end
  mov R0, 1
  jmp __function_b2ExplosionCallback_return
__if_38702_end:
  lea R12, [BP-67]
  lea DR, [BP-69]
  mov CR, 2
  movs
__if_38713_start:
  mov R0, [BP-61]
  feq R0, 0.000000
  jf R0, __if_38713_end
  mov R1, [BP-3]
  mov [SP], R1
  lea R1, [BP-69]
  mov [SP+1], R1
  call __function_b2GetShapeCentroid
__if_38713_end:
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
__if_38742_start:
  lea R2, [BP-71]
  mov [SP], R2
  call __function_b2LengthSquared
  mov R1, R0
  mov R2, [BP-72]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_38742_else
  lea R1, [BP-71]
  mov [SP], R1
  lea R1, [BP-89]
  mov [SP+1], R1
  call __function_b2Normalize
  lea R13, [BP-71]
  lea R12, [BP-89]
  mov CR, 2
  movs
  jmp __if_38742_end
__if_38742_else:
  mov R0, 1.000000
  mov [BP-71], R0
  mov R0, 0.000000
  mov [BP-70], R0
__if_38742_end:
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
__if_38784_start:
  mov R0, [BP-61]
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_38792
  mov R2, [BP-1]
  iadd R2, 4
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_38792:
  jf R0, __if_38784_end
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
__if_38784_end:
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
__if_39031_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_39042
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
__LogicalAnd_ShortCircuit_39042:
  mov R0, R1
  jf R0, __if_39031_end
  mov R0, 1
  jmp __function_b2MoverCollideCallback_return
__if_39031_end:
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
__if_39073_start:
  mov R1, [BP-6]
  jf R1, __LogicalAnd_ShortCircuit_39076
  lea R3, [BP-11]
  mov [SP], R3
  call __function_b2IsNormalized
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_39076:
  mov R0, R1
  jf R0, __if_39073_end
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
__if_39073_end:
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
__if_39238_start:
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ine R1, -1
  jf R1, __LogicalAnd_ShortCircuit_39249
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
__LogicalAnd_ShortCircuit_39249:
  mov R0, R1
  jf R0, __if_39238_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_39238_end:
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
__if_39289_start:
  mov R0, [BP-30]
  feq R0, 0.000000
  jf R0, __if_39289_end
  mov R1, [BP-1]
  iadd R1, 24
  mov R0, [R1]
  jmp __function_b2MoverCastCallback_return
__if_39289_end:
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
__if_39502_start:
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
  jf R0, __if_39502_end
  jmp __function_b2CreateContact_return
__if_39502_end:
__if_39511_start:
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
  jf R0, __if_39511_end
  mov R0, [BP+3]
  mov [BP-12], R0
  mov R0, [BP+4]
  mov [BP+3], R0
  mov R0, [BP-12]
  mov [BP+4], R0
__if_39511_end:
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
__if_39549_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jt R0, __LogicalOr_ShortCircuit_39556
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  or R0, R1
__LogicalOr_ShortCircuit_39556:
  jf R0, __if_39549_else
  mov R0, 2
  mov [BP-3], R0
  jmp __if_39549_end
__if_39549_else:
  mov R0, 1
  mov [BP-3], R0
__if_39549_end:
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
__if_39579_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 33
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_39579_end
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
__if_39579_end:
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
__if_39689_start:
  mov R1, [BP-1]
  iadd R1, 18
  mov R0, [R1]
  and R0, 4096
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_39702
  mov R2, [BP-2]
  iadd R2, 18
  mov R1, [R2]
  and R1, 4096
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_39702:
  jf R0, __if_39689_end
  mov R1, [BP-8]
  iadd R1, 14
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-8]
  iadd R1, 14
  mov [R1], R0
__if_39689_end:
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
__if_39745_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39745_end
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
__if_39745_end:
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
__if_39817_start:
  mov R1, [BP-2]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39817_end
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
__if_39817_end:
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
__if_39955_start:
  mov R1, [BP+3]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39955_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_39955_end:
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
__if_39990_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_39990_end
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
__if_39990_end:
__if_40019_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40019_end
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
__if_40019_end:
__if_40048_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_40048_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 3
  mov [R1], R0
__if_40048_end:
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
__if_40087_start:
  mov R1, [BP-5]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40087_end
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
__if_40087_end:
__if_40116_start:
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_40116_end
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
__if_40116_end:
__if_40145_start:
  mov R1, [BP-6]
  iadd R1, 3
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_40145_end
  mov R1, [BP-5]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-6]
  iadd R1, 3
  mov [R1], R0
__if_40145_end:
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
__if_40188_start:
  mov R0, [BP-8]
  mov R1, [BP-9]
  ine R0, R1
  jf R0, __if_40188_end
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
__if_40188_end:
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
__if_40263_start:
  mov R0, [BP+4]
  jf R0, __LogicalAnd_ShortCircuit_40265
  mov R1, [BP-2]
  and R0, R1
__LogicalAnd_ShortCircuit_40265:
  jf R0, __if_40263_end
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
__if_40263_end:
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
__if_40325_start:
  mov R1, [BP+3]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 64
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_40325_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40325_end:
__if_40333_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_40340
  mov R2, [BP+3]
  mov R1, [R2]
  mov R3, [BP+2]
  iadd R3, 33
  iadd R3, 1
  mov R2, [R3]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_40340:
  jf R0, __if_40333_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40333_end:
  mov R1, [BP+2]
  iadd R1, 33
  mov R0, [R1]
  mov R2, [BP+3]
  mov R1, [R2]
  isub R1, 1
  imul R1, 16
  iadd R0, R1
  mov [BP-1], R0
__if_40358_start:
  mov R1, [BP-1]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_40358_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40358_end:
__if_40367_start:
  mov R1, [BP-1]
  iadd R1, 15
  mov R0, [R1]
  mov R2, [BP+3]
  iadd R2, 2
  mov R1, [R2]
  ine R0, R1
  jf R0, __if_40367_end
  mov R0, 0
  jmp __function_b2Contact_IsValid_return
__if_40367_end:
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
__while_40694_start:
__while_40694_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40694_end
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
__if_40725_start:
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
  jf R0, __if_40725_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
__if_40725_end:
  jmp __while_40694_start
__while_40694_end:
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
__while_40754_start:
__while_40754_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_40754_end
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
__if_40787_start:
  mov R0, [BP-6]
  mov R1, [BP+4]
  ieq R0, R1
  jf R0, __LogicalAnd_ShortCircuit_40793
  mov R2, [BP-5]
  iadd R2, 16
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_40793:
  jf R0, __if_40787_end
  mov R0, 0
  jmp __function_b2ShouldBodiesCollide_return
__if_40787_end:
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
  jmp __while_40754_start
__while_40754_end:
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
__if_40839_start:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 1
  jt R0, __LogicalOr_ShortCircuit_40846
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 1
  or R0, R1
__LogicalOr_ShortCircuit_40846:
  jf R0, __if_40839_else
  mov R0, 1
  mov [BP-3], R0
  jmp __if_40839_end
__if_40839_else:
__if_40852_start:
  mov R1, [BP-1]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_40859
  mov R2, [BP-2]
  iadd R2, 19
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_40859:
  jf R0, __if_40852_else
  mov R0, 0
  mov [BP-3], R0
  jmp __if_40852_end
__if_40852_else:
  mov R0, 2
  mov [BP-3], R0
__if_40852_end:
__if_40839_end:
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
__if_40882_start:
  mov R0, [BP-5]
  mov R2, [BP+2]
  iadd R2, 40
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_40882_end
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
__if_40882_end:
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
__if_41020_start:
  mov R1, [BP-1]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41020_end
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
__if_41020_end:
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
__if_41091_start:
  mov R1, [BP-2]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41091_end
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
__if_41091_end:
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
__if_41234_start:
  mov R0, [BP+8]
  ieq R0, 0
  jf R0, __if_41234_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2DestroyContactsBetweenBodies
__if_41234_end:
__if_41242_start:
  mov R0, [BP-3]
  ige R0, 2
  jf R0, __if_41242_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2LinkJoint
__if_41242_end:
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
__if_41263_start:
  mov R1, [BP+3]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41263_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_b2UnlinkJoint
__if_41263_end:
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
__if_41305_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41305_end
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
__if_41305_end:
__if_41334_start:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41334_end
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
__if_41334_end:
__if_41363_start:
  mov R1, [BP-4]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 0
  ieq R0, R1
  jf R0, __if_41363_end
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-4]
  iadd R1, 8
  mov [R1], R0
__if_41363_end:
  mov R1, [BP-4]
  iadd R1, 9
  mov R0, [R1]
  isub R0, 1
  mov R1, [BP-4]
  iadd R1, 9
  mov [R1], R0
__if_41386_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41386_end
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
__if_41386_end:
__if_41415_start:
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_41415_end
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
__if_41415_end:
__if_41444_start:
  mov R1, [BP-5]
  iadd R1, 8
  mov R0, [R1]
  mov R1, [BP-1]
  shl R1, 1
  or R1, 1
  ieq R0, R1
  jf R0, __if_41444_end
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-5]
  iadd R1, 8
  mov [R1], R0
__if_41444_end:
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
__if_41487_start:
  mov R0, [BP-7]
  mov R1, [BP-8]
  ine R0, R1
  jf R0, __if_41487_end
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
__if_41487_end:
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
__if_41562_start:
  mov R0, [BP+4]
  jf R0, __if_41562_end
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
__if_41562_end:
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
__if_42337_start:
  mov R1, [BP+3]
  iadd R1, 20
  mov R0, [R1]
  jf R0, __if_42337_end
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
__if_42337_end:
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
__if_44955_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_44955_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44955_end
__if_44955_else:
__if_44969_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_44969_else
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-1]
  iadd R1, 23
  iadd R1, 10
  mov [SP+1], R1
  mov R1, [BP+4]
  mov [SP+2], R1
  call __function_b2MulSV
  jmp __if_44969_end
__if_44969_else:
__if_44983_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_44983_else
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
  jmp __if_44983_end
__if_44983_else:
__if_45009_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_45009_else
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
  jmp __if_45009_end
__if_45009_else:
__if_45096_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_45096_else
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
  jmp __if_45096_end
__if_45096_else:
__if_45164_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_45164_else
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
  jmp __if_45164_end
__if_45164_else:
  lea R13, [BP+4]
  mov R13, [R13]
  mov R12, global_b2Vec2_zero
  mov CR, 2
  movs
__if_45164_end:
__if_45096_end:
__if_45009_end:
__if_44983_end:
__if_44969_end:
__if_44955_end:
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
__if_45248_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_45248_end
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
__if_45248_end:
__if_45272_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_45272_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45272_end:
__if_45285_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_45285_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 1
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45285_end:
__if_45297_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_45297_end
  mov R0, [BP-2]
  mov R2, [BP-1]
  iadd R2, 23
  iadd R2, 12
  mov R1, [R2]
  fmul R0, R1
  jmp __function_b2GetJointConstraintTorque_return
__if_45297_end:
__if_45309_start:
  mov R1, [BP+3]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_45309_end
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
__if_45309_end:
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
__if_46092_start:
  mov R1, [BP-1]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46092_end
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  imul R1, 24
  mov [SP+1], R1
  call __function_b2Free
__if_46092_end:
__if_46107_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46107_end
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
__if_46107_end:
__if_46122_start:
  mov R1, [BP-1]
  iadd R1, 6
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46122_end
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
__if_46122_end:
__if_46137_start:
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46137_end
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
__if_46137_end:
__if_46152_start:
  mov R1, [BP-1]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_46152_end
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
__if_46152_end:
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
__if_46256_start:
  mov R0, [BP+3]
  ilt R0, 3
  jf R0, __if_46256_end
  jmp __function_b2WakeSolverSet_return
__if_46256_end:
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
__for_46279_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46279_end
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
__for_46279_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46279_start
__for_46279_end:
  mov R0, 0
  mov [BP-3], R0
__for_46417_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 6
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46417_end
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
__for_46417_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46417_start
__for_46417_end:
  mov R0, 0
  mov [BP-3], R0
__for_46493_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 9
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46493_end
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
__for_46493_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46493_start
__for_46493_end:
  mov R0, 0
  mov [BP-3], R0
__for_46569_start:
  mov R0, [BP-3]
  mov R2, [BP-1]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_46569_end
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
__for_46569_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_46569_start
__for_46569_end:
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
__for_46660_start:
  mov R0, [BP-2]
  ige R0, 0
  jf R0, __for_46660_end
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
__if_46739_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ine R0, 2
  jf R0, __LogicalAnd_ShortCircuit_46746
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  ine R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_46746:
  jf R0, __if_46739_end
  jmp __for_46660_continue
__if_46739_end:
__if_46750_start:
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
  jf R0, __if_46750_end
__if_46761_start:
  mov R1, [BP-8]
  jf R1, __LogicalAnd_ShortCircuit_46763
  mov R3, [BP-6]
  mov [SP], R3
  mov R3, [BP-7]
  mov [SP+1], R3
  call __function_b2ShouldReportContactEvents
  mov R2, R0
  and R1, R2
__LogicalAnd_ShortCircuit_46763:
  mov R0, R1
  jf R0, __if_46761_end
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
__if_46761_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  mov R1, 0
  mov [SP+2], R1
  call __function_b2DestroyContact
  jmp __for_46660_continue
__if_46750_end:
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
__if_46790_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46790_else
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  jmp __if_46790_end
__if_46790_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46790_end:
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
__if_46816_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46816_else
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  jmp __if_46816_end
__if_46816_else:
  mov R0, -1
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46816_end:
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
__if_46876_start:
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
  jf R0, __if_46876_else
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
  jmp __if_46876_end
__if_46876_else:
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
__if_46876_end:
__if_46916_start:
  mov R0, [BP-19]
  jf R0, __LogicalAnd_ShortCircuit_46918
  mov R1, [BP-8]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_46918:
  jf R0, __if_46916_else
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  or R0, 1
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_46930_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_46930_end
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
__if_46930_end:
__if_46942_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46942_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46942_end:
__if_46951_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ige R0, 3
  jf R0, __if_46951_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R2, [BP-10]
  iadd R2, 1
  mov R1, [R2]
  mov [SP+1], R1
  call __function_b2WakeSolverSet
__if_46951_end:
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
__if_46978_start:
  mov R1, [BP-9]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46978_end
  mov R1, [BP-9]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
__if_46978_end:
__if_46988_start:
  mov R1, [BP-10]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_46988_end
  mov R1, [BP-10]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
__if_46988_end:
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
  jmp __if_46916_end
__if_46916_else:
__if_47021_start:
  mov R0, [BP-19]
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_47026
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_47026:
  jf R0, __if_47021_end
  mov R1, [BP-5]
  iadd R1, 14
  mov R0, [R1]
  and R0, -2
  mov R1, [BP-5]
  iadd R1, 14
  mov [R1], R0
__if_47036_start:
  mov R1, [BP-6]
  mov [SP], R1
  mov R1, [BP-7]
  mov [SP+1], R1
  call __function_b2ShouldReportContactEvents
  jf R0, __if_47036_end
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
__if_47036_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-5]
  mov [SP+1], R1
  call __function_b2UnlinkContact
__if_47021_end:
__if_46916_end:
__if_47051_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_47051_end
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
__if_47051_end:
__if_47070_start:
  mov R1, [BP-3]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_47070_end
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
__if_47070_end:
__for_46660_continue:
  mov R0, [BP-2]
  isub R0, 1
  mov [BP-2], R0
  jmp __for_46660_start
__for_46660_end:
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
__if_47126_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47126_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47126_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  and R0, 3
  mov [BP-5], R0
__if_47141_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_47141_else
__if_47146_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __LogicalAnd_ShortCircuit_47152
  mov R1, [BP-4]
  mov R3, [BP-1]
  iadd R3, 1
  mov R2, [R3]
  ilt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_47152:
  jf R0, __if_47146_end
__if_47157_start:
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
  jf R0, __if_47157_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47157_end:
__if_47146_end:
  jmp __if_47141_end
__if_47141_else:
__if_47169_start:
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
  jf R0, __if_47169_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47169_end:
__if_47141_end:
__if_47180_start:
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
  jf R0, __if_47180_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47180_end:
__if_47194_start:
  mov R0, [BP-4]
  mov R2, [BP-1]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_47194_else
  mov R0, [BP+3]
  mov [BP-6], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-7], R0
  jmp __if_47194_end
__if_47194_else:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, [BP+3]
  mov [BP-7], R0
__if_47194_end:
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
__if_47231_start:
  mov R1, [BP-8]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-9]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47231_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47231_end:
__if_47239_start:
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
  jf R0, __if_47239_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47239_end:
__if_47249_start:
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
  jf R0, __if_47249_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47249_end:
__if_47261_start:
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
  jf R0, __if_47261_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47261_end:
__if_47272_start:
  mov R1, [BP-8]
  iadd R1, 24
  mov R0, [R1]
  jt R0, __LogicalOr_ShortCircuit_47275
  mov R2, [BP-9]
  iadd R2, 24
  mov R1, [R2]
  or R0, R1
__LogicalOr_ShortCircuit_47275:
  jf R0, __if_47272_end
  mov R0, 1
  jmp __function_b2PairQueryCallback_return
__if_47272_end:
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
__for_47299_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_47299_end
  mov R2, [BP-1]
  iadd R2, 2
  mov R0, [R2]
  mov R1, [BP-3]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-4], R0
__if_47315_start:
  mov R0, [BP-4]
  ieq R0, -1
  jf R0, __if_47315_end
  jmp __for_47299_continue
__if_47315_end:
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
__if_47369_start:
  mov R0, [BP-5]
  ieq R0, 2
  jf R0, __if_47369_end
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
__if_47369_end:
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
__for_47299_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_47299_start
__for_47299_end:
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
__if_47454_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47454_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47454_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_47469_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47469_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47469_end:
__if_47478_start:
  mov R1, [BP-4]
  iadd R1, 25
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_47478_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47478_end:
__if_47485_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_47485_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47485_end:
__if_47490_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_47490_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47490_end:
__if_47498_start:
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
  jf R0, __if_47498_end
  mov R0, 1
  jmp __function_b2SensorQueryCallback_return
__if_47498_end:
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
__if_47558_start:
  mov R0, [BP-59]
  mov R1, 1.000000
  mov R2, [global_b2_two_pow_23]
  fdiv R1, R2
  fmul R1, 10.000000
  flt R0, R1
  jf R0, __if_47558_end
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
__if_47558_end:
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
__for_47608_start:
  mov R0, [BP-2]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __for_47608_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_47626_start:
  mov R1, [BP-3]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_47626_end
  jmp __for_47608_continue
__if_47626_end:
__if_47634_start:
  mov R1, [BP-3]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_47634_end
  jmp __for_47608_continue
__if_47634_end:
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
  jf R0, __LogicalAnd_ShortCircuit_47670
  mov R2, [BP-3]
  iadd R2, 25
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_47670:
  mov [BP-12], R0
__if_47673_start:
  mov R0, [BP-12]
  jf R0, __if_47673_end
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
__for_47695_start:
  mov R0, [BP-25]
  ilt R0, 3
  jf R0, __for_47695_end
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
__for_47695_continue:
  mov R0, [BP-25]
  iadd R0, 1
  mov [BP-25], R0
  jmp __for_47695_start
__for_47695_end:
__if_47673_end:
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
__for_47739_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47739_end
  mov R0, [BP-16]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47757_start:
  mov R0, [BP-18]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47757_end
__if_47766_start:
  mov R0, [BP-14]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47766_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47757_end
__if_47766_end:
__for_47757_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47757_start
__for_47757_end:
__if_47777_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47777_end
  mov R1, [BP+2]
  iadd R1, 76
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47777_end:
__for_47739_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47739_start
__for_47739_end:
  mov R0, 0
  mov [BP-17], R0
__for_47788_start:
  mov R0, [BP-17]
  mov R1, [BP-15]
  ilt R0, R1
  jf R0, __for_47788_end
  mov R0, [BP-14]
  mov R1, [BP-17]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-19], R0
  mov R0, 0
  mov [BP-20], R0
  mov R0, 0
  mov [BP-18], R0
__for_47806_start:
  mov R0, [BP-18]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47806_end
__if_47815_start:
  mov R0, [BP-16]
  mov R1, [BP-18]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP-19]
  ieq R0, R1
  jf R0, __if_47815_end
  mov R0, 1
  mov [BP-20], R0
  jmp __for_47806_end
__if_47815_end:
__for_47806_continue:
  mov R0, [BP-18]
  iadd R0, 1
  mov [BP-18], R0
  jmp __for_47806_start
__for_47806_end:
__if_47826_start:
  mov R0, [BP-20]
  ieq R0, 0
  jf R0, __if_47826_end
  mov R1, [BP+2]
  iadd R1, 79
  mov [SP], R1
  mov R2, [BP-3]
  mov R1, [R2]
  mov [SP+1], R1
  mov R1, [BP-19]
  mov [SP+2], R1
  call __function_b2AddSensorEvent
__if_47826_end:
__for_47788_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47788_start
__for_47788_end:
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
__for_47848_start:
  mov R0, [BP-17]
  mov R1, [BP-13]
  ilt R0, R1
  jf R0, __for_47848_end
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
__for_47848_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_47848_start
__for_47848_end:
  mov R0, [BP-13]
  mov R1, [BP-3]
  iadd R1, 27
  mov [R1], R0
__for_47608_continue:
  mov R0, [BP-2]
  iadd R0, 1
  mov [BP-2], R0
  jmp __for_47608_start
__for_47608_end:
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
__for_47902_start:
  mov R0, [BP-7]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_47902_end
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
__if_47956_start:
  mov R1, [BP-8]
  iadd R1, 15
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_47956_else
  mov R1, [BP-8]
  iadd R1, 21
  mov R0, [R1]
  mov [BP-15], R0
  jmp __if_47956_end
__if_47956_else:
  mov R0, 0.000000
  mov [BP-15], R0
__if_47956_end:
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
__for_47902_continue:
  mov R0, [BP-7]
  iadd R0, 1
  mov [BP-7], R0
  jmp __for_47902_start
__for_47902_end:
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
__for_48065_start:
  mov R0, [BP-6]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_48065_end
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
__if_48089_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 1
  ine R0, 0
  jf R0, __if_48089_end
  mov R0, 0.000000
  mov [BP-9], R0
__if_48089_end:
__if_48101_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 2
  ine R0, 0
  jf R0, __if_48101_end
  mov R0, 0.000000
  mov [BP-8], R0
__if_48101_end:
__if_48113_start:
  mov R1, [BP-7]
  iadd R1, 3
  mov R0, [R1]
  and R0, 4
  ine R0, 0
  jf R0, __if_48113_end
  mov R0, 0.000000
  mov [BP-10], R0
__if_48113_end:
__if_48124_start:
  lea R2, [BP-9]
  mov [SP], R2
  lea R2, [BP-9]
  mov [SP+1], R2
  call __function_b2Dot
  mov R1, R0
  mov R2, [BP-4]
  fgt R1, R2
  mov R0, R1
  jf R0, __if_48124_end
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
__if_48124_end:
__if_48158_start:
  mov R0, [BP-10]
  mov R1, [BP-10]
  fmul R0, R1
  mov R1, [BP-5]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_48169
  mov R2, [BP-7]
  iadd R2, 3
  mov R1, [R2]
  and R1, 128
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_48169:
  jf R0, __if_48158_end
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
__if_48158_end:
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
__for_48065_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_48065_start
__for_48065_end:
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
__if_48257_start:
  mov R0, [BP+3]
  mov R2, [BP-3]
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_48257_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48257_end:
  mov R1, [BP-2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP+3]
  imul R1, 87
  iadd R0, R1
  mov [BP-4], R0
__if_48272_start:
  mov R1, [BP-4]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_48272_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48272_end:
__if_48281_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_48281_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48281_end:
__if_48289_start:
  mov R1, [BP-4]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_48289_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48289_end:
__if_48294_start:
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
  jf R0, __if_48294_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48294_end:
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
__if_48320_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_48320_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48320_end:
__if_48330_start:
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
  jf R0, __if_48330_end
  mov R0, 1
  jmp __function_b2ContinuousQueryCallback_return
__if_48330_end:
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
__if_48402_start:
  mov R0, [BP-64]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_48409
  mov R1, [BP-64]
  mov R3, [BP-1]
  iadd R3, 13
  mov R2, [R3]
  flt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_48409:
  jf R0, __if_48402_end
  mov R0, [BP-64]
  mov R1, [BP-1]
  iadd R1, 13
  mov [R1], R0
__if_48402_end:
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
__while_48500_start:
__while_48500_continue:
  mov R0, [BP-34]
  ine R0, -1
  jf R0, __while_48500_end
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
__if_48519_start:
  mov R1, [BP-35]
  iadd R1, 24
  mov R0, [R1]
  jf R0, __if_48519_end
  jmp __while_48500_continue
__if_48519_end:
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
__if_48606_start:
  mov R0, [BP-25]
  jf R0, __if_48606_end
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
__if_48606_end:
  jmp __while_48500_start
__while_48500_end:
__if_48639_start:
  mov R0, [BP-11]
  flt R0, 1.000000
  jf R0, __if_48639_else
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
  jmp __if_48639_end
__if_48639_else:
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
__if_48639_end:
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
__while_48748_start:
__while_48748_continue:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __while_48748_end
  mov R1, [BP+2]
  iadd R1, 18
  mov R0, [R1]
  mov R1, [BP-2]
  imul R1, 87
  iadd R0, R1
  mov [BP-3], R0
__if_48763_start:
  mov R1, [BP-3]
  iadd R1, 8
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_48763_end
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
__if_48829_start:
  mov R2, [BP-3]
  iadd R2, 13
  mov [SP], R2
  lea R2, [BP-7]
  mov [SP+1], R2
  call __function_b2AABB_Contains
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_48829_end
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
__if_48829_end:
__if_48763_end:
  mov R1, [BP-3]
  iadd R1, 3
  mov R0, [R1]
  mov [BP-2], R0
  jmp __while_48748_start
__while_48748_end:
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
__for_48925_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_48925_end
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
__if_49045_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_49055
  mov R2, [BP-6]
  iadd R2, 23
  mov R1, [R2]
  and R1, 2048
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_49055:
  jt R0, __LogicalOr_ShortCircuit_49059
  mov R1, [BP-21]
  mov R3, [BP-14]
  iadd R3, 14
  mov R2, [R3]
  fgt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_49059:
  jf R0, __if_49045_else
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
  jmp __if_49045_end
__if_49045_else:
  mov R1, [BP-14]
  iadd R1, 15
  mov R0, [R1]
  mov R1, [BP+3]
  fadd R0, R1
  mov R1, [BP-14]
  iadd R1, 15
  mov [R1], R0
__if_49045_end:
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
  jf R0, __LogicalAnd_ShortCircuit_49135
  mov R2, [BP-14]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_49135:
  jf R0, __LogicalAnd_ShortCircuit_49141
  mov R1, [BP-28]
  mov R3, [BP-6]
  iadd R3, 17
  mov R2, [R3]
  fmul R2, 0.500000
  fgt R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_49141:
  mov [BP-29], R0
__if_49147_start:
  mov R0, [BP-29]
  jf R0, __if_49147_else
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  or R0, 8
  mov R1, [BP-6]
  iadd R1, 23
  mov [R1], R0
__if_49157_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 16
  ine R0, 0
  jf R0, __if_49157_end
  jmp __for_48925_continue
__if_49157_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-14]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  call __function_b2SolveContinuous
  jmp __if_49147_end
__if_49147_else:
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
__if_49147_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  call __function_b2UpdateBodyProxies
__for_48925_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_48925_start
__for_48925_end:
  mov R0, 0
  mov [BP-5], R0
__for_49185_start:
  mov R0, [BP-5]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_49185_end
  mov R0, [BP-2]
  mov R1, [BP-5]
  imul R1, 24
  iadd R0, R1
  mov [BP-6], R0
__if_49201_start:
  mov R1, [BP-6]
  iadd R1, 23
  mov R0, [R1]
  and R0, 24
  ine R0, 24
  jf R0, __if_49201_end
  jmp __for_49185_continue
__if_49201_end:
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
__for_49185_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_49185_start
__for_49185_end:
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
__if_49372_start:
  mov R0, [BP-9]
  fgt R0, 0.000000
  jf R0, __if_49372_else
  mov R0, 1.000000
  mov R1, [BP-9]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
  jmp __if_49372_end
__if_49372_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 9
  mov [R1], R0
__if_49372_end:
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
__if_49415_start:
  mov R0, [BP-12]
  fgt R0, 0.000000
  jf R0, __if_49415_else
  mov R0, 1.000000
  mov R1, [BP-12]
  fdiv R0, R1
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
  jmp __if_49415_end
__if_49415_else:
  mov R0, 0.000000
  mov R1, [BP+3]
  iadd R1, 10
  mov [R1], R0
__if_49415_end:
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
__for_49510_start:
  mov R0, [BP-6]
  mov R1, [BP-4]
  ilt R0, R1
  jf R0, __for_49510_end
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
__if_49531_start:
  mov R0, [BP-8]
  ieq R0, 0
  jf R0, __if_49531_end
  jmp __for_49510_continue
__if_49531_end:
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
__if_49616_start:
  mov R0, [BP-9]
  ieq R0, -1
  jt R0, __LogicalOr_ShortCircuit_49623
  mov R1, [BP-10]
  ieq R1, -1
  or R0, R1
__LogicalOr_ShortCircuit_49623:
  jf R0, __if_49616_else
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+5]
  mov R12, [R12]
  mov CR, 3
  movs
  jmp __if_49616_end
__if_49616_else:
  mov R13, [BP-11]
  iadd R13, 34
  lea R12, [BP+4]
  mov R12, [R12]
  mov CR, 3
  movs
__if_49616_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-13]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-14], R0
__if_49644_start:
  mov R0, [BP-9]
  ine R0, -1
  jf R0, __if_49644_end
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
__if_49644_end:
  mov R12, global_b2Vec2_zero
  lea DR, [BP-16]
  mov CR, 2
  movs
  mov R0, 0.000000
  mov [BP-17], R0
__if_49669_start:
  mov R0, [BP-10]
  ine R0, -1
  jf R0, __if_49669_end
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
__if_49669_end:
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
__if_49699_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_49699_end
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
__if_49699_end:
__if_49733_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_49733_end
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
__if_49733_end:
__for_49510_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_49510_start
__for_49510_end:
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
__for_49944_start:
  mov R0, [BP-11]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_49944_end
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
__if_49974_start:
  mov R0, [BP-13]
  ieq R0, -1
  jf R0, __if_49974_else
  lea R0, [BP-10]
  mov [BP-15], R0
  jmp __if_49974_end
__if_49974_else:
  mov R0, [BP-2]
  mov R1, [BP-13]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_49974_end:
__if_49992_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_49992_else
  lea R0, [BP-10]
  mov [BP-16], R0
  jmp __if_49992_end
__if_49992_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_49992_end:
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
__if_50041_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50041_end
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
__if_50041_end:
__if_50072_start:
  mov R1, [BP-12]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50072_end
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
__if_50072_end:
__if_50103_start:
  mov R0, [BP-13]
  ine R0, -1
  jf R0, __if_50103_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_50103_end:
__if_50118_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_50118_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_50118_end:
__for_49944_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_49944_start
__for_49944_end:
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
__if_50257_start:
  mov R0, [BP-11]
  fgt R0, 0.000000
  jf R0, __if_50257_else
  mov R0, [BP-11]
  mov R1, [BP+12]
  fmul R0, R1
  mov [BP-12], R0
  jmp __if_50257_end
__if_50257_else:
__if_50267_start:
  mov R0, [BP+14]
  jf R0, __if_50267_end
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
__if_50267_end:
__if_50257_end:
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
__if_50377_start:
  mov R0, [BP-23]
  flt R0, 0.000000
  jf R0, __if_50377_end
  mov R0, 0.000000
  mov [BP-23], R0
__if_50377_end:
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
__for_50739_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_50739_end
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
__if_50769_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_50769_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_50769_end
__if_50769_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_50769_end:
__if_50787_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_50787_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_50787_end
__if_50787_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_50787_end:
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
__if_50866_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50866_end
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
__if_50866_end:
__if_50907_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50907_end
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
__if_50907_end:
__if_50948_start:
  mov R0, [BP+6]
  ieq R0, 0
  jf R0, __if_50948_end
__if_50953_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_50953_end
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
__if_50953_end:
__if_50986_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_50986_end
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
__if_50986_end:
__if_50948_end:
__if_51019_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_51019_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_51019_end:
__if_51034_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_51034_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_51034_end:
__for_50739_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_50739_start
__for_50739_end:
__function_b2SolveContacts_return:
  mov SP, BP
  pop BP
  ret

__function_b2ApplyRestitutionPoint:
  push BP
  mov BP, SP
  isub SP, 17
__if_51062_start:
  mov R1, [BP+2]
  iadd R1, 5
  mov R0, [R1]
  mov R1, [BP+5]
  fsgn R1
  fgt R0, R1
  jt R0, __LogicalOr_ShortCircuit_51070
  mov R2, [BP+2]
  iadd R2, 8
  mov R1, [R2]
  feq R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_51070:
  jf R0, __if_51062_end
  jmp __function_b2ApplyRestitutionPoint_return
__if_51062_end:
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
__for_51318_start:
  mov R0, [BP-12]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_51318_end
  mov R0, [BP+3]
  mov R1, [BP-12]
  imul R1, 38
  iadd R0, R1
  mov [BP-13], R0
__if_51334_start:
  mov R1, [BP-13]
  iadd R1, 32
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_51334_end
  jmp __for_51318_continue
__if_51334_end:
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
__if_51354_start:
  mov R0, [BP-14]
  ieq R0, -1
  jf R0, __if_51354_else
  lea R0, [BP-11]
  mov [BP-16], R0
  jmp __if_51354_end
__if_51354_else:
  mov R0, [BP-2]
  mov R1, [BP-14]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_51354_end:
__if_51372_start:
  mov R0, [BP-15]
  ieq R0, -1
  jf R0, __if_51372_else
  lea R0, [BP-11]
  mov [BP-17], R0
  jmp __if_51372_end
__if_51372_else:
  mov R0, [BP-2]
  mov R1, [BP-15]
  imul R1, 8
  iadd R0, R1
  mov [BP-17], R0
__if_51372_end:
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
__if_51408_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_51408_end
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
__if_51408_end:
__if_51440_start:
  mov R1, [BP-13]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_51440_end
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
__if_51440_end:
__if_51472_start:
  mov R0, [BP-14]
  ine R0, -1
  jf R0, __if_51472_end
  mov R13, [BP-16]
  lea R12, [BP-19]
  mov CR, 2
  movs
  mov R0, [BP-20]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_51472_end:
__if_51487_start:
  mov R0, [BP-15]
  ine R0, -1
  jf R0, __if_51487_end
  mov R13, [BP-17]
  lea R12, [BP-22]
  mov CR, 2
  movs
  mov R0, [BP-23]
  mov R1, [BP-17]
  iadd R1, 2
  mov [R1], R0
__if_51487_end:
__for_51318_continue:
  mov R0, [BP-12]
  iadd R0, 1
  mov [BP-12], R0
  jmp __for_51318_start
__for_51318_end:
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
__for_51521_start:
  mov R0, [BP-3]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_51521_end
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
__if_51545_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 1
  jf R0, __if_51545_end
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
__if_51545_end:
__if_51595_start:
  mov R1, [BP-4]
  iadd R1, 37
  mov R0, [R1]
  ige R0, 2
  jf R0, __if_51595_end
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
__if_51595_end:
__for_51521_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_51521_start
__for_51521_end:
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
__if_51769_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51769_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_51769_end
__if_51769_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_51769_end:
__if_51785_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_51785_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_51785_end
__if_51785_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_51785_end:
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
__if_51920_start:
  mov R0, [BP-30]
  fgt R0, 0.000000
  jf R0, __if_51920_else
  mov R0, 1.000000
  mov R1, [BP-30]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_51920_end
__if_51920_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_51920_end:
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
__if_51984_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_51984_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_51984_end
__if_51984_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_51984_end:
__if_52004_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52004_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_52004_end
__if_52004_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_52004_end:
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
__if_52111_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52111_end
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
__if_52111_end:
__if_52147_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_52147_end
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
__if_52147_end:
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
__if_52227_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52227_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_52227_end
__if_52227_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_52227_end:
__if_52247_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_52247_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_52247_end
__if_52247_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_52247_end:
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
__if_52354_start:
  mov R1, [BP-14]
  iadd R1, 25
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_52357
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  mov R3, [BP-14]
  iadd R3, 6
  mov R2, [R3]
  flt R1, R2
  jt R1, __LogicalOr_ShortCircuit_52366
  mov R3, [BP-14]
  iadd R3, 26
  mov R2, [R3]
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_52366:
  and R0, R1
__LogicalAnd_ShortCircuit_52357:
  jf R0, __if_52354_else
__if_52370_start:
  mov R1, [BP-14]
  iadd R1, 1
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_52370_end
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
__if_52370_end:
__if_52544_start:
  mov R1, [BP-14]
  iadd R1, 27
  mov R0, [R1]
  jf R0, __if_52544_end
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
__if_52544_end:
__if_52691_start:
  mov R1, [BP-14]
  iadd R1, 26
  mov R0, [R1]
  jf R0, __if_52691_end
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
__if_52761_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52761_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52761_end
__if_52761_else:
__if_52770_start:
  mov R0, [BP+6]
  jf R0, __if_52770_end
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
__if_52770_end:
__if_52761_end:
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
__if_52947_start:
  mov R0, [BP-49]
  fgt R0, 0.000000
  jf R0, __if_52947_else
  mov R0, [BP-49]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-50], R0
  jmp __if_52947_end
__if_52947_else:
__if_52956_start:
  mov R0, [BP+6]
  jf R0, __if_52956_end
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
__if_52956_end:
__if_52947_end:
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
__if_52691_end:
  jmp __if_52354_end
__if_52354_else:
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
__if_53134_start:
  mov R0, [BP+6]
  jf R0, __if_53134_end
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
__if_53134_end:
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
__if_52354_end:
__if_53234_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53234_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_53234_end:
__if_53250_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53250_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_53250_end:
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
__if_53368_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53368_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_53368_end
__if_53368_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_53368_end:
__if_53384_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_53384_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_53384_end
__if_53384_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_53384_end:
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
__if_53487_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_53487_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_53487_end
__if_53487_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_53487_end:
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
__if_53551_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53551_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53551_end
__if_53551_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53551_end:
__if_53571_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53571_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53571_end
__if_53571_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53571_end:
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
__if_53626_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53626_end
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
__if_53626_end:
__if_53667_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_53667_end
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
__if_53667_end:
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
__if_53752_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53752_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_53752_end
__if_53752_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_53752_end:
__if_53772_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_53772_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_53772_end
__if_53772_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_53772_end:
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
__if_53847_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53850
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53850:
  jf R0, __if_53847_end
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
__if_53847_end:
__if_53927_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53930
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53930:
  jf R0, __if_53927_end
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
__if_53927_end:
__if_53991_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_53994
  mov R1, [BP-29]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_53994:
  jf R0, __if_53991_end
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
__if_54020_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_54020_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_54020_end
__if_54020_else:
__if_54029_start:
  mov R0, [BP+6]
  jf R0, __if_54029_end
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
__if_54029_end:
__if_54020_end:
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
__if_54118_start:
  mov R0, [BP-63]
  fgt R0, 0.000000
  jf R0, __if_54118_else
  mov R0, [BP-63]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-64], R0
  jmp __if_54118_end
__if_54118_else:
__if_54127_start:
  mov R0, [BP+6]
  jf R0, __if_54127_end
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
__if_54127_end:
__if_54118_end:
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
__if_53991_end:
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
__if_54276_start:
  mov R0, [BP+6]
  jf R0, __if_54276_end
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
__if_54276_end:
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
__if_54527_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54527_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_54527_end:
__if_54543_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54543_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_54543_end:
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
__if_54661_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54661_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_54661_end
__if_54661_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_54661_end:
__if_54677_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_54677_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_54677_end
__if_54677_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_54677_end:
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
__if_54780_start:
  mov R0, [BP-18]
  fgt R0, 0.000000
  jf R0, __if_54780_else
  mov R0, 1.000000
  mov R1, [BP-18]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_54780_end
__if_54780_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_54780_end:
__if_54794_start:
  mov R1, [BP-13]
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54794_else
  mov R13, [BP-13]
  iadd R13, 4
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54794_end
__if_54794_else:
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
__if_54794_end:
__if_54813_start:
  mov R1, [BP-13]
  iadd R1, 2
  mov R0, [R1]
  feq R0, 0.000000
  jf R0, __if_54813_else
  mov R13, [BP-13]
  iadd R13, 7
  mov R12, [BP+3]
  iadd R12, 18
  mov CR, 3
  movs
  jmp __if_54813_end
__if_54813_else:
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
__if_54813_end:
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
__if_54873_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54873_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_54873_end
__if_54873_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_54873_end:
__if_54893_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_54893_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_54893_end
__if_54893_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_54893_end:
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
__if_54935_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54935_end
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
__if_54935_end:
__if_54977_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_54977_end
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
__if_54977_end:
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
__if_55061_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55061_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55061_end
__if_55061_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55061_end:
__if_55081_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55081_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55081_end
__if_55081_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55081_end:
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
__if_55163_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_55165
  mov R2, [BP-14]
  iadd R2, 2
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_55165:
  jf R0, __if_55163_end
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
__if_55163_end:
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
__if_55265_start:
  mov R0, [BP+4]
  jt R0, __LogicalOr_ShortCircuit_55267
  mov R2, [BP-14]
  mov R1, [R2]
  fgt R1, 0.000000
  or R0, R1
__LogicalOr_ShortCircuit_55267:
  jf R0, __if_55265_end
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
__if_55265_end:
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
__if_55564_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55564_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_55564_end:
__if_55580_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_55580_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_55580_end:
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
__if_55698_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55698_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
  jmp __if_55698_end
__if_55698_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 13
  mov [R1], R0
__if_55698_end:
__if_55714_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_55714_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
  jmp __if_55714_end
__if_55714_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 14
  mov [R1], R0
__if_55714_end:
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
__if_55892_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55892_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_55892_end
__if_55892_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_55892_end:
__if_55912_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_55912_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_55912_end
__if_55912_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_55912_end:
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
__if_56117_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56117_end
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
__if_56117_end:
__if_56149_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_56149_end
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
__if_56149_end:
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
__if_56225_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_56225_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_56225_end
__if_56225_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 13
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_56225_end:
__if_56245_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_56245_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_56245_end
__if_56245_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 14
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_56245_end:
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
__if_56433_start:
  mov R0, [BP-48]
  fgt R0, 0.000000
  jf R0, __if_56433_else
  mov R0, 1.000000
  mov R1, [BP-48]
  fdiv R0, R1
  mov [BP-49], R0
  jmp __if_56433_end
__if_56433_else:
  mov R0, 0.000000
  mov [BP-49], R0
__if_56433_end:
__if_56445_start:
  mov R1, [BP-14]
  iadd R1, 28
  mov R0, [R1]
  jf R0, __if_56445_end
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
__if_56445_end:
__if_56577_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __if_56577_end
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
__if_56577_end:
__if_56699_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_56699_end
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
__if_56720_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56720_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56734_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56734_else
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
  jmp __if_56734_end
__if_56734_else:
__if_56749_start:
  mov R0, [BP+6]
  jf R0, __if_56749_end
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
__if_56749_end:
__if_56734_end:
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
  jmp __if_56720_end
__if_56720_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 4
  mov [R1], R0
__if_56720_end:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  mov R1, [BP-43]
  fsub R0, R1
  mov [BP-86], R0
__if_56895_start:
  mov R0, [BP-86]
  mov R1, [BP-85]
  flt R0, R1
  jf R0, __if_56895_else
  mov R0, 0.000000
  mov [BP-87], R0
  mov R0, 1.000000
  mov [BP-88], R0
  mov R0, 0.000000
  mov [BP-89], R0
__if_56909_start:
  mov R0, [BP-86]
  fgt R0, 0.000000
  jf R0, __if_56909_else
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
  jmp __if_56909_end
__if_56909_else:
__if_56924_start:
  mov R0, [BP+6]
  jf R0, __if_56924_end
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
__if_56924_end:
__if_56909_end:
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
  jmp __if_56895_end
__if_56895_else:
  mov R0, 0.000000
  mov R1, [BP-14]
  iadd R1, 5
  mov [R1], R0
__if_56895_end:
__if_56699_end:
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
__if_57135_start:
  mov R0, [BP+6]
  jf R0, __if_57135_end
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
__if_57135_end:
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
__if_57203_start:
  mov R0, [BP-66]
  feq R0, 0.000000
  jf R0, __if_57203_end
  mov R0, 1.000000
  mov [BP-66], R0
__if_57203_end:
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
__if_57367_start:
  mov R1, [BP-14]
  iadd R1, 13
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57367_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_57367_end:
__if_57383_start:
  mov R1, [BP-14]
  iadd R1, 14
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_57383_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_57383_end:
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
__if_57501_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_57501_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
  jmp __if_57501_end
__if_57501_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 11
  mov [R1], R0
__if_57501_end:
__if_57517_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_57517_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
  jmp __if_57517_end
__if_57517_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 12
  mov [R1], R0
__if_57517_end:
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
__if_57712_start:
  mov R0, [BP-36]
  fgt R0, 0.000000
  jf R0, __if_57712_else
  mov R0, 1.000000
  mov R1, [BP-36]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_57712_end
__if_57712_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_57712_end:
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
__if_57757_start:
  mov R0, [BP-39]
  fgt R0, 0.000000
  jf R0, __if_57757_else
  mov R0, 1.000000
  mov R1, [BP-39]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
  jmp __if_57757_end
__if_57757_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 25
  mov [R1], R0
__if_57757_end:
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
__if_57785_start:
  mov R0, [BP-40]
  fgt R0, 0.000000
  jf R0, __if_57785_else
  mov R0, 1.000000
  mov R1, [BP-40]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_57785_end
__if_57785_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_57785_end:
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
__if_57840_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57840_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_57840_end
__if_57840_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_57840_end:
__if_57860_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_57860_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_57860_end
__if_57860_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_57860_end:
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
__if_58080_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58080_end
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
__if_58080_end:
__if_58112_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_58112_end
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
__if_58112_end:
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
__if_58188_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58188_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_58188_end
__if_58188_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 11
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_58188_end:
__if_58208_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_58208_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_58208_end
__if_58208_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 12
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_58208_end:
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
__if_58374_start:
  mov R1, [BP-14]
  iadd R1, 30
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_58377
  mov R1, [BP-23]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_58377:
  jf R0, __if_58374_end
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
__if_58374_end:
__if_58438_start:
  mov R1, [BP-14]
  iadd R1, 29
  mov R0, [R1]
  jf R0, __if_58438_end
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
__if_58438_end:
__if_58568_start:
  mov R1, [BP-14]
  iadd R1, 31
  mov R0, [R1]
  jf R0, __if_58568_end
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
__if_58588_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58588_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58588_end
__if_58588_else:
__if_58597_start:
  mov R0, [BP+6]
  jf R0, __if_58597_end
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
__if_58597_end:
__if_58588_end:
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
__if_58750_start:
  mov R0, [BP-47]
  fgt R0, 0.000000
  jf R0, __if_58750_else
  mov R0, [BP-47]
  mov R1, [BP+5]
  fmul R0, R1
  mov [BP-48], R0
  jmp __if_58750_end
__if_58750_else:
__if_58759_start:
  mov R0, [BP+6]
  jf R0, __if_58759_end
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
__if_58759_end:
__if_58750_end:
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
__if_58568_end:
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
__if_58913_start:
  mov R0, [BP+6]
  jf R0, __if_58913_end
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
__if_58913_end:
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
__if_59060_start:
  mov R1, [BP-14]
  iadd R1, 11
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59060_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_59060_end:
__if_59076_start:
  mov R1, [BP-14]
  iadd R1, 12
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59076_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_59076_end:
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
__if_59194_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_59194_else
  mov R1, [BP-3]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
  jmp __if_59194_end
__if_59194_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 23
  mov [R1], R0
__if_59194_end:
__if_59210_start:
  mov R1, [BP-4]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_59210_else
  mov R1, [BP-4]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
  jmp __if_59210_end
__if_59210_else:
  mov R0, -1
  mov R1, [BP-13]
  iadd R1, 24
  mov [R1], R0
__if_59210_end:
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
__if_59422_start:
  mov R0, [BP-26]
  fgt R0, 0.000000
  jf R0, __if_59422_else
  mov R0, 1.000000
  mov R1, [BP-26]
  fdiv R0, R1
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
  jmp __if_59422_end
__if_59422_else:
  mov R0, 0.000000
  mov R1, [BP-13]
  iadd R1, 39
  mov [R1], R0
__if_59422_end:
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
__if_59477_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59477_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_59477_end
__if_59477_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_59477_end:
__if_59497_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59497_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59497_end
__if_59497_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59497_end:
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
__if_59557_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59557_end
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
__if_59557_end:
__if_59596_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_59596_end
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
__if_59596_end:
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
__if_59677_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59677_else
  lea R0, [BP-9]
  mov [BP-15], R0
  jmp __if_59677_end
__if_59677_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 23
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-15], R0
__if_59677_end:
__if_59697_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_59697_else
  lea R0, [BP-9]
  mov [BP-16], R0
  jmp __if_59697_end
__if_59697_else:
  mov R0, [BP-1]
  mov R2, [BP-14]
  iadd R2, 24
  mov R1, [R2]
  imul R1, 8
  iadd R0, R1
  mov [BP-16], R0
__if_59697_end:
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
__if_59731_start:
  mov R1, [BP-14]
  iadd R1, 10
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59738
  mov R2, [BP-14]
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59738:
  jf R0, __if_59731_end
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
__if_59731_end:
__if_59858_start:
  mov R1, [BP-14]
  iadd R1, 4
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_59858_end
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
__if_59858_end:
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
__if_59943_start:
  mov R1, [BP-14]
  iadd R1, 7
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __LogicalAnd_ShortCircuit_59950
  mov R2, [BP-14]
  iadd R2, 5
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_59950:
  jf R0, __if_59943_end
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
__if_60214_start:
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
  jf R0, __if_60214_end
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
__if_60214_end:
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
__if_59943_end:
__if_60314_start:
  mov R1, [BP-14]
  iadd R1, 2
  mov R0, [R1]
  fgt R0, 0.000000
  jf R0, __if_60314_end
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
__if_60427_start:
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
  jf R0, __if_60427_end
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
__if_60427_end:
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
__if_60314_end:
__if_60527_start:
  mov R1, [BP-14]
  iadd R1, 23
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_60527_end
  mov R13, [BP-15]
  lea R12, [BP-18]
  mov CR, 2
  movs
  mov R0, [BP-19]
  mov R1, [BP-15]
  iadd R1, 2
  mov [R1], R0
__if_60527_end:
__if_60543_start:
  mov R1, [BP-14]
  iadd R1, 24
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_60543_end
  mov R13, [BP-16]
  lea R12, [BP-21]
  mov CR, 2
  movs
  mov R0, [BP-22]
  mov R1, [BP-16]
  iadd R1, 2
  mov [R1], R0
__if_60543_end:
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
__for_60578_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60578_end
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
__if_60612_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60612_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareDistanceJoint
  jmp __if_60612_end
__if_60612_else:
__if_60621_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60621_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareRevoluteJoint
  jmp __if_60621_end
__if_60621_else:
__if_60630_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60630_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWeldJoint
  jmp __if_60630_end
__if_60630_else:
__if_60639_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60639_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PreparePrismaticJoint
  jmp __if_60639_end
__if_60639_else:
__if_60648_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60648_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareWheelJoint
  jmp __if_60648_end
__if_60648_else:
__if_60657_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60657_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2PrepareMotorJoint
__if_60657_end:
__if_60648_end:
__if_60639_end:
__if_60630_end:
__if_60621_end:
__if_60612_end:
__for_60578_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60578_start
__for_60578_end:
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
__for_60683_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60683_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60701_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60701_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartDistanceJoint
  jmp __if_60701_end
__if_60701_else:
__if_60709_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60709_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartRevoluteJoint
  jmp __if_60709_end
__if_60709_else:
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
  call __function_b2WarmStartWeldJoint
  jmp __if_60717_end
__if_60717_else:
__if_60725_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60725_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartPrismaticJoint
  jmp __if_60725_end
__if_60725_else:
__if_60733_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60733_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartWheelJoint
  jmp __if_60733_end
__if_60733_else:
__if_60741_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60741_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  call __function_b2WarmStartMotorJoint
__if_60741_end:
__if_60733_end:
__if_60725_end:
__if_60717_end:
__if_60709_end:
__if_60701_end:
__for_60683_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60683_start
__for_60683_end:
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
__for_60769_start:
  mov R0, [BP-3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __for_60769_end
  mov R1, [BP-1]
  iadd R1, 9
  mov R0, [R1]
  mov R1, [BP-3]
  imul R1, 63
  iadd R0, R1
  mov [BP-4], R0
__if_60787_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_60787_else
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
  jmp __if_60787_end
__if_60787_else:
__if_60798_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 4
  jf R0, __if_60798_else
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
  jmp __if_60798_end
__if_60798_else:
__if_60809_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 5
  jf R0, __if_60809_else
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_b2SolveWeldJoint
  jmp __if_60809_end
__if_60809_else:
__if_60818_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 3
  jf R0, __if_60818_else
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
  jmp __if_60818_end
__if_60818_else:
__if_60829_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 6
  jf R0, __if_60829_else
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
  jmp __if_60829_end
__if_60829_else:
__if_60840_start:
  mov R1, [BP-4]
  iadd R1, 3
  mov R0, [R1]
  ieq R0, 2
  jf R0, __if_60840_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-4]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2SolveMotorJoint
__if_60840_end:
__if_60829_end:
__if_60818_end:
__if_60809_end:
__if_60798_end:
__if_60787_end:
__for_60769_continue:
  mov R0, [BP-3]
  iadd R0, 1
  mov [BP-3], R0
  jmp __for_60769_start
__for_60769_end:
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
__if_60866_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 11
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_60866_end
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
__if_60866_end:
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
__for_60997_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_60997_end
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
__if_61084_start:
  mov R0, [BP-10]
  mov R1, [BP-12]
  ine R0, R1
  jf R0, __if_61084_end
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
__if_61084_end:
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
__for_60997_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_60997_start
__for_60997_end:
  mov R0, 0
  mov [BP-5], R0
__for_61116_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 8
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61116_end
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
__if_61193_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_61193_end
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
__if_61193_end:
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
__for_61116_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_61116_start
__for_61116_end:
  mov R0, 0
  mov [BP-5], R0
__for_61243_start:
  mov R0, [BP-5]
  mov R2, [BP-1]
  iadd R2, 11
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61243_end
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
__if_61320_start:
  mov R0, [BP-9]
  mov R1, [BP-11]
  ine R0, R1
  jf R0, __if_61320_end
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
__if_61320_end:
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
__for_61243_continue:
  mov R0, [BP-5]
  iadd R0, 1
  mov [BP-5], R0
  jmp __for_61243_start
__for_61243_end:
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
__if_61418_start:
  mov R0, [BP-6]
  mov R1, [BP-7]
  ine R0, R1
  jf R0, __if_61418_end
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
__if_61418_end:
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
__if_61467_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  mov R1, [BP+3]
  ieq R0, R1
  jf R0, __if_61467_end
  mov R0, -1
  mov R1, [BP+2]
  iadd R1, 50
  mov [R1], R0
__if_61467_end:
__function_b2TrySleepIsland_return:
  mov SP, BP
  pop BP
  ret

__function_b2UpdateSleep:
  push BP
  mov BP, SP
  isub SP, 9
__if_61512_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  ieq R0, 0
  jf R0, __if_61512_end
  jmp __function_b2UpdateSleep_return
__if_61512_end:
  mov R2, [BP+2]
  iadd R2, 11
  mov R1, [R2]
  iadd R1, 32
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
__while_61529_start:
__while_61529_continue:
  mov R0, [BP-1]
  ige R0, 0
  jf R0, __while_61529_end
  mov R1, [BP+2]
  iadd R1, 11
  mov R0, [R1]
  iadd R0, 32
  mov [BP-2], R0
__if_61542_start:
  mov R0, [BP-1]
  mov R2, [BP-2]
  iadd R2, 12
  iadd R2, 1
  mov R1, [R2]
  ige R0, R1
  jf R0, __if_61542_end
  mov R1, [BP-2]
  iadd R1, 12
  iadd R1, 1
  mov R0, [R1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_61529_continue
__if_61542_end:
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
__for_61582_start:
  mov R0, [BP-6]
  mov R2, [BP-4]
  iadd R2, 5
  mov R1, [R2]
  ilt R0, R1
  jf R0, __for_61582_end
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
__if_61604_start:
  mov R1, [BP-7]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 2
  jf R0, __if_61604_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61582_end
__if_61604_end:
__if_61614_start:
  mov R1, [BP-7]
  iadd R1, 15
  mov R0, [R1]
  flt R0, 0.500000
  jf R0, __if_61614_end
  mov R0, 0
  mov [BP-5], R0
  jmp __for_61582_end
__if_61614_end:
__for_61582_continue:
  mov R0, [BP-6]
  iadd R0, 1
  mov [BP-6], R0
  jmp __for_61582_start
__for_61582_end:
__if_61624_start:
  mov R0, [BP-5]
  jf R0, __if_61624_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2TrySleepIsland
__if_61624_end:
  mov R0, [BP-1]
  isub R0, 1
  mov [BP-1], R0
  jmp __while_61529_start
__while_61529_end:
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
__for_61655_start:
  mov R0, [BP-4]
  mov R1, [BP-3]
  ilt R0, R1
  jf R0, __for_61655_end
  mov R1, [BP-2]
  iadd R1, 6
  mov R0, [R1]
  mov R1, [BP-4]
  imul R1, 49
  iadd R0, R1
  mov [BP-5], R0
__if_61673_start:
  mov R1, [BP-5]
  iadd R1, 41
  mov R0, [R1]
  and R0, 1048576
  ieq R0, 0
  jf R0, __if_61673_end
  jmp __for_61655_continue
__if_61673_end:
  mov R0, [BP-1]
  mov [BP-6], R0
  mov R0, -1
  mov [BP-7], R0
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 27
  mov R0, [R1]
  mov [BP-8], R0
__if_61694_start:
  mov R0, [BP-8]
  ige R0, 1
  jf R0, __if_61694_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61708_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61718
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61718:
  jf R0, __if_61708_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__if_61708_end:
__if_61694_end:
__if_61728_start:
  mov R0, [BP-8]
  ige R0, 2
  jf R0, __if_61728_end
  mov R1, [BP-5]
  iadd R1, 9
  iadd R1, 3
  iadd R1, 12
  iadd R1, 9
  mov R0, [R1]
  fsgn R0
  mov [BP-23], R0
__if_61742_start:
  mov R0, [BP-23]
  mov R1, [BP-6]
  fgt R0, R1
  jf R0, __LogicalAnd_ShortCircuit_61752
  mov R2, [BP-5]
  iadd R2, 9
  iadd R2, 3
  iadd R2, 12
  iadd R2, 8
  mov R1, [R2]
  fgt R1, 0.000000
  and R0, R1
__LogicalAnd_ShortCircuit_61752:
  jf R0, __if_61742_end
  mov R0, [BP-23]
  mov [BP-6], R0
  mov R0, 1
  mov [BP-7], R0
__if_61742_end:
__if_61728_end:
__if_61762_start:
  mov R0, [BP-7]
  ieq R0, -1
  jf R0, __if_61762_end
  jmp __for_61655_continue
__if_61762_end:
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
__if_61808_start:
  mov R1, [BP-11]
  iadd R1, 19
  mov R0, [R1]
  ine R0, 0
  jf R0, __LogicalAnd_ShortCircuit_61815
  mov R2, [BP-12]
  iadd R2, 19
  mov R1, [R2]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_61815:
  jf R0, __if_61808_else
__if_61819_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61819_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 2
  mov CR, 2
  movs
  jmp __if_61819_end
__if_61819_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  iadd R12, 2
  mov CR, 2
  movs
__if_61819_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-12]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
  jmp __if_61808_end
__if_61808_else:
__if_61850_start:
  mov R0, [BP-7]
  ieq R0, 0
  jf R0, __if_61850_else
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  mov CR, 2
  movs
  jmp __if_61850_end
__if_61850_else:
  lea R13, [BP-14]
  mov R12, [BP-5]
  iadd R12, 9
  iadd R12, 3
  iadd R12, 12
  mov CR, 2
  movs
__if_61850_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-11]
  mov [SP+1], R1
  call __function_b2GetBodySim
  mov [BP-23], R0
  mov R0, [BP-23]
  iadd R0, 4
  mov [BP-15], R0
__if_61808_end:
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
__for_61655_continue:
  mov R0, [BP-4]
  iadd R0, 1
  mov [BP-4], R0
  jmp __for_61655_start
__for_61655_end:
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
__if_61932_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_61932_end
  mov R0, 1
  mov [BP+4], R0
__if_61932_end:
  mov R0, [BP+3]
  mov R1, [BP+4]
  cif R1
  fdiv R0, R1
  mov [BP-3], R0
__if_61946_start:
  mov R0, [BP-3]
  fgt R0, 0.000000
  jf R0, __if_61946_else
  mov R0, 1.000000
  mov R1, [BP-3]
  fdiv R0, R1
  mov [BP-4], R0
  jmp __if_61946_end
__if_61946_else:
  mov R0, 0.000000
  mov [BP-4], R0
__if_61946_end:
  mov R0, [BP-4]
  mov R1, [BP+2]
  iadd R1, 55
  mov [R1], R0
__if_61964_start:
  mov R0, [BP+3]
  fgt R0, 0.000000
  jf R0, __if_61964_else
  mov R0, 1.000000
  mov R1, [BP+3]
  fdiv R0, R1
  mov [BP-5], R0
  jmp __if_61964_end
__if_61964_else:
  mov R0, 0.000000
  mov [BP-5], R0
__if_61964_end:
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
__if_62022_start:
  mov R0, [BP-2]
  igt R0, 0
  jf R0, __if_62022_end
__if_62027_start:
  mov R0, [BP-2]
  mov R2, [BP+2]
  iadd R2, 66
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_62027_end
__if_62033_start:
  mov R1, [BP+2]
  iadd R1, 65
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_62033_end
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
__if_62033_end:
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
__if_62027_end:
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
__if_62022_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_b2PrepareJoints
  mov R0, 0
  mov [BP-17], R0
__for_62075_start:
  mov R0, [BP-17]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_62075_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  call __function_b2IntegrateVelocities
__if_62088_start:
  mov R1, [BP+2]
  iadd R1, 53
  mov R0, [R1]
  jf R0, __if_62088_end
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
__if_62088_end:
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
__for_62075_continue:
  mov R0, [BP-17]
  iadd R0, 1
  mov [BP-17], R0
  jmp __for_62075_start
__for_62075_end:
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
__if_62139_start:
  mov R1, [BP+2]
  iadd R1, 51
  mov R0, [R1]
  jf R0, __if_62139_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_b2UpdateSplitIsland
__if_62145_start:
  mov R1, [BP+2]
  iadd R1, 50
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_62145_end
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
__if_62145_end:
__if_62139_end:
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
__if_62169_start:
  mov R0, [BP+3]
  fle R0, 0.000000
  jf R0, __if_62169_end
  jmp __function_b2World_Step_return
__if_62169_end:
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

__function_vb2_SetGravity:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  mov [73], R0
  mov R0, [BP+3]
  mov [74], R0
__function_vb2_SetGravity_return:
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
__if_62466_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_62466_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62466_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_62485_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_62490
  mov R1, [BP-1]
  mov R2, [22]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_62490:
  jf R0, __if_62485_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62485_end:
  mov R0, [21]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 21
  iadd R0, R1
  mov [BP-3], R0
__if_62507_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_62507_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62507_end:
__if_62516_start:
  mov R1, [BP-3]
  iadd R1, 20
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_62516_end
  mov R0, 0
  jmp __function_vb2_ResolveBody_return
__if_62516_end:
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

__function_vb2_ResolveShape:
  push BP
  mov BP, SP
  isub SP, 4
  push R1
  push R2
  isub SP, 3
__if_62563_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62563_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62563_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_b2GetBodyFullId
  mov [BP-4], R0
__if_62579_start:
  mov R1, [BP-4]
  iadd R1, 5
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_62579_end
  mov R0, 0
  jmp __function_vb2_ResolveShape_return
__if_62579_end:
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
__if_62840_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62840_end
  jmp __function_vb2_Destroy_return
__if_62840_end:
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
__if_62857_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62857_end
  mov R0, 0.000000
  jmp __function_vb2_GetX_return
__if_62857_end:
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
__if_62882_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62882_end
  mov R0, 0.000000
  jmp __function_vb2_GetY_return
__if_62882_end:
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
__if_62907_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62907_end
  mov R0, 0.000000
  jmp __function_vb2_GetAngle_return
__if_62907_end:
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
__if_62933_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62933_end
  mov R0, 0.000000
  jmp __function_vb2_GetVX_return
__if_62933_end:
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
__if_62958_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_62958_end
  mov R0, 0.000000
  jmp __function_vb2_GetVY_return
__if_62958_end:
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

__function_vb2_SetPosition:
  push BP
  mov BP, SP
  isub SP, 11
__if_63023_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63023_end
  jmp __function_vb2_SetPosition_return
__if_63023_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Body_GetRotation
  mov R0, [BP+3]
  mov [BP-7], R0
  mov R0, [BP+4]
  mov [BP-6], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-7]
  mov [SP+2], R1
  lea R1, [BP-5]
  mov [SP+3], R1
  call __function_b2Body_SetTransform
__function_vb2_SetPosition_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetVelocity:
  push BP
  mov BP, SP
  isub SP, 8
__if_63102_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63102_end
  jmp __function_vb2_SetVelocity_return
__if_63102_end:
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

__function_vb2_SetAngularVelocity:
  push BP
  mov BP, SP
  isub SP, 6
__if_63132_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63132_end
  jmp __function_vb2_SetAngularVelocity_return
__if_63132_end:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP+3]
  mov [SP+2], R1
  call __function_b2Body_SetAngularVelocity
__function_vb2_SetAngularVelocity_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_ApplyForce:
  push BP
  mov BP, SP
  isub SP, 9
__if_63184_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveBody
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63184_end
  jmp __function_vb2_ApplyForce_return
__if_63184_end:
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
  call __function_b2Body_ApplyForceToCenter
__function_vb2_ApplyForce_return:
  mov SP, BP
  pop BP
  ret

__function_vb2_SetFriction:
  push BP
  mov BP, SP
  isub SP, 6
__if_63271_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63271_end
  jmp __function_vb2_SetFriction_return
__if_63271_end:
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
__if_63290_start:
  mov R2, [BP+2]
  mov [SP], R2
  lea R2, [BP-3]
  mov [SP+1], R2
  call __function_vb2_ResolveShape
  mov R1, R0
  ieq R1, 0
  mov R0, R1
  jf R0, __if_63290_end
  jmp __function_vb2_SetBounce_return
__if_63290_end:
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
__if_63401_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_63401_end
  mov R0, -1
  jmp __function_vb2_BodyOfShape_return
__if_63401_end:
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
__if_63505_start:
  mov R0, [global_vb2_pickShape]
  ine R0, -1
  jf R0, __if_63505_end
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_63505_end:
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
__if_63531_start:
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  lea R1, [BP-5]
  mov [SP+2], R1
  call __function_b2Shape_TestPoint
  jf R0, __if_63531_end
  mov R0, [BP+3]
  mov [global_vb2_pickShape], R0
  mov R0, 0
  jmp __function_vb2_PointPickCallback_return
__if_63531_end:
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
__if_63606_start:
  mov R1, [BP+2]
  ilt R1, 0
  jt R1, __LogicalOr_ShortCircuit_63611
  mov R2, [BP+2]
  mov R4, global_vb2_world
  mov [SP], R4
  call __function_b2World_GetBeginTouchEventCount
  mov R3, R0
  ige R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_63611:
  mov R0, R1
  jf R0, __if_63606_end
  mov R0, -1
  jmp __function_vb2_TouchA_return
__if_63606_end:
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
__if_63632_start:
  mov R1, [BP+2]
  ilt R1, 0
  jt R1, __LogicalOr_ShortCircuit_63637
  mov R2, [BP+2]
  mov R4, global_vb2_world
  mov [SP], R4
  call __function_b2World_GetBeginTouchEventCount
  mov R3, R0
  ige R2, R3
  or R1, R2
__LogicalOr_ShortCircuit_63637:
  mov R0, R1
  jf R0, __if_63632_end
  mov R0, -1
  jmp __function_vb2_TouchB_return
__if_63632_end:
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
__if_63659_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_63659_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63659_end:
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, [BP+2]
  shl R0, -16
  and R0, 32767
  mov [BP-2], R0
__if_63678_start:
  mov R0, [BP-1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_63683
  mov R1, [BP-1]
  mov R2, [58]
  igt R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_63683:
  jf R0, __if_63678_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63678_end:
  mov R0, [57]
  mov R1, [BP-1]
  isub R1, 1
  imul R1, 17
  iadd R0, R1
  mov [BP-3], R0
__if_63700_start:
  mov R1, [BP-3]
  iadd R1, 10
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_63700_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63700_end:
__if_63709_start:
  mov R1, [BP-3]
  iadd R1, 15
  mov R0, [R1]
  and R0, 32767
  mov R1, [BP-2]
  ine R0, R1
  jf R0, __if_63709_end
  mov R0, 0
  jmp __function_vb2_ResolveJoint_return
__if_63709_end:
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

__function_asteroid_points:
  push BP
  mov BP, SP
__if_64214_start:
  mov R0, [BP+2]
  ieq R0, 2
  jf R0, __if_64214_end
  mov R0, 20
  jmp __function_asteroid_points_return
__if_64214_end:
__if_64220_start:
  mov R0, [BP+2]
  ieq R0, 1
  jf R0, __if_64220_end
  mov R0, 50
  jmp __function_asteroid_points_return
__if_64220_end:
  mov R0, 100
__function_asteroid_points_return:
  mov SP, BP
  pop BP
  ret

__function_frand:
  push BP
  mov BP, SP
  push R1
  push R2
  push R3
  push R4
  mov R1, [BP+2]
  call __function_rand
  mov R2, R0
  imod R2, 1000
  cif R2
  fdiv R2, 999.000000
  mov R3, [BP+3]
  mov R4, [BP+2]
  fsub R3, R4
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
__function_frand_return:
  pop R4
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_int_to_string:
  push BP
  mov BP, SP
  isub SP, 14
__if_64248_start:
  mov R0, [BP+2]
  ieq R0, 0
  jf R0, __if_64248_end
  mov R0, 48
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  jmp __function_int_to_string_return
__if_64248_end:
  mov R0, 0
  mov [BP-1], R0
__if_64267_start:
  mov R0, [BP+2]
  ilt R0, 0
  jf R0, __if_64267_end
  mov R0, 1
  mov [BP-1], R0
  mov R0, [BP+2]
  isgn R0
  mov [BP+2], R0
__if_64267_end:
  mov R0, 0
  mov [BP-12], R0
__while_64285_start:
__while_64285_continue:
  mov R0, [BP+2]
  igt R0, 0
  jf R0, __while_64285_end
  mov R0, [BP+2]
  imod R0, 10
  iadd R0, 48
  lea R1, [BP-11]
  mov R2, [BP-12]
  mov R3, R2
  iadd R3, 1
  mov [BP-12], R3
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP+2]
  idiv R0, 10
  mov [BP+2], R0
  jmp __while_64285_start
__while_64285_end:
  mov R0, 0
  mov [BP-13], R0
__if_64307_start:
  mov R0, [BP-1]
  cib R0
  jf R0, __if_64307_end
  mov R0, 45
  mov R1, [BP+3]
  mov R2, [BP-13]
  mov R3, R2
  iadd R3, 1
  mov [BP-13], R3
  iadd R1, R2
  mov [R1], R0
__if_64307_end:
  mov R0, [BP-12]
  isub R0, 1
  mov [BP-14], R0
__for_64315_start:
  mov R0, [BP-14]
  ige R0, 0
  jf R0, __for_64315_end
  lea R0, [BP-11]
  mov R1, [BP-14]
  iadd R0, R1
  mov R0, [R0]
  mov R1, [BP+3]
  mov R2, [BP-13]
  mov R3, R2
  iadd R3, 1
  mov [BP-13], R3
  iadd R1, R2
  mov [R1], R0
__for_64315_continue:
  mov R0, [BP-14]
  mov R1, R0
  isub R1, 1
  mov [BP-14], R1
  jmp __for_64315_start
__for_64315_end:
  mov R0, 0
  mov R1, [BP+3]
  mov R2, [BP-13]
  iadd R1, R2
  mov [R1], R0
__function_int_to_string_return:
  mov SP, BP
  pop BP
  ret

__function_make_asteroid_body:
  push BP
  mov BP, SP
  isub SP, 107
  push R1
  push R2
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
  mov R0, 0
  mov [BP-107], R0
__for_64377_start:
  mov R0, [BP-107]
  ilt R0, 6
  jf R0, __for_64377_end
  mov R0, global_asteroidShapes
  mov R1, [BP+7]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-107]
  imul R1, 2
  iadd R0, R1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  lea R1, [BP-37]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  mov [R1], R0
  mov R0, global_asteroidShapes
  mov R1, [BP+7]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-107]
  imul R1, 2
  iadd R0, R1
  iadd R0, 1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  lea R1, [BP-37]
  mov R2, [BP-107]
  imul R2, 2
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
__for_64377_continue:
  mov R0, [BP-107]
  mov R1, R0
  iadd R1, 1
  mov [BP-107], R1
  jmp __for_64377_start
__for_64377_end:
  lea R1, [BP-37]
  mov [SP], R1
  mov R1, 6
  mov [SP+1], R1
  lea R1, [BP-54]
  mov [SP+2], R1
  call __function_b2ComputeHull
  lea R1, [BP-54]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  lea R1, [BP-90]
  mov [SP+2], R1
  call __function_b2MakePolygon
  lea R1, [BP-102]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R0, 2.000000
  mov [BP-102], R0
  mov R0, 0.300000
  mov [BP-101], R0
  mov R0, 0.700000
  mov [BP-100], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-25]
  mov [SP+1], R1
  lea R1, [BP-102]
  mov [SP+2], R1
  lea R1, [BP-90]
  mov [SP+3], R1
  lea R1, [BP-105]
  mov [SP+4], R1
  call __function_b2CreatePolygonShape
  mov R1, [BP-25]
  mov [SP], R1
  mov R1, [BP-23]
  mov [SP+1], R1
  call __function_vb2_PackHandle
  mov [BP-106], R0
  mov R1, [BP-106]
  mov [SP], R1
  mov R1, [BP+4]
  mov [SP+1], R1
  mov R1, [BP+5]
  mov [SP+2], R1
  call __function_vb2_SetVelocity
  mov R1, [BP-106]
  mov [SP], R1
  mov R1, [BP+6]
  mov [SP+1], R1
  call __function_vb2_SetAngularVelocity
  mov R0, [BP-106]
__function_make_asteroid_body_return:
  iadd SP, 5
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_spawn_asteroid:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  push R3
  isub SP, 6
  mov R0, 0
  mov [BP-1], R0
__for_64482_start:
  mov R0, [BP-1]
  ilt R0, 36
  jf R0, __for_64482_end
__if_64492_start:
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  bnot R0
  jf R0, __if_64492_end
__if_64501_start:
  mov R0, [BP+6]
  ieq R0, 2
  jf R0, __if_64501_else
  call __function_rand
  mov R1, R0
  imod R1, 2
  mov [BP-2], R1
  mov R0, R1
  jmp __if_64501_end
__if_64501_else:
__if_64510_start:
  mov R0, [BP+6]
  ieq R0, 1
  jf R0, __if_64510_else
  call __function_rand
  mov R1, R0
  imod R1, 2
  iadd R1, 2
  mov [BP-2], R1
  mov R0, R1
  jmp __if_64510_end
__if_64510_else:
  mov R0, 4
  mov [BP-2], R0
__if_64510_end:
__if_64501_end:
  mov R1, -1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_frand
  mov [BP-3], R0
  mov R2, [BP+2]
  mov [SP], R2
  mov R2, [BP+3]
  mov [SP+1], R2
  mov R2, [BP+4]
  mov [SP+2], R2
  mov R2, [BP+5]
  mov [SP+3], R2
  mov R2, [BP-3]
  mov [SP+4], R2
  mov R2, [BP-2]
  mov [SP+5], R2
  call __function_make_asteroid_body
  mov R1, R0
  mov R2, global_asteroids
  mov R3, [BP-1]
  imul R3, 4
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, [BP+6]
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 2
  mov [R1], R0
  mov R0, 1
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  jmp __function_spawn_asteroid_return
__if_64492_end:
__for_64482_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_64482_start
__for_64482_end:
  mov R0, -1
__function_spawn_asteroid_return:
  iadd SP, 6
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_split_asteroid:
  push BP
  mov BP, SP
  isub SP, 14
  mov R0, global_asteroids
  mov R1, [BP+2]
  imul R1, 4
  iadd R0, R1
  mov [BP-1], R0
__if_64574_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  bnot R0
  jf R0, __if_64574_end
  jmp __function_split_asteroid_return
__if_64574_end:
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-2], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-3], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetVX
  mov [BP-4], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetVY
  mov [BP-5], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-6], R0
  mov R2, [BP-1]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_Destroy
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
__if_64610_start:
  mov R0, [BP-6]
  igt R0, 0
  jf R0, __if_64610_end
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 6.283185
  mov [SP+1], R1
  call __function_frand
  mov [BP-7], R0
  mov R1, [BP-7]
  mov [SP], R1
  call __function_cos
  mov [BP-8], R0
  mov R1, [BP-7]
  mov [SP], R1
  call __function_sin
  mov [BP-9], R0
  mov R1, [BP-2]
  mov R2, [BP-8]
  fmul R2, 0.400000
  fadd R1, R2
  mov [SP], R1
  mov R1, [BP-3]
  mov R2, [BP-9]
  fmul R2, 0.400000
  fadd R1, R2
  mov [SP+1], R1
  mov R1, [BP-4]
  mov R2, [BP-8]
  fmul R2, 1.400000
  fadd R1, R2
  mov [SP+2], R1
  mov R1, [BP-5]
  mov R2, [BP-9]
  fmul R2, 1.400000
  fadd R1, R2
  mov [SP+3], R1
  mov R1, [BP-6]
  isub R1, 1
  mov [SP+4], R1
  call __function_spawn_asteroid
  mov R1, [BP-2]
  mov R2, [BP-8]
  fmul R2, 0.400000
  fsub R1, R2
  mov [SP], R1
  mov R1, [BP-3]
  mov R2, [BP-9]
  fmul R2, 0.400000
  fsub R1, R2
  mov [SP+1], R1
  mov R1, [BP-4]
  mov R2, [BP-8]
  fmul R2, 1.400000
  fsub R1, R2
  mov [SP+2], R1
  mov R1, [BP-5]
  mov R2, [BP-9]
  fmul R2, 1.400000
  fsub R1, R2
  mov [SP+3], R1
  mov R1, [BP-6]
  isub R1, 1
  mov [SP+4], R1
  call __function_spawn_asteroid
__if_64610_end:
__function_split_asteroid_return:
  mov SP, BP
  pop BP
  ret

__function_count_active_asteroids:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  mov R0, 0
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__for_64682_start:
  mov R0, [BP-2]
  ilt R0, 36
  jf R0, __for_64682_end
__if_64691_start:
  mov R1, global_asteroids
  mov R2, [BP-2]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  jf R0, __if_64691_end
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
__if_64691_end:
__for_64682_continue:
  mov R0, [BP-2]
  mov R1, R0
  iadd R1, 1
  mov [BP-2], R1
  jmp __for_64682_start
__for_64682_end:
  mov R0, [BP-1]
__function_count_active_asteroids_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_count_active_big:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  push R2
  push R3
  mov R0, 0
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__for_64704_start:
  mov R0, [BP-2]
  ilt R0, 36
  jf R0, __for_64704_end
__if_64713_start:
  mov R1, global_asteroids
  mov R2, [BP-2]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_64718
  mov R2, global_asteroids
  mov R3, [BP-2]
  imul R3, 4
  iadd R2, R3
  iadd R2, 1
  mov R1, [R2]
  ieq R1, 2
  and R0, R1
__LogicalAnd_ShortCircuit_64718:
  jf R0, __if_64713_end
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
__if_64713_end:
__for_64704_continue:
  mov R0, [BP-2]
  mov R1, R0
  iadd R1, 1
  mov [BP-2], R1
  jmp __for_64704_start
__for_64704_end:
  mov R0, [BP-1]
__function_count_active_big_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_spawn_big_offscreen:
  push BP
  mov BP, SP
  isub SP, 11
__if_64730_start:
  call __function_count_active_big
  mov R1, R0
  ige R1, 5
  mov R0, R1
  jf R0, __if_64730_end
  jmp __function_spawn_big_offscreen_return
__if_64730_end:
  call __function_rand
  mov R1, R0
  imod R1, 4
  mov R0, R1
  mov [BP-1], R0
  mov R1, 0.800000
  mov [SP], R1
  mov R1, 1.800000
  mov [SP+1], R1
  call __function_frand
  mov [BP-6], R0
__if_64750_start:
  mov R0, [BP-1]
  ieq R0, 0
  jf R0, __if_64750_else
  mov R2, -16.000000
  mov [SP], R2
  mov R2, 16.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R0, 10.200000
  mov [BP-3], R0
  mov R2, -0.900000
  mov [SP], R2
  mov R2, 0.900000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
  mov R0, [BP-6]
  fsgn R0
  mov [BP-5], R0
  jmp __if_64750_end
__if_64750_else:
__if_64776_start:
  mov R0, [BP-1]
  ieq R0, 1
  jf R0, __if_64776_else
  mov R2, -16.000000
  mov [SP], R2
  mov R2, 16.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R0, -10.200000
  mov [BP-3], R0
  mov R2, -0.900000
  mov [SP], R2
  mov R2, 0.900000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
  mov R0, [BP-6]
  mov [BP-5], R0
  jmp __if_64776_end
__if_64776_else:
__if_64802_start:
  mov R0, [BP-1]
  ieq R0, 2
  jf R0, __if_64802_else
  mov R0, -17.200001
  mov [BP-2], R0
  mov R2, -9.000000
  mov [SP], R2
  mov R2, 9.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  mov R0, [BP-6]
  mov [BP-4], R0
  mov R2, -0.900000
  mov [SP], R2
  mov R2, 0.900000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-5], R1
  mov R0, R1
  jmp __if_64802_end
__if_64802_else:
  mov R0, 17.200001
  mov [BP-2], R0
  mov R2, -9.000000
  mov [SP], R2
  mov R2, 9.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  mov R0, [BP-6]
  fsgn R0
  mov [BP-4], R0
  mov R2, -0.900000
  mov [SP], R2
  mov R2, 0.900000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-5], R1
  mov R0, R1
__if_64802_end:
__if_64776_end:
__if_64750_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_spawn_asteroid
__function_spawn_big_offscreen_return:
  mov SP, BP
  pop BP
  ret

__function_spawn_initial_field:
  push BP
  mov BP, SP
  isub SP, 11
  mov R0, 0
  mov [BP-1], R0
__for_64857_start:
  mov R0, [BP-1]
  ilt R0, 4
  jf R0, __for_64857_end
  mov R0, 0
  mov [BP-4], R0
__do_64873_start:
  mov R2, -15.000000
  mov [SP], R2
  mov R2, 15.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-2], R1
  mov R0, R1
  mov R2, -8.000000
  mov [SP], R2
  mov R2, 8.000000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-3], R1
  mov R0, R1
  mov R0, [BP-4]
  mov R1, R0
  iadd R1, 1
  mov [BP-4], R1
__do_64873_continue:
  mov R0, [BP-2]
  mov R1, [BP-2]
  fmul R0, R1
  mov R1, [BP-3]
  mov R2, [BP-3]
  fmul R1, R2
  fadd R0, R1
  flt R0, 30.000000
  jf R0, __LogicalAnd_ShortCircuit_64907
  mov R1, [BP-4]
  ilt R1, 100
  and R0, R1
__LogicalAnd_ShortCircuit_64907:
  jt R0, __do_64873_start
__do_64873_end:
  mov R2, -1.500000
  mov [SP], R2
  mov R2, 1.500000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-5], R1
  mov R2, -1.500000
  mov [SP], R2
  mov R2, 1.500000
  mov [SP+1], R2
  call __function_frand
  mov R1, R0
  mov [BP-6], R1
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-6]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  mov R1, 2
  mov [SP+4], R1
  call __function_spawn_asteroid
__for_64857_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_64857_start
__for_64857_end:
__function_spawn_initial_field_return:
  mov SP, BP
  pop BP
  ret

__function_find_asteroid:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
__if_64924_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_64924_end
  mov R0, -1
  jmp __function_find_asteroid_return
__if_64924_end:
  mov R0, 0
  mov [BP-1], R0
__for_64932_start:
  mov R0, [BP-1]
  ilt R0, 36
  jf R0, __for_64932_end
__if_64941_start:
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_64946
  mov R2, global_asteroids
  mov R3, [BP-1]
  imul R3, 4
  iadd R2, R3
  mov R1, [R2]
  mov R2, [BP+2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_64946:
  jf R0, __if_64941_end
  mov R0, [BP-1]
  jmp __function_find_asteroid_return
__if_64941_end:
__for_64932_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_64932_start
__for_64932_end:
  mov R0, -1
__function_find_asteroid_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_find_bullet:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  push R3
__if_64960_start:
  mov R0, [BP+2]
  ieq R0, -1
  jf R0, __if_64960_end
  mov R0, -1
  jmp __function_find_bullet_return
__if_64960_end:
  mov R0, 0
  mov [BP-1], R0
__for_64968_start:
  mov R0, [BP-1]
  ilt R0, 12
  jf R0, __for_64968_end
__if_64977_start:
  mov R1, global_bullets
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_64982
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov R2, [BP+2]
  ieq R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_64982:
  jf R0, __if_64977_end
  mov R0, [BP-1]
  jmp __function_find_bullet_return
__if_64977_end:
__for_64968_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_64968_start
__for_64968_end:
  mov R0, -1
__function_find_bullet_return:
  pop R3
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_fire_bullet:
  push BP
  mov BP, SP
  isub SP, 55
  mov R0, 0
  mov [BP-1], R0
__for_64995_start:
  mov R0, [BP-1]
  ilt R0, 12
  jf R0, __for_64995_end
__if_65005_start:
  mov R1, global_bullets
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  bnot R0
  jf R0, __if_65005_end
  mov R1, [global_shipAngle]
  mov [SP], R1
  call __function_cos
  mov [BP-2], R0
  mov R1, [global_shipAngle]
  mov [SP], R1
  call __function_sin
  mov [BP-3], R0
  mov R1, [global_shipHandle]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-4], R0
  mov R1, [global_shipHandle]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-5], R0
  lea R1, [BP-27]
  mov [SP], R1
  call __function_b2DefaultBodyDef
  mov R0, 2
  mov [BP-27], R0
  mov R0, 1
  mov [BP-9], R0
  mov R0, [BP-4]
  mov R1, [BP-2]
  fmul R1, 0.800000
  fadd R0, R1
  mov [BP-26], R0
  mov R0, [BP-5]
  mov R1, [BP-3]
  fmul R1, 0.800000
  fadd R0, R1
  mov [BP-25], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-27]
  mov [SP+1], R1
  lea R1, [BP-30]
  mov [SP+2], R1
  call __function_b2CreateBody
  mov R0, 0.000000
  mov [BP-33], R0
  mov R0, 0.000000
  mov [BP-32], R0
  mov R0, 0.120000
  mov [BP-31], R0
  lea R1, [BP-45]
  mov [SP], R1
  call __function_b2DefaultShapeDef
  mov R0, 4.000000
  mov [BP-45], R0
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-30]
  mov [SP+1], R1
  lea R1, [BP-45]
  mov [SP+2], R1
  lea R1, [BP-33]
  mov [SP+3], R1
  lea R1, [BP-48]
  mov [SP+4], R1
  call __function_b2CreateCircleShape
  mov R2, [BP-30]
  mov [SP], R2
  mov R2, [BP-28]
  mov [SP+1], R2
  call __function_vb2_PackHandle
  mov R1, R0
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R0, 70
  mov R1, global_bullets
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, global_bullets
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov [R1], R0
  mov R2, [global_shipHandle]
  mov [SP], R2
  call __function_vb2_GetVY
  mov R1, R0
  mov R2, [BP-3]
  fmul R2, 14.000000
  fadd R1, R2
  mov [BP-49], R1
  mov R2, [global_shipHandle]
  mov [SP], R2
  call __function_vb2_GetVX
  mov R1, R0
  mov R2, [BP-2]
  fmul R2, 14.000000
  fadd R1, R2
  mov [BP-50], R1
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  mov R1, [BP-50]
  mov [SP+1], R1
  mov R1, [BP-49]
  mov [SP+2], R1
  call __function_vb2_SetVelocity
  mov R1, 0
  mov [SP], R1
  call __function_play_sound
  jmp __for_64995_end
__if_65005_end:
__for_64995_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_64995_start
__for_64995_end:
__function_fire_bullet_return:
  mov SP, BP
  pop BP
  ret

__function_destroy_bullet:
  push BP
  mov BP, SP
  isub SP, 1
__if_65156_start:
  mov R1, global_bullets
  mov R2, [BP+2]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  bnot R0
  jf R0, __if_65156_end
  jmp __function_destroy_bullet_return
__if_65156_end:
  mov R2, global_bullets
  mov R3, [BP+2]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_Destroy
  mov R0, 0
  mov R1, global_bullets
  mov R2, [BP+2]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov [R1], R0
__function_destroy_bullet_return:
  mov SP, BP
  pop BP
  ret

__function_wrap_body:
  push BP
  mov BP, SP
  isub SP, 7
  mov R1, [BP+2]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-1], R0
  mov R1, [BP+2]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-2], R0
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, [BP-2]
  mov [BP-4], R0
__if_65190_start:
  mov R0, [BP-1]
  flt R0, -17.500000
  jf R0, __if_65190_end
  mov R0, [BP-1]
  fadd R0, 35.000000
  mov [BP-3], R0
__if_65190_end:
__if_65207_start:
  mov R0, [BP-1]
  fgt R0, 17.500000
  jf R0, __if_65207_end
  mov R0, [BP-1]
  fsub R0, 35.000000
  mov [BP-3], R0
__if_65207_end:
__if_65223_start:
  mov R0, [BP-2]
  flt R0, -10.500000
  jf R0, __if_65223_end
  mov R0, [BP-2]
  fadd R0, 21.000000
  mov [BP-4], R0
__if_65223_end:
__if_65240_start:
  mov R0, [BP-2]
  fgt R0, 10.500000
  jf R0, __if_65240_end
  mov R0, [BP-2]
  fsub R0, 21.000000
  mov [BP-4], R0
__if_65240_end:
__if_65256_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  fne R0, R1
  jt R0, __LogicalOr_ShortCircuit_65261
  mov R1, [BP-4]
  mov R2, [BP-2]
  fne R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_65261:
  jf R0, __if_65256_end
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  call __function_vb2_SetPosition
__if_65256_end:
__function_wrap_body_return:
  mov SP, BP
  pop BP
  ret

__function_draw_asteroid_b2:
  push BP
  mov BP, SP
  isub SP, 24
__if_65270_start:
  mov R1, [BP+2]
  iadd R1, 3
  mov R0, [R1]
  bnot R0
  jf R0, __if_65270_end
  jmp __function_draw_asteroid_b2_return
__if_65270_end:
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-1], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-2], R0
  mov R2, [BP+2]
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetAngle
  mov [BP-3], R0
  mov R1, [BP-3]
  mov [SP], R1
  call __function_cos
  mov [BP-4], R0
  mov R1, [BP-3]
  mov [SP], R1
  call __function_sin
  mov [BP-5], R0
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
__for_65302_start:
  mov R0, [BP-7]
  ilt R0, 6
  jf R0, __for_65302_end
  mov R0, [BP-7]
  iadd R0, 1
  imod R0, 6
  mov [BP-8], R0
  mov R0, global_asteroidShapes
  mov R1, [BP-6]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-7]
  imul R1, 2
  iadd R0, R1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  mov [BP-9], R0
  mov R0, global_asteroidShapes
  mov R1, [BP-6]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-7]
  imul R1, 2
  iadd R0, R1
  iadd R0, 1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  mov [BP-10], R0
  mov R0, global_asteroidShapes
  mov R1, [BP-6]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-8]
  imul R1, 2
  iadd R0, R1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  mov [BP-11], R0
  mov R0, global_asteroidShapes
  mov R1, [BP-6]
  imul R1, 12
  iadd R0, R1
  mov R1, [BP-8]
  imul R1, 2
  iadd R0, R1
  iadd R0, 1
  mov R0, [R0]
  cif R0
  fmul R0, 0.050000
  mov [BP-12], R0
  mov R0, [BP-1]
  mov R1, [BP-4]
  mov R2, [BP-9]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-5]
  mov R2, [BP-10]
  fmul R1, R2
  fsub R0, R1
  mov [BP-13], R0
  mov R0, [BP-2]
  mov R1, [BP-5]
  mov R2, [BP-9]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-4]
  mov R2, [BP-10]
  fmul R1, R2
  fadd R0, R1
  mov [BP-14], R0
  mov R0, [BP-1]
  mov R1, [BP-4]
  mov R2, [BP-11]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-5]
  mov R2, [BP-12]
  fmul R1, R2
  fsub R0, R1
  mov [BP-15], R0
  mov R0, [BP-2]
  mov R1, [BP-5]
  mov R2, [BP-11]
  fmul R1, R2
  fadd R0, R1
  mov R1, [BP-4]
  mov R2, [BP-12]
  fmul R1, R2
  fadd R0, R1
  mov [BP-16], R0
  mov R2, [BP-16]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-17], R1
  mov R2, [BP-15]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-18], R1
  mov R2, [BP-14]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-19], R1
  mov R2, [BP-13]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-20], R1
  mov R1, [BP-20]
  mov [SP], R1
  mov R1, [BP-19]
  mov [SP+1], R1
  mov R1, [BP-18]
  mov [SP+2], R1
  mov R1, [BP-17]
  mov [SP+3], R1
  call __function_draw_line
__for_65302_continue:
  mov R0, [BP-7]
  mov R1, R0
  iadd R1, 1
  mov [BP-7], R1
  jmp __for_65302_start
__for_65302_end:
__function_draw_asteroid_b2_return:
  mov SP, BP
  pop BP
  ret

__function_draw_ship_world:
  push BP
  mov BP, SP
  isub SP, 27
  mov R0, 0.750000
  mov [BP-1], R0
  mov R0, 0.400000
  mov [BP-2], R0
  mov R0, 0.785398
  mov [BP-3], R0
  mov R1, [BP+2]
  mov R2, [BP-1]
  mov R4, [BP+4]
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-4], R0
  mov R1, [BP+3]
  mov R2, [BP-1]
  mov R4, [BP+4]
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-5], R0
  mov R1, [BP+2]
  mov R2, [BP-1]
  mov R4, [BP+4]
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-6], R0
  mov R1, [BP+3]
  mov R2, [BP-1]
  mov R4, [BP+4]
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-7], R0
  mov R1, [BP+2]
  mov R2, [BP-2]
  mov R4, [BP+4]
  mov R5, [BP-3]
  fadd R4, R5
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-8], R0
  mov R1, [BP+3]
  mov R2, [BP-2]
  mov R4, [BP+4]
  mov R5, [BP-3]
  fadd R4, R5
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-9], R0
  mov R1, [BP+2]
  mov R2, [BP-2]
  mov R4, [BP+4]
  mov R5, [BP-3]
  fsub R4, R5
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-10], R0
  mov R1, [BP+3]
  mov R2, [BP-2]
  mov R4, [BP+4]
  mov R5, [BP-3]
  fsub R4, R5
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fadd R1, R2
  mov R0, R1
  mov [BP-11], R0
  mov R2, [BP-5]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-20], R1
  mov R2, [BP-4]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-21], R1
  mov R2, [BP-9]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-22], R1
  mov R2, [BP-8]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-23], R1
  mov R1, [BP-23]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP-21]
  mov [SP+2], R1
  mov R1, [BP-20]
  mov [SP+3], R1
  call __function_draw_line
  mov R2, [BP-5]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-20], R1
  mov R2, [BP-4]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-21], R1
  mov R2, [BP-11]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-22], R1
  mov R2, [BP-10]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-23], R1
  mov R1, [BP-23]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP-21]
  mov [SP+2], R1
  mov R1, [BP-20]
  mov [SP+3], R1
  call __function_draw_line
__if_65524_start:
  mov R0, [BP+5]
  jf R0, __if_65524_end
  mov R1, [BP-6]
  mov R3, [BP+4]
  mov [SP], R3
  call __function_cos
  mov R2, R0
  fmul R2, 0.100000
  fsub R1, R2
  mov R0, R1
  mov [BP-12], R0
  mov R1, [BP-7]
  mov R3, [BP+4]
  mov [SP], R3
  call __function_sin
  mov R2, R0
  fmul R2, 0.100000
  fsub R1, R2
  mov R0, R1
  mov [BP-13], R0
  mov R0, 0.392699
  mov [BP-14], R0
  mov R0, [BP+6]
  mov R1, 0
  ieq R1, R0
  jt R1, __switch_65550_case_0
  mov R1, 1
  ieq R1, R0
  jt R1, __switch_65550_case_1
  mov R1, 2
  ieq R1, R0
  jt R1, __switch_65550_case_2
  mov R1, 3
  ieq R1, R0
  jt R1, __switch_65550_case_3
  jmp __switch_65550_default
__switch_65550_case_0:
  mov R0, 0.250000
  mov [BP-15], R0
  jmp __switch_65550_end
__switch_65550_case_1:
  mov R0, 0.400000
  mov [BP-15], R0
  jmp __switch_65550_end
__switch_65550_case_2:
  mov R0, 0.300000
  mov [BP-15], R0
  jmp __switch_65550_end
__switch_65550_case_3:
  mov R0, 0.450000
  mov [BP-15], R0
  jmp __switch_65550_end
__switch_65550_default:
  mov R0, 0.300000
  mov [BP-15], R0
__switch_65550_end:
  mov R1, [BP-12]
  mov R2, [BP-15]
  mov R4, [BP+4]
  mov R5, [BP-14]
  fadd R4, R5
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-16], R0
  mov R1, [BP-13]
  mov R2, [BP-15]
  mov R4, [BP+4]
  mov R5, [BP-14]
  fadd R4, R5
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-17], R0
  mov R1, [BP-12]
  mov R2, [BP-15]
  mov R4, [BP+4]
  mov R5, [BP-14]
  fsub R4, R5
  mov [SP], R4
  call __function_cos
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-18], R0
  mov R1, [BP-13]
  mov R2, [BP-15]
  mov R4, [BP+4]
  mov R5, [BP-14]
  fsub R4, R5
  mov [SP], R4
  call __function_sin
  mov R3, R0
  fmul R2, R3
  fsub R1, R2
  mov R0, R1
  mov [BP-19], R0
  mov R2, [BP-17]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-20], R1
  mov R2, [BP-16]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-21], R1
  mov R2, [BP-13]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-22], R1
  mov R2, [BP-12]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-23], R1
  mov R1, [BP-23]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP-21]
  mov [SP+2], R1
  mov R1, [BP-20]
  mov [SP+3], R1
  call __function_draw_line
  mov R2, [BP-19]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-20], R1
  mov R2, [BP-18]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-21], R1
  mov R2, [BP-13]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-22], R1
  mov R2, [BP-12]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-23], R1
  mov R1, [BP-23]
  mov [SP], R1
  mov R1, [BP-22]
  mov [SP+1], R1
  mov R1, [BP-21]
  mov [SP+2], R1
  mov R1, [BP-20]
  mov [SP+3], R1
  call __function_draw_line
__if_65524_end:
__function_draw_ship_world_return:
  mov SP, BP
  pop BP
  ret

__function_draw_bullets:
  push BP
  mov BP, SP
  isub SP, 13
  mov R0, 0
  mov [BP-1], R0
__for_65640_start:
  mov R0, [BP-1]
  ilt R0, 12
  jf R0, __for_65640_end
__if_65650_start:
  mov R1, global_bullets
  mov R2, [BP-1]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  jf R0, __if_65650_end
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-2], R0
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-3], R0
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetVX
  mov [BP-4], R0
  mov R2, global_bullets
  mov R3, [BP-1]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetVY
  mov [BP-5], R0
  mov R2, [BP-3]
  mov R3, [BP-5]
  fmul R3, 0.025000
  fsub R2, R3
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-6], R1
  mov R2, [BP-2]
  mov R3, [BP-4]
  fmul R3, 0.025000
  fsub R2, R3
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-7], R1
  mov R2, [BP-3]
  mov [SP], R2
  call __function_vb2_ScreenY
  mov R1, R0
  mov [BP-8], R1
  mov R2, [BP-2]
  mov [SP], R2
  call __function_vb2_ScreenX
  mov R1, R0
  mov [BP-9], R1
  mov R1, [BP-9]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  mov R1, [BP-7]
  mov [SP+2], R1
  mov R1, [BP-6]
  mov [SP+3], R1
  call __function_draw_line
__if_65650_end:
__for_65640_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_65640_start
__for_65640_end:
__function_draw_bullets_return:
  mov SP, BP
  pop BP
  ret

__function_clear_field:
  push BP
  mov BP, SP
  isub SP, 2
  mov R0, 0
  mov [BP-1], R0
__for_65702_start:
  mov R0, [BP-1]
  ilt R0, 36
  jf R0, __for_65702_end
__if_65712_start:
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  jf R0, __if_65712_end
  mov R2, global_asteroids
  mov R3, [BP-1]
  imul R3, 4
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_Destroy
  mov R0, 0
  mov R1, global_asteroids
  mov R2, [BP-1]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov [R1], R0
__if_65712_end:
__for_65702_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_65702_start
__for_65702_end:
  mov R0, 0
  mov [BP-1], R0
__for_65729_start:
  mov R0, [BP-1]
  ilt R0, 12
  jf R0, __for_65729_end
  mov R1, [BP-1]
  mov [SP], R1
  call __function_destroy_bullet
__for_65729_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_65729_start
__for_65729_end:
__function_clear_field_return:
  mov SP, BP
  pop BP
  ret

__function_reset_ship:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  call __function_vb2_SetPosition
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  mov R1, 0.000000
  mov [SP+2], R1
  call __function_vb2_SetVelocity
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  call __function_vb2_SetAngularVelocity
  mov R0, 1.570796
  mov [global_shipAngle], R0
__function_reset_ship_return:
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 87
  call __function_vb2_Init
  mov R1, 0.000000
  mov [SP], R1
  mov R1, 0.000000
  mov [SP+1], R1
  call __function_vb2_SetGravity
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, 1
  mov [SP+1], R1
  call __function_b2World_EnableContinuous
  mov R2, 0.000000
  mov [SP], R2
  mov R2, 0.000000
  mov [SP+1], R2
  mov R2, 0.500000
  mov [SP+2], R2
  call __function_vb2_Ball
  mov R1, R0
  mov [global_shipHandle], R1
  mov R0, R1
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, 0.200000
  mov [SP+1], R1
  call __function_vb2_SetFriction
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, 0.400000
  mov [SP+1], R1
  call __function_vb2_SetBounce
  mov R1, [global_shipHandle]
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  call __function_vb2_GetBodyId
  mov R1, global_vb2_world
  mov [SP], R1
  lea R1, [BP-3]
  mov [SP+1], R1
  mov R1, 0.900000
  mov [SP+2], R1
  call __function_b2Body_SetLinearDamping
  mov R0, 1.570796
  mov [global_shipAngle], R0
  mov R0, 4.000000
  mov [BP-4], R0
  mov R0, 8.000000
  mov [BP-5], R0
  mov R0, 0.016667
  mov [BP-6], R0
  mov R0, 0
  mov [BP-7], R0
  mov R0, 0
  mov [BP-8], R0
  mov R0, 0
  mov [BP-9], R0
  mov R1, 3
  mov [SP], R1
  call __function_select_sound
  mov R1, 1
  mov [SP], R1
  call __function_set_sound_loop
  mov R1, 0
  mov [SP], R1
  call __function_select_gamepad
  call __function_spawn_initial_field
__while_65822_start:
__while_65822_continue:
  mov R0, 1
  jf R0, __while_65822_end
  mov R0, 0
  mov [BP-7], R0
__if_65828_start:
  mov R0, [global_isAlive]
  jf R0, __if_65828_end
__if_65831_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_65831_end
  mov R0, [global_shipAngle]
  mov R1, [BP-4]
  mov R2, [BP-6]
  fmul R1, R2
  fadd R0, R1
  mov [global_shipAngle], R0
__if_65831_end:
__if_65840_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_65840_end
  mov R0, [global_shipAngle]
  mov R1, [BP-4]
  mov R2, [BP-6]
  fmul R1, R2
  fsub R0, R1
  mov [global_shipAngle], R0
__if_65840_end:
__if_65849_start:
  call __function_gamepad_button_a
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_65849_end
  mov R1, [BP-5]
  mov R3, [global_shipAngle]
  mov [SP], R3
  call __function_sin
  mov R2, R0
  fmul R1, R2
  mov [BP-81], R1
  mov R1, [BP-5]
  mov R3, [global_shipAngle]
  mov [SP], R3
  call __function_cos
  mov R2, R0
  fmul R1, R2
  mov [BP-82], R1
  mov R1, [global_shipHandle]
  mov [SP], R1
  mov R1, [BP-82]
  mov [SP+1], R1
  mov R1, [BP-81]
  mov [SP+2], R1
  call __function_vb2_ApplyForce
  mov R0, 1
  mov [BP-7], R0
__if_65849_end:
__if_65867_start:
  call __function_gamepad_button_b
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  jf R0, __if_65867_end
  call __function_fire_bullet
__if_65867_end:
  mov R0, [global_spawnTimer]
  mov R1, R0
  iadd R1, 1
  mov [global_spawnTimer], R1
__if_65874_start:
  mov R1, [global_spawnTimer]
  ige R1, 300
  jt R1, __LogicalOr_ShortCircuit_65879
  call __function_count_active_asteroids
  mov R2, R0
  ieq R2, 0
  or R1, R2
__LogicalOr_ShortCircuit_65879:
  mov R0, R1
  jf R0, __if_65874_end
  mov R0, 0
  mov [global_spawnTimer], R0
  call __function_spawn_big_offscreen
__if_65874_end:
__if_65887_start:
  mov R0, [global_invulnFrames]
  igt R0, 0
  jf R0, __if_65887_end
  mov R0, [global_invulnFrames]
  mov R1, R0
  isub R1, 1
  mov [global_invulnFrames], R1
__if_65887_end:
__if_65828_end:
  mov R1, global_vb2_world
  mov [SP], R1
  mov R1, [BP-6]
  mov [SP+1], R1
  mov R1, 2
  mov [SP+2], R1
  call __function_b2World_Step
__if_65898_start:
  mov R0, [global_isAlive]
  jf R0, __if_65898_end
  call __function_vb2_TouchCount
  mov [BP-74], R0
__if_65910_start:
  mov R0, [BP-74]
  igt R0, 32
  jf R0, __if_65910_end
  mov R0, 32
  mov [BP-74], R0
__if_65910_end:
  mov R0, 0
  mov [BP-76], R0
__for_65917_start:
  mov R0, [BP-76]
  mov R1, [BP-74]
  ilt R0, R1
  jf R0, __for_65917_end
  mov R2, [BP-76]
  mov [SP], R2
  call __function_vb2_TouchA
  mov R1, R0
  lea R2, [BP-41]
  mov R3, [BP-76]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
  mov R2, [BP-76]
  mov [SP], R2
  call __function_vb2_TouchB
  mov R1, R0
  lea R2, [BP-73]
  mov R3, [BP-76]
  iadd R2, R3
  mov [R2], R1
  mov R0, R1
__for_65917_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_65917_start
__for_65917_end:
  mov R0, 0
  mov [BP-76], R0
__for_65939_start:
  mov R0, [BP-76]
  ilt R0, 36
  jf R0, __for_65939_end
  mov R0, 0
  mov R1, global_asteroidDead
  mov R2, [BP-76]
  iadd R1, R2
  mov [R1], R0
  mov R0, 0
  mov R1, global_asteroidScored
  mov R2, [BP-76]
  iadd R1, R2
  mov [R1], R0
__for_65939_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_65939_start
__for_65939_end:
  mov R0, 0
  mov [BP-76], R0
__for_65959_start:
  mov R0, [BP-76]
  ilt R0, 12
  jf R0, __for_65959_end
  mov R0, 0
  mov R1, global_bulletSpent
  mov R2, [BP-76]
  iadd R1, R2
  mov [R1], R0
__for_65959_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_65959_start
__for_65959_end:
  mov R0, 0
  mov [BP-75], R0
  mov R0, 0
  mov [BP-76], R0
__for_65976_start:
  mov R0, [BP-76]
  mov R1, [BP-74]
  ilt R0, R1
  jf R0, __for_65976_end
  lea R0, [BP-41]
  mov R1, [BP-76]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-77], R0
  lea R0, [BP-73]
  mov R1, [BP-76]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-78], R0
__if_65996_start:
  mov R0, [BP-77]
  mov R1, [global_shipHandle]
  ieq R0, R1
  jt R0, __LogicalOr_ShortCircuit_66001
  mov R1, [BP-78]
  mov R2, [global_shipHandle]
  ieq R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_66001:
  jf R0, __if_65996_else
__if_66007_start:
  mov R0, [BP-77]
  mov R1, [global_shipHandle]
  ieq R0, R1
  jf R0, __if_66007_else
  mov R0, [BP-78]
  mov [BP-79], R0
  jmp __if_66007_end
__if_66007_else:
  mov R0, [BP-77]
  mov [BP-79], R0
__if_66007_end:
  mov R1, [BP-79]
  mov [SP], R1
  call __function_find_asteroid
  mov [BP-80], R0
__if_66021_start:
  mov R0, [BP-80]
  ige R0, 0
  jf R0, __LogicalAnd_ShortCircuit_66026
  mov R1, [global_invulnFrames]
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_66026:
  jf R0, __if_66021_end
  mov R0, 1
  mov [BP-75], R0
  mov R0, 1
  mov R1, global_asteroidDead
  mov R2, [BP-80]
  iadd R1, R2
  mov [R1], R0
__if_66021_end:
  jmp __if_65996_end
__if_65996_else:
  mov R1, [BP-77]
  mov [SP], R1
  call __function_find_bullet
  mov [BP-79], R0
  mov R1, [BP-78]
  mov [SP], R1
  call __function_find_asteroid
  mov [BP-80], R0
__if_66047_start:
  mov R0, [BP-79]
  ilt R0, 0
  jf R0, __if_66047_end
  mov R2, [BP-78]
  mov [SP], R2
  call __function_find_bullet
  mov R1, R0
  mov [BP-79], R1
  mov R0, R1
  mov R2, [BP-77]
  mov [SP], R2
  call __function_find_asteroid
  mov R1, R0
  mov [BP-80], R1
  mov R0, R1
__if_66047_end:
__if_66060_start:
  mov R0, [BP-79]
  ige R0, 0
  jf R0, __LogicalAnd_ShortCircuit_66065
  mov R1, [BP-80]
  ige R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_66065:
  jf R0, __if_66060_end
  mov R0, 1
  mov R1, global_asteroidDead
  mov R2, [BP-80]
  iadd R1, R2
  mov [R1], R0
  mov R0, 1
  mov R1, global_asteroidScored
  mov R2, [BP-80]
  iadd R1, R2
  mov [R1], R0
  mov R0, 1
  mov R1, global_bulletSpent
  mov R2, [BP-79]
  iadd R1, R2
  mov [R1], R0
__if_66060_end:
__if_65996_end:
__for_65976_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_65976_start
__for_65976_end:
  mov R0, 0
  mov [BP-76], R0
__for_66084_start:
  mov R0, [BP-76]
  ilt R0, 12
  jf R0, __for_66084_end
__if_66093_start:
  mov R0, global_bulletSpent
  mov R1, [BP-76]
  iadd R0, R1
  mov R0, [R0]
  jf R0, __if_66093_end
  mov R1, [BP-76]
  mov [SP], R1
  call __function_destroy_bullet
__if_66093_end:
__for_66084_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_66084_start
__for_66084_end:
  mov R0, 0
  mov [BP-76], R0
__for_66099_start:
  mov R0, [BP-76]
  ilt R0, 36
  jf R0, __for_66099_end
__if_66109_start:
  mov R0, global_asteroidDead
  mov R1, [BP-76]
  iadd R0, R1
  mov R0, [R0]
  jf R0, __LogicalAnd_ShortCircuit_66113
  mov R2, global_asteroids
  mov R3, [BP-76]
  imul R3, 4
  iadd R2, R3
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_66113:
  jf R0, __if_66109_end
__if_66119_start:
  mov R0, global_asteroidScored
  mov R1, [BP-76]
  iadd R0, R1
  mov R0, [R0]
  jf R0, __if_66119_end
  mov R1, [global_score]
  mov R4, global_asteroids
  mov R5, [BP-76]
  imul R5, 4
  iadd R4, R5
  iadd R4, 1
  mov R3, [R4]
  mov [SP], R3
  call __function_asteroid_points
  mov R2, R0
  iadd R1, R2
  mov [global_score], R1
  mov R0, R1
__if_66119_end:
  mov R1, 1
  mov [SP], R1
  call __function_play_sound
  mov R1, [BP-76]
  mov [SP], R1
  call __function_split_asteroid
__if_66109_end:
__for_66099_continue:
  mov R0, [BP-76]
  mov R1, R0
  iadd R1, 1
  mov [BP-76], R1
  jmp __for_66099_start
__for_66099_end:
__if_66134_start:
  mov R0, [BP-75]
  jf R0, __if_66134_end
  mov R0, [global_lives]
  mov R1, R0
  isub R1, 1
  mov [global_lives], R1
  mov R1, 2
  mov [SP], R1
  call __function_play_sound
  call __function_reset_ship
  mov R0, 150
  mov [global_invulnFrames], R0
__if_66145_start:
  mov R0, [global_lives]
  ile R0, 0
  jf R0, __if_66145_end
  mov R0, 0
  mov [global_isAlive], R0
  mov R0, 0
  mov [BP-7], R0
__if_66145_end:
__if_66134_end:
__if_65898_end:
  mov R0, 0
  mov [BP-10], R0
__for_66156_start:
  mov R0, [BP-10]
  ilt R0, 12
  jf R0, __for_66156_end
__if_66166_start:
  mov R1, global_bullets
  mov R2, [BP-10]
  imul R2, 3
  iadd R1, R2
  iadd R1, 2
  mov R0, [R1]
  jf R0, __if_66166_end
  mov R2, global_bullets
  mov R3, [BP-10]
  imul R3, 3
  iadd R2, R3
  iadd R2, 1
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
  mov R2, global_bullets
  mov R3, [BP-10]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetX
  mov [BP-11], R0
  mov R2, global_bullets
  mov R3, [BP-10]
  imul R3, 3
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_vb2_GetY
  mov [BP-12], R0
__if_66191_start:
  mov R1, global_bullets
  mov R2, [BP-10]
  imul R2, 3
  iadd R1, R2
  iadd R1, 1
  mov R0, [R1]
  ile R0, 0
  jt R0, __LogicalOr_ShortCircuit_66199
  mov R1, [BP-11]
  flt R1, -16.500000
  or R0, R1
__LogicalOr_ShortCircuit_66199:
  jt R0, __LogicalOr_ShortCircuit_66206
  mov R1, [BP-11]
  fgt R1, 16.500000
  or R0, R1
__LogicalOr_ShortCircuit_66206:
  jt R0, __LogicalOr_ShortCircuit_66212
  mov R1, [BP-12]
  flt R1, -9.500000
  or R0, R1
__LogicalOr_ShortCircuit_66212:
  jt R0, __LogicalOr_ShortCircuit_66219
  mov R1, [BP-12]
  fgt R1, 9.500000
  or R0, R1
__LogicalOr_ShortCircuit_66219:
  jf R0, __if_66191_end
  mov R1, [BP-10]
  mov [SP], R1
  call __function_destroy_bullet
__if_66191_end:
__if_66166_end:
__for_66156_continue:
  mov R0, [BP-10]
  mov R1, R0
  iadd R1, 1
  mov [BP-10], R1
  jmp __for_66156_start
__for_66156_end:
  mov R1, [global_shipHandle]
  mov [SP], R1
  call __function_wrap_body
  mov R0, 0
  mov [BP-10], R0
__for_66228_start:
  mov R0, [BP-10]
  ilt R0, 36
  jf R0, __for_66228_end
__if_66237_start:
  mov R1, global_asteroids
  mov R2, [BP-10]
  imul R2, 4
  iadd R1, R2
  iadd R1, 3
  mov R0, [R1]
  jf R0, __if_66237_end
  mov R2, global_asteroids
  mov R3, [BP-10]
  imul R3, 4
  iadd R2, R3
  mov R1, [R2]
  mov [SP], R1
  call __function_wrap_body
__if_66237_end:
__for_66228_continue:
  mov R0, [BP-10]
  mov R1, R0
  iadd R1, 1
  mov [BP-10], R1
  jmp __for_66228_start
__for_66228_end:
  mov R1, -16777216
  mov [SP], R1
  call __function_clear_screen
  mov R0, 0
  mov [BP-10], R0
__for_66249_start:
  mov R0, [BP-10]
  ilt R0, 36
  jf R0, __for_66249_end
  mov R1, global_asteroids
  mov R2, [BP-10]
  imul R2, 4
  iadd R1, R2
  mov [SP], R1
  call __function_draw_asteroid_b2
__for_66249_continue:
  mov R0, [BP-10]
  mov R1, R0
  iadd R1, 1
  mov [BP-10], R1
  jmp __for_66249_start
__for_66249_end:
  call __function_draw_bullets
__if_66264_start:
  mov R0, [global_isAlive]
  jf R0, __if_66264_else
  mov R0, [BP-9]
  iadd R0, 1
  imod R0, 4
  mov [BP-9], R0
  mov R0, 1
  mov [BP-10], R0
__if_66278_start:
  mov R0, [global_invulnFrames]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_66286
  mov R1, [global_invulnFrames]
  idiv R1, 4
  imod R1, 2
  ieq R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_66286:
  jf R0, __if_66278_end
  mov R0, 0
  mov [BP-10], R0
__if_66278_end:
__if_66294_start:
  mov R0, [BP-10]
  jf R0, __if_66294_end
  mov R2, [global_shipHandle]
  mov [SP], R2
  call __function_vb2_GetY
  mov R1, R0
  mov [BP-81], R1
  mov R2, [global_shipHandle]
  mov [SP], R2
  call __function_vb2_GetX
  mov R1, R0
  mov [BP-82], R1
  mov R1, [BP-82]
  mov [SP], R1
  mov R1, [BP-81]
  mov [SP+1], R1
  mov R1, [global_shipAngle]
  mov [SP+2], R1
  mov R1, [BP-7]
  mov [SP+3], R1
  mov R1, [BP-9]
  mov [SP+4], R1
  call __function_draw_ship_world
__if_66294_end:
  mov R1, [global_score]
  mov [SP], R1
  mov R1, global_numberBuffer
  mov [SP+1], R1
  call __function_int_to_string
  mov R1, 10
  mov [SP], R1
  mov R1, 10
  mov [SP+1], R1
  mov R1, __literal_string_66310
  mov [SP+2], R1
  call __function_print_at
  mov R1, 70
  mov [SP], R1
  mov R1, 10
  mov [SP+1], R1
  mov R1, global_numberBuffer
  mov [SP+2], R1
  call __function_print_at
  mov R1, 10
  mov [SP], R1
  mov R1, 30
  mov [SP+1], R1
  mov R1, __literal_string_66318
  mov [SP+2], R1
  call __function_print_at
  mov R0, 0
  mov [BP-11], R0
__for_66319_start:
  mov R0, [BP-11]
  mov R1, [global_lives]
  ilt R0, R1
  jf R0, __for_66319_end
  mov R1, [BP-11]
  imul R1, 20
  iadd R1, 70
  mov [SP], R1
  mov R1, 30
  mov [SP+1], R1
  mov R1, __literal_string_66335
  mov [SP+2], R1
  call __function_print_at
__for_66319_continue:
  mov R0, [BP-11]
  mov R1, R0
  iadd R1, 1
  mov [BP-11], R1
  jmp __for_66319_start
__for_66319_end:
  jmp __if_66264_end
__if_66264_else:
__if_66337_start:
  mov R0, [global_score]
  mov R1, [global_maxScore]
  igt R0, R1
  jf R0, __if_66337_end
  mov R0, [global_score]
  mov [global_maxScore], R0
__if_66337_end:
  mov R1, 270
  mov [SP], R1
  mov R1, 170
  mov [SP+1], R1
  mov R1, __literal_string_66347
  mov [SP+2], R1
  call __function_print_at
  mov R1, [global_score]
  mov [SP], R1
  mov R1, global_numberBuffer
  mov [SP+1], R1
  call __function_int_to_string
  mov R1, 250
  mov [SP], R1
  mov R1, 190
  mov [SP+1], R1
  mov R1, __literal_string_66354
  mov [SP+2], R1
  call __function_print_at
  mov R1, 380
  mov [SP], R1
  mov R1, 190
  mov [SP+1], R1
  mov R1, global_numberBuffer
  mov [SP+2], R1
  call __function_print_at
  mov R1, [global_maxScore]
  mov [SP], R1
  mov R1, global_numberBuffer
  mov [SP+1], R1
  call __function_int_to_string
  mov R1, 250
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  mov R1, __literal_string_66365
  mov [SP+2], R1
  call __function_print_at
  mov R1, 380
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  mov R1, global_numberBuffer
  mov [SP+2], R1
  call __function_print_at
  mov R1, 230
  mov [SP], R1
  mov R1, 240
  mov [SP+1], R1
  mov R1, __literal_string_66373
  mov [SP+2], R1
  call __function_print_at
__if_66374_start:
  call __function_gamepad_button_a
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  jf R0, __if_66374_end
  mov R0, 0
  mov [global_score], R0
  mov R0, 3
  mov [global_lives], R0
  mov R0, 1
  mov [global_isAlive], R0
  mov R0, 0
  mov [global_spawnTimer], R0
  mov R0, 150
  mov [global_invulnFrames], R0
  call __function_clear_field
  call __function_reset_ship
  call __function_spawn_initial_field
__if_66374_end:
__if_66264_end:
__if_66397_start:
  mov R0, [BP-7]
  jf R0, __LogicalAnd_ShortCircuit_66399
  mov R1, [BP-8]
  bnot R1
  and R0, R1
__LogicalAnd_ShortCircuit_66399:
  jf R0, __if_66397_end
  mov R1, 3
  mov [SP], R1
  mov R1, 15
  mov [SP+1], R1
  call __function_play_sound_in_channel
__if_66397_end:
__if_66405_start:
  mov R0, [BP-7]
  bnot R0
  jf R0, __LogicalAnd_ShortCircuit_66408
  mov R1, [BP-8]
  and R0, R1
__LogicalAnd_ShortCircuit_66408:
  jf R0, __if_66405_end
  mov R1, 15
  mov [SP], R1
  call __function_stop_channel
__if_66405_end:
  mov R0, [BP-7]
  mov [BP-8], R0
  call __function_end_frame
  jmp __while_65822_start
__while_65822_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_19253:
  string "0123456789ABCDEF"
__literal_string_19290:
  string "-2147483648"
__literal_string_66310:
  string "Score:"
__literal_string_66318:
  string "Life:"
__literal_string_66335:
  string "V"
__literal_string_66347:
  string "GAME OVER"
__literal_string_66354:
  string "Final Score:"
__literal_string_66365:
  string "Highscore:"
__literal_string_66373:
  string "Press A to restart"
