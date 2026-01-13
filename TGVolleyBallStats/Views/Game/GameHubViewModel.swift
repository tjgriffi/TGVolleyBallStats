//
//  GameHubViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/11/26.
//

import Foundation

@Observable
class GameHubViewModel {
    
    var games: [Game]
    
    init(games: [Game] = [Game.example]) {
        self.games = games
    }
}
