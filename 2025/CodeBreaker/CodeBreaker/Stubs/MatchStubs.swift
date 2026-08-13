//
//  MatchStubs.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//
import SwiftUI

final class MatchStubs {
    static let stubs: [GameLineModel] = [
        match(attempt: solution3_attempt1, solution: solution3),
        match(attempt: solution3_attempt2, solution: solution3),
        match(attempt: solution4_attempt1, solution: solution4),
        match(attempt: solution4_attempt2, solution: solution4),
        match(attempt: solution4_attempt3, solution: solution4),
        match(attempt: solution5_attempt1, solution: solution5),
        match(attempt: solution6_attempt1, solution: solution6)
    ]
        
    private static let solution3: [Color] = [.red, .green, .yellow]
    private static let solution3_attempt1: [Color] = [.red, .yellow, .green]
    private static let solution3_attempt2: [Color] = [.red, .red, .blue]
    
    private static let solution4: [Color] = [.blue, .red, .green, .yellow]
    private static let solution4_attempt1: [Color] = [.blue, .red, .yellow, .green]
    private static let solution4_attempt2: [Color] = [.blue, .red, .red, .yellow]
    private static let solution4_attempt3: [Color] = [.yellow, .red, .yellow, .yellow]
    
    
    private static let solution5: [Color] = [.green, .blue, .red, .yellow, .green]
    private static let solution5_attempt1: [Color] = [.green, .yellow, .blue, .red, .green]
    
    private static let solution6: [Color] = [.green, .blue, .red, .yellow, .green, .red]
    private static let solution6_attempt1: [Color] = [.red, .yellow, .yellow, .yellow, .green, .yellow]
    
    private static func match(attempt: [Color], solution: [Color]) -> GameLineModel {
        var exact = 0
        var inexact = 0
        
        var unmatched = [Color: Int]()
        var searched = [Color: Int]()
        for pair in zip(attempt, solution) {
            if pair.0 == pair.1 {
                exact += 1
            } else if solution.contains(pair.0) {
                unmatched[pair.0, default: 0] += 1
                searched[pair.1, default: 0] += 1
            }
        }
        for (color, count) in unmatched {
            inexact += min(count, searched[color, default: 0])
        }
        
        return GameLineModel(
            pegs: attempt,
            matches: MatchMarkersModel(
                exact: exact,
                inexact: inexact,
                total: attempt.count
            )
        )
    }
}
