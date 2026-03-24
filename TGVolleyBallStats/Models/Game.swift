//
//  Game.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/10/26.
//

import Foundation

struct Game: Identifiable {
    var id: Date { return date }
    let date: Date
    var players: [Player]
    var sets: [VSet] = []
    
    static var example: Game {
        let players = Player.examples
        
        return Game(
            date: Date(),
            players: players,
            sets: (1...3).map { _ in VSet.generateSet(withPlayers: players) }
        )
    }
    
    static var noSets: Game {
        let players = Player.examples
        
        return Game(
            date: Date(),
            players: players
        )
    }
}

// TODO: Revisit if Set needs a list of players for production or if it's just needed for testing
// MARK: We also may need to make this a class
struct VSet: Identifiable {
    let id = UUID()
    let players: [Player]
    let rallies: [Rally]
    
    static var example: VSet {
        
        let players = Player.examples
        
        return VSet(
            players: players,
            rallies: players.map { player in
                Rally.generateExampleRally(forPlayer: player.name)
            }
        )
    }
    
    static func generateSet(withPlayers players: [Player]) -> VSet {
        
        VSet(
            players: players,
            rallies: players.map { player in
                Rally.generateExampleRally(forPlayer: player.name)
            }
        )
    }
}

struct Rally: Identifiable {
    var id = UUID()
    let rotation: Int
    let rallyStart: RallyStart
    let point: Int
    let stats: [PlayerAndStat]
    
    static var example: Rally {
        Rally(
            rotation: (1...6).randomElement()!,
            rallyStart: .allCases.randomElement()!,
            point: (0...1).randomElement()!,
            stats: PlayerAndStat.examples
        )
    }
    
    static var examples: [Rally] {
        
        var rallies = ["Tj", "John", "Jane", "Sarah", "Michael", "Nancy"].map { name in
            Rally(
                rotation: (1...6).randomElement()!,
                rallyStart: .allCases.randomElement()!,
                point: (0...1).randomElement()!,
                stats: PlayerAndStat.generateExamples(with: name)
            )
        }
        
        return rallies
    }
    
    static func generateExampleRally(forPlayer name: String) -> Rally {
        Rally(
            rotation: (1...6).randomElement()!,
            rallyStart: .allCases.randomElement()!,
            point: (0...1).randomElement()!,
            stats: PlayerAndStat.generateExamples(with: name)
        )
    }
}

import Playgrounds

#Playground {
    let rallyExample = Rally.example
    let exampleRallies = Rally.examples
    
    let setExample = VSet.example
    let gameExample = Game.example
}
