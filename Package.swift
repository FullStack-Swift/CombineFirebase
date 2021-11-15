// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CombineFirebase",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "CombineFirebase",
      targets: ["CombineFirebase"]),
    .library(
      name: "CombineFirebaseAuth",
      targets: ["CombineFirebaseAuth"]
    ),
    .library(
      name: "CombineFirebaseDatabase",
      targets: ["CombineFirebaseDatabase"]
    ),
    .library(
      name: "CombineFirebaseFirestore",
      targets: ["CombineFirebaseFirestore"]
    ),
    .library(
      name: "CombineFirebaseStorage",
      targets: ["CombineFirebaseStorage"]
    ),
  ],
  dependencies: [
    .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", "7.3.1"..<"9.0.0"),
  ],
  targets: [
    .target(
      name: "CombineFirebase",
      dependencies: [
        
      ],
    path: "Sources/CombineFirebase"),
    .target(
      name: "CombineFirebaseAuth",
      dependencies: [
        "CombineFirebase",
        .product(name: "FirebaseAuth", package: "Firebase"),
      ],
      path: "Sources/Auth"),
    .target(
      name: "CombineFirebaseDatabase",
      dependencies: [
        .product(name: "FirebaseDatabase", package: "Firebase"),
      ],
      path: "Sources/Database"),
    .target(
      name: "CombineFirebaseFirestore",
      dependencies: [
        "CombineFirebase",
        .product(name: "FirebaseFirestore", package: "Firebase"),
        .product(name: "FirebaseFirestoreSwift-Beta", package: "Firebase"),
      ],
      path: "Sources/Firestore"),
    .target(
      name: "CombineFirebaseStorage",
      dependencies: [
        .product(name: "FirebaseStorage", package: "Firebase"),
        .product(name: "FirebaseStorageSwift-Beta", package: "Firebase")
      ],
      path: "Sources/Storage"),
    .testTarget(
      name: "CombineFirebaseTests",
      dependencies: ["CombineFirebase"]),
  ]
)
