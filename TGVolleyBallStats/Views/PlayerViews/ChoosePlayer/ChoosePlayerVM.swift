//
//  ChoosePlayerVM.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/26/26.
//

import Foundation

@Observable
class ChoosePlayerVM {
    
    private(set) var players: [Player]
    private var playerRepositry: PlayerRepository
    
    init(players: [Player] = [],
         playerRepository: PlayerRepository) {
        self.players = players
        self.playerRepositry = playerRepository
    }
    
    // Fetch the players through the repository
    func getPlayers() {
        players = playerRepositry.fetchPlayers()
    }
}
