//
//  VolleyballHubView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/9/26.
//

import SwiftUI

struct VolleyballHubView: View {
    
//    var games: [Game]
//    var player: Player
    @Environment(\.storageManager) var storageManager
    
    @Environment(\.managedObjectContext) var context
    var volleyBallHubVM: VolleyBallHubVM
    
    var body: some View {
        TabView {
            Tab("Games", systemImage: "volleyball") {
                NavigationStack {
                    GameHubView(
                        gameHubViewModel: GameHubViewModel(
                            gameRepository: volleyBallHubVM.gameRepository,
                            playerRepository: volleyBallHubVM.playerRepository)
                    )
                }
            }
            Tab("Player", systemImage: "figure.volleyball") {
                NavigationStack{
                    ChoosePlayerView(
                        choosePlayerVM: ChoosePlayerVM(
                            playerRepository: volleyBallHubVM.playerRepository)
                    )
                }
            }
        }
    }
}

#Preview {
    VolleyballHubView(
        volleyBallHubVM: VolleyBallHubVM(
            playerRepository: CDPlayerRepository(
                context: StorageManager.preview.container.viewContext,
                cache: PlayerCache(),
                storageManager: StorageManager.preview),
            gameRepository: CDGameRepository(
                storageManager: .preview,
                cache: GameCache()))
    )
        .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
        .environment(\.storageManager, StorageManager.preview)
}
