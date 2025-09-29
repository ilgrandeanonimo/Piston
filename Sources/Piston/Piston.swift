//
//  Piston.swift
//  Piston
//

import ArgumentParser
import Foundation
@preconcurrency import SpectreKit

let console = Console()
let client = PistonMeta()

@main
struct Piston: AsyncParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "piston",
        subcommands: [
            ListSubcommand.self,
            FetchSubcommand.self
        ]
    )
}
