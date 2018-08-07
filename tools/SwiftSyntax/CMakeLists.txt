add_swift_library(swiftSwiftSyntax
                  SHARED
                    # This file should be listed the first.  Module name is
                    # inferred from the filename.
                    SwiftSyntax.swift
                    AbsolutePosition.swift
                    AtomicCache.swift
                    Diagnostic.swift
                    DiagnosticConsumer.swift
                    DiagnosticEngine.swift
                    JSONDiagnosticConsumer.swift
                    PrintingDiagnosticConsumer.swift
                    RawSyntax.swift
                    SourcePresence.swift
                    SourceLength.swift
                    SwiftcInvocation.swift
                    Syntax.swift
                    SyntaxData.swift
                    SyntaxChildren.swift
                    SyntaxCollections.swift.gyb
                    SyntaxClassifier.swift.gyb
                    SyntaxBuilders.swift.gyb
                    SyntaxFactory.swift.gyb
                    SyntaxKind.swift.gyb
                    SyntaxNodes.swift.gyb
                    SyntaxRewriter.swift.gyb
                    TokenKind.swift.gyb
                    Trivia.swift.gyb
                  SWIFT_MODULE_DEPENDS_OSX
                    Foundation
                    Darwin
                  SWIFT_MODULE_DEPENDS_LINUX
                    Glibc
                  SWIFT_COMPILE_FLAGS
                    -I ${SWIFT_PATH_TO_LIBDISPATCH_SOURCE}
                    -I ${SWIFT_PATH_TO_LIBDISPATCH_BUILD}/src/swift
                    -I ${SWIFT_PATH_TO_LIBDISPATCH_BUILD}/swift
                    -F ${SWIFT_PATH_TO_FOUNDATION_BUILD}/CoreFoundation-prefix/System/Library/Frameworks
                  SWIFT_COMPILE_FLAGS_LINUX
                    # required for dlfcn.h to be included properly
                    -Xcc -D_GNU_SOURCE
                  INSTALL_IN_COMPONENT
                    swift-syntax
                  IS_STDLIB)
