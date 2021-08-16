//
//  CardsManager.swift
//  iScoreCards
//
//  Created by Michael DHaem on 5/21/21.
//

import Foundation

class CardsManager: ObservableObject {    
    @Published var name: String
    @Published var hands: String
    @Published var team: String
    @Published var scores: [[Int]]
    @Published var scoreTotals: [Int]
    
    init(name: String, hands: String, team: String, scores: [[Int]], scoreCardTotals: [Int]) {
        self.name = name
        self.hands = hands
        self.team = team
        self.scores = scores
        self.scoreTotals = scoreCardTotals
    }
    
    func teamCount() -> Int {
        return self.team.components(separatedBy: ",").count
    }
    
    func players() -> [String] {
        return self.team.components(separatedBy: ",")
    }
    
    func handsCount() -> Int {
        return Int(self.hands) ?? 8
    }
    
    func scoreCard() -> [[Int]] {
        return Array(repeating: Array(repeating: 0, count: teamCount()), count: handsCount())
    }
    
    func scoreCardTotals() -> [Int] {
        return Array(repeating: 0, count: teamCount())
    }
    
    func formComplete() -> Bool {
        return self.name.count < 3 || self.hands.isEmpty ||  self.team.components(separatedBy: ",").count < 2
    }
    
    func populateScoreArray() {
        self.scores = self.scoreCard()
        self.scoreTotals = self.scoreCardTotals()
    }
    
    func totalScores(value: Int, row: Int, column: Int) {
        print("\(value)  row:\(row)  column:\(column)")
        var totalScore = Int(self.scoreTotals[row])
        totalScore += value
        self.scoreTotals[row] = totalScore
    }
    
    func adjustTotalScores(value: Int, row: Int, column: Int) {
        if value != 0 {
            self.scoreTotals[row] -= value
        }
    }
    
    func addScoreCardRow() {
        scores.append(Array(repeating: 0, count: teamCount()))
    }
    
    func deleteScoreCardRow() {
        
    }
    
    func sumScores(row: Int, column: Int) {
        
        //Compute column-wise sum
//        for (int i = 0; i < cols; i++) {
//            int cSum = 0;
//            for (int j = 0; j < rows; j++) {
//                cSum += arr[j][i];
//            }
//            System.out.println("Column " + (i + 1) + " sum = " + cSum);
//        }
        
    
        self.scores.forEach {item in
            print("\(item)")
            print("column:\(column)")
            print("row:\(row)")
            self.scoreTotals[column] += item[column]
            print("totals: \(self.scoreTotals)")
        }
    }
    
}
