// -- check that `-libc` is required on Windows
// RUN: not %swiftc_driver -target x86_64-unknown-windows-msvc -c %s -### 2>&1 | %FileCheck %s -check-prefix CHECK-REQUIRED
// CHECK-REQUIRED: error: missing argument valeu for '-libc', expected 1 argument(s)

// -- check that invalid values are flagged
// RUN: not %swiftc_driver -target x86_64-unknown-windows-msvc -libc MLd -c %s -### | %FileCheck %s -check-prefix CHECK-UNSUPPORTED
// CHECK-UNSUPPORTED: error: invalid value 'MLd' in '-libc'

// -- check that cross-compilation still succeeds
// RUN: %swiftc_driver -target x86_64-unknown-linux-gnu -c %s -###

