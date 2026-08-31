//
//  GameListView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 30/08/2026.
//
import SwiftUI
import SwiftData

struct GameListView: View {
    enum SortBy: CaseIterable {
        case name
        case creationTimestamp
        case lastAttemptTimestamp
        
        var title: String {
            switch self {
            case .name: return "Name"
            case .creationTimestamp: return "Last Created"
            case .lastAttemptTimestamp: return "Last Played"
            }
        }
    }
    
    // MARK: Data in
    @Environment(\.modelContext) var modelContext
    
    // MARK: Data shared
    @Binding var selection: CodeBreaker?
    
    // MARK: Data owned
    @Query private var games: [CodeBreaker]
    
    init(
        nameContains search: String,
        sortBy: SortBy,
        selection: Binding<CodeBreaker?>
    ) {
        let predicate = #Predicate<CodeBreaker> {
            search.isEmpty || $0.name.localizedStandardContains(search)
        }
        self._games = switch sortBy {
            case .name: Query(filter: predicate, sort: \.name)
            case .creationTimestamp: Query(filter: predicate, sort: \.timestamp, order: .reverse)
            case .lastAttemptTimestamp: Query(filter: predicate, sort: \.lastAttemptTimestamp, order: .reverse)
        }
        self._selection = selection
    }
    
    // MARK: UI
    var body: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                VStack {
                    NavigationLink(value: game) {
                        GameSummaryView(game: game)
                    }
                }
                .contextMenu {
                    deleteButtonView(for: game)
                }
            }
            .onDelete { offsets in
                for offset in offsets {
                    modelContext.delete(games[offset])
                }
            }
        }
        .onChange(of: games) { updateSelectedGameIfCurrentDeleted() }
    }
    
    private func deleteButtonView(for game: CodeBreaker) -> some View {
        Button("Delete", systemImage: "minus.circle", role: .destructive) {
            withAnimation { delete(game) }
        }
    }
    
    // MARK: Actions
    private func delete(_ game: CodeBreaker) {
        modelContext.delete(game)
    }
    
    private func updateSelectedGameIfCurrentDeleted() {
        if let selection, !games.contains(selection) {
            self.selection = games.first
        }
    }
}
