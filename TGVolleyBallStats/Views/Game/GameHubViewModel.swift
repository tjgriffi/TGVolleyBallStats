//
//  GameHubViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/11/26.
//

import Foundation

@Observable
class GameHubViewModel {
    
    var games = [Game]()
    private var gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
    func loadGames() {
        
        // Grab the values from the repository
        games = gameRepository.getGames()
    }
}
