//
//  ContentView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/18/21.
//

import SwiftUI

struct iScoreCardsView: View {
    @ObservedObject var cardsManager: CardsManager
    //@State  var score: [[String]]
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem { Label( "Home", systemImage: "house.circle") }
                .tag(1)
            UnregisteredGameSetupView(cardsManager: cardsManager)
                .tabItem { Label( "Unregister Play", systemImage: "rectangle.stack.person.crop") }
                .tag(2)
            SecondTabView()
                .tabItem { Label( "Register Play/Login", systemImage: "rectangle.stack.person.crop.fill")}
                .tag(3)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var cardsManager: CardsManager = CardsManager(name: "", hands: "", team: "", score: [["0","0","0","0"], ["0","0","0","0"]], scoreCardTotals: ["0","0","0","0"])
//    @State static var score: [[String]] = [["0","0","0","0"], ["0","0","0","0"]]
//    static var previews: some View {
//        iScoreCardsView(cardsManager: cardsManager)
//    }
//}
