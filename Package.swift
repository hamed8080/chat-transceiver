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
        .package(path: "../ChatDTO"),
        .package(path: "../ChatCore"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ChatTransceiver",
            dependencies: [
                "ChatDTO",
                "ChatCore",
            ]
        ),
        .testTarget(
            name: "ChatTransceiverTests",
            dependencies: [
                "ChatTransceiver",
                "ChatDTO",
                "ChatCore",
            ],
            resources: []
        ),
    ]
)
