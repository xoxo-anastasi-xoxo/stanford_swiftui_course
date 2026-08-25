//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//

import SwiftUI

@Observable
class CodeBreaker: Identifiable {
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
    
    private var __attempts = Set<Code>()
    
    init(pallete: Pegs? = nil, count: Int? = nil) {
        self.pegChoices = pallete ?? .palletes.randomElement() ?? .circles
        let pegsCount = count ?? Self.getRandomPegsCount()
        guess = Code(kind: .guess, count: pegsCount)
        startTime = .now
        masterCode = Code(kind: .master(isHidden: true), count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
    }
    
    // TODO: Repeats the init logic
    func reset() {
        pegChoices = .palletes.randomElement() ?? .circles
        let pegsCount = Self.getRandomPegsCount()
        // TODO: CONSTANTS?
        guess = Code(kind: .guess, count: pegsCount)
        attempts = []
        __attempts = []
        startTime = .now
        endTime = nil
        masterCode = Code(kind: .master(isHidden: true), count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
    }
    
    func setGuessPeg(to peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guard pegChoices.values.contains(peg) else { return }
        guess.pegs[index] = peg
    }
    
    @discardableResult
    func attemptGuess() -> Bool {
        guard guess.isFilled else { return false }
        var attempt = guess
        attempt.kind = .attempt(matches: attempt.matchAgainst(masterCode))
        guard !__attempts.contains(attempt) else { return false }
        attempts.append(attempt)
        __attempts.insert(attempt)
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
