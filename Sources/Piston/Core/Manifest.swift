//
//  VersionsManifest.swift
//  Piston
//
//  Created by Paolo Boglione on 28/09/25.
//

import Foundation

typealias VersionKind = Manifest.Version.Kind

public struct Manifest: Codable {
    public var latest: Latest
    public var versions: [Version]
}

public extension Manifest {
    struct Latest: Codable {
        public var release: String
        public var snapshot: String
    }
    
    struct Version: Codable {
        public var id: String
        public var kind: Kind
        public var url: URL
        public var time: Date
        public var release: Date
        public var sha1: String
        private var complianceLevel: Int
        public var latestSecurityFeatures: Bool {
            complianceLevel == 1
        }
        
        private enum CodingKeys: String, CodingKey {
            case id
            case kind = "type"
            case url
            case time
            case release = "releaseTime"
            case sha1
            case complianceLevel
        }
        
        public enum Kind: String, Codable {
            case release
            case snapshot
            case legacyBeta = "old_beta"
            case legacyAlpha = "old_alpha"
        }
    }
}
