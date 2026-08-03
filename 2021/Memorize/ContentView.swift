//
//  ContentView.swift
//  Memorize
//
//  Created by Anastasia Kazantseva on 01.05.2022.
//

import SwiftUI

// TODO: при перевороте чтобы все было красиво
struct ContentView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    NavigationView {
      ScrollView {
        // TODO: adapt 90 to the screen
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
          ForEach(viewModel.cards) { card in
            MemorizeCardView(card: card)
              .onTapGesture {
                viewModel.choose(card)
              }
          }
        }
      }
      .padding()
      .navigationTitle("Memorize!")
    }
  }
}

// TODO: cornerRadius should depend on View size
// TODO: emojy font size should be bigger
struct MemorizeCardView: View {
  let card: MemoryGame<String>.Card
  
  var body: some View {
    let shape = RoundedRectangle(cornerRadius: 25)
    ZStack {
      if card.isFaceUp {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(card.content).font(.largeTitle)
        
      } else if card.isMatched {
        shape.opacity(0)
      } else {
        shape
      }
    }
    .aspectRatio(2/3, contentMode: .fit)
    .foregroundColor(card.color)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    
    ContentView(viewModel: game)
      .previewInterfaceOrientation(.portrait)
  }
}
