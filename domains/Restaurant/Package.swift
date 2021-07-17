// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Restaurant",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Restaurant",
            targets: ["Restaurant"]),
    ],
    dependencies: [
        .package(path: "../Helper")
    ],
    targets: [
        .target(
            name: "Restaurant",
            dependencies: []
        ),
        .testTarget(
            name: "RestaurantTests",
            dependencies: ["Restaurant"]),
    ]
)
