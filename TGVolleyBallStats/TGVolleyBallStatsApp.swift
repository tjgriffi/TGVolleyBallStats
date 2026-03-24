//
//  TGVolleyBallStatsApp.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI
import CoreData

@main
struct TGVolleyBallStatsApp: App {
    let storageManager = StorageManager.shared
    
    // MARK: Core Data
    // Need to grab these vales from persistence
    var games: [Game] = [Game.example]
    var player: Player = Player.example
    
    var body: some Scene {
        WindowGroup {
            VolleyballHubView(games: games, player: player)

            // MARK: Core Data
//            MatterListView()
//                .environment(\.managedObjectContext, storageManager.container.viewContext)
            
//            NavigationStack(path: $router.navigationPath) {
//                GameView(gameViewModel: GameViewModel(
//                    players: Player.examples, sets: [set1, set2, set3], gameName: "AirplaneModeIVL"))
//                .navigationDestination(for: Route.self) { route in
//                    switch route {
//                    case .addRally(let onCompletion):
//                        RallyView(playerName: names.first ?? "Player Name", names: names, onCompletion: onCompletion)
//                    case .setDetailView(let setViewModel):
//                        SetView(setViewModel: SetViewModel(rallies: setViewModel.rallies))
//                    case .addSet:
//                        // Create a setdetailView with an empty setDetailViewModel
//                        SetView(setViewModel: SetViewModel(rallies: []))
//                    default:
//                        Circle()
//                    }
//                }
//            }
//            .environment(\.router, router)
        }
    }
}
