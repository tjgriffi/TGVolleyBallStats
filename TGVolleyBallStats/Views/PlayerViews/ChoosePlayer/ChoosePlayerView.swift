//
//  ChoosePlayerView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import SwiftUI

struct ChoosePlayerView: View {
    
    @State var choosePlayerVM: ChoosePlayerVM
    
    var body: some View {
        List(choosePlayerVM.players) { player in
            NavigationLink {
                PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
            } label: {
                Text(player.name)
            }
        }
        .task {
            choosePlayerVM.getPlayers()
        }
    }
}

#Preview {
    NavigationStack {
        ChoosePlayerView(
            choosePlayerVM: ChoosePlayerVM(playerRepository: CDPlayerRepository(
                context: StorageManager.preview.container.viewContext)
            ))
            .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
    }
}
