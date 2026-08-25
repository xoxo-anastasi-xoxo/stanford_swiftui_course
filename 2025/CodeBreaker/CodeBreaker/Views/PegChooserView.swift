//
//  PegChooserView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 16/08/2026.
//

import SwiftUI

struct PegChooserView: View {
    // MARK: Data in
    let pegChoices: [Peg]
    let onChoose: ((Peg) -> Void)?
    
    init(pegChoices: [Peg], onChoose: ((Peg) -> Void)? = nil) {
        self.pegChoices = pegChoices
        self.onChoose = onChoose
    }
    
    // MARK: Body
    var body: some View {
        HStack {
            ForEach(pegChoices, id: \.self) { peg in
                PegView(peg: peg)
                    .onTapGesture { onChoose?(peg) }
            }
        }
    }
}
