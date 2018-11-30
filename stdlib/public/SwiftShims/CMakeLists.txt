set(sources
  AssertionReporting.h
  CoreFoundationShims.h
  FoundationShims.h
  GlobalObjects.h
  HeapObject.h
  KeyPath.h
  LibcOverlayShims.h
  LibcShims.h
  Random.h
  RefCount.h
  RuntimeShims.h
  RuntimeStubs.h
  SwiftStdbool.h
  SwiftStddef.h
  SwiftStdint.h
  System.h
  Target.h
  ThreadLocalStorage.h
  UnicodeShims.h
  Visibility.h

  DispatchOverlayShims.h
  NetworkOverlayShims.h
  OSOverlayShims.h
  ObjectiveCOverlayShims.h
  SafariServicesOverlayShims.h
  UIKitOverlayShims.h
  XCTestOverlayShims.h
  XPCOverlayShims.h

  CoreFoundationOverlayShims.h
  CFCharacterSetShims.h
  CFHashingShims.h

  FoundationOverlayShims.h
  FoundationShimSupport.h
  NSCalendarShims.h
  NSCharacterSetShims.h
  NSCoderShims.h
  NSDataShims.h
  NSDictionaryShims.h
  NSErrorShims.h
  NSFileManagerShims.h
  NSIndexPathShims.h
  NSIndexSetShims.h
  NSKeyedArchiverShims.h
  NSLocaleShims.h
  NSTimeZoneShims.h
  NSUndoManagerShims.h

  module.modulemap
  )

if ("${LLVM_PACKAGE_VERSION}" STREQUAL "")
  message(FATAL_ERROR
          "LLVM_PACKAGE_VERSION must be set before including subdirectories")
endif()

# Symlink in the Clang headers.
# First extract the "version" used for Clang's resource directory.
string(REGEX MATCH "[0-9]+\\.[0-9]+(\\.[0-9]+)?" CLANG_VERSION
  "${LLVM_PACKAGE_VERSION}")

# Function to find LLVM or Clang headers
function(find_llvm_clang_headers suffix description out_var)
  set(headers_locations
      "${LLVM_LIBRARY_DIR}${suffix}"

      "${SWIFT_PATH_TO_CLANG_BUILD}/${CMAKE_CFG_INTDIR}/lib${suffix}"
      "${SWIFT_PATH_TO_CLANG_BUILD}/${LLVM_BUILD_TYPE}/lib${suffix}")

  set(headers_location)
  foreach(loc ${headers_locations})
    if(EXISTS "${loc}")
      set(headers_location "${loc}")
      set(${out_var} "${loc}" PARENT_SCOPE)
      break()
    endif()
  endforeach()
  if("${headers_location}" STREQUAL "")
    message(FATAL_ERROR "${description} headers were not found in any of the following locations: ${headers_locations}")
  endif()
endfunction()

if(SWIFT_BUILT_STANDALONE)
  find_llvm_clang_headers("/clang/${CLANG_VERSION}" "Clang" clang_headers_location)
else() # NOT SWIFT_BUILT_STANDALONE
  set(clang_headers_location "${LLVM_LIBRARY_DIR}/clang/${CLANG_VERSION}")
endif()

add_custom_command_target(unused_var
                          OUTPUT
                            ${SWIFTLIB_DIR}/clang
                          CUSTOM_TARGET_NAME
                            swift-clang-headers-symlink
                          COMMAND
                            ${CMAKE_COMMAND} -E make_directory ${SWIFTLIB_DIR}
                          COMMAND
                            ${CMAKE_COMMAND} -E copy_directory ${clang_headers_location} ${SWIFTLIB_DIR}/clang)
add_custom_command_target(unused_var
                          OUTPUT
                            ${SWIFTLIB_DIR}/shims
                          CUSTOM_TARGET_NAME
                            swift-shim-headers
                          COMMAND
                            ${CMAKE_COMMAND} -E make_directory ${SWIFTLIB_DIR}/shims
                          COMMAND
                            ${CMAKE_COMMAND} -E copy_if_different ${sources} ${SWIFTLIB_DIR}/shims/
                          WORKING_DIRECTORY
                            ${CMAKE_CURRENT_SOURCE_DIR}
                          DEPENDS
                            ${sources})
add_custom_target(swift-headers ALL
                  DEPENDS ${SWIFTLIB_DIR}/shims)
install(FILES
          ${sources}
        COMPONENT swift-headers
        PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
        DESTINATION lib/swift/shims)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swift-headers
                           DEPENDS swift-headers
                           COMPONENT swift-headers)
endif()

add_custom_target(swift-clang-resource-dir-symlink ALL
                  DEPENDS ${SWIFTLIB_DIR}/clang)
install(CODE
          "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${clang_headers_location} $ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib${LLVM_LIBDIR_SUFFIX}/swift/clang)"
        COMPONENT swift-clang-resource-dir-symlink)
if(NOT CMAKE_CONFIGURATION_TYPES)
  add_llvm_install_targets(install-swift-clang-resource-dir-symlink
                           DEPENDS swift-clang-resource-dir-symlink
                           COMPONENT swift-clang-resource-dir-symlink)
endif()
