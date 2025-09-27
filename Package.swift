// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Piston",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/patriksvensson/spectre-kit.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "Piston",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SpectreKit", package: "spectre-kit"),
            ],
            swiftSettings: [
                .treatAllWarnings(as: .error),
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-Osize",
                    "-Xlinker", "-dead_strip"
                ], .when(configuration: .release))
            ]
        ),
    ]
)
