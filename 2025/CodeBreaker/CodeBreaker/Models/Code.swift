//
//  Code.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//
import SwiftUI

struct Code {
    enum Kind: Equatable {
        case master
        case guess
        case attempt(matches: Matches)
    }
    
    static var mising: Peg = .clear
    
    var kind: Kind
    var pegs: [Peg]
    
    var matches: Matches? {
        switch kind {
        case .attempt(matches: let matches): matches
        default: nil
        }
    }
    
    var isFilled: Bool {
        !pegs.contains(Self.mising)
    }
    
    init(kind: Kind, count: Int) {
        self.kind = kind
        self.pegs = .init(repeating: Self.mising, count: count)
    }
    
    mutating func randomize(from choises: [Peg]) {
        for i in pegs.indices {
            pegs[i] = choises.randomElement() ?? Self.mising
        }
    }
    
    func matchAgainst(_ code: Code) -> Matches {
        var exact = 0
        var inexact = 0
        
        var unmatched = [Color: Int]()
        var searched = [Color: Int]()
        for pair in zip(pegs, code.pegs) {
            if pair.0 == pair.1 {
                exact += 1
            } else {
                unmatched[pair.0, default: 0] += 1
                searched[pair.1, default: 0] += 1
            }
        }
        for (color, count) in unmatched {
            inexact += min(count, searched[color, default: 0])
        }
        return Matches(
            exact: exact,
            inexact: inexact,
            total: code.pegs.count
        )
    }
}
