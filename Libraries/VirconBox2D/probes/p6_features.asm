; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  %define global_Zero 0
  %define global_Identity 2
  %define global_Arr 4

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 0.000000
  mov [global_Zero], R0
  mov R0, 0.000000
  mov [1], R0
  mov R0, 1.000000
  mov [global_Identity], R0
  mov R0, 0.000000
  mov [3], R0
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 22
  mov R0, 2.000000
  mov [BP-1], R0
  mov R0, [BP-1]
  mov [BP-3], R0
  mov R0, 0.005000
  mov [BP-2], R0
  mov R12, global_Zero
  lea DR, [BP-5]
  mov CR, 2
  movs
  mov R0, 5.000000
  mov [global_Identity], R0
  mov R0, 3
  mov [BP-6], R0
  mov R0, 1.000000
  mov [BP-22], R0
__function_main_return:
  mov SP, BP
  pop BP
  ret

