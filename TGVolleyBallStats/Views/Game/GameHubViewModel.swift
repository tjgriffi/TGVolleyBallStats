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
    var enableAddGameButton: Bool
    private(set) var gameRepository: GameRepository
    private(set) var playerRepository: PlayerRepository
    
    init(gameRepository: GameRepository, playerRepository: PlayerRepository, enableAddGameButton: Bool = false) {
        self.gameRepository = gameRepository
        self.playerRepository = playerRepository
        self.enableAddGameButton = playerRepository.getPlayers().count > 0
    }
    
    func updateEnableAddGameButton() {
        enableAddGameButton = playerRepository.getPlayers().count > 0
    }
    
    func loadGames() {
        
        // Grab the values from the repository
        games = gameRepository.getGames()
    }
}
