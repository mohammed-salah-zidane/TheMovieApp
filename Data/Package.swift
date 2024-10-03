// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Data/Package.swift

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Domain"],
            path: "Sources"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            path: "Tests"
        ),
    ]
)
