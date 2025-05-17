// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WiseTrackLib",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "WiseTrackLib",
            targets: ["WiseTrackLib"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "WiseTrackLib",
            url: "https://github.com/wisetrack-io/ios-sdk/releases/download/1.0.1/WiseTrackLib.xcframework.zip",            checksum: "d99765e56629a288b255b16c3b17344084d983b33800c732dbaaa0a828a25284"
        )
    ]
)
