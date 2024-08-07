//===-- Implementation header for pthread_attr_getstacksize -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_PTHREAD_PTHREAD_ATTR_GETSTACKSIZE_H
#define LLVM_LIBC_SRC_PTHREAD_PTHREAD_ATTR_GETSTACKSIZE_H

#include "src/__support/macros/config.h"
#include <pthread.h>

namespace LIBC_NAMESPACE_DECL {

int pthread_attr_getstacksize(const pthread_attr_t *__restrict attr,
                              size_t *__restrict stacksize);

} // namespace LIBC_NAMESPACE_DECL

#endif // LLVM_LIBC_SRC_PTHREAD_PTHREAD_ATTR_GETSTACKSIZE_H
