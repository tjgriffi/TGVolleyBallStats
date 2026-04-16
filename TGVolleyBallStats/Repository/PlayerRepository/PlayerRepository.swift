//
//  PlayerRepository.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import Foundation
import CoreData

protocol PlayerRepository {
    func savePlayer(_ name: String) async throws
    func getPlayers(with ids: [UUID]) -> [Player]
    func deletePlayer(withID id: UUID) throws
    func getPlayers() -> [Player]
    func updatePlayer(with player: Player) async throws
    // TODO: Add function to initiate another fetch from the database
}

enum CDRepositoryError: LocalizedError {
    case saveFailed(String)
    case noChanges
    case unknownSaveError(String)
    case issueGrabbingUser
    case unknownDeleteError(String)
    
    var errorDescription: String? {
        switch self {
        case .saveFailed(let string):
            return "Error saving the game: \(string)"
        case .noChanges:
            return "No changes detected"
        case .unknownSaveError(let string), .unknownDeleteError(let string):
            return "Unknown error: \(string)"
        case .issueGrabbingUser:
            return "There was an issue fetching the CDPlayer"
        }
    }
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
    
    nonisolated func savePlayer(_ name: String) async throws {
        // Update the backend
        do {
            let cdPlayer = CDPlayer(name: name, context: context)
            try await storageManager.save()
            
            // Create a player object from the saved DTO (to make sure the UUID of the CDPlayer matches the Player)
            let player = Player(from: cdPlayer)
            
            // Update the cache
            cache.setValue(player)
        } catch let error as StorageManager.StorageManagerError {
            
            switch error {
            case .saveError(let errorString):
                throw CDRepositoryError.saveFailed(errorString)
            case .noChanges:
                throw CDRepositoryError.noChanges
            }
        } catch {
            throw CDRepositoryError.unknownSaveError(error.localizedDescription)
        }
    }
    
    func getPlayers(with ids: [UUID]) -> [Player] {
        
        let players = ids.compactMap { id in
            cache.get(id)
        }
        
        return players
    }
    
    func deletePlayer(withID id: UUID) throws {
        
        // Grab the CDPlayer object
        do {
            let cdPlayer = try fetchCDPlayer(withID: id)
            
            // Remove it from CoreData
            CDPlayer.delete(cdPlayer)
            
            // Remove it from the cache
            cache.remove(id)
        } catch let error as CDRepositoryError {
            throw error
        } catch {
            throw CDRepositoryError.unknownDeleteError(error.localizedDescription)
        }
        
    }
    
    func getPlayers() -> [Player] {
        return cache.getAll()
    }
    
    /// Grab the CDPlayer DTO corresponding to the given UUID
    /// - Parameter id: The UUID of the Player object
    /// - Returns: the CDPlayer object
    private func fetchCDPlayer(withID id: UUID) throws -> CDPlayer {
        
        let request = CDPlayer.fetchRequest()
        
        request.predicate = NSPredicate(format: "uuid_ == %@", id as CVarArg)
        
        do {
            let cdPlayerFetchResult = try context.fetch(request)
            
            guard let cdPlayer = cdPlayerFetchResult.first else {
                
                throw CDRepositoryError.issueGrabbingUser
            }
            
            return cdPlayer
        } catch {
            throw CDRepositoryError.issueGrabbingUser
        }
    }
    
    
    func updatePlayer(with player: Player) async throws {
        
        do {
            // Fetch the cdPlayer object from the backend using the uuid
            let cdPlayer = try fetchCDPlayer(withID: player.id)
            
            // Update the values of the cdPlayer with the values in the given player
            cdPlayer.name = player.name
            
            var last10GameStatsSet = Set<CDPlayerDateStat>()
            player.last10GameStats.forEach { playerDateStat in
                last10GameStatsSet.insert(
                    CDPlayerDateStat(
                        date: playerDateStat.date,
                        digRating: playerDateStat.digRating,
                        passRating: playerDateStat.passRating,
                        killPercentage: playerDateStat.killPercentage,
                        freeBallRating: playerDateStat.freeBallRating,
                        pointScore: playerDateStat.pointScore,
                        context: context))
            }
            
            cdPlayer.playerDateStats = last10GameStatsSet
            
            // Save the updates to the Player
            try await storageManager.save()

        } catch let error as StorageManager.StorageManagerError {
            throw CDRepositoryError.saveFailed(error.localizedDescription)
        } catch let error as CDRepositoryError {
            throw error
        } catch {
            throw CDRepositoryError.unknownSaveError(error.localizedDescription)
        }
    }
}

//import Playgrounds

//#Playground("Update Player") {
//    let cache = PlayerCache()
//    let storageManager = StorageManager.preview
//    let playerRepository = CDPlayerRepository(context: storageManager.container.viewContext, cache: cache)
//    
//    let players = playerRepository.getPlayers()
//    
//    var player = players.first!
//    
//    player.addNewGameStats(stats: Stats.examples, date: Date())
//    let initialPlayer = playerRepository.getPlayers(with: [player.id]).first
//            
//    do {
//        try await playerRepository.updatePlayer(with: player)
//
//        let updatedPlayer = playerRepository.getPlayers(with: [player.id]).first
//    } catch {
//        print(error.localizedDescription)
//    }
//}
