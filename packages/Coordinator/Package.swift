// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinator",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0")
    ],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: [
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
    ]
)
