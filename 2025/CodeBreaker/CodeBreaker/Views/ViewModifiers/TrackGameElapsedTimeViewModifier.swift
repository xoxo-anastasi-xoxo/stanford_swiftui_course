//
//  TrackGameElapsedTimeViewModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 28/08/2026.
//

import SwiftUI
import SwiftData

struct TrackGameElapsedTimeViewModifier: ViewModifier {
    // MARK: Data in
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var modelContext
    
    // MARK: Data shared
    @Bindable var game: CodeBreaker
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                game.startTimer()
            }
            .onDisappear {
                game.pauseTimer()
            }
            .onChange(of: game) { oldGame, newGame in
                oldGame.pauseTimer()
                newGame.startTimer()
            }
            .onChange(of: scenePhase) {
                print("scenePhase: \(scenePhase)")
                switch scenePhase {
                case .active: game.startTimer()
                case .inactive: game.pauseTimer()
                default: break
                }
            }
            .task {
                for await _ in NotificationCenter.default.notifications(named: ModelContext.willSave) {
                    game.updateElapsedTime()
                }
            }
    }
}

extension View {
    func trackElapsedTime(for game: CodeBreaker) -> some View {
        modifier(TrackGameElapsedTimeViewModifier(game: game))
    }
}
