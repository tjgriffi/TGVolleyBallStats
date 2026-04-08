//
//  VolleyBallHubVM.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 4/6/26.
//

import Foundation

class VolleyBallHubVM {
    
    var playerRepository: PlayerRepository
    var gameRepository: GameRepository
    
    init(playerRepository: PlayerRepository, gameRepository: GameRepository) {
        self.playerRepository = playerRepository
        self.gameRepository = gameRepository
    }
}
