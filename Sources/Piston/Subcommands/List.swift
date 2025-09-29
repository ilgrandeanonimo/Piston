//
//  List.swift
//  Piston
//

import ArgumentParser
@preconcurrency import SpectreKit

struct ListSubcommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(commandName: "list")
    
    @Option(help: "Filter versions by kind.")
    var kind: Manifest.Version.Kind?
    
    mutating func run() async throws {
        let list = Table()
            .setTitle("Versions List")
            .addColumns("Version", "Kind", "Advanced Security", "Release Date")
        
        let versions = try await client.fetchManifest().versions
            .filter { kind == nil || $0.kind == kind }
        
        for version in versions {
            list.addRow(
                version.id,
                version.kind.rawValue,
                version.latestSecurityFeatures.description,
                version.release.formatted()
            )
        }
        
        console.write(list)
    }
}
