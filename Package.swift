// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "HyperSnapSDK",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "HyperSnapSDK", // 👈 The name shown to clients
            targets: ["HyperSnapSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "HyperSnapSDK", // 👈 Must match the .xcframework name exactly
            path: "Core/HyperSnapSDK.xcframework"
        )
    ]
)