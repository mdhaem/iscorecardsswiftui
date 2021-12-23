//
//  ScoreCardHistoryView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 9/12/21.
//

import SwiftUI

struct ScoreCardHistoryView: View {
    @ObservedObject var cardsManager: CardsManager
    
    var body: some View {
        HStack {
            ForEach(cardsManager.players(), id: \.self) { player in
                Text(player)
                    //.padding(.leading)
                    .padding(EdgeInsets(top: 7, leading: 22, bottom: 7, trailing: 0))

                Spacer()
            }
        }
    }
}



struct ScoreCardHistoryView_Previews: PreviewProvider {
    static var cardManager = CardsManager(name: "test", hands: "3", team: "1,2,3,4", scores: [[0,0,0]], scoreCardTotals: [0,0,0])
    static var previews: some View {
        ScoreCardHistoryView(cardsManager: cardManager)
    }
}
