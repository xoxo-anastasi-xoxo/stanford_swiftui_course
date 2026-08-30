//
//  CodeKind.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 29/08/2026.
//

extension Code {
    enum Kind: Hashable, CustomStringConvertible {
        case master(isHidden: Bool)
        case guess
        case attempt(matches: Matches)
        
        init(from string: String) {
            switch string {
            case "\(Kind.masterLiteral)\(Kind.separator)true": self = .master(isHidden: true)
            case "\(Kind.masterLiteral)\(Kind.separator)false": self = .master(isHidden: false)
            case Kind.guessLiteral: self = .guess
            default:
                let parts = string.split(separator: Kind.separator).map(String.init)
                assert(parts[0] == Kind.attemptLiteral, "Invalid literal: not an attempt - \(string)")
                assert(parts.count == 2, "Invalid literal: wrong separator - \(string)")
                self = .attempt(matches: .init(from: parts.count == 2 ? parts[1] : ""))
            }
        }
        
        var description: String {
            switch self {
            case .master(let isHidden): return "\(Kind.masterLiteral)\(Kind.separator)\(isHidden)"
            case .guess: return Kind.guessLiteral
            case .attempt(let matches): return "\(Kind.attemptLiteral)\(Kind.separator)\(matches)"
            }
        }
        
        private static let separator = " "
        private static let masterLiteral = "master"
        private static let guessLiteral = "guess"
        private static let attemptLiteral = "attempt"
    }
    
}
