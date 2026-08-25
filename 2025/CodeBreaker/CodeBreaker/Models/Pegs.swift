//
//  Peg.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//

typealias Peg = String

extension Peg {
    static let missing: Peg = ""
}

struct Pegs: Hashable {
    enum Kind {
        case emogi
        case circle
        case star
    }
    let name: String
    let values: [Peg]
    let kind: Kind
    
    static let circles: Pegs = Pegs(name: "Classic Colors", values: ["red", "green", "blue", "yellow"], kind: .circle)
    static let stars: Pegs = Pegs(name: "Colored Stars", values: ["yellow", "orange", "purple", "pink"], kind: .star)
    static let faces: Pegs = Pegs(name: "Emojies", values: ["😀", "😎", "😱", "🤡"], kind: .emogi)
    static let fruits: Pegs = Pegs(name: "Fruits", values: ["🍎", "🍊", "🍐", "🍋"], kind: .emogi)

    static let palletes = [Self.circles, Self.stars, Self.faces, Self.fruits]
}
