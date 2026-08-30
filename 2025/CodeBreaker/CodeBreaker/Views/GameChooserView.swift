//
//  GameChooser.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct GameChooserView: View {
    // MARK: Data shared
    @State private var selection: CodeBreaker?
    
    // MARK: Data owned
    @State private var games: [CodeBreaker] = []
    @State private var isGameEditorPresented: Bool = false
    
    // MARK: UI
    var body: some View {
        NavigationSplitView { gamesList } detail: { selectedGameView() }
        .onAppear { loadGames() }
        .onChange(of: games) { updateSelectedGameIfCurrentDeleted() }
    }
    
    private var gamesList: some View {
        List(selection: $selection) {
            ForEach(
                $games,
                editActions: [.delete, .move]
            ) { $game in
                VStack {
                    NavigationLink(value: game) {
                        GameSummaryView(game: game)
                    }
//                        NavigationLink {
//                            PegChooserView(pegChoices: game.masterCode.pegs)
//                                .navigationTitle("\(game.name) Master Code")
//                                .environment(\.pegsKind, game.pegChoices.kind)
//                        } label: {
//                            Text("Cheat 😅")
//                        }
                }
                .contextMenu {
                    deleteButtonView(for: game)
                }
                
            }
        }
        .navigationTitle("Code Breaker")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar { // Lives only inside NavigationStack
            ToolbarItem(placement: .primaryAction) { addButton }
            ToolbarItem { EditButton() }
        }
    }
    
    @ViewBuilder
    private func selectedGameView() -> some View {
        if let selection {
            CodeBreakerView(game: selection)
                .navigationTitle(selection.name)
        } else {
            Text("Choose a game!")
        }
    }
    
    private var addButton: some View {
        Button("Add", systemImage: "plus", role: .confirm) {
            isGameEditorPresented = true
        }
        .sheet(
            isPresented: $isGameEditorPresented,
            onDismiss: {
                isGameEditorPresented = false
            }
        ) {
            GameEditorView {
                games.insert($0, at: 0)
                selection = games.first
            }
        }
    }
    
    private func deleteButtonView(for game: CodeBreaker) -> some View {
        Button("Delete", systemImage: "minus.circle", role: .destructive) {
            withAnimation { delete(game) }
        }
    }
    
    // MARK: Actions
    private func loadGames() {
        if games.isEmpty {
            for pallete in Pegs.palletes {
                games.append(CodeBreaker(
                    name: pallete.name,
                    pallete: pallete
                ))
            }
        }
    }
    
    private func updateSelectedGameIfCurrentDeleted() {
        if let selection, !games.contains(selection) {
            self.selection = games.first
        }
    }
    
    private func delete(_ game: CodeBreaker) {
        games.removeAll(where: { $0 == game })
    }
}

#Preview(traits: .swiftData) {
    GameChooserView()
}
