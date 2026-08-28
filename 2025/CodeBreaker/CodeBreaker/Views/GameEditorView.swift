//
//  GameEditorView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct GameEditorView: View {
    // MARK: Data in
    @Environment(\.dismiss) var dismiss
    let completion: (CodeBreaker) -> Void
    
    // MARK: Data owned
    @State private var name: String = "My Game"
    @State private var palette: Pegs = .faces
    @State private var pegsCount: Int = 4
    @State private var isAlertPresented = false
    
    // MARK: UI
    var body: some View {
        NavigationStack {
            Form {
                Section("Game Name") {
                    TextField("Game Name", text: $name)
                }
                Section("Pegs Count") {
                    Stepper("\(pegsCount)", value: $pegsCount, in: 3...6)
                }
                Section("Pegs Pallete") {
                    Picker("Pallete", selection: $palette) {
                        ForEach(Pegs.palletes) { pallete in
                            PegChooserView(pegChoices: pallete.values)
                                .environment(\.pegsKind, pallete.kind)
                                .tag(pallete)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    doneButton
                }
            }
        }
    }
    
    private var doneButton: some View {
        Button("Done", role: .confirm, action: onSubmit)
        .alert(
            "Invalid Game Name",
            isPresented: $isAlertPresented,
            actions: {
                Button("Got it", role: .cancel) {
                    isAlertPresented = false
                }
            }, message: {
                Text("It should not be empty 😉")
            }
        )
    }
    
    // MARK: Actions
    func onSubmit() {
        guard !name.isEmpty else {
            isAlertPresented = true
            return
        }
        completion(CodeBreaker(
            name: name,
            pallete: palette,
            count: pegsCount
        ))
        dismiss()
    }
}

#Preview {
    GameEditorView() { _ in }
}
