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
        NavigationStack {
            List {
                ForEach(
                    $games,
                    editActions: [.delete, .move]
                ) { $game in
                    NavigationLink { // Lives only inside NavigationStack
                        CodeBreakerView(game: game)
                    } label: {
                        GameSummaryView(game: game)
                    }
                }
            }
            .listStyle(.plain)
            .toolbar { // Lives only inside NavigationStack
                EditButton()
            }
        }
    }
}

#Preview {
    GameChooserView()
}
