#===----------------------------------------------------------------------===#
#
# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information
# See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
#
#===----------------------------------------------------------------------===#

# Some files can't be sorted alphabetically, see notes in the list below.
#
# The list of sources without which it's impossible to build a core standard
# library.  Try to add new standard library sources to `target_sources below if
# possible, to improve layering.  Check that you got it right by configuring
# with -DSWIFT_STDLIB_BUILD_ESSENTIAL_ONLY=YES
add_library(swiftCore
  Algorithm.swift
  AnyHashable.swift
  Array.swift
  ArrayBody.swift
  ArrayBuffer.swift
  ArrayBufferProtocol.swift
  ArrayCast.swift
  ArrayShared.swift
  ArraySlice.swift
  ArrayType.swift
  ASCII.swift
  Assert.swift
  AssertCommon.swift
  BidirectionalCollection.swift
  Bitset.swift
  Bool.swift
  BridgeObjectiveC.swift
  BridgeStorage.swift
  BridgingBuffer.swift
  Builtin.swift
  BuiltinMath.swift
  Character.swift
  CharacterProperties.swift
  ClosedRange.swift
  CocoaArray.swift
  Codable.swift
  Collection.swift
  CollectionAlgorithms.swift
  Comparable.swift
  CompilerProtocols.swift
  ContiguousArray.swift
  ContiguousArrayBuffer.swift
  ContiguouslyStored.swift
  CString.swift
  CTypes.swift
  DebuggerSupport.swift
  Dictionary.swift
  DictionaryBridging.swift
  DictionaryBuilder.swift
  DictionaryCasting.swift
  DictionaryStorage.swift
  DictionaryVariant.swift
  DropWhile.swift
  Dump.swift
  EmptyCollection.swift
  Equatable.swift
  ErrorType.swift
  ExistentialCollection.swift
  Filter.swift
  FixedArray.swift
  FlatMap.swift
  Flatten.swift
  FloatingPoint.swift
  Hashable.swift
  Hasher.swift
  Hashing.swift
  HashTable.swift
  ICU.swift
  Identifiable.swift
  Indices.swift
  InputStream.swift
  IntegerParsing.swift
  Integers.swift
  Join.swift
  KeyPath.swift
  KeyValuePairs.swift
  LazyCollection.swift
  LazySequence.swift
  LegacyABI.swift
  LifetimeManager.swift
  ManagedBuffer.swift
  Map.swift
  MemoryLayout.swift
  MigrationSupport.swift
  Mirrors.swift
  Misc.swift
  MutableCollection.swift
  NativeDictionary.swift
  NativeSet.swift
  NewtypeWrapper.swift
  ObjectIdentifier.swift
  Optional.swift
  OptionSet.swift
  OutputStream.swift
  Pointer.swift
  Policy.swift
  PrefixWhile.swift
  Print.swift
  Random.swift
  RandomAccessCollection.swift
  Range.swift
  RangeReplaceableCollection.swift
  ReflectionMirror.swift
  Repeat.swift
  REPL.swift
  Result.swift
  Reverse.swift
  Runtime.swift
  RuntimeFunctionCounters.swift
  Sequence.swift
  SequenceAlgorithms.swift
  Set.swift
  SetAlgebra.swift
  SetAnyHashableExtensions.swift
  SetBridging.swift
  SetBuilder.swift
  SetCasting.swift
  SetStorage.swift
  SetVariant.swift
  ShadowProtocols.swift
  Shims.swift
  SipHash.swift
  Slice.swift
  SmallString.swift
  Sort.swift
  StaticString.swift
  Stride.swift
  String.swift
  StringBreadcrumbs.swift
  StringBridge.swift
  StringCharacterView.swift
  StringComparable.swift
  StringComparison.swift
  StringCreate.swift
  StringGraphemeBreaking.swift
  StringGuts.swift
  StringGutsRangeReplaceable.swift
  StringGutsSlice.swift
  StringHashable.swift
  StringIndex.swift
  StringIndexConversions.swift
  StringInterpolation.swift
  StringLegacy.swift
  StringNormalization.swift
  StringObject.swift
  StringProtocol.swift
  StringRangeReplaceableCollection.swift
  StringStorage.swift
  StringStorageBridge.swift
  StringSwitch.swift
  StringTesting.swift
  StringUnicodeScalarView.swift
  StringUTF16View.swift
  StringUTF8Validation.swift
  StringUTF8View.swift
  Substring.swift
  SwiftNativeNSArray.swift
  ThreadLocalStorage.swift
  UIntBuffer.swift
  UnavailableStringAPIs.swift
  Unicode.swift
  UnicodeEncoding.swift
  UnicodeHelpers.swift
  UnicodeParser.swift
  UnicodeScalar.swift
  UnicodeScalarProperties.swift
  Unmanaged.swift
  UnmanagedOpaqueString.swift
  UnmanagedString.swift
  UnsafePointer.swift
  UnsafeRawPointer.swift
  UTF16.swift
  UTF32.swift
  UTF8.swift
  UTFEncoding.swift
  ValidUTF8Buffer.swift
  WriteBackMutableSlice.swift)
swift_gyb_target_sources(swiftCore PRIVATE
  AtomicInt.swift.gyb
  FloatingPointParsing.swift.gyb
  FloatingPointTypes.swift.gyb
  IntegerTypes.swift.gyb
  UnsafeBufferPointer.swift.gyb
  UnsafeRawBufferPointer.swift.gyb)
if(NOT SWIFT_STDLIB_BUILD_ESSENTIAL_ONLY)
  target_sources(swiftCore PRIVATE
    Availability.swift
    CollectionDifference.swift
    CollectionOfOne.swift
    Diffing.swift
    Mirror.swift
    PlaygroundDisplay.swift
    CommandLine.swift
    SliceBuffer.swift
    SIMDVector.swift
    UnfoldSequence.swift
    VarArgs.swift
    Zip.swift)
  swift_gyb_target_sources(swiftCore PRIVATE
    SIMDVectorTypes.swift.gyb
    Tuple.swift.gyb)
endif()
target_compile_options(swiftCore PRIVATE
  -force-single-frontend-invocation
  -parse-stdlib
  -module-name Swift
  "SHELL:-Xcc -DswiftCore_EXPORTS"
  "SHELL:-Xllvm -sil-inline-generics"
  "SHELL:-Xllvm -sil-partial-specialization"
  "SHELL:$<$<BOOL:${SWIFT_STDLIB_ENABLE_SIL_DEBUGGING}>:-Xfrontend -gsil>"
  "SHELL:$<$<BOOL:${SWIFT_STDLIB_ENABLE_STDLIBCORE_EXCLUSIVITY_CHECKING}>:-enforce-exclusivity=checked>")
target_link_libraries(swiftCore PRIVATE
  $<$<PLATFORM_ID:Cygwin>:psapi>
  $<$<PLATFORM_ID:Darwin>:darwin-linker-support>
  $<$<PLATFORM_ID:Windows>:DbgHelp>
  $<$<PLATFORM_ID:Windows>:shell32>
  $<$<NOT:$<PLATFORM_ID:Darwin>>:ICU::i18n>
  $<$<NOT:$<PLATFORM_ID:Darwin>>:ICU::uc>
  swiftShims
  swiftStubs
  swiftRuntime)
target_link_options(swiftCore PRIVATE
  "SHELL:$<PLATFORM_ID:Darwin>:-all_load icucore>")
