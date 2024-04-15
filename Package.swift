// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Apollo-PGATOUR",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5)
  ],
  products: [
    .library(name: "Apollo-PGATOUR", targets: ["Apollo"]),
    .library(name: "ApolloAPI", targets: ["ApolloAPI"]),
    .library(name: "Apollo-Dynamic", type: .dynamic, targets: ["Apollo"]),
    .library(name: "ApolloSQLite", targets: ["ApolloSQLite"]),
    .library(name: "ApolloWebSocket", targets: ["ApolloWebSocket"]),
    .library(name: "ApolloTestSupport", targets: ["ApolloTestSupport"]),
    .plugin(name: "InstallCLI", targets: ["Install CLI"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/stephencelis/SQLite.swift.git",
      .upToNextMajor(from: "0.13.1")),
  ],
  targets: [
    .target(
      name: "Apollo-PGATOUR",
      dependencies: [
        "ApolloAPI"
      ],
      resources: [
        .copy("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .target(
      name: "ApolloAPI",
      dependencies: [],
      resources: [
        .copy("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .target(
      name: "ApolloSQLite",
      dependencies: [
        "Apollo-PGATOUR",
        .product(name: "SQLite", package: "SQLite.swift"),
      ],
      resources: [
        .copy("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .target(
      name: "ApolloWebSocket",
      dependencies: [
        "Apollo-PGATOUR"
      ],
      resources: [
        .copy("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .target(
      name: "ApolloTestSupport",
      dependencies: [
        "Apollo-PGATOUR",
        "ApolloAPI"
      ]
    ),
    .plugin(
      name: "Install CLI",
      capability: .command(
        intent: .custom(
          verb: "apollo-cli-install",
          description: "Installs the Apollo iOS Command line interface."),
        permissions: [
          .writeToPackageDirectory(reason: "Downloads and unzips the CLI executable into your project directory."),
          .allowNetworkConnections(scope: .all(ports: []), reason: "Downloads the Apollo iOS CLI executable from the GitHub Release.")
        ]),
      dependencies: [],
      path: "Plugins/InstallCLI"
    )
  ]
)
