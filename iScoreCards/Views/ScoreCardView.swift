//
//  ScoreCardView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/22/21.
//

import SwiftUI
//import Introspect

private class TextFieldObserver: NSObject {
    @objc
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}



struct ScoreCardView: View {
    @ObservedObject var cardsManager: CardsManager
    @State private var editMode = EditMode.inactive
    @State var needRefresh: Bool = false
    
    private let textFieldObserver = TextFieldObserver()
    
    var column: Int
    var row: Int
    
//    var someNumberProxy: Binding<String> {
//        Binding<String>(
//            get: { String(format: "%.0f", $cardsManager.scores[column][row] as! CVarArg) },
//            set: {
//                if let value = NumberFormatter().number(from: $0) {
//                    //column.append(cardsManager.scores[column][row] = Int(value.int32Value))
//                }
//            }
//        )
//    }
    
//    static var integer: NumberFormatter {
////        let formatter = NumberFormatter()
//        formatter.numberStyle = .none
//        return formatter
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("\(cardsManager.scores)" as String)
                    Text("\(cardsManager.scoreTotals)" as String)
                    Section(header: Text("game score history")){
                        ScoreCardHistoryView(cardsManager: cardsManager)
                            .border(Color.blue)
                    }
                    Section(header: Text("game score totals")){
                        ScoreCardTotalsView(cardsManager: cardsManager)
                            .border(Color.blue)
                        Button("Save game totals", action: cardsManager.saveScores)
                    }
                    ScoreCardPlayersView(cardsManager: cardsManager)
                    List {
                        self.makeGrid()
                    }.frame(maxWidth: .infinity, maxHeight: 200.0)
                    
                    .onAppear(perform: {
                        cardsManager.populateScoreArray()
                        print(cardsManager.scores)
                        print(cardsManager.hands)
                        print(cardsManager.team)
                        print(cardsManager.teamCount())
                        print("ScoreCardView appeared!")
                    })
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("\(cardsManager.name)").font(.largeTitle)
                            Text("Unregistered").font(.subheadline)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Add") {
                            cardsManager.addScoreCardRow()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VStack{
                            Text(Image(systemName: "minus.circle"))
                            Text("Delete Row").font(.subheadline)
                        }
                    }
                }
            }
        }
    }
    
    func makeGrid() -> AnyView {
        return AnyView(
            ForEach(0..<cardsManager.handsCount(), id: \.self) { row in
                
                HStack {
                    Text("\(row + 1)")
                        .padding(.leading)
                        .foregroundColor(.blue)
                        .font(.footnote)
                    
                    ForEach(0..<cardsManager.teamCount(), id: \.self) { column in
                        ScoreCardRowView(column: column, row: row, cardsManager: cardsManager)
                    }
                }
            }
        )
    }
}



struct ScoreCardView_Previews: PreviewProvider {
    static var cardsManager = CardsManager(name: "Test", hands: "8", team: "1,2,3,4", scores: [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]], scoreCardTotals: [0,0,0,0])
    static var previews: some View {
        ScoreCardView(cardsManager: cardsManager, column: 0, row: 0)
    }
}
