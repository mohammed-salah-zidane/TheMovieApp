// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Presentation/Package.swift

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Data"),
        .package(path: "../Factories"),
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Domain", "Data", "Factories"],
            path: "Sources"
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"],
            path: "Tests"
        ),
    ]
)
