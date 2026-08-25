//
//  GameChooser.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct GameChooserView: View {
    // MARK: Data owned
    @State private var games: [CodeBreaker] = [
        CodeBreaker(pallete: .circles),
        CodeBreaker(pallete: .stars),
        CodeBreaker(pallete: .faces),
        CodeBreaker(pallete: .fruits)
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(
                    $games,
                    editActions: [.delete, .move]
                ) { $game in
                    NavigationLink(value: game) {
                        GameSummaryView(game: game)
                    }
                    NavigationLink {
                        PegChooserView(pegChoices: game.masterCode.pegs)
                            .environment(\.pegsKind, game.pegChoices.kind)
                    } label: {
                        Text("Cheat 😅")
                    }
                    
                }
            }
            .navigationTitle("Code Breaker")
            .navigationDestination(for: CodeBreaker.self, destination: {
                CodeBreakerView(game: $0)
                    .navigationTitle($0.pegChoices.name)
            })
            .listStyle(.plain)
            .toolbar { // Lives only inside NavigationStack
                EditButton()
            }
        } detail: {
            Text("Choose a game!")
        }
    }
}

#Preview {
    GameChooserView()
}
