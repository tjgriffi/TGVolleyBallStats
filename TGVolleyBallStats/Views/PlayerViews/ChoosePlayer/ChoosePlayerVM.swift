//
//  ChoosePlayerVM.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/26/26.
//

import Foundation

@Observable
class ChoosePlayerVM {
    
    enum ChoosePlayerVMState: Equatable {
        case initial
        case empty
        case loading
        case loaded
        case error(String)
    }
    
    private(set) var players: [Player]
    private(set) var playerRepositry: PlayerRepository
    private(set) var state: ChoosePlayerVMState
    
    init(players: [Player] = [],
         playerRepository: PlayerRepository,
         state: ChoosePlayerVMState = .initial) {
        self.players = players
        self.playerRepositry = playerRepository
        self.state = state
    }
    
    // Fetch the players through the repository
    func getPlayers() {
        players = playerRepositry.getPlayers()
        state = players.isEmpty ? .empty : .loaded
    }
}
