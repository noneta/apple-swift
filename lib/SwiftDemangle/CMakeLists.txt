add_swift_host_library(swiftDemangle
                  SHARED
                    SwiftDemangle.cpp
                    MangleHack.cpp
                  LINK_LIBRARIES
                    swiftDemangling
                  C_COMPILE_FLAGS
                    -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1)

install(TARGETS
          swiftDemangle
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib${LLVM_LIBDIR_SUFFIX}
        ARCHIVE DESTINATION lib${LLVM_LIBDIR_SUFFIX}
        COMPONENT swiftDemangle)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swiftDemangle
                           DEPENDS swiftDemangle
                           COMPONENT swiftDemangle)
endif()
