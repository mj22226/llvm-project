; RUN: llc -verify-machineinstrs -enable-machine-outliner -mtriple aarch64 %s -o - | \
; RUN:   FileCheck %s --check-prefixes CHECK,V8A
; RUN: llc -verify-machineinstrs -enable-machine-outliner -mtriple aarch64 -mattr=+v8.3a %s -o - | \
; RUN:   FileCheck %s --check-prefixes CHECK,V83A

define void @a() "sign-return-address"="all" "sign-return-address-key"="a_key" nounwind {
; CHECK-LABEL:      a:                                     // @a
; V8A:              hint #25
; V83A:             paciasp
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 1, ptr %1, align 4
  store i32 2, ptr %2, align 4
  store i32 3, ptr %3, align 4
  store i32 4, ptr %4, align 4
  store i32 5, ptr %5, align 4
  store i32 6, ptr %6, align 4
; V8A:              hint #29
; V83A:             retaa
  ret void
}

define void @b() "sign-return-address"="all" nounwind {
; CHECK-LABEL:      b:                                     // @b
; V8A:              hint #25
; V83A:             paciasp
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 1, ptr %1, align 4
  store i32 2, ptr %2, align 4
  store i32 3, ptr %3, align 4
  store i32 4, ptr %4, align 4
  store i32 5, ptr %5, align 4
  store i32 6, ptr %6, align 4
; V8A:              hint #29
; V83A:             retaa
  ret void
}

define void @c() "sign-return-address"="all" nounwind {
; CHECK-LABEL:      c:                                     // @c
; V8A:              hint #25
; V83A:             paciasp
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 1, ptr %1, align 4
  store i32 2, ptr %2, align 4
  store i32 3, ptr %3, align 4
  store i32 4, ptr %4, align 4
  store i32 5, ptr %5, align 4
  store i32 6, ptr %6, align 4
; V8A:              hint #29
; V83A:             retaa
  ret void
}

; CHECK-LABEL:      OUTLINED_FUNCTION_0:
; V8A:                hint #25
; V83A:               paciasp
; V8A:                hint #29
; V8A-NEXT:           ret
; V83A:               retaa
