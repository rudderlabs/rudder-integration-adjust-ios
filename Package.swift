// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Rudder-Adjust",
    platforms: [
        .iOS("12.0"), .tvOS("12.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rudder-Adjust",
            targets: ["Rudder-Adjust"]),
    ],
    dependencies: [
        .package(name: "AdjustSdk", url: "https://github.com/adjust/ios_sdk", .exact("5.1.0")),
        .package(name: "Rudder", url: "https://github.com/rudderlabs/rudder-sdk-ios", from: "1.0.0"),
    ],

    targets: [
        .target(
            name: "Rudder-Adjust",
            dependencies: [
                .product(name: "AdjustSdk", package: "AdjustSdk"),
                .product(name: "Rudder", package: "Rudder"),
            ],
            path: "Rudder-Adjust",
            sources: ["Classes/"],
            publicHeadersPath: "Classes/",
            cSettings: [
                .headerSearchPath("Classes/")
            ]
        ),
    ]
)
