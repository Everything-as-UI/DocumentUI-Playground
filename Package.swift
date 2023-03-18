// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let dependencies: [Package.Dependency]

let env = Context.environment["USER"]
let isDevelop = env == "K-o-D-e-N"
if isDevelop {
    dependencies = [
        .package(path: "../DocumentUI"),
        .package(name: "AttributedTextUI", path: "../AttributedText"),
        .package(name: "FigmaKit", path: "~/Downloads/Research Projects/FigmaKit-main")
    ]
} else {
    dependencies = [
        .package(url: "https://github.com/Everything-as-UI/DocumentUI.git", branch: "main"),
        .package(url: "https://github.com/Everything-as-UI/AttrubutedTextUI.git", branch: "main"),
        .package(url: "https://github.com/jverkoey/FigmaKit.git", branch: "main")
    ]
}

let package = Package(
    name: "DocumentUI-Playground",
    platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .executable(name: "HotReload", targets: ["HotReload"]),
        .executable(name: "HotCompiler", targets: ["HotCompiler"]),
        .executable(name: "DocumentGenerator", targets: ["DocumentGenerator"]),
        .library(name: "FileWatcher", targets: ["FileWatcher"]),
        .library(name: "ExportDependencies", targets: ["ExportDependencies"])
    ],
    dependencies: dependencies,
    targets: [
        .target(name: "ExportDependencies", dependencies: ["DocumentUI", "AttributedTextUI"]),
        .target(name: "FileWatcher", dependencies: []),
        .executableTarget(name: "HotReload", dependencies: ["FileWatcher"]),
        .executableTarget(name: "HotCompiler", dependencies: ["DocumentUI", "FileWatcher"]),
        .executableTarget(name: "DocumentGenerator", dependencies: ["DocumentUI", "FigmaKit", "AttributedTextUI"], resources: [.copy("./Resources/figma_response.json")]),
    ]
)
