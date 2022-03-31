// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppScaffold",
    platforms: [.iOS(.v14), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "AppScaffold",
            targets: ["AppScaffold"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "AppScaffold",
            dependencies: []
        ),
        .testTarget(
            name: "AppScaffoldTests",
            dependencies: ["AppScaffold"]
        ),
    ]
)
