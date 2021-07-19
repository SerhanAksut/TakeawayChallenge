// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxHelper",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "RxHelper",
            targets: ["RxHelper"]
        ),
        .library(
            name: "RxTestHelper",
            targets: ["RxTestHelper"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "RxHelper",
            dependencies: [
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .target(
            name: "RxTestHelper",
            dependencies: [
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxTest", package: "RxSwift")
            ]
        ),
    ]
)
