; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_KFIVE 0
  %define global_KHALF 1
  %define global_gd 2
  %define global_gc 3
  %define global_gs 4
  %define global_gl 5

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 5
  mov [global_KFIVE], R0
  mov R0, 0.500000
  mov [global_KHALF], R0
  mov R0, 2.500000
  mov [global_gd], R0
  mov R0, 65
  mov [global_gc], R0
  mov R0, 7
  mov [global_gs], R0
  mov R0, 9
  mov [global_gl], R0
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 4
  mov R0, [global_gd]
  mov R1, [global_KHALF]
  fadd R0, R1
  mov [BP-1], R0
  mov R0, [global_gc]
  iadd R0, 1
  mov [BP-2], R0
  mov R0, [global_KFIVE]
  mov R1, [global_KFIVE]
  imul R0, R1
  mov [BP-3], R0
  mov R0, [BP-1]
  mov R1, [BP-2]
  cif R1
  fmul R0, R1
  mov R1, [BP-3]
  cif R1
  fmul R0, R1
  mov [BP-4], R0
__if_139_start:
  mov R0, [BP-4]
  fgt R0, 0.000000
  jf R0, __if_139_end
  mov R0, [global_gl]
  mov [global_gs], R0
__if_139_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

