//
//  MatchMarkersView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 05/08/2026.
//

import SwiftUI

struct MatchMarkersModel {
    let exact: Int
    let inexact: Int
    let total: Int
}

struct MatchMarkersView: View {
    let model: MatchMarkersModel
    
    var body: some View {
        VStack {
            // + 1 for rounding up
            let middleIndex = (model.total + 1) / 2
            HStack {
                ForEach(0..<middleIndex, id: \.self) { index in
                    makeMarker(index: index)
                }
            }
            HStack {
                ForEach(middleIndex..<model.total, id: \.self) { index in
                    makeMarker(index: index)
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeMarker(index: Int) -> some View {
        let isExact = index < model.exact
        let isFound = index < (model.exact + model.inexact)
        
        Circle()
            .fill(isExact ? Color.primary : isFound ? Color.secondary : Color.clear)
//            .strokeBorder(.secondary, lineWidth: isFound ? 0 : 5)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    MatchMarkersView(
        model: MatchMarkersModel(exact: 2, inexact: 1, total: 4)
    )
}
