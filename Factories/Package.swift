// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Factories/Package.swift

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Factories",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Factories",
            targets: ["Factories"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Data"),
    ],
    targets: [
        .target(
            name: "Factories",
            dependencies: ["Domain", "Data"],
            path: "Sources"
        ),
        .testTarget(
            name: "FactoriesTests",
            dependencies: ["Factories"],
            path: "Tests"
        ),
    ]
)

