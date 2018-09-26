add_swift_library(swiftASTSectionImporter STATIC
  ASTSectionImporter.cpp
  LINK_LIBS swiftBasic
  LLVM_COMPONENT_DEPENDS core)

