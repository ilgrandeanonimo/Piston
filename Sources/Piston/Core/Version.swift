//
//  Version.swift
//  Piston
//

import Foundation

struct Version: Codable {
    var downloads: Downloads
    
    struct Downloads: Codable {
        /// The client.jar download information.
        var client: Download
        
        /// The obfuscation maps for this client version. Added in Java Edition 19w36a but got included in 1.14.4 also.
        var clientMappings: Download?
        
        /// The server download information.
        var server: Download
        
        /// The obfuscation maps for this server version. Added in Java Edition 19w36a but got included in 1.14.4 also.
        var serverMappings: Download?
        
        /// The Windows server download information. Removed in Java Edition 16w05a, but is still present in prior versions.
        var windowsServer: Download?
        
        struct Download: Codable {
            /// The SHA1 hash of the jar.
            var sha1: String
            
            /// The size of the jar in bytes.
            var size: Int
            
            /// The URL the launcher should visit to download the file.
            var url: URL
        }
    }
}
