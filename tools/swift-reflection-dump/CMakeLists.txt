add_swift_host_tool(swift-reflection-dump
  swift-reflection-dump.cpp
  LLVM_COMPONENT_DEPENDS object support
)
target_link_libraries(swift-reflection-dump
                      PRIVATE
                        swiftReflection)
