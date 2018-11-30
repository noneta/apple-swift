
set(swift_remote_mirror_headers
      MemoryReaderInterface.h
      Platform.h
      SwiftRemoteMirror.h
      SwiftRemoteMirrorTypes.h)

add_custom_target(swift-remote-mirror-headers ALL
                  DEPENDS
                    ${swift_remote_mirror_headers})
install(FILES
          ${swift_remote_mirror_headers}
        PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
        COMPONENT swift-remote-mirror-headers
        DESTINATION include/swift/SwiftRemoteMirror)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swift-remote-mirror-headers
                           DEPENDS swift-remote-mirror-headers
                           COMPONENT swift-remote-mirror-headers)
endif()
