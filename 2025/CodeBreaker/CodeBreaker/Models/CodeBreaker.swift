//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//
import Foundation
import SwiftData

@Model
class CodeBreaker {
    var timestamp = Date.now
    
    // Configuration
    var pegChoices: Pegs
    var name: String
    
    // Gameplay Stored
    @Relationship(deleteRule: .cascade) var masterCode: Code
    @Relationship(deleteRule: .cascade) var guess: Code
    @Relationship(deleteRule: .cascade) var _attempts: [Code] = [Code]()
    var lastAttemptTimestamp = Date.now
    var elapsedTime: TimeInterval = 0
    
    // Gameplay Not Stored
    @Transient var startTime: Date? // last game session start time
    
    // Gameplay Computed
    var attempts: [Code] {
        _attempts.sorted(by: { $0.timestamp > $1.timestamp })
    }
    var isOver: Bool {
        attempts.first?.pegs == masterCode.pegs
    }
    
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
        _attempts = []
        elapsedTime = 0
        startTime = .now
    }
    
    func setGuessPeg(to peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guard pegChoices.values.contains(peg) else { return }
        guess.pegs[index] = peg
    }
    
    @discardableResult
    func attemptGuess() -> Bool {
        guard guess.isFilled else { return false }
        let attempt = Code(kind: .attempt(matches: guess.matchAgainst(masterCode)), pegs: guess.pegs)
        guard !_attempts.contains(attempt) else { return false }
        _attempts.append(attempt)
        lastAttemptTimestamp = .now
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
            elapsedTime += 0.00001 // hack: @Transient startTime does not update UI, so we force it to update by changing other observable var
        }
    }
    func pauseTimer() {
        if let startTime {
            elapsedTime += Date.now.timeIntervalSince(startTime)
        }
        startTime = nil
    }
    func updateElapsedTime() {
        pauseTimer()
        startTimer()
    }
    
    private static func getRandomPegsCount() -> Int {
        (3...6).randomElement() ?? 4
    }
}
