//
//  Game.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/10/26.
//

import Foundation

struct Game: Identifiable, Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID/*Date { return date }*/
    let date: Date
    var playerIDs: [UUID]
    var sets: [VSet] = []
    
    init(id: UUID, date: Date, players: [UUID], sets: [VSet]) {
        self.id = id
        self.date = date
        self.playerIDs = players
        self.sets = sets
    }
    
    init(from cdGame: CDGame){
        
        
        self.id = cdGame.uuid
        self.date = cdGame.date
        self.playerIDs = []
        
                
        cdGame.sets.forEach { cdVSet in
            
            sets.append(VSet(from: cdVSet))
        }
    }
    
    // TODO: Need to fix the examples now that we're using IDs
    static var example: Game {
        let playerIDs = Player.examples.map { $0.id }
        
        return Game(
            id: UUID(),
            date: Date(),
            players: playerIDs,
            sets: (1...3).map { _ in VSet.generateSet(withPlayers: Player.examples) }
        )
    }
    
    static var noSets: Game {
        let playerIDs = Player.examples.map { $0.id }
        
        return Game(
            id: UUID(),
            date: Date(),
            players: playerIDs, sets: []
        )
    }
}

// TODO: Revisit if Set needs a list of players for production or if it's just needed for testing
// MARK: We also may need to make this a class
struct VSet: Identifiable {
    let id: UUID
//    let players: [Player] //TODO: Remove players
    let rallies: [Rally]
    
    init(id: UUID, /*players: [Player],*/ rallies: [Rally]) {
        self.id = id
//        self.players = players
        self.rallies = rallies
    }
    
    init(from cdVSet: CDVSet) {
        
        self.id = cdVSet.uuid
//        self.players = []
        
        self.rallies = cdVSet.rallies.map({ cdRally in
            Rally(from: cdRally)
        })
    }
    
    static var example: VSet {
        
        let players = Player.examples
        
        return VSet(
            id: UUID(), /*players: players,*/
            rallies: players.map { player in
                Rally.generateExampleRally(forPlayer: player.name)
            }
        )
    }
    
    static func generateSet(withPlayers players: [Player]) -> VSet {
        
        VSet(
            id: UUID(), /*players: players,*/
            rallies: players.map { player in
                Rally.generateExampleRally(forPlayer: player.name)
            }
        )
    }
}

struct Rally: Identifiable {
    let id: UUID
    let rotation: Int
    let rallyStart: RallyStart
    let point: Int
    let stats: [PlayerAndStat]
    
    init(id: UUID, rotation: Int, rallyStart: RallyStart, point: Int, stats: [PlayerAndStat]) {
        self.id = id
        self.rotation = rotation
        self.rallyStart = rallyStart
        self.point = point
        self.stats = stats
    }
    
    init(from cdRally: CDRally){
        
        self.id = cdRally.uuid
        self.rotation = Int(cdRally.rotation)
        self.rallyStart = cdRally.rallyStart ? .serve : .receive // True (serve) False (receive)
        self.point = cdRally.pointGained ? 1 : 0
        
        self.stats = cdRally.stats.map({ cdPlayerAndStat in
            PlayerAndStat(from: cdPlayerAndStat)
        })
    }
    
    static var example: Rally {
        Rally(
            id: UUID(), rotation: (1...6).randomElement()!,
            rallyStart: .allCases.randomElement()!,
            point: (0...1).randomElement()!,
            stats: PlayerAndStat.examples
        )
    }
    
    static var examples: [Rally] {
        
        let rallies = ["Tj", "John", "Jane", "Sarah", "Michael", "Nancy"].map { name in
            Rally(
                id: UUID(), rotation: (1...6).randomElement()!,
                rallyStart: .allCases.randomElement()!,
                point: (0...1).randomElement()!,
                stats: PlayerAndStat.generateExamples(with: name)
            )
        }
        
        return rallies
    }
    
    static func generateExampleRally(forPlayer name: String) -> Rally {
        Rally(
            id: UUID(), rotation: (1...6).randomElement()!,
            rallyStart: .allCases.randomElement()!,
            point: (0...1).randomElement()!,
            stats: PlayerAndStat.generateExamples(with: name)
        )
    }
}

//import Playgrounds
//
//#Playground {
//    let rallyExample = Rally.example
//    let exampleRallies = Rally.examples
//    
//    let setExample = VSet.example
//    let gameExample = Game.example
//}
