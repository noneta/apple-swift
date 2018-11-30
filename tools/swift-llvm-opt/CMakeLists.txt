add_swift_host_tool(swift-llvm-opt
  LLVMOpt.cpp
)
target_link_libraries(swift-llvm-opt
                      PRIVATE
                        swiftIRGen
                        # Swift libraries included to appease the linker on linux.
                        swiftSema
                        swiftAST
                        # Clang libraries included to appease the linker on linux.
                        clangBasic
                        clangCodeGen)
