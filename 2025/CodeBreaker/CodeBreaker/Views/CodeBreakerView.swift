//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()
    
    var body: some View {
        VStack(spacing: 4) {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) {
                    view(for: game.attempts[$0])
                }
            }
        }
        .padding()
    }
    
    func view(for code: Code) -> some View {
        HStack(spacing: 4) {
            ForEach(code.pegs.indices, id: \.self) { index in
                peg(for: code.pegs[index])
                    .onTapGesture {
                        guard code.kind == .guess else { return }
                        game.changeGuess(at: index)
                    }
                
            }
            MatchMarkersView(model: code.matches)
                .overlay {
                    switch code.kind {
                    case .attempt(_):
                        EmptyView()
                    case .guess:
                        Button("Guess") {
                            withAnimation {
                                game.attemptGuess()
                            }
                        }
                        .font(.system(size: 80))
                        .minimumScaleFactor(0.1)
                    case .master:
                        Button("Restart") {
                            withAnimation {
                                game.reset()
                            }
                        }
                        .foregroundStyle(.red)
                        .font(.system(size: 80))
                        .minimumScaleFactor(0.1)
                    }
                }
        }
        .scaledToFit()
    }
    
    @ViewBuilder
    private func pegOverlay(for peg: Peg) -> some View {
        if peg == Code.mising {
            Circle().stroke(lineWidth: 1)
        } else if game.pegChoices.kind == .emogi {
            Text(peg)
                .font(.system(size: 80))
                .minimumScaleFactor(0.1)
        }
    }
    
    @ViewBuilder
    private func peg(for peg: Peg) -> some View {
        let overlay = pegOverlay(for: peg)
        switch game.pegChoices.kind {
        case .emogi, .circle:
            Circle().stylePeg(
                foregroundColorName: peg,
                overlayContent: { overlay }
            )
        case .star:
            Star(points: 8)
                .aspectRatio(contentMode: .fit)
                .stylePeg(
                    foregroundColorName: peg,
                    overlayContent: { overlay }
                )
        }
    }
}

#Preview {
    CodeBreakerView()
}
