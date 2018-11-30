set(LLVM_LINK_COMPONENTS Support)
add_swift_host_tool(swift-demangle-yamldump
  swift-demangle-yamldump.cpp
  )
target_link_libraries(swift-demangle-yamldump
                      PRIVATE
                        swiftDemangling)
