add_swift_fuzzer_host_tool(swift-demangle-fuzzer
  swift-demangle-fuzzer.cpp
  LLVM_COMPONENT_DEPENDS support
  )
target_link_libraries(swift-demangle-fuzzer
                      PRIVATE
                        swiftDemangling)
