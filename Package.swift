// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "HyperSnapSDK",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "HyperSnapSDK",
            targets: ["HyperSnapSDK", "HyperSnapResources"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "HyperSnapSDK",
            path: "Core/HyperSnapSDK.xcframework"
        ),
        .target(
            name: "HyperSnapResources",
            path: "Sources/HVResources",
            resources: [
                .process(".")
            ]
        )
    ]
)
