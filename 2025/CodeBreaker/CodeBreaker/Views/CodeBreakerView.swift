//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(
        pegChoices: [.green, .pink, .purple, .yellow],
        pegsCount: 5
    )
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) {
                    view(for: game.attempts[$0])
                }
            }
        }
    }
    
    func view(for code: Code) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<code.pegs.count, id: \.self) { index in
                Circle()
                    .contentShape(Circle())
                    .foregroundStyle(code.pegs[index])
                    .overlay {
                        if code.pegs[index] == Code.mising {
                            Circle().stroke(lineWidth: 1)
                        }
                    }
                    .onTapGesture {
                        guard code.kind == .guess else { return }
                        game.changeGuess(at: index)
                    }
            }
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
                Button("Reset") {
                    withAnimation {
                        game.reset()
                    }
                }
                .foregroundStyle(.red)
                .font(.system(size: 80))
                .minimumScaleFactor(0.1)
            }
        }
    .scaledToFit()
//        .frame(height: 50)
    }
}

#Preview {
    CodeBreakerView()
}
