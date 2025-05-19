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
            targets: ["WiseTrackLib"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "WiseTrackLib",
            url: "https://github.com/wisetrack-io/ios-sdk/releases/download/1.0.10/WiseTrackLib.xcframework.zip",
            checksum: "a2a5b46b61ec506d0390cd0b21d2f9ddf776b11248b98fafcb040fd6459aa982"
        )
    ]
)
