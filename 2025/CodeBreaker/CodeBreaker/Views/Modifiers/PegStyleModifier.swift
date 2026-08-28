//
//  PegStyleModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//

import SwiftUI

struct PegStyleModifier<OverlayContent: View>: ViewModifier {
    let foregroundColor: Color
    @ViewBuilder let overlayContent: () -> OverlayContent
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(foregroundColor)
            .contentShape(Circle())
            .overlay(content: overlayContent)
    }
}

extension View {
    func stylePeg<OverlayContent: View>(
        foregroundColorName: String,
        @ViewBuilder overlayContent: @escaping () -> OverlayContent
    ) -> some View {
        modifier(PegStyleModifier(foregroundColor: Color(named: foregroundColorName), overlayContent: overlayContent))
    }
}

extension Color {
    init(named name: String) {
        switch name {
        case "red": self = .red
        case "green": self = .green
        case "blue": self = .blue
        case "yellow": self = .yellow
        case "orange": self = .orange
        case "pink": self = .pink
        case "purple": self = .purple
        case "gray": self = .gray
        case "black": self = .black
        case "white": self = .white
        default: self = .clear
        }
    }
}
