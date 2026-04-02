//
//  GameRepository.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/28/26.
//

import Foundation
import CoreData

protocol GameRepository {
    func saveGame(_ game: Game)
    func getGame(with id: UUID) -> Game?
    func deleteGame(withID id: UUID)
    func getGames() -> [Game]
}

class CDGameRepository: GameRepository {
  
    private let storageManager: StorageManager
    private let cache: any BaseCache<Game>
    
    init(
        storageManager: StorageManager = StorageManager.shared,
        cache: any BaseCache<Game> = GameCache.shared) {
        self.storageManager = storageManager
        self.cache = cache
        
            // Initial setup
            fetchGames()
    }
    
    private func fetchGames() {
        
        let request = CDGame.fetch()
        cache.clear()
        
        let context = storageManager.container.viewContext
        
        do {
            let cdGames = try context.fetch(request)
            
            cdGames.forEach { cdGame in
                                
                let game = Game(from: cdGame)
                
                cache.setValue(game)
            }
            
            return
        } catch {
            print("CDGameRepository: fetchGames error: \(error)")
        }
        return
    }
    
    func saveGame(_ game: Game) {
        
        // Update the backend
        let cdGame = CDGame(date: game.date, context: storageManager.container.viewContext)
        storageManager.save()
        
        // Create a game for the local cache
        let game = Game(from: cdGame)
        
        cache.setValue(game)
    }
    
    func getGame(with id: UUID) -> Game? {
        
        return cache.get(id)
    }
    
    func deleteGame(withID id: UUID) {
        // Grab the cdGame object
        guard let cdGame = fetchCDGame(withID: id) else {
            print("deleteGame: No game object to delete")
            return
        }
        
        // Remove it from CoreData
        CDGame.delete(cdGame)
        
        // Remove it from the cache
        cache.remove(id)
    }
    
    func getGames() -> [Game] {
        return cache.getAll()
    }
    
    // MARK: Helper functions
    
    /// Grabs the CDGame DTO that corresponds to the given UUID
    /// - Parameter id: The UUID of the Game object
    /// - Returns: the CDGame DTO
    private func fetchCDGame(withID id: UUID) -> CDGame? {
        
        let request = CDGame.fetchRequest()
        
        request.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        
        do {
            let cdGame = try storageManager.container.viewContext.fetch(request)
            
            if cdGame.count > 1 {
                // MARK: Need to add proper error handling
                print("fetchCDGame: Error there is more than one CDGame with this uuid: \(id)")
            }
            
            return cdGame.first
        } catch {
            // MARK: Need to add proper error handling
            print("fetchCDGame: Error grabbing the CDGame object \(error)")
        }
        
        return nil
    }
}

//import Playgrounds
//
//#Playground {
//    let cache = GameCache()
//    let storageManager = StorageManager.preview
//    let gameRepository = CDGameRepository(context: storageManager.container.viewContext, cache: cache)
//    
//    gameRepository.fetchGames()
//}
