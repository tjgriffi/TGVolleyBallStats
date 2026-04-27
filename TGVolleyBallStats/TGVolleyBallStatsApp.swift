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
    private var storageManager = StorageManager.shared
    
    var body: some Scene {
        WindowGroup {
            VolleyballHubView(volleyBallHubVM: VolleyBallHubVM(
                playerRepository: CDPlayerRepository(),
                gameRepository: CDGameRepository()))
                .environment(\.managedObjectContext, storageManager.container.viewContext)
                .environment(\.storageManager, storageManager)
        }
    }
}
