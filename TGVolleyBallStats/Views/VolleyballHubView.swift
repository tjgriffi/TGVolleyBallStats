//
//  VolleyballHubView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/9/26.
//

import SwiftUI

struct VolleyballHubView: View {
    
    var games: [Game]
    var player: Player
    
    var body: some View {
        TabView {
            Tab("Games", systemImage: "volleyball") {
                GameHubView(gameHubViewModel: GameHubViewModel(games: games))
            }
            Tab("Player", systemImage: "figure.volleyball") {
                PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
            }
        }
    }
}

#Preview {
    VolleyballHubView(games: [Game.example], player: Player.example)
}
