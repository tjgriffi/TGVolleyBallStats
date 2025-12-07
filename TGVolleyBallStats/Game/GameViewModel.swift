//
//  GameViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/25/25.
//

import Foundation

class VolleyBallSet: Identifiable {
    private(set) var rallies: [Rally]
    private(set) var id = UUID()
    
    init(rallies: [Rally]) {
        self.rallies = rallies
    }
}

@Observable class GameViewModel {
    
    private(set) var playerNames: [String]
    @Published private(set) var sets: [VolleyBallSet]
    private(set) var gameName: String
    
//    static var preview: GameViewModel {
//        
//        return GameViewModel(playerNames: <#T##[String]#>, sets: <#T##[VolleyBallSet]#>, gameName: "Preview")
//    }
    
    init(playerNames: [String],
         sets: [VolleyBallSet],
         gameName: String) {
        self.playerNames = playerNames
        self.sets = sets
        self.gameName = gameName
    }
    
    func addSet(set: VolleyBallSet) {
        sets.append(set)
    }
    
    func getSetScores(for set: VolleyBallSet) -> RallyFinalScore {
        
        var homeScore = 0
        var awayScore = 0
        
        set.rallies.forEach { rally in
            if rally.point == 0 {
                awayScore += 1
            } else {
                homeScore += 1
            }
        }
        
        let rallyFinalScore = RallyFinalScore(home: homeScore,away: awayScore)
        
        return rallyFinalScore
    }
}
