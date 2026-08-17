//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 16/08/2026.
//

import SwiftUI

struct CodeView<V: View>: View {
    // MARK: Data in
    let code: Code
    @ViewBuilder let lastElement: () -> V
    
    // MARK: Data shared
    @Binding var selectedIndex: Int?
    
    init(
        code: Code,
        selectedIndex: Binding<Int?> = .constant(nil),
        lastElement: @escaping () -> V
    ) {
        self.code = code
        self.lastElement = lastElement
        self._selectedIndex = selectedIndex
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                .padding(4)
                .overlay {
                    if code.isHidden {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.gray)
                    }
                }
                .background {
                    if let selectedIndex, index == selectedIndex {
                        Circle()
//                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.blue)
                            .opacity(0.2)
                    }
                }
                .onTapGesture {
                    if selectedIndex != nil {
                        selectedIndex = index
                    }
                }
                
            }
            Circle()
                .foregroundStyle(.clear)
                .overlay {
                    lastElement()
                }
        }
    }
}
