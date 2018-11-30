set(LLVM_LINK_COMPONENTS Support)
add_swift_host_tool(swift-demangle
  swift-demangle.cpp
  )
target_link_libraries(swift-demangle
                      PRIVATE
                        swiftDemangling)
