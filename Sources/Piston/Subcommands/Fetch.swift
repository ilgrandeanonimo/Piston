//
//  Fetch.swift
//  Piston
//

import ArgumentParser
@preconcurrency import SpectreKit
import Foundation
#if os(Linux)
import FoundationNetwoking
#endif

struct FetchSubcommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(commandName: "fetch")
    
    @Argument(help: "The version id. Example: 1.19.5 or 1.21.9-rc1")
    var id: String
    
    @Option(help: "Where to save the server jar")
    var destination: String = "./server.jar"
    
    mutating func run() async throws {
        console.writeLine("Fetching versions manifest...")
        let version = try await client.fetchManifest().versions
            .filter { $0.id == id }
            .first
        guard let version else {
            console.markupLine("[red]Version not found![/]")
            return
        }
        console.writeLine("Fetching version's manifest...")
        let (data, _) = try await URLSession.shared.data(from: version.url)
        let versionManifest = try JSONDecoder().decode(Version.self, from: data)
        
        console.writeLine("Downloading server jar...")
        let destination = URL(fileURLWithPath: destination)
        let (url, _) = try await URLSession.shared.download(from: versionManifest.downloads.server.url)

        console.writeLine("Saving server jar to destination...")
        var isFolder: ObjCBool = false
        let fileExist = FileManager.default.fileExists(
            atPath: destination.relativePath,
            isDirectory: &isFolder
        )
        if fileExist && !isFolder.boolValue {
            guard confirmation("File already exist at path: \(destination.relativePath). Overwrite?")
            else {
                console.markupLine("[red]The file won't be overwritten.[/]")
                return
            }
            try FileManager.default.removeItem(at: destination)
        }
        try FileManager.default.moveItem(at: url, to: destination)
        console.markupLine("[green]Server jar for version \(id) has been downloaded to \(destination.relativePath)[/]")
    }
}
