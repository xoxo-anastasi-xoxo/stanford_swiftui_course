//
//  Code.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//
import Foundation
import SwiftData

@Model
class Code: Identifiable, Hashable {
    var _kind: String
    var pegs: [Peg]
    var timestamp = Date.now
    
    var kind: Kind {
        get { Kind(from: _kind) }
        set { _kind = newValue.description }
    }
    var isFilled: Bool {
        !pegs.contains(.missing)
    }
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): isHidden
        case .guess, .attempt: false 
        }
    }
    
    init(kind: Kind, count: Int) {
        self._kind = kind.description
        self.pegs = .init(repeating: .missing, count: count)
    }
    
    init(kind: Kind, pegs: [Peg]) {
        self._kind = kind.description
        self.pegs = pegs
    }
    
    func randomize(from choises: [Peg]) {
        for i in pegs.indices {
            pegs[i] = choises.randomElement() ?? .missing
        }
    }
    
    func matchAgainst(_ code: Code) -> Matches {
        var exact = 0
        var inexact = 0
        
        var unmatched = [Peg: Int]()
        var searched = [Peg: Int]()
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
