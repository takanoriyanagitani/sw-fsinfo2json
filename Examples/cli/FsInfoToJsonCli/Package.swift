// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "FsInfoToJsonCli",
  dependencies: [
    .package(url: "https://github.com/realm/SwiftLint", from: "0.59.1"),
    .package(path: "../../.."),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1"),
  ],
  targets: [
    .executableTarget(
      name: "FsInfoToJsonCli",
      dependencies: [
        .product(name: "FsInfoToJson", package: "sw-fsinfo2json"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ],
    )
  ]
)
