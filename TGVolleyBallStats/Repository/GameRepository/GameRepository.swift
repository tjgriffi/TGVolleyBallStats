//
//  GameRepository.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/28/26.
//

import Foundation
import CoreData

protocol GameRepository {
    func fetchGames()
    func saveGame(_ game: Game)
    func deleteGame(_ game: Game)
}

class CDGameRepository: GameRepository {
    
    private let context: NSManagedObjectContext
    private let cache: any BaseCache<Game>
    
    init(context: NSManagedObjectContext, cache: any BaseCache<Game> = GameCache.shared) {
        self.context = context
        self.cache = cache
    }
    
    func fetchGames() {
        
        let request = CDGame.fetch()
        cache.clear()
        
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
        // TODO: Need to add functionality
    }
    
    func deleteGame(_ game: Game) {
        // TODO: Need to add implementation
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
