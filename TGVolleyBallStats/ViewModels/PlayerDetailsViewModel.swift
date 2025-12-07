//
//  PlayerDetailsViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import Foundation

@Observable class PlayerDetailsViewModel {
    
    let player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    static var preview: PlayerDetailsViewModel {
        PlayerDetailsViewModel(player: Player.example)
    }
    
    var killPercentage: String? {
        generatePercentage(player.killPercentage)
    }
    
    var passRatingPercentage: String? {
        generatePercentage(player.passRating)
    }
    
    var digRatingPercentage: String? {
        generatePercentage(player.digRating)
    }
    
    var freeballRatingPercentage: String? {
        generatePercentage(player.freeBallRating)
    }
    
    var pointsScored: String {
        String(player.pointScore)
    }
    
    func generatePercentage(_ value: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: value)) else {
            return nil
        }
        
        return formattedPercentage
    }
    
}
