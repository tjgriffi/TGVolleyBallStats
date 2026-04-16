//
//  Player.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import Foundation

class Player: Identifiable, Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    let name: String
    var isSelected: Bool = false // Used for choosing players in the add game screen
    
    static var example: Player {
        let player = Player(name: "Player 1")
        let calendar = Calendar.current
        for index in 1...10 {
            player.addNewGameStats(stats: Stats.examples, date: calendar.date(byAdding: .day, value: index, to: Date()) ?? Date())
        }
        player.last10GameStats = player.last10GameStats.sorted { $0.date < $1.date }
        return player
    }
    
    // An array of 6 players with 10 games each
    static var examples: [Player] {
        var players = [Player]()
        for num in 1...6 {
            let player = Player(name: "Player \(num)")
            let calendar = Calendar.current
            for index in 1...10 {
                player.addNewGameStats(stats: Stats.examples, date: calendar.date(byAdding: .weekOfYear, value: index, to: Date()) ?? Date())
            }
            player.last10GameStats = player.last10GameStats.sorted { $0.date > $1.date }
            players.append(player)
        }
        
        return players
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.last10GameStats = []
    }
    
    init(from cdPlayer: CDPlayer) {
        self.id = cdPlayer.uuid
        self.name = cdPlayer.name
        self.last10GameStats = cdPlayer.playerDateStats.map({ cdPDS in
            PlayerDateStats(
                date: cdPDS.date,
                killPercentage: cdPDS.killPercentage,
                passRating: cdPDS.passRating,
                freeBallRating: cdPDS.freeBallRating,
                digRating: cdPDS.digRating,
                pointScore: cdPDS.pointScore)
        })
    }
    
    // TODO: Determine how to grab these from CoreData, but for now just initialize them as empty
    private(set) var last10GameStats: [PlayerDateStats]
    
    // Update the player's stats with the latest stats from a game
    func addNewGameStats(stats: [Stats], date: Date) {
        
        var kills: Double = 0
        var hitAttempts: Double = 0
        var passes: Double = 0
        var passAttempts: Double = 0
        var freeball: Double = 0
        var freeballReceives: Double = 0
        var digs: Double = 0
        var digAttempts: Double = 0
        var pointsScored: Int = 0
        
        for stat in stats {
            switch stat{
            case .kill, .freeBallKill, .setterDump:
                kills += 1
                pointsScored += 1
                hitAttempts += 1
            case .hitAttempt, .hitError:
                hitAttempts += 1
            case .pass1, .pass2, .pass3:
                passes += 1
                passAttempts += 1
            case .pass0:
                passAttempts += 1
            case .freeBallR1,.freeBallR2, .freeBallR3:
                freeball += 1
                freeballReceives += 1
            case .freeBallError:
                freeballReceives += 1
            case .dig1, .dig2, .dig3:
                digs += 1
                digAttempts += 1
            case .dig0:
                digAttempts += 1
            default:
                continue
            }
        }
        
        // Update the player stats
        let killPercentage = kills/hitAttempts
        
        let passRating = passes/passAttempts

        let freeBallRating = freeball/freeballReceives

        let digRating = digs/digAttempts

        let pointScore = pointsScored

        let playerDateStat = PlayerDateStats(
            date: date,
            killPercentage: killPercentage,
            passRating: passRating,
            freeBallRating: freeBallRating,
            digRating: digRating,
            pointScore: pointScore)
        
        last10GameStats.append(playerDateStat)
        if last10GameStats.count > 10 {
            last10GameStats.removeFirst()
        }
    }
}

struct PlayerDateStats: Identifiable {
    var id: Date { return date }
    
    let date: Date
    let killPercentage: Double
    let passRating: Double
    let freeBallRating: Double
    let digRating: Double
    let pointScore: Int
}

// MARK:  See if this is still needed in the code
struct PlayerAndStat: Identifiable {
    let player: String
    let stat: Stats
    let id: UUID
    
    init(id: UUID = UUID(), player: String, stat: Stats) {
        self.id = id
        self.player = player
        self.stat = stat
    }
    
    init(from cdPlayerAndStat: CDPlayerAndStat) {
        self.id = UUID() // MARK: Investigate if it's ok to just give it a UUID here/if the id is even needed
        self.player = cdPlayerAndStat.playerName
        self.stat = Stats(rawValue: cdPlayerAndStat.stat) ?? .none // MARK: Need to log some sort of error if the stat type can't be found
    }
    
    static var example: PlayerAndStat {
        PlayerAndStat(id: UUID(), player: "TJ", stat: Stats.allCases.randomElement() ?? .ace)
    }
    
    static var examples: [PlayerAndStat] {
        let player = "TJ"
                
        return (0...4).map {_ in PlayerAndStat(id: UUID(), player: player, stat: Stats.allCases.randomElement() ?? .ace) }
    }
    
    static func generateExamples(with name: String) -> [PlayerAndStat] {
        
        return (0...4).map {_ in PlayerAndStat(id: UUID(), player: name, stat: Stats.allCases.randomElement() ?? .ace) }
    }
}

//import Playgrounds
//#Playground {
//    let playerAndStat = PlayerAndStat.example
//    
//    let playersRallyStats = PlayerAndStat.examples
//    let customPlayerRallyStats = PlayerAndStat.generateExamples(with: "Ryan")
//}
