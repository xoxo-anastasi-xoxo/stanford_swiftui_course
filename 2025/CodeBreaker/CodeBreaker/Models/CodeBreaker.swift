//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//

import SwiftUI

@Observable
class CodeBreaker {
    // Configuration
    let pegChoices: Pegs
    let name: String
    
    // Gameplay
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = [Code]()
    var elapsedTime: TimeInterval = 0
    var startTime: Date? // last game session start time
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    private var __attempts = Set<Code>()
    
    init(name: String, pallete: Pegs? = nil, count: Int? = nil) {
        self.name = name
        self.pegChoices = pallete ?? .palletes.randomElement() ?? .circles
        let pegsCount = count ?? Self.getRandomPegsCount()
        guess = Code(kind: .guess, count: pegsCount)
        masterCode = Code(kind: .master(isHidden: true), count: pegsCount)
        masterCode.randomize(from: pegChoices.values)
    }
    
    func reset() {
        guess = Code(kind: .guess, count: masterCode.pegs.count)
        attempts = []
        elapsedTime = 0
        startTime = .now
        __attempts = []
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
            pauseTimer()
        }
        return true
    }
    
    func startTimer() {
        if startTime == nil {
            startTime = .now
        }
    }
    func pauseTimer() {
        if let startTime {
            elapsedTime += Date.now.timeIntervalSince(startTime)
        }
        startTime = nil
    }
    
    private static func getRandomPegsCount() -> Int {
        (3...6).randomElement() ?? 4
    }
}

extension CodeBreaker: Identifiable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
        lhs.id == rhs.id
    }
     
}
