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
    
    // MARK: Data owned
    @Namespace private var selectionNamespace
    
    init(
        code: Code,
        selectedIndex: Binding<Int?> = .constant(nil),
        lastElement: @escaping () -> V = { EmptyView() }
    ) {
        self.code = code
        self.lastElement = lastElement
        self._selectedIndex = selectedIndex
    }
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 4) {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.isHidden ? "" : code.pegs[index])
                .padding(4)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(code.isHidden ? .gray : .clear)
                        .transaction {
                            // Prevents animation on restart
                            if code.isHidden {
                                $0.animation = nil
                            }
                        }
                }
                .animation(nil, value: code.pegs[index])
                .transition(.identity)
                .background {
                    selectionIndicator(for: index)
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
    
    @ViewBuilder
    private func selectionIndicator(for index: Int) -> some View {
            Group {
                if let selectedIndex, index == selectedIndex {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.gray)
                        .opacity(0.2)
                        .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                }
            }
            .animation(.easeInOut, value: selectedIndex)
    }
}
