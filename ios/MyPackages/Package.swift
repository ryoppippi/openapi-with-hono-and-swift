// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private extension PackageDescription.Target.Dependency {
    static let openAPIRuntime: Self = .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime")
    static let openAPIURLSession: Self = .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
}

private extension PackageDescription.Target.PluginUsage {
    static let openAPIGenerator: Self = .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
}


let package = Package(
    name: "MyPackages",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v16),
        .macOS(.v12)
    ],
    products: [
        .library(name: "ProductionApp", targets: ["ProductionApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", .upToNextMinor(from: "0.3.5")),
        .package(url: "https://github.com/apple/swift-openapi-runtime", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMinor(from: "0.1.0"))
    ],
    targets: [
        .target(
            name: "ProductionApp",
            dependencies: [
                "MyDomainsRepositories"
            ],
            path: "./Sources/Apps/Production"
        ),
        .target(
            name: "MyDomainsRepositories",
            dependencies: [
                .openAPIRuntime,
                .openAPIURLSession
            ],
            path: "./Sources/Domains/Repositories",
            plugins: [
                .openAPIGenerator
            ]
        ),
    ]
)
