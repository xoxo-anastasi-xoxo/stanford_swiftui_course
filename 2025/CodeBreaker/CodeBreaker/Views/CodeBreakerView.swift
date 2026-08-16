//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

struct CodeBreakerView: View {
    @State private var game = CodeBreaker()
    
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
                PegView(
                    peg: code.pegs[index],
                    kind: game.pegChoices.kind
                )
                .onTapGesture {
                    guard code.kind == .guess else { return }
                    game.changeGuess(at: index)
                }
                
            }
            Circle()
                .foregroundStyle(.clear)
                .overlay {
                    switch code.kind {
                    case .attempt(let matches):
                        MatchMarkersView(model: matches)
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
    }
}

#Preview {
    CodeBreakerView()
}
