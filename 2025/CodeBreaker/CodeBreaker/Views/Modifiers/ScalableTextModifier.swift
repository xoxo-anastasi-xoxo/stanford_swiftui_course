//
//  ScalableTextModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 19/08/2026.
//

import SwiftUI

struct ScalableTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
}

extension View {
    func scalableText() -> some View {
        modifier(ScalableTextModifier())
    }
}
