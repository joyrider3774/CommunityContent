; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_b2_eps_denom 0

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 8388608.000000
  mov [global_b2_eps_denom], R0
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 1
  mov R0, 1.000000
  mov R1, [global_b2_eps_denom]
  fdiv R0, R1
  mov [BP-1], R0
__function_main_return:
  mov SP, BP
  pop BP
  ret

