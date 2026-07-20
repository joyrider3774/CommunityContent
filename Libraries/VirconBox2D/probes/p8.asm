; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables

__global_scope_initialization:
  push BP
  mov BP, SP
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 6
  mov R0, 0.001000
  mov [BP-1], R0
  mov R0, 0.000100
  mov [BP-2], R0
  mov R0, 0.000010
  mov [BP-3], R0
  mov R0, 0.000001
  mov [BP-4], R0
  mov R0, 0.000000
  mov [BP-5], R0
  mov R0, 0.000000
  mov [BP-6], R0
__function_main_return:
  mov SP, BP
  pop BP
  ret

