//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anastasia Kazantseva on 07.06.2022.
//

import SwiftUI

let vehiclesEmojies = [
  "🚗", "🚠", "🚂", "🚁", "⛵️",
  "🚕", "🚌", "🚎", "🚛", "🚜",
  "🏎", "🚐", "🚒", "🛴", "🚍"
]
let foodEmojies = [
  "🥑", "🥬", "🥒", "🍑", "🥭",
  "🍎", "🥗", "🍳", "🥘", "🍲",
  "🍚", "🌰", "🥔", "🍇", "🍋"
]

class EmojiMemoryGame: ObservableObject {
  private static let emojies = [
    "🐬", "🪴", "🐳", "🌷", "🐥",
    "🌈", "🦚", "🐞", "🌳", "🦋",
    "☀️", "🐶", "🐠", "🌲", "🐘"
  ]
  // ViewModel (it is) creates view model in a lot of apps
  // Сначала стоит постараться сделать модель приватной и давать к ней выборочный доступ с помощью функций - а потом если станет понятно, что надо все из модели - уже делать ее private(set)
  @Published private var model = MemoryGame<String>(numberOfPairsOfCards: 4) { index in emojies[index] }
  
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
  
  // MARK: - Intent
  
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
}
