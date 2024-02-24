// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NMRepository",
    platforms: [
        .macOS(.v10_15), .iOS(.v16), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NMRepository",
            targets: ["NMRepository"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../NMModel"),
        .package(path: "../NMServices"),
        .package(path: "../GenericNetworking")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NMRepository",
            dependencies: [
                .product(name: "NMModel", package: "NMModel"),
                .product(name: "NMServices", package: "NMServices"),
                .product(name: "GenericNetworking", package: "GenericNetworking")
            ]),
        .testTarget(
            name: "NMRepositoryTests",
            dependencies: ["NMRepository"]),
    ]
)
