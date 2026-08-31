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
        case creationTimestamp
        case lastAttemptTimestamp
        case compleated
        
        var title: String {
            switch self {
            case .creationTimestamp: return "Last Created"
            case .lastAttemptTimestamp: return "Last Played"
            case .compleated: return "Completed"
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
        let isCompleatedOnly = sortBy == .compleated
        let predicate = #Predicate<CodeBreaker> { game in
            (!isCompleatedOnly || game._attempts.contains(where: { game.masterCode.pegs == $0.pegs })) &&
            (search.isEmpty || game.name.localizedStandardContains(search))
        }
        self._games = switch sortBy {
            case .creationTimestamp: Query(filter: predicate, sort: \.timestamp, order: .reverse)
            case .lastAttemptTimestamp: Query(filter: predicate, sort: \.lastAttemptTimestamp, order: .reverse)
            case .compleated: Query(filter: predicate, sort: \.lastAttemptTimestamp, order: .reverse)
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
//        if let selection, !games.contains(selection) {
//            self.selection = games.first
//        }
    }
}
