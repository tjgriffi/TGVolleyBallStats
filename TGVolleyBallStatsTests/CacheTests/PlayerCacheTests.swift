//
//  PlayerCacheTests.swift
//  TGVolleyBallStatsTests
//
//  Created by Terrance Griffith on 3/31/26.
//

import Testing
@testable import TGVolleyBallStats

struct PlayerCacheTests : ~Copyable {

    // MARK: Basic Tests
    var cache: PlayerCache
    
    init() {
        cache = PlayerCache()
    }
    
    deinit {
        cache.clear()
    }
    
    @Test mutating func playerCacheGet() {
        let player = Player(name: VBSConstants.coreDataPlayerName)
        cache = PlayerCache(cache: [player.id : player])
        
        #expect(cache.get(player.id) == player)
    }

}
