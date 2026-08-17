//
//  PegView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 16/08/2026.
//
import SwiftUI

struct PegView: View {
    // MARK: Data in
    @Environment(\.pegsKind) var kind
    let peg: Peg
    
    // MARK: Body
    var body: some View {
        switch kind {
        case .emogi, .circle:
            Circle().stylePeg(
                foregroundColorName: peg,
                overlayContent: { overlay() }
            )
        case .star:
            Star(points: 8)
                .aspectRatio(contentMode: .fit)
                .stylePeg(
                    foregroundColorName: peg,
                    overlayContent: { overlay() }
                )
        }
    }
    
    @ViewBuilder
    private func overlay() -> some View {
        if peg == .missing {
            Circle().stroke(lineWidth: 1)
        } else if kind == .emogi {
            Text(peg)
                .font(.system(size: 80))
                .minimumScaleFactor(0.1)
        }
    }
}
