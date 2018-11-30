add_swift_host_library(swiftDemangle
                       SHARED
                         SwiftDemangle.cpp
                         MangleHack.cpp
                       LINK_LIBS
                         swiftDemangling)
target_compile_definitions(swiftDemangle
                           PRIVATE
                             LLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1)

