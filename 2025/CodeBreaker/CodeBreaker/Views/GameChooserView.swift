//
//  GameChooser.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI
import SwiftData

struct GameChooserView: View {
    // MARK: Data in
    @Environment(\.modelContext) var modelContext
    
    // MARK: Data shared
    @State private var selection: CodeBreaker?
    
    // MARK: Data owned
    @State private var isGameEditorPresented: Bool = false
    @State private var sortOption: GameListView.SortBy = .name
    @State private var search: String = ""
    
    // MARK: UI
    var body: some View {
        NavigationSplitView { gamesList } detail: { selectedGameView() }
        .onAppear { loadGames() }
    }
    
    private var gamesList: some View {
        VStack {
            Picker("", selection: $sortOption) {
                ForEach(GameListView.SortBy.allCases, id: \.self) {
                    Text($0.title)
                        .flexibleSystemFont()
                }
            }
            .pickerStyle(.segmented)
            GameListView(
                nameContains: search,
                sortBy: sortOption,
                selection: $selection
            )
            .searchable(text: $search)
            .animation(.easeInOut, value: sortOption)
            .animation(.easeInOut, value: search)
        }
        .navigationTitle("Code Breaker")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar { // Lives only inside NavigationStack
            ToolbarItem(placement: .primaryAction) { addButton }
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
                modelContext.insert($0)
                selection = $0
            }
        }
    }
    
    // MARK: Actions
    private func loadGames() {
        let descriptor = FetchDescriptor<CodeBreaker>()
        if let count = try? modelContext.fetchCount(descriptor), count == 0 {
            for pallete in Pegs.palletes {
                modelContext.insert(CodeBreaker(
                    name: pallete.name,
                    pallete: pallete
                ))
            }
        }
    }
}

#Preview(traits: .swiftData) {
    GameChooserView()
}
