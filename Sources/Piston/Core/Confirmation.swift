//
//  Confirmation.swift
//  Piston
//
//  Created by Paolo Boglione on 28/09/25.
//

func confirmation(_ string: String) -> Bool {
    print(string +  " [y/N] ", terminator: "")
    let response = readLine()
    guard let response else {
        return false
    }
    
    return response
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .starts(with: "y")
}
