//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//

import SwiftUI

struct CodeBreaker {
    // Configuration
    var pegChoices: Pegs
    
    // Gameplay
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = [Code]()
    var startTime: Date
    var endTime: Date?
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    init(pallete: Pegs? = nil, count: Int? = nil) {
        self.pegChoices = pallete ?? .palletes.randomElement() ?? .circles
        let pegsCount = count ?? Self.getRandomPegsCount()
        masterCode = Code(kind: .master(isHidden: true), count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
        guess = Code(kind: .guess, count: pegsCount)
        startTime = .now
    }
    
    // TODO: Repeats the init logic
    mutating func reset() {
        pegChoices = .palletes.randomElement() ?? .circles
        let pegsCount = Self.getRandomPegsCount()
        // TODO: CONSTANTS?
        masterCode = Code(kind: .master(isHidden: true), count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
        guess = Code(kind: .guess, count: pegsCount)
        attempts = []
        startTime = .now
        endTime = nil
    }
    
    mutating func setGuessPeg(to peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guard pegChoices.values.contains(peg) else { return }
        guess.pegs[index] = peg
    }
    
    @discardableResult
    mutating func attemptGuess() -> Bool {
        guard guess.isFilled else { return false }
        var attempt = guess
        attempt.kind = .attempt(matches: attempt.matchAgainst(masterCode))
        attempts.append(attempt)
        guess = Code(kind: .guess, count: guess.pegs.count)
        if isOver {
            masterCode.kind = .master(isHidden: false)
            endTime = .now
        }
        return true
    }
    
    private static func getRandomPegsCount() -> Int {
        (3...6).randomElement() ?? 4
    }
}
