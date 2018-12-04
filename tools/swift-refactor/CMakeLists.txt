add_swift_host_tool(swift-refactor
  swift-refactor.cpp
)
target_link_libraries(swift-refactor
                      PRIVATE
                        swiftDriver
                        swiftFrontend
                        swiftIDE)
