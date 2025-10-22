// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "2.1.0"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "9d966a9c6f0e8b493812b80df3cc94c653136004db16845ac0fcf09226447218"
    static let FaceTecSDKChecksum = "3e5cf05fa2452d4a23836ebed3caf31889caad9291c5d1b1dd550de3cae9d307"
    static let iDenfyLivenessChecksum = "bd0d063a349f0159f6418c2df80464be051695b5eccd3b740bda761e7e4ac2ac"
    static let idenfyviewsChecksum = "0adbc777ad0b0245cb81856775603ef46672f03a50d298ddd643f836e0fae781"
    static let iDenfySDKChecksum = "50f224f2f8f7d38bf95108fd2f394b4855481e1837ef002aca5b7b7a675dc573"
    static let idenfycoreChecksum = "9fb4416e4dd052f8f4a92fb4e30990e921bd806f331d7ee288cccfd9953615b5"
    static let idenfyNFCReadingChecksum = "f5f8e7a339a987b28e50bca2e2d21ba4f6f67d7f953a48f1baa302cf6af04e38"
    static let openSSLChecksum = "97c6794383e9f2872d2356b5ab3fc593115c824f59fa65baeaf197c0b6c35b0a"
    static let iDenfyBlurGlareDetectionChecksum = "91b70f59876fabb0901fe31d0e4820e03b45b7812de7496cc26fc834f2044bab"
}

let package = Package(
    name: "iDenfyNFCReading",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "iDenfyNFCReading-Dynamic",
            type: .dynamic,
            targets: ["iDenfySDKTarget"]),
        .library(
            name: "iDenfyNFCReading",
            targets: ["iDenfySDKTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.5.0"..<"4.5.1"),
    ],
    targets: [
        //iDenfyBlurGlareDetection
        .target(
            name: "iDenfyBlurGlareDetectionTarget",
            dependencies: [.target(name: "iDenfyBlurGlareDetectionWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfyBlurGlareDetectionWrap"
        ),
        .target(
            name: "iDenfyBlurGlareDetectionWrapper",
            dependencies: [
                .target(
                    name: "iDenfyBlurGlareDetection",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "iDenfyBlurGlareDetectionWrapper"
        ),
        //IdenfyViews
        .target(
            name: "idenfyviewsTarget",
            dependencies: [.target(name: "idenfyviewsWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyviewsWrap"
        ),
        .target(
            name: "idenfyviewsWrapper",
            dependencies: [
                .target(
                    name: "idenfyviews",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyviewsWrapper"
        ),
        //IdenfyNFCReading
        .target(
            name: "idenfyNFCReadingTarget",
            dependencies: [.target(name: "idenfyNFCReadingWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyNFCReadingWrap"
        ),
        .target(
            name: "idenfyNFCReadingWrapper",
            dependencies: [
                .target(
                    name: "idenfyNFCReading",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "OpenSSL",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyNFCReadingWrapper"
        ),
        //IdenfyLiveness
        .target(
            name: "IdenfyLivenessTarget",
            dependencies: [.target(name: "IdenfyLivenessWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/IdenfyLivenessWrap"
        ),
        .target(
            name: "IdenfyLivenessWrapper",
            dependencies: [
                .target(
                    name: "IdenfyLiveness",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "IdenfyLivenessWrapper"
        ),
        //iDenfySDK
        .target(
            name: "iDenfySDKTarget",
            dependencies: [.target(name: "iDenfySDKWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfySDKWrap",
            cSettings: [
                .define("CLANG_MODULES_AUTOLINK", to: "YES"),
            ]
        ),
        .target(
            name: "iDenfySDKWrapper",
            dependencies: [
                .target(
                    name: "iDenfySDK",
                    condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyInternalLogger",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyNFCReadingTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "IdenfyLivenessTarget",
                        condition: .when(platforms: [.iOS])),
                 .target(name: "iDenfyBlurGlareDetectionTarget",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "iDenfySDKWrapper"
        ),
        // Binaries
        .binaryTarget(name: "iDenfyInternalLogger",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/iDenfyInternalLogger.zip", checksum: Checksums.iDenfyInternalLoggerChecksum),
        .binaryTarget(name: "FaceTecSDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/FaceTecSDK.zip", checksum: Checksums.FaceTecSDKChecksum),
        .binaryTarget(name: "IdenfyLiveness",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/IdenfyLiveness.zip", checksum: Checksums.iDenfyLivenessChecksum),
        .binaryTarget(name: "idenfyviews",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/idenfyviews.zip", checksum: Checksums.idenfyviewsChecksum),
        .binaryTarget(name: "iDenfySDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/iDenfySDK.zip", checksum: Checksums.iDenfySDKChecksum),
        .binaryTarget(name: "idenfycore",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/idenfycore.zip", checksum: Checksums.idenfycoreChecksum),
        .binaryTarget(name: "idenfyNFCReading",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/idenfyNFCReading.zip", checksum: Checksums.idenfyNFCReadingChecksum),
        .binaryTarget(name: "OpenSSL",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/OpenSSL.zip", checksum: Checksums.openSSLChecksum),
        .binaryTarget(name: "iDenfyBlurGlareDetection",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyNFCReading/iDenfyBlurGlareDetection.zip", checksum: Checksums.iDenfyBlurGlareDetectionChecksum),
    ]
)
