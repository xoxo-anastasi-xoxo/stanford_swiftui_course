//
//  Matches.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//
import Foundation

struct Matches: Hashable, CustomStringConvertible {
    let exact: Int
    let inexact: Int
    let total: Int
    
    init(from string: String) {
        // TODO: to maintain propper functioning all separator's must be stored together (to ensure they are unique and do not overlap)
        let parts = string
            .components(separatedBy: "_")
            .map { Int($0) ?? 0 }
        
        self.exact = parts.count > 0 ? parts[0] : 0
        self.inexact = parts.count > 1 ? parts[1] : 0
        self.total = parts.count > 2 ? parts[2] : 0
    }
    
    init (exact: Int, inexact: Int, total: Int) {
        self.exact = exact
        self.inexact = inexact
        self.total = total
    }
    
    var description: String {
        "\(exact)_\(inexact)_\(total)"
    }
}
