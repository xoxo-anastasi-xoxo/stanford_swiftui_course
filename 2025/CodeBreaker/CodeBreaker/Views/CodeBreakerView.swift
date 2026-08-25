//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data in
    let game: CodeBreaker
    // MARK: Data owned
    // Just for the sake of using Binding we mess up types 😞
    @State private var selectedGuessPegIndex: Int? = 0
    @State private var isRestarting: Bool = false
    @State private var isMostRecentMarkerHidden: Bool = false
    
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
                        .opacity(isRestarting ? 0 : 1)
                }
                ForEach(game.attempts.reversed()) {
                    attemptCodeView(for: $0, isMostRecent: game.attempts.last == $0)
                }
            }
            if !game.isOver {
                PegChooserView(pegChoices: game.pegChoices.values) { peg in
                    game.setGuessPeg(
                        to: peg,
                        at: selectedGuessPegIndex!
                    )
                    selectedGuessPegIndex! += 1
                    selectedGuessPegIndex! %= game.guess.pegs.count
                }
                .transition(Constants.pegChooserTransition)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                restartButton
            }
            ToolbarItem {
                ElapsedTimeView(startTime: game.startTime, endTime: game.endTime)
                    .monospaced()
            }
        }
        .padding()
        .environment(\.pegsKind, game.pegChoices.kind)
    }
    
    private var masterCodeView: some View {
        CodeView(code: game.masterCode)
            .transition(.identity)
    }

    private var restartButton: some View {
        Button("Restart", systemImage: "arrow.clockwise") {
            withAnimation(Constants.defaultAnimation) {
                isRestarting = game.isOver
                game.reset()
            } completion: {
                withAnimation(Constants.defaultAnimation) {
                    isRestarting = false
                }
            }
        }
        .foregroundStyle(Constants.restartButtonColor)
        .flexibleSystemFont()
    }
    
    private var guessCodeView: some View {
        CodeView(
            code: game.guess,
            selectedIndex: $selectedGuessPegIndex
        ) { guessButton }
            .animation(nil, value: game.attempts.count)
    }

    private var guessButton: some View {
        Button("Guess") {
            withAnimation(Constants.defaultAnimation) {
                let isGuessSucsessful = game.attemptGuess()
                if isGuessSucsessful {
                    selectedGuessPegIndex = 0
                    isMostRecentMarkerHidden = true
                }
            } completion: {
                withAnimation(Constants.defaultAnimation) {
                    isMostRecentMarkerHidden = false
                }
            }
        }
        .foregroundStyle(.blue)
        .flexibleSystemFont()
    }
    
    @ViewBuilder
    func attemptCodeView(for code: Code, isMostRecent: Bool) -> some View {
        if case let .attempt(matches) = code.kind {
            CodeView(code: code, lastElement: {
                MatchMarkersView(model: matches)
                    .opacity(isMostRecent && isMostRecentMarkerHidden ? 0 : 1)
            })
            .transition(Constants.getAttemptViewTransition(game.isOver || isRestarting))
        }
    }
    
    struct Constants {
        static let restartButtonColor: Color = .red
        
        static let pegChooserTransition = AnyTransition.offset(x: 0, y: 200)
        
        static let defaultAnimation: Animation = .easeInOut
        
        static func getAttemptViewTransition(_ isOver: Bool) -> AnyTransition {
            .asymmetric(
                insertion: isOver ? .opacity : .move(edge: .top),
                removal: .move(edge: .trailing)
           )
        }
    }
}

#Preview {
    @Previewable @State var game = CodeBreaker()
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
