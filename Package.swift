// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let package = Package(
    name: "W5500",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "W5500",
            targets: ["W5500"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/madmachineio/SwiftIO.git", .branch("main")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "W5500",
            dependencies: ["SwiftIO", "CW5500",]),
        .target(
            name: "CW5500",
            dependencies: [
                .product(name: "CSwiftIO", package: "SwiftIO"),
            ]),
        .testTarget(
            name: "W5500Tests",
            dependencies: ["W5500"]),
    ]
)
