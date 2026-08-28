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
                Section(Strings.nameSectionName) {
                    TextField(Strings.nameSectionName, text: $name)
                }
                Section(Strings.countSectionName) {
                    Stepper("\(pegsCount)", value: $pegsCount, in: 3...6)
                }
                Section(Strings.palleteSectionName) {
                    palletPicker
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { cancelButton }
                ToolbarItem(placement: .confirmationAction) { doneButton }
            }
        }
    }
    
    private var doneButton: some View {
        Button(Strings.submitButton, role: .confirm, action: onSubmit)
        .alert(
            Strings.errorTitle,
            isPresented: $isAlertPresented,
            actions: {
                Button(Strings.errorButton, role: .cancel) {
                    isAlertPresented = false
                }
            }, message: {
                Text(Strings.errorMessage)
            }
        )
    }
    
    private var cancelButton: some View {
        Button(Strings.cancelButton, role: .cancel) { dismiss() }
    }
    
    private var palletPicker: some View {
        Picker(Strings.palleteSectionName, selection: $palette) {
            ForEach(Pegs.palletes) { pallete in
                PegChooserView(pegChoices: pallete.values)
                    .environment(\.pegsKind, pallete.kind)
                    .tag(pallete)
            }
        }
        .pickerStyle(.wheel)
    }
    
    // MARK: Actions
    
    private func onSubmit() {
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
    
    // MARK: Constants
    
    private struct Strings {
        static let errorTitle = "Invalid Game Name"
        static let errorMessage = "It should not be empty 😉"
        static let errorButton = "Got it"
        
        static let nameSectionName = "Game Name"
        static let countSectionName = "Pegs Count"
        static let palleteSectionName = "Pegs Pallete"
        
        static let submitButton = "Done"
        static let cancelButton = "Cancel"
    }
}

#Preview {
    GameEditorView() { _ in }
}
