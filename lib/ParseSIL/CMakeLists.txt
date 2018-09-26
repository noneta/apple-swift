add_swift_library(swiftParseSIL STATIC
  ParseSIL.cpp
  LINK_LIBS
    swiftParse
    swiftSema
    swiftSIL
)

