//
//  PegChooserView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 16/08/2026.
//

import SwiftUI

struct PegChooserView: View {
    let pegChoices: [Peg]
    let pegsKind: Pegs.Kind
    let onChoose: (Peg) -> Void
    
    var body: some View {
        HStack {
            ForEach(pegChoices, id: \.self) { peg in
                PegView(peg: peg, kind: pegsKind)
                    .onTapGesture { onChoose(peg) }
            }
        }
    }
}
