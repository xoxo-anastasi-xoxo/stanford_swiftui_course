//
//  MatchMarkersView.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 05/08/2026.
//

import SwiftUI

struct MatchMarkersView: View {
    let model: Matches
    
    var body: some View {
        VStack(alignment: .leading) {
            // + 1 for rounding up
            let middleIndex = (model.total + 1) / 2
            HStack {
                ForEach(0..<middleIndex, id: \.self) { index in
                    makeMarker(index: index)
                }
            }
            HStack {
                ForEach(middleIndex..<(2 * middleIndex), id: \.self) { index in
                    makeMarker(index: index)
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeMarker(index: Int) -> some View {
        let isExact = index < model.exact
        let isFound = index < (model.exact + model.inexact)
        let isEmpty = !isFound && index < model.total
        
        Circle()
            .fill(isExact ? Color.primary : isFound ? Color.secondary : Color.clear)
            .strokeBorder(.secondary, lineWidth: isEmpty ? 5 : 0)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    MatchMarkersView(
        model: Matches(exact: 2, inexact: 1, total: 4)
    )
    MatchMarkersView(
        model: Matches(exact: 0, inexact: 3, total: 5)
    )
    MatchMarkersView(
        model: Matches(exact: 1, inexact: 0, total: 6)
    )
}
