//
//  Peg.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//
import SwiftData

typealias Peg = String

extension Peg {
    static let missing: Peg = ""
}

@Model
class Pegs: Hashable, Identifiable {
    enum Kind: String {
        case emogi
        case circle
        case star
    }
    
    var name: String
    var values: [Peg]
    var _kind: String
    
    
    var kind: Kind {
        get { Kind(rawValue: _kind) ?? .circle }
        set { _kind = newValue.rawValue }
    }
    var id: String { name }
    
    init(name: String, values: [Peg], kind: Kind) {
        self.name = name
        self.values = values
        self._kind = kind.rawValue
    }
    
    static let circles: Pegs = Pegs(name: "Classic Colors", values: ["red", "green", "blue", "yellow"], kind: .circle)
    static let stars: Pegs = Pegs(name: "Colored Stars", values: ["yellow", "orange", "purple", "pink"], kind: .star)
    static let faces: Pegs = Pegs(name: "Emojies", values: ["😀", "😎", "😱", "🤡"], kind: .emogi)
    static let fruits: Pegs = Pegs(name: "Fruits", values: ["🍎", "🍊", "🍐", "🍋"], kind: .emogi)

    static let palletes = [Pegs.circles, Pegs.stars, Pegs.faces, Pegs.fruits]
}
