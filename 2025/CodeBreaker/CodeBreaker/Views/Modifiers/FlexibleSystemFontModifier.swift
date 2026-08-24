//
//  ScalableTextModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 19/08/2026.
//

import SwiftUI

struct FlexibleSystemFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
}

extension View {
    func flexibleSystemFont() -> some View {
        modifier(FlexibleSystemFontModifier())
    }
}
