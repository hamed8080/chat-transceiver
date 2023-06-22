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
        .package(path: "../Additive"),
        .package(path: "../Logger"),
        .package(path: "../ChatDTO"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ChatTransceiver",
            dependencies: [
                "Additive",
                "Logger",
                "ChatDTO",
            ]
        ),
        .testTarget(
            name: "ChatTransceiverTests",
            dependencies: [],
            resources: []
        ),
    ]
)
