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
  isub SP, 2
  mov R0, 0.000000
  mov [BP-1], R0
  mov R0, 0
  mov [BP-2], R0
__if_8_start:
  mov R0, [BP-1]
  fle R0, 0.000000
  jf R0, __if_8_end
  mov R0, 1
  mov R1, [BP-2]
  idiv R0, R1
  mov [BP-2], R0
__if_8_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

