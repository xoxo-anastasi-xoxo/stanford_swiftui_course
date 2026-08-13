//
//  PegLineView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 05/08/2026.
//

import SwiftUI

struct PegsView: View {
    var pegs: [Color]
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<pegs.count, id: \.self) {
                Circle().foregroundStyle(pegs[$0])
            }
        }
    }
}

#Preview {
    PegsView(pegs: [.red, .green, .blue])
    PegsView(pegs: [.red, .green, .red, .green,])
    PegsView(pegs: [.red, .blue, .blue, .green, .green])
}
