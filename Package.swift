// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Checkit",
    products: [
        .library(name: "Checkit", targets: ["Checkit"]),
    ],
    targets: [
        .target(name: "Checkit", dependencies: []),
        .testTarget(name: "CheckitTests", dependencies: ["Checkit"]),
    ]
)
