//
//  CodeBreakerApp.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI
import SwiftData

extension EnvironmentValues {
    @Entry var pegsKind: Pegs.Kind = .circle
    @Entry var sceneFrame: CGRect = .zero
}

@main
struct CodeBreakerApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                GameChooserView()
                    .modelContainer(for: CodeBreaker.self)
                    .environment(\.sceneFrame, geometry.frame(in: .global))
            }
            .ignoresSafeArea()
        }
    }
}
