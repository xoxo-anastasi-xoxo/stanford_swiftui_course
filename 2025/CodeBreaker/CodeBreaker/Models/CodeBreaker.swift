//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//

import SwiftUI

struct CodeBreaker {
    // Configuration
    let pegChoices: [Peg]
    let pegsCount: Int
    
    // Gameplay
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = [Code]()
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow], pegsCount: Int = 4) {
        self.pegChoices = pegChoices
        self.pegsCount = pegsCount
        masterCode = Code(kind: .master, count: pegsCount)
        masterCode.randomize(from: pegChoices)
        guess = Code(kind: .guess, count: pegsCount)
    }
    
    mutating func reset() {
        masterCode = Code(kind: .master, count: pegsCount)
        masterCode.randomize(from: pegChoices)
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
        guard let indexOfExistingPeg = pegChoices.firstIndex(of: existingPegs) else {
            guess.pegs[index] = pegChoices.first ?? Code.mising
            return
        }
        let nextIndex = (indexOfExistingPeg + 1) % pegChoices.count
        guess.pegs[index] = pegChoices[nextIndex]
        
    }
}
