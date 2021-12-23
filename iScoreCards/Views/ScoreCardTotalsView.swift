//
//  ScoreCardTotalsView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 6/6/21.
//

import SwiftUI

struct ScoreCardTotalsView: View {
    @ObservedObject var cardsManager: CardsManager
    
    var body: some View {
        HStack {
            ForEach(0..<cardsManager.teamCount(), id: \.self) { column in
                TextField(
                    "0",
                    //text: $cardsManager.scoreTotals[column]
                    value: $cardsManager.scoreTotals[column],
                    formatter: ScoreCardRowView.integer
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0))
                Spacer()
            }
        }
    }
}

struct ScoreCardTotalsView_Previews: PreviewProvider {
    static var cardsManager = CardsManager(name: "Test", hands: "8", team: "1,2,3,4", scores: [[0,0,0,0], [0,0,0,0],[0,0,0,0], [0,0,0,0]], scoreCardTotals: [0,0,0,0])
    
    static var previews: some View {
        ScoreCardTotalsView(cardsManager: cardsManager)
    }
}
