//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var pegsKind: Pegs.Kind = .circle
}

struct CodeBreakerView: View {
    // MARK: Data owned
    @State private var game = CodeBreaker()
    // TODO: FIXMEPLS
    @State private var selectedGuessPegIndex: Int? = 0
    
    // MARK: Body
    var body: some View {
        VStack(spacing: 4) {
            #if DEBUG
                let _ = print(game.masterCode.pegs)
            #endif
            masterCodeView
            ScrollView {
                if !game.isOver {
                    guessCodeView
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) {
                    attemptCodeView(for: game.attempts[$0])
                }
            }
            PegChooserView(pegChoices: game.pegChoices.values) { peg in
                game.setGuessPeg(
                    to: peg,
                    at: selectedGuessPegIndex!
                )
                selectedGuessPegIndex! += 1
                selectedGuessPegIndex! %= game.guess.pegs.count
            }
        }
        .padding()
        .environment(\.pegsKind, game.pegChoices.kind)
    }
    
    private var masterCodeView: some View {
        CodeView(code: game.masterCode) { restartButton }
    }
    private var restartButton: some View {
        Button("Restart") {
            withAnimation {
                selectedGuessPegIndex = 0
                game.reset()
            }
        }
        .foregroundStyle(.red)
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    private var guessCodeView: some View {
        CodeView(
            code: game.guess,
            selectedIndex: $selectedGuessPegIndex
        ) { guessButton }
    }
    private var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .foregroundStyle(.blue)
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    @ViewBuilder
    func attemptCodeView(for code: Code) -> some View {
        if case let .attempt(matches) = code.kind {
            CodeView(code: code) { MatchMarkersView(model: matches) }
        }
    }
    
    struct Constants {}
}

#Preview {
    CodeBreakerView()
}
