//
//  ContentView.swift
//  Memorize
//
//  Created by Anastasia Kazantseva on 01.05.2022.
//

import SwiftUI

// TODO: сделать нормально.
let natureEmojies = [
  "🐬", "🪴", "🐳", "🌷", "🐥",
  "🌈", "🦚", "🐞", "🌳", "🦋",
  "☀️", "🐶", "🐠", "🌲", "🐘"
]
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

enum MemorizeCardSetTheme {
  case nature([String])
  case food([String])
  case vehicles([String])
  
  var id: String {
    switch self {
    case .nature: return "Nature"
    case .vehicles: return "Vehicles"
    case .food: return "Food"
    }
  }
  var systemImage: String {
    switch self {
    case .nature: return "globe.europe.africa"
    case .vehicles: return "car.2"
    case .food: return "cup.and.saucer"
    }
  }
  var color: Color {
    switch self {
    case .nature: return .green
    case .vehicles: return .red
    case .food: return .purple
    }
  }
  var emojies: [String] {
    switch self {
    case let .nature(arr): return arr
    case let .vehicles(arr): return arr
    case let .food(arr): return arr
    }
  }
}

// TODO: при перевороте
struct ContentView: View {
  @State var shownCardsCount = 6
  @State var theme: MemorizeCardSetTheme = .nature(natureEmojies.shuffled())
  
  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          // TODO: adapt 90 to the screen
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(theme.emojies[0..<shownCardsCount], id: \.self) {
              MemorizeCardView(content: $0, color: theme.color)
            }
          }
        }
        Spacer()
        // TODO: move to property menu
        HStack {
          Button("Remove card", action: {
            if shownCardsCount > 0 { shownCardsCount -= 1 }
          })
          Spacer()
          // TODO: disabledView
          Button("Add card", action: {
            if shownCardsCount < theme.emojies.count { shownCardsCount += 1 }
          })
        }
        .padding(.horizontal)
      }
      .padding()
      .navigationTitle("Memorize!")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Menu {
            Button(action: { theme = .nature(natureEmojies.shuffled()) }) {
              Label("Nature", systemImage: "globe.europe.africa")
            }
            Button(action: { theme = .food(foodEmojies.shuffled()) }) {
              Label("Food", systemImage: "cup.and.saucer")
            }
              Button(action: { theme = .vehicles(vehiclesEmojies.shuffled()) }) {
              Label("Vehicles", systemImage: "car.2")
            }
          }
        label: {
          Label("Sort", systemImage: "paintbrush.pointed")
        }
        }
      }
    }
  }
}

// TODO: cornerRadius should depend on View size
// TODO: emojy font size should be bigger
struct MemorizeCardView: View {
  let content: String
  let color: Color
  
  @State var isFaceUp = false
  
  var body: some View {
    let shape = RoundedRectangle(cornerRadius: 25)
    ZStack {
      if isFaceUp {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(content).font(.largeTitle)
        
      } else {
        shape
      }
    }
    .aspectRatio(2/3, contentMode: .fit)
    .foregroundColor(color)
    .onTapGesture {
      isFaceUp.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewInterfaceOrientation(.portrait)
  }
}
