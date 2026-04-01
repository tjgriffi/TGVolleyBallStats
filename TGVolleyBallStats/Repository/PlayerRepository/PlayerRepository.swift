//
//  PlayerRepository.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import Foundation
import CoreData

protocol PlayerRepository {
    func savePlayer(_ name: String)
    func getPlayers(with ids: [UUID]) -> [Player]
}

class CDPlayerRepository: PlayerRepository {
    
    private let context: NSManagedObjectContext
    private let storageManager: StorageManager
    
    private var cache: any BaseCache<Player>
    
    init(context: NSManagedObjectContext,
         cache: any BaseCache<Player> = PlayerCache.shared,
         storageManager: StorageManager = StorageManager.shared) {
        self.context = context
        
        // Have a default playerDateStatRepository for dependency injection
        self.cache = cache
        self.storageManager = storageManager
        
        // Initial setup
        fetchPlayers()
    }
    
    private func fetchPlayers() {

        let request = CDPlayer.fetch()
        
        do {
            let cdPlayers = try context.fetch(request)
            
            cache.clear()
            
            cdPlayers.forEach { cdPlayer in

                // Grab the stats for this player
//                cdPlayer.playerDateStats = playerDateStatRepository.fetchPlayerDateStats(for: cdPlayer)
                
                // Creates the player instance
                let player = Player(from: cdPlayer)
                
                cache.setValue(player)
            }
            
            return
        } catch {
            print("CDPlayerRepository: fetchPlayers: Error fetching the players: \(error)")
        }
        
        // TODO: Need to signify that somethings has gone wrong here (but the error might already do that for us)
        self.cache.clear()
    }
    
    func savePlayer(_ name: String) {
        // Update the backend
        let cdPlayer = CDPlayer(name: name, context: context)
        storageManager.save()
        
        // Create a player object from the saved DTO (to make sure the UUID of the CDPlayer matches the Player)
        let player = Player(from: cdPlayer)
        
        // Update the cache
        cache.setValue(player)
    }
    
    func getPlayers(with ids: [UUID]) -> [Player] {
        
        let players = ids.compactMap { id in
            cache.get(id)
        }
        
        return players
    }
}
//
//import Playgrounds
//
//#Playground {
//    let cache = PlayerCache()
//    let storageManager = StorageManager.preview
//    let playerRepository = CDPlayerRepository(context: storageManager.container.viewContext, cache: cache)
//}
