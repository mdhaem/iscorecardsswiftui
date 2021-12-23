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
        return (self.team.components(separatedBy: ",").count)
    }
    
    func players() -> [String] {
        return self.team.components(separatedBy: ",")
    }
    
    func handsCount() -> Int {
     return Int(self.hands)!// ?? 8
    }
    
    func scoreCard() -> [[Int]] {
        //print("teamCount/handsCount", teamCount(), handsCount())
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
    
    func totalScores(oldValue: Int, newValue: Int, row: Int, column: Int) {
        print(oldValue, newValue, row, column)
        var totalScore = self.scoreTotals[column]
        if newValue > 0 && oldValue == 0 {
            totalScore += newValue
        } else if oldValue > 0 && totalScore >= oldValue {
            totalScore -= oldValue
            totalScore += newValue
        }
        
        self.scoreTotals[column] = totalScore
        print(self.scoreTotals[column], totalScore)
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
    
    func saveScores(){
        
    }
    
    
}
