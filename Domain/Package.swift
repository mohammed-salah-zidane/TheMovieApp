// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Domain/Package.swift

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Domain",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"],
            path: "Tests"
        ),
    ]
)

