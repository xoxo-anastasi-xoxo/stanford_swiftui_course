//
//  Code.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//

struct Code: Identifiable, Hashable {
    enum Kind: Hashable {
        case master(isHidden: Bool)
        case guess
        case attempt(matches: Matches)
    }
    
    var kind: Kind
    var pegs: [Peg]
    
    
    var isFilled: Bool {
        !pegs.contains(.missing)
    }
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): isHidden
        case .guess, .attempt: false 
        }
    }
    var id: Self { self }
    
    init(kind: Kind, count: Int) {
        self.kind = kind
        self.pegs = .init(repeating: .missing, count: count)
    }
    
    mutating func randomize(from choises: [Peg]) {
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
