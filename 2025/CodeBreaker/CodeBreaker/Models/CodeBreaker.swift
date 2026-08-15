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
    
    init(pallete: Pegs? = nil, count: Int? = nil) {
        self.pegChoices = pallete ?? .palletes.randomElement() ?? .circles
        let pegsCount = count ?? Self.getRandomPegsCount()
        masterCode = Code(kind: .master, count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
        guess = Code(kind: .guess, count: pegsCount)
    }
    
    mutating func reset() {
        pegChoices = .palletes.randomElement() ?? .circles
        let pegsCount = Self.getRandomPegsCount()
        masterCode = Code(kind: .master, count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
        guess = Code(kind: .guess, count: pegsCount)
        attempts = []
    }
    
    mutating func attemptGuess() {
        guard guess.isFilled else { return }
        var attempt = guess
        attempt.kind = .attempt(matches: attempt.matchAgainst(masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuess(at index: Int) {
        let existingPegs = guess.pegs[index]
        guard let indexOfExistingPeg = pegChoices.values.firstIndex(of: existingPegs) else {
            guess.pegs[index] = pegChoices.values.first ?? Code.mising
            return
        }
        let nextIndex = (indexOfExistingPeg + 1) % pegChoices.values.count
        guess.pegs[index] = pegChoices.values[nextIndex]
        
    }
    
    private static func getRandomPegsCount() -> Int { (3...6).randomElement() ?? 4 }
}
