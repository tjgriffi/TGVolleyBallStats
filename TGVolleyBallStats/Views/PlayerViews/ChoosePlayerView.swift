//
//  ChoosePlayerView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import SwiftUI

struct ChoosePlayerView: View {
    
    private var players: [Player] = Player.examples
    
    var body: some View {
        List(players) { player in
            NavigationLink {
                PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
            } label: {
                Text(player.name)
            }

        }
    }
}

#Preview {
    NavigationView {
        ChoosePlayerView()
    }
}
