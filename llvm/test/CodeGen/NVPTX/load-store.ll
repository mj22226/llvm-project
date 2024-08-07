; RUN: llc < %s -march=nvptx64 -mcpu=sm_20 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -march=nvptx64 -mcpu=sm_20 | %ptxas-verify %}

; CHECK-LABEL: plain
define void @plain(ptr %a, ptr %b, ptr %c, ptr %d) local_unnamed_addr {
  ; CHECK: ld.u8 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %a.load = load i8, ptr %a
  %a.add = add i8 %a.load, 1
  ; CHECK: st.u8 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store i8 %a.add, ptr %a

  ; CHECK: ld.u16 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %b.load = load i16, ptr %b
  %b.add = add i16 %b.load, 1
  ; CHECK: st.u16 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store i16 %b.add, ptr %b

  ; CHECK: ld.u32 %r{{[0-9]+}}, [%rd{{[0-9]+}}]
  %c.load = load i32, ptr %c
  %c.add = add i32 %c.load, 1
  ; CHECK: st.u32 [%rd{{[0-9]+}}], %r{{[0-9]+}}
  store i32 %c.add, ptr %c

  ; CHECK: ld.u64 %rd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %d.load = load i64, ptr %d
  %d.add = add i64 %d.load, 1
  ; CHECK: st.u64 [%rd{{[0-9]+}}], %rd{{[0-9]+}}
  store i64 %d.add, ptr %d

  ; CHECK: ld.f32 %f{{[0-9]+}}, [%rd{{[0-9]+}}]
  %e.load = load float, ptr %c
  %e.add = fadd float %e.load, 1.
  ; CHECK: st.f32 [%rd{{[0-9]+}}], %f{{[0-9]+}}
  store float %e.add, ptr %c

  ; CHECK: ld.f64 %fd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %f.load = load double, ptr %c
  %f.add = fadd double %f.load, 1.
  ; CHECK: st.f64 [%rd{{[0-9]+}}], %fd{{[0-9]+}}
  store double %f.add, ptr %c

  ret void
}

; CHECK-LABEL: volatile
define void @volatile(ptr %a, ptr %b, ptr %c, ptr %d) local_unnamed_addr {
  ; CHECK: ld.volatile.u8 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %a.load = load volatile i8, ptr %a
  %a.add = add i8 %a.load, 1
  ; CHECK: st.volatile.u8 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store volatile i8 %a.add, ptr %a

  ; CHECK: ld.volatile.u16 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %b.load = load volatile i16, ptr %b
  %b.add = add i16 %b.load, 1
  ; CHECK: st.volatile.u16 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store volatile i16 %b.add, ptr %b

  ; CHECK: ld.volatile.u32 %r{{[0-9]+}}, [%rd{{[0-9]+}}]
  %c.load = load volatile i32, ptr %c
  %c.add = add i32 %c.load, 1
  ; CHECK: st.volatile.u32 [%rd{{[0-9]+}}], %r{{[0-9]+}}
  store volatile i32 %c.add, ptr %c

  ; CHECK: ld.volatile.u64 %rd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %d.load = load volatile i64, ptr %d
  %d.add = add i64 %d.load, 1
  ; CHECK: st.volatile.u64 [%rd{{[0-9]+}}], %rd{{[0-9]+}}
  store volatile i64 %d.add, ptr %d

  ; CHECK: ld.volatile.f32 %f{{[0-9]+}}, [%rd{{[0-9]+}}]
  %e.load = load volatile float, ptr %c
  %e.add = fadd float %e.load, 1.
  ; CHECK: st.volatile.f32 [%rd{{[0-9]+}}], %f{{[0-9]+}}
  store volatile float %e.add, ptr %c

  ; CHECK: ld.volatile.f64 %fd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %f.load = load volatile double, ptr %c
  %f.add = fadd double %f.load, 1.
  ; CHECK: st.volatile.f64 [%rd{{[0-9]+}}], %fd{{[0-9]+}}
  store volatile double %f.add, ptr %c

  ret void
}

; CHECK-LABEL: monotonic
define void @monotonic(ptr %a, ptr %b, ptr %c, ptr %d, ptr %e) local_unnamed_addr {
  ; CHECK: ld.volatile.u8 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %a.load = load atomic i8, ptr %a monotonic, align 1
  %a.add = add i8 %a.load, 1
  ; CHECK: st.volatile.u8 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store atomic i8 %a.add, ptr %a monotonic, align 1

  ; CHECK: ld.volatile.u16 %rs{{[0-9]+}}, [%rd{{[0-9]+}}]
  %b.load = load atomic i16, ptr %b monotonic, align 2
  %b.add = add i16 %b.load, 1
  ; CHECK: st.volatile.u16 [%rd{{[0-9]+}}], %rs{{[0-9]+}}
  store atomic i16 %b.add, ptr %b monotonic, align 2

  ; CHECK: ld.volatile.u32 %r{{[0-9]+}}, [%rd{{[0-9]+}}]
  %c.load = load atomic i32, ptr %c monotonic, align 4
  %c.add = add i32 %c.load, 1
  ; CHECK: st.volatile.u32 [%rd{{[0-9]+}}], %r{{[0-9]+}}
  store atomic i32 %c.add, ptr %c monotonic, align 4

  ; CHECK: ld.volatile.u64 %rd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %d.load = load atomic i64, ptr %d monotonic, align 8
  %d.add = add i64 %d.load, 1
  ; CHECK: st.volatile.u64 [%rd{{[0-9]+}}], %rd{{[0-9]+}}
  store atomic i64 %d.add, ptr %d monotonic, align 8

  ; CHECK: ld.volatile.f32 %f{{[0-9]+}}, [%rd{{[0-9]+}}]
  %e.load = load atomic float, ptr %e monotonic, align 4
  %e.add = fadd float %e.load, 1.0
  ; CHECK: st.volatile.f32 [%rd{{[0-9]+}}], %f{{[0-9]+}}
  store atomic float %e.add, ptr %e monotonic, align 4

  ; CHECK: ld.volatile.f64 %fd{{[0-9]+}}, [%rd{{[0-9]+}}]
  %f.load = load atomic double, ptr %e monotonic, align 8
  %f.add = fadd double %f.load, 1.
  ; CHECK: st.volatile.f64 [%rd{{[0-9]+}}], %fd{{[0-9]+}}
  store atomic double %f.add, ptr %e monotonic, align 8

  ret void
}
