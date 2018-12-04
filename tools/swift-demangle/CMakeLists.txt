add_swift_host_tool(swift-demangle
  swift-demangle.cpp
  LLVM_COMPONENT_DEPENDS support
  )
target_link_libraries(swift-demangle
                      PRIVATE
                        swiftDemangling)
