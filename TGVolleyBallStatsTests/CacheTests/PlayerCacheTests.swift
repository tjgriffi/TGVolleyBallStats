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
    
    @Test mutating func player_cache_returns_player_given_id() {
        let player = Player(name: VBSConstants.coreDataPlayerName1)
        cache = PlayerCache(cache: [player.id : player])
        
        #expect(cache.get(player.id) == player)
    }
    
    @Test mutating func player_cache_adds_a_player() {
        // Given
        let player = Player(name: VBSConstants.coreDataPlayerName1)
        cache = PlayerCache()
        
        #expect(cache.size() == 0, "Cache has items already inside of it")
        
        // When
        cache.setValue(player)
        
        // Then
        #expect(cache.size() == 1, "Cache doesn't have only one element")
        #expect(cache.get(player.id) == player, "The stored player is not the player that was created")
    }
    
    @Test mutating func player_cache_removes_all_players() {
        
        // Given
        let players = [
            Player(name: VBSConstants.coreDataPlayerName1),
            Player(name: VBSConstants.coreDataPlayerName2)
        ]
        
        cache = PlayerCache(cache: [
            players[0].id : players[0],
            players[1].id : players[1]
        ])
        
        #expect(cache.size() == players.count, "The cache size does not have the number of players that were already added")
        
        // When
        cache.clear()
        
        // Then
        #expect(cache.get(players[0].id) == nil, "No player should be in the cache if it was cleared")
        #expect(cache.get(players[1].id) == nil, "No player should be in the cache if it was cleared")
        #expect(cache.size() == 0, "The cache was not properly cleared")
    }
    
    @Test mutating func player_cache_removes_single_player_at_a_time() {
        let player = Player(name: VBSConstants.coreDataPlayerName1)
        
        cache = PlayerCache(cache: [player.id: player])
        #expect(cache.size() == 1, "Cache was not initialized with one player")
        
        cache.remove(player.id)
        
        
        #expect(cache.get(player.id) == nil, "PLyaer could be grabbed from the cached")
        #expect(cache.size() == 0, "The player was not removed from the cache")
    }
    
    @Test mutating func player_cache_returns_all_stored_players() {
        // GIVEN
        let players = [
            Player(name: VBSConstants.coreDataPlayerName1),
            Player(name: VBSConstants.coreDataPlayerName2)
        ]
        
        cache = PlayerCache(cache: [
            players[0].id : players[0],
            players[1].id : players[1]
        ])
        
        #expect(cache.size() == players.count, "The cache size does not have the number of players that were already added")
        
        // WHEN
        let returnedPlayers = cache.getAll()
        
        // THEN
        #expect(returnedPlayers.count == players.count)
    }

}
