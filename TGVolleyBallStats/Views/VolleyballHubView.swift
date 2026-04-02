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
    
    var body: some View {
        TabView {
            Tab("Games", systemImage: "volleyball") {
                NavigationStack {
                    GameHubView(
                        gameHubViewModel: GameHubViewModel(
                            gameRepository: CDGameRepository(
                                storageManager: storageManager))
                    )
                }
            }
            Tab("Player", systemImage: "figure.volleyball") {
                NavigationStack{
                    ChoosePlayerView(choosePlayerVM: ChoosePlayerVM(playerRepository: CDPlayerRepository(context: context)))
                }
            }
        }
    }
}

#Preview {
    VolleyballHubView()
        .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
        .environment(\.storageManager, StorageManager.preview)
}
