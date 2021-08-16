//
//  iScoreCardsApp.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/18/21.
//

import SwiftUI

@main
struct iScoreCardsApp: App {
    @State var score: [[Int]] = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
    var body: some Scene {
        WindowGroup {
            iScoreCardsView(cardsManager: CardsManager(name: "", hands: "", team: "", scores: score, scoreCardTotals: [0,0,0,0]))
        }
    }
}
