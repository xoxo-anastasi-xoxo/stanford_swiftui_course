//
//  GameLineView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 13/08/2026.
//

import SwiftUI

struct GameLineModel {
    let pegs: [Color]
    let matches: MatchMarkersModel
}

struct GameLineView: View {
    let model: GameLineModel
    var body: some View {
        HStack(spacing: 10) {
            PegsView(pegs: model.pegs)
            MatchMarkersView(model: model.matches)
        }
        .frame(height: 50)
    }
}

#Preview {
    ForEach(0..<MatchStubs.stubs.count, id: \.self) {
        GameLineView(model: MatchStubs.stubs[$0])
    }
}
