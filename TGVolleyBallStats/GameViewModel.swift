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

class GameViewModel: ObservableObject {
    
    private(set) var playerNames: [String]
    @Published private(set) var sets: [VolleyBallSet]
    private(set) var gameName: String
    
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
}
