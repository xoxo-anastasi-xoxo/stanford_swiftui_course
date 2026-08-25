//
//  ScalableTextModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 19/08/2026.
//

import SwiftUI

struct FlexibleSystemFontModifier: ViewModifier {
    let maxFontSize: CGFloat
    let minFontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: maxFontSize))
            .minimumScaleFactor(minFontSize/maxFontSize)
            .lineLimit(1)
    }
}

extension View {
    func flexibleSystemFont(maxFontSize: CGFloat = 80, minFontSize: CGFloat = 10) -> some View {
        modifier(FlexibleSystemFontModifier(
            maxFontSize: maxFontSize,
            minFontSize: minFontSize)
        )
    }
}
