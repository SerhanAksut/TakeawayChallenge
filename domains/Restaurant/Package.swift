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
            name: "RestaurantList",
            targets: ["RestaurantList"]),
    ],
    dependencies: [
        .package(path: "Helper"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "RestaurantList",
            dependencies: [
                "Helper",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "RestaurantTests",
            dependencies: ["RestaurantList"]
        ),
    ]
)
