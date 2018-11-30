set(datafiles
  macos4.json
  ios4.json
  tvos4.json
  watchos4.json
  overlay4.json
)

add_custom_target(swift-migrator-data ALL
                  COMMAND
                    ${CMAKE_COMMAND} -E make_directory ${SWIFTLIB_DIR}/migrator
                  COMMAND
                    ${CMAKE_COMMAND} -E copy_if_different ${datafiles} ${SWIFTLIB_DIR}/migrator/
                  WORKING_DIRECTORY
                    ${CMAKE_CURRENT_SOURCE_DIR}
                  DEPENDS
                    ${datafiles})

add_swift_host_library(swiftMigrator STATIC
  APIDiffMigratorPass.cpp
  EditorAdapter.cpp
  FixitApplyDiagnosticConsumer.cpp
  Migrator.cpp
  MigrationState.cpp
  OptionalTryMigratorPass.cpp
  RewriteBufferEditsReceiver.cpp
  LINK_LIBS
    swiftSyntax swiftIDE)
add_dependencies(swiftMigrator swift-migrator-data)

install(FILES
          ${datafiles}
        COMPONENT swift-migrator-data
        PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
        DESTINATION lib/swift/migrator)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swift-migrator-data
                           DEPENDS swift-migrator-data
                           COMPONENT swift-migrator-data)
endif()

