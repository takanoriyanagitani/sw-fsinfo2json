// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "FsInfoToJson",
  products: [
    .library(
      name: "FsInfoToJson",
      targets: ["FsInfoToJson"])
  ],
  dependencies: [
    .package(url: "https://github.com/realm/SwiftLint", from: "0.59.1")
  ],
  targets: [
    .target(
      name: "FsInfoToJson"),
    .testTarget(
      name: "FsInfoToJsonTests",
      dependencies: ["FsInfoToJson"]
    ),
  ]
)
