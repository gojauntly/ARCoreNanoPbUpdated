// swift-tools-version: 5.5
//
// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
  name: "ARCoreNanoPbUpdated", platforms: [.iOS(.v12)],
  products: [
    .library(name: "ARCoreCloudAnchors", targets: ["CloudAnchors"]),
    .library(name: "ARCoreGeospatial", targets: ["Geospatial"]),
    .library(name: "ARCoreGARSession", targets: ["GARSession"]),
    .library(name: "ARCoreAugmentedFaces", targets: ["AugmentedFaces"]),
    .library(name: "ARCoreSemantics", targets: ["Semantics"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/nanopb.git", "2.30909.0" ..< "2.30910.0"),
    .package(
      url: "https://github.com/google/GoogleDataTransport.git", .upToNextMajor(from: "10.1.0")),
    .package(url: "https://github.com/google/gtm-session-fetcher.git", "2.1.0" ..< "4.0.0"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", "8.0.0" ..< "11.4.2"),
  ],
  targets: [
    .binaryTarget(
      name: "ARCoreBase", path: "Base/Frameworks/ARCoreBase.xcframework"
    ),
    .target(
      name: "Base",
      dependencies: [
        "ARCoreBase",
        .product(name: "nanopb", package: "nanopb"),
        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
      ],
      path: "Base",
      sources: ["dummy.m"],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreCloudAnchors", path: "CloudAnchors/Frameworks/ARCoreCloudAnchors.xcframework"
    ),
    .target(
      name: "CloudAnchors",
      dependencies: [
        "ARCoreCloudAnchors",
        "GARSession",
        .product(name: "GTMSessionFetcherCore", package: "gtm-session-fetcher"),
        .product(name: "nanopb", package: "nanopb"),
      ],
      path: "CloudAnchors",
      sources: ["dummy.m"],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreGeospatial", path: "Geospatial/Frameworks/ARCoreGeospatial.xcframework"
    ),
    .target(
      name: "Geospatial",
      dependencies: [
        "ARCoreGeospatial",
        "GARSession",
      ],
      path: "Geospatial",
      sources: ["dummy.m"],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreGARSession", path: "GARSession/Frameworks/ARCoreGARSession.xcframework"
    ),
    .target(
      name: "GARSession",
      dependencies: [
        "ARCoreGARSession",
        "Base",
        .product(name: "nanopb", package: "nanopb"),
        .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
      ],
      path: "GARSession",
      sources: ["dummy.m"],
      resources: [.copy("Resources/ARCoreResources")],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreAugmentedFaces",
      path: "AugmentedFaces/Frameworks/ARCoreAugmentedFaces.xcframework"
    ),
    .target(
      name: "AugmentedFaces",
      dependencies: [
        "ARCoreAugmentedFaces",
        "Base",
        "TFShared",
        .product(name: "nanopb", package: "nanopb"),
      ],
      path: "AugmentedFaces",
      sources: ["dummy.m"],
      resources: [.copy("Resources/ARCoreFaceResources")],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreSemantics", path: "Semantics/Frameworks/ARCoreSemantics.xcframework"
    ),
    .target(
      name: "Semantics",
      dependencies: [
        "ARCoreSemantics",
        "GARSession",
        "TFShared",
      ],
      path: "Semantics",
      sources: ["dummy.m"],
      resources: [.copy("Resources/ARCoreCoreMLSemanticsResources")],
      publicHeadersPath: "Sources"
    ),
    .binaryTarget(
      name: "ARCoreTFShared", path: "TFShared/Frameworks/ARCoreTFShared.xcframework"
    ),
    .target(
      name: "TFShared",
      dependencies: [
        "ARCoreTFShared",
        "Base",
      ],
      path: "TFShared",
      sources: ["dummy.m"],
      publicHeadersPath: "Sources"
    ),
  ]
)
