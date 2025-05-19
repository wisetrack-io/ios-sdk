// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "WiseTrackLib",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "WiseTrackLib",
            targets: ["WiseTrackLibWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/getsentry/sentry-cocoa.git", from: "8.50.2")
    ],
    targets: [
        .binaryTarget(
            name: "WiseTrackLib",
            url: "https://github.com/wisetrack-io/ios-sdk/releases/download/1.0.1/WiseTrackLib.xcframework.zip",
            checksum: "d99765e56629a288b255b16c3b17344084d983b33800c732dbaaa0a828a25284"
        ),
        .target(
            name: "WiseTrackLibWrapper",
            dependencies: [
                "WiseTrackLib",
                .product(name: "Sentry", package: "sentry-cocoa")
            ]
        )
    ]
)
