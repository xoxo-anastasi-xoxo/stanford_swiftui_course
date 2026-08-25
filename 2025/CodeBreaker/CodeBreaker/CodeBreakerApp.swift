//
//  CodeBreakerApp.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 03/08/2026.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var pegsKind: Pegs.Kind = .circle
}

@main
struct CodeBreakerApp: App {
    var body: some Scene {
        WindowGroup {
            GameChooserView()
        }
    }
}
