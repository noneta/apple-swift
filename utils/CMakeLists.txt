add_subdirectory(vim)
add_subdirectory(lldb)

swift_install_in_component(editor-integration
    FILES swift-mode.el
    DESTINATION "share/emacs/site-lisp")

install(PROGRAMS
          swift-api-dump.py
        DESTINATION bin
        COMPONENT swift-api-dump)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swift-api-dump
                           DEPENDS swift-api-dump.py
                           COMPONENT swift-api-dump)
endif()

# We install LLVM's FileCheck, if requested.
swift_install_in_component(toolchain-dev-tools
    FILES "${SWIFT_PATH_TO_LLVM_BUILD}/bin/FileCheck"
    DESTINATION bin)
