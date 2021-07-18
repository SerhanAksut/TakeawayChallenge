// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FileReader",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "FileReader",
            targets: ["FileReader"]
        ),
        .library(
            name: "RestaurantReader",
            targets: ["RestaurantReader"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "FileReader",
            dependencies: []
        ),
        .target(
            name: "RestaurantReader",
            dependencies: [
                "FileReader",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
    ]
)
