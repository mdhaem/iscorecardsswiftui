//
//  ScoreCardRowView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 7/8/21.
//

import SwiftUI
import Introspect

private class TextFieldObserver: NSObject {
    @objc
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}

struct ScoreCardRowView: View {
    var column: Int
    var row: Int
    
    @ObservedObject var cardsManager: CardsManager
    private let textFieldObserver = TextFieldObserver()
    
    var someNumberProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.0f", $cardsManager.scores[column][row] as! CVarArg) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    cardsManager.scores[column][row] = Int(value.int32Value)
                }
            }
        )
    }
    
    var body: some View {
        TextField(
            "0",
            value: $cardsManager.scores[row][column],
            formatter: ScoreCardView.integer
        )
        .introspectTextField { textField in
            textField.addTarget(
                self.textFieldObserver,
                action: #selector(TextFieldObserver.textFieldDidBeginEditing),
                for: .editingDidBegin
            )
        }
        .onChange(of: cardsManager.scores[column][row]) { value in
            print(value)
            cardsManager.totalScores(value: value, row: row, column: column)
            //cardsManager.sumScores(row: row, column: column)
        }
        .onTapGesture(count: 1, perform: {
            print("Tapped!")
            let value = cardsManager.scores[column][row]
            cardsManager.adjustTotalScores(value: value, row: row, column: column)
        })
        .fixedSize()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        //.padding(.leading)
        .padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0))
        Spacer()
    }
}

struct ScoreCardRowView_Previews: PreviewProvider {
    static var cardsManager = CardsManager(name: "Test", hands: "8", team: "1,2,3,4", scores: [[0,0,0,0], [0,0,0,0],[0,0,0,0], [0,0,0,0]], scoreCardTotals: [0,0,0,0])
    static var previews: some View {
        ScoreCardRowView(column: 0, row: 1, cardsManager: cardsManager)
    }
}
