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
            targets: ["RestaurantList"]
        ),
        .library(
            name: "SortingOptions",
            targets: ["SortingOptions"]
        ),
    ],
    dependencies: [
        .package(path: "Helper"),
        .package(path: "RxHelper"),
        .package(path: "FileReader"),
        .package(path: "Entities"),
        .package(path: "Coordinator"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "RestaurantList",
            dependencies: [
                "Helper",
                "RxHelper",
                "Entities",
                "Coordinator",
                .product(name: "RestaurantReader", package: "FileReader"),
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .target(
            name: "SortingOptions",
            dependencies: [
                "Entities",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "RestaurantTests",
            dependencies: [
                "RestaurantList",
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "RxTestHelper", package: "RxHelper")
            ]
        ),
    ]
)
