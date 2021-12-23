//
//  FirstTabView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/18/21.
//

import SwiftUI
import Combine

struct UnregisteredGameSetupView: View {
    @ObservedObject var cardsManager: CardsManager
    @State private var shouldShow = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("enter name of game")) {
                        TextField("Game Name", text: $cardsManager.name)
                    }
                    
                    Section(header: Text("enter the number of hands expected in game"))  {
                        TextField("Total number of hands", text: $cardsManager.hands)
                        .onReceive(Just(cardsManager.hands)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                cardsManager.hands = filtered
                            }
                        }
                    }
                    
                    Section(header: Text("enter players first names separated by a comma")) {
                        TextField("Players", text: $cardsManager.team)
                    }.onChange(of: cardsManager.team, perform: { value in
                        cardsManager.populateScoreArray()
                    })
                    
                    
                    NavigationLink(destination: ScoreCardView(cardsManager: cardsManager, column: 0, row: 0), isActive: $shouldShow) {
                        Button("ScoreCard", action: cardsManager.populateScoreArray)
                    }.disabled(cardsManager.formComplete())
                    
                }
                .navigationBarTitleDisplayMode(.large)
                .toolbar { 
                    ToolbarItem(placement: .principal) { 
                        VStack {
                            Text("Game Setup").font(.largeTitle)
                            Text("Unregistered").font(.subheadline)
                        }.padding()
                    }
                }
            }
        }
    }
}



//struct UnregisteredGameSetupView_Previews: PreviewProvider {
//    static var cardsManager = CardsManager(name: "", hands: "", team: "", score: [["0","0","0","0"], ["0","0","0","0"],["0","0","0","0"], ["0","0","0","0"]], scoreCardTotals: ["0","0","0","0"])
//    //@State static var score: [[String]] = [["0","0","0","0"], ["0","0","0","0"]]
//    static var previews: some View {
//        UnregisteredGameSetupView(cardsManager: cardsManager)
//    }
//}

