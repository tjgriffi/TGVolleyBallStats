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
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        TabView {
            Tab("Games", systemImage: "volleyball") {
                NavigationStack {
                    GameHubView(gameHubViewModel: GameHubViewModel(games: games))
                }
            }
            Tab("Player", systemImage: "figure.volleyball") {
//                PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
                NavigationStack{
                    ChoosePlayerView(choosePlayerVM: ChoosePlayerVM(playerRepository: CDPlayerRepository(context: context)))
                }
            }
        }
    }
}

#Preview {
    VolleyballHubView(games: [Game.example], player: Player.example)
        .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
}
