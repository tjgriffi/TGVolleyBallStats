//
//  PlayerRepository.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import Foundation
import CoreData

protocol PlayerRepository {
    func fetchPlayers() -> [Player]
    func savePlayer(_ player: Player)
}

class CDPlayerRepository: PlayerRepository {
    
    private let context: NSManagedObjectContext
    private let playerDateStatRepository: CDPlayerDateStatRepository
    
    init(context: NSManagedObjectContext, playerDateStatRepository: CDPlayerDateStatRepository? = nil) {
        self.context = context
        
        // Have a default playerDateStatRepository for dependency injection
        self.playerDateStatRepository = playerDateStatRepository ?? CDPlayerDateStatRepository(context: context)
    }
    
    func fetchPlayers() -> [Player] {

        let request = CDPlayer.fetch()
        
        do {
            let cdPlayers = try context.fetch(request)
            
            var players = [Player]()
            
            cdPlayers.forEach { cdPlayer in

                // Grab the stats for this player
                cdPlayer.playerDateStats = playerDateStatRepository.fetchPlayerDateStats(for: cdPlayer)
                
                // Creates the player instance
                let player = Player(from: cdPlayer)
                
                players.append(player)
            }
            
            return players
        } catch {
            print("CDPlayerRepository: fetchPlayers: Error fetching the players: \(error)")
        }
        
        // TODO: Need to signify that somethings has gone wrong here (but the error might already do that for us)
        return []
    }
    
    func savePlayer(_ player: Player) {
        // TODO: Implementation
    }
}

protocol PlayerDateStatRepository {
//    func fetchPlayerDateStats(for player: CDPlayer) -> [PlayerDateStats]
    func fetchPlayerDateStats(for player: CDPlayer) -> Set<CDPlayerDateStat>
    func savePlayerDateStats(of playerDateStats: PlayerDateStats, to player: CDPlayer)
}

class CDPlayerDateStatRepository: PlayerDateStatRepository {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchPlayerDateStats(for player: CDPlayer) -> Set<CDPlayerDateStat>/*[PlayerDateStats]*/ {
        let request = CDPlayerDateStat.fetchRequest()
        
        // Setup the predicate to look at the stats for only the given player
        request.predicate = NSPredicate(format: "player_ == %@", player as CVarArg)
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDPlayerDateStat.date_, ascending: true)]
        
        // Make the request
        
        do {
            let result = try context.fetch(request)
            
            // MARK: See if this commented code is still needed.  It was commented out since we wanted to grab the stats for the player and tie them directly to the Data Transfer object instead of the Model used in the UI
//            var stats = [PlayerDateStats]()
//            result.forEach { stat in
//                stats.append(
//                    PlayerDateStats(
//                        date: stat.date,
//                        killPercentage: stat.killPercentage,
//                        passRating: stat.passRating,
//                        freeBallRating: stat.freeBallRating,
//                        digRating: stat.digRating,
//                        pointScore: stat.pointScore)
//                    )
//            }
            
            return Set(result)
            
        } catch {
            print("Error loading the player date stats for \(player.name), error: \(error)")
        }
        
        return []
    }
    
    func savePlayerDateStats(of playerDateStats: PlayerDateStats, to player: CDPlayer) {
        // TODO: Implementation
    }
}
