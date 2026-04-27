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
    private var cache: [UUID: Player]
    
    init(cache: [UUID: Player] = [:]) {
        
        self.cache = cache
    }
    
    func get(_ id: UUID) -> Player? {
        return cache[id]
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
    
    func getAll() -> [Player] {
        return Array(cache.values)
    }
}
