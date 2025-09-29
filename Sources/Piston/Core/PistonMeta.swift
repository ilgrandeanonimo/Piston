//
//  API.swift
//  Piston
//

import Foundation
#if os(Linux)
import FoundationNetwoking
#endif

public enum PistonMetaError: Error {
    case versionNotFound
    case unexpectedServerResponse(Int)
}

public final class PistonMeta: Sendable {
    private let decoder: JSONDecoder
    
    public func fetchManifest() async throws -> Manifest {
        let url = URL(string: "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json")!
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.statusCode == 200 else {
            throw PistonMetaError.unexpectedServerResponse(httpResponse.statusCode)
        }
        return try decoder.decode(Manifest.self, from: data)
    }
    
    public func fetchLatestVersions() async throws -> Manifest.Latest {
        return try await fetchManifest().latest
    }
    
    public init() {
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
}
