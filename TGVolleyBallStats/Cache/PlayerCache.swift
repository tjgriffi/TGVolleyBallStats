//
//  PlayerCache.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/31/26.
//
import Foundation
import CoreData

class PlayerCache: BaseCache {
    
    typealias T = Player
    
    static let shared = PlayerCache()
//    private var playerRepository: PlayerRepository
    private var cache: [UUID: Player]/*NSCache<NSString, Player>*/
    
    init(
//        playerRepository: PlayerRepository = CDPlayerRepository(context: StorageManager.shared.container.viewContext),
        cache: [UUID: Player] = [:]/*NSCache<NSString, Player> = NSCache<NSString, Player>()*/) {
        
//        self.playerRepository = playerRepository
        self.cache = cache
    }
    
    func get(_ id: UUID) -> Player? {
        return cache[id]/*cache.object(forKey: id.uuidString as NSString)*/
    }
    
    func clear() {
        cache.removeAll()
    }
    
    func setValue(_ value: Player) {
        cache[value.id] = value
    }
    
    func remove(_ key: UUID) {
        cache.removeValue(forKey: key)
    }
}
