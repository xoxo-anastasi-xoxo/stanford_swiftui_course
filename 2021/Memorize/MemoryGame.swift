//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anastasia Kazantseva on 07.06.2022.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
  private var facedUpCardIndex: Int?
  private(set) var cards: [Card]
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    
    for i in 0..<numberOfPairsOfCards {
      let cardContent = createCardContent(i)
      cards.append(Card(content: cardContent, id: i * 2))
      cards.append(Card(content: cardContent, id: i * 2 + 1))
    }
  }
   
  mutating func choose(_ card: Card) {
    guard
      let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
      !cards[chosenCardIndex].isMatched
    else { return }
    
    if let pairedCardIndex = facedUpCardIndex {
      // open the second card
      cards[chosenCardIndex].isFaceUp.toggle()
      guard facedUpCardIndex != chosenCardIndex else {
        // opened the same card twice
        facedUpCardIndex = nil
        return
      }
      
      if cards[pairedCardIndex].content == cards[chosenCardIndex].content {
        cards[pairedCardIndex].isMatched = true
        cards[chosenCardIndex].isMatched = true
      }
      
      facedUpCardIndex = nil
    } else {
      // open the first card
      cards = turnCardsFaceDown()
      cards[chosenCardIndex].isFaceUp.toggle()
      facedUpCardIndex = chosenCardIndex
    }
  }
  
  private func turnCardsFaceDown() -> [Card] {
    cards.map({ card in
      guard card.isFaceUp else { return card }
      
      var copy = card
      copy.isFaceUp = false
      return copy
    })
  }
  
  struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var color: Color = .purple
    
    var content: CardContent
    var id: Int
  }
}
