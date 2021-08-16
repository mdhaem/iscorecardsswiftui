//
//  ScoreCardView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/22/21.
//

import SwiftUI
import Introspect

private class TextFieldObserver: NSObject {
    @objc
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}



struct ScoreCardView: View {
    @ObservedObject var cardsManager: CardsManager
    @State private var editMode = EditMode.inactive
    
    private var addButton: some View {
            switch editMode {
            case .inactive:
                return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    func onAdd() {
        ScoreCardRowView(column: column, row: row, cardsManager: cardsManager)

        }
    
    private let textFieldObserver = TextFieldObserver()
    
    var column: Int
    var row: Int
    
    var someNumberProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.0f", $cardsManager.scores[column][row] as! CVarArg) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    //column.append(cardsManager.scores[column][row] = Int(value.int32Value))
                }
            }
        )
    }
    
    static var integer: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("\(cardsManager.scores)" as String)
                    //                    Text("\(cardsManager.scoreTotals)" as String)
                    
                    Section(header: Text("game score totals")){
                        ScoreCardTotalsView(cardsManager: cardsManager)
                            .border(Color.blue)
                    }
                    ScoreCardPlayersView(cardsManager: cardsManager)
                    List {
                        ForEach(0..<cardsManager.handsCount(), id: \.self) { row in
                                                        
                            HStack {
                                Text("\(column + 1)")
                                    .padding(.leading)
                                    .foregroundColor(.blue)
                                    .font(.footnote)
                                
                                ForEach(0..<cardsManager.teamCount(), id: \.self) { column in
                                    ScoreCardRowView(column: column, row: row, cardsManager: cardsManager)
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 200.0)
                    
                    .onAppear(perform: {
                        //cardsManager.populateScoreArray()
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
                    ToolbarItem(placement: .navigationBarLeading) { self.addButton
                        
//                        VStack{
////                            Text(Image(systemName: "plus.circle"))
////                            Text("Add Row").font(.subheadline)
//                        }
                        
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
}



//struct ScoreCardView_Previews: PreviewProvider {
//    static var cardsManager = CardsManager(name: "Test", hands: "8", team: "1,2,3,4", score: [[0,0,0,0], [0,00,0,0,0], [0,0,0,0]], scoreCardTotals: ["0","0","0","0"])
//    static var previews: some View {
//        ScoreCardView(cardsManager: cardsManager)
//    }
//}
