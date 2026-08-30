//
//  SwiftDataModifier.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 30/08/2026.
//

import SwiftUI
import SwiftData

struct SwiftDataModifier: PreviewModifier {
    func body(content: Content, context modelContainer: ModelContainer) -> some View {
        content
            .modelContainer(modelContainer)
    }
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(
            for: CodeBreaker.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        // maybe load some sample data
        return container
    }
}

extension PreviewTrait<Preview.ViewTraits> {
    @MainActor static var swiftData: Self = .modifier(SwiftDataModifier())
}
