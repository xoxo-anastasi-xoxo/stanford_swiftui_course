//
//  Peg.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//

typealias Peg = String

struct Pegs {
    enum Kind {
        case emogi
        case circle
        case star
    }
    let values: [Peg]
    let kind: Kind
    
    static let circles: Pegs = Pegs(values: ["red", "green", "blue", "yellow"], kind: .circle)
    static let stars: Pegs = Pegs(values: ["yellow", "orange", "purple", "pink"], kind: .star)
    static let faces: Pegs = Pegs(values: ["😀", "😎", "😱", "🤡"], kind: .emogi)
    static let fruits: Pegs = Pegs(values: ["🍎", "🍊", "🍐", "🍋"], kind: .emogi)

    static let palletes = [Self.circles, Self.stars, Self.faces, Self.fruits]
}
