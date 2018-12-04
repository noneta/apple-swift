add_swift_host_tool(swift-demangle-yamldump
  swift-demangle-yamldump.cpp
  LLVM_COMPONENT_DEPENDS support
  )
target_link_libraries(swift-demangle-yamldump
                      PRIVATE
                        swiftDemangling)
