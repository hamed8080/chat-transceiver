// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatTransceiver",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v10),
        .macOS(.v12),
        .macCatalyst(.v13),
    ],
    products: [
        .library(
            name: "ChatTransceiver",
            targets: ["ChatTransceiver"]),
    ],
    dependencies: [
        .package(url: "https://pubgi.sandpod.ir/chat/ios/chat-dto", from: "2.1.0"),
        .package(url: "https://pubgi.sandpod.ir/chat/ios/additive", from: "1.2.2"),
        .package(url: "https://pubgi.sandpod.ir/chat/ios/mocks", from: "1.2.3"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ChatTransceiver",
            dependencies: [
                .product(name: "ChatDTO", package: "chat-dto"),
                .product(name: "Additive", package: "additive"),
                .product(name: "Mocks", package: "mocks"),
            ]
        ),
        .testTarget(
            name: "ChatTransceiverTests",
            dependencies: [
                "ChatTransceiver",
                .product(name: "ChatDTO", package: "chat-dto"),
                .product(name: "Additive", package: "additive"),
                .product(name: "Mocks", package: "mocks"),
            ],
            resources: []
        ),
    ]
)
