// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HyperSnapSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Final product that consumers import as "HyperSnapSDK"
        .library(
            name: "HyperSnapSDK",
            targets: ["HyperSnapSDKWrapper"]
        )
    ],
    targets: [
        // Binary target: name MUST match the actual module name in the XCFramework.
        .binaryTarget(
            name: "HyperSnapSDK", // Use "HyperSnapSDK" here, not "HyperSnapSDKBinary"
            path: "Core/HyperSnapSDK.xcframework"
        ),

        // Swift wrapper target that depends on the binary target and processes resources.
        .target(
            name: "HyperSnapSDKWrapper",
            dependencies: [
                .target(name: "HyperSnapSDK")
            ],
            path: "Sources/HyperSnapSDKWrapper",
            resources: [
                // Adjust the relative path as needed.
                .process("HVResources")
            ]
        )
    ]
)
