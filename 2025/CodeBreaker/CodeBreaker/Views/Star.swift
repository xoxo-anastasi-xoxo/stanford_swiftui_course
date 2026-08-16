//
//  Star.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 15/08/2026.
//


import SwiftUI

struct Star: Shape {
    // MARK: Data In
    var points: Int = 5
    var innerRatio: CGFloat = 0.4

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * innerRatio
        let angleStep = Double.pi * 2 / Double(points * 2)
        let startAngle = -Double.pi / 2

        var path = Path()

        for i in 0..<(points * 2) {
            let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
            let angle = startAngle + angleStep * Double(i)
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * radius,
                y: center.y + CGFloat(sin(angle)) * radius
            )
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

#Preview {
    Star()
    Star(points: 8)
        .foregroundStyle(.yellow)
}
