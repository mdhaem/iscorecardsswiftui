//
//  ScoreCardPlayersView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 6/6/21.
//

import SwiftUI

struct ScoreCardPlayersView: View {
    @ObservedObject var cardsManager: CardsManager
    
    var body: some View {
        HStack {
            Text("Hand:").font(.footnote)
                .foregroundColor(.blue)
            ForEach(cardsManager.players(), id: \.self) { player in
                Text(player)
                    .padding(.leading)
                Spacer()
            }
        }
    }
}

struct ScoreCardPlayersView_Previews: PreviewProvider {
    static var cardsManager = CardsManager(name: "Test", hands: "8", team: "Bill,Bev,Mike,Sandy", scores: [[0,0,0,0], [0,0,0,0],[0,0,0,0], [0,0,0,0]], scoreCardTotals: [0,0,0,0])
    
    static var previews: some View {
        ScoreCardPlayersView(cardsManager: cardsManager)
    }
}
