add_swift_host_tool(lldb-moduleimport-test
  lldb-moduleimport-test.cpp
)
target_link_libraries(lldb-moduleimport-test
                      PRIVATE
                        swiftASTSectionImporter
                        swiftClangImporter
                        swiftDWARFImporter
                        swiftFrontend)

