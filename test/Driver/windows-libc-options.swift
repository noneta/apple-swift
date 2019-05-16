// -- check flags for /MD
// RUN: %swiftc_driver -target x86_64-unknown-windows-msvc -libc MD -c %s -### 2>&1 | %FileCheck %s -check-prefix CHECK-MD
// CHECK-MD: -autolink-library oldnames -autolink-library ucrt -Xcc -D_DLL -Xcc -D_MT

// -- check flags for /MDd
// RUN: %swiftc_driver -target x86_64-unknown-windows-msvc -libc MDd -c %s -### 2>&1 | %FileCheck %s -check-prefix CHECK-MD
// CHECK-MD: -autolink-library oldnames -autolink-library ucrtd -Xcc -D_DLL -Xcc -D_MT

// -- check flags for /MT
// RUN: %swiftc_driver -target x86_64-unknown-windows-msvc -libc MDd -c %s -### 2>&1 | %FileCheck %s -check-prefix CHECK-MD
// CHECK-MD: -autolink-library oldnames -autolink-library libucrt -Xcc -D_MT

// -- check flags for /MTd
// RUN: %swiftc_driver -target x86_64-unknown-windows-msvc -libc MDd -c %s -### 2>&1 | %FileCheck %s -check-prefix CHECK-MD
// CHECK-MD: -autolink-library oldnames -autolink-library libucrtd -Xcc -D_MT

