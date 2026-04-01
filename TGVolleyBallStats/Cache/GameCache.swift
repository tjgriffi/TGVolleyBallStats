//
//  GameCache.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/31/26.
//

import Foundation

class GameCache: BaseCache {
        
    typealias T = Game
    
    static let shared = GameCache()
//    private var gameRepository: GameRepository
    private var cache: [UUID: Game]
    
    init(
//        gameRepository: GameRepository = CDGameRepository(context: StorageManager.shared.container.viewContext),
        cache: [UUID : Game] = [:]) {
//        self.gameRepository = gameRepository
        self.cache = cache
    }
    
    func get(_ id: UUID) -> Game? {
        return cache[id]
    }
    
    func setValue(_ value: Game) {
        cache[value.id] = value
    }
        
    func remove(_ key: UUID) {
        cache.removeValue(forKey: key)
    }
    
    func clear() {
        cache.removeAll()
    }
}
