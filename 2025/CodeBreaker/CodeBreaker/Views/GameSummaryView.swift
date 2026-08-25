//
//  GameSummaryView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct GameSummaryView: View {
    var game: CodeBreaker
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(game.pegChoices.name).font(.title)
            PegChooserView(pegChoices: game.pegChoices.values)
                .environment(\.pegsKind, game.pegChoices.kind)
                .frame(maxHeight: 60)
            Text("^[\(game.attempts.count) attempt](inflect: true)")
        }
    }
}
