//
//  Player.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import Foundation

class Player: Identifiable {
    let id = UUID()
    let name: String
    
    static var example: Player {
        let player = Player(name: "Player 1")
        for _ in 1...10 {
            player.addNewGameStats(stats: Stats.examples)
        }
        return player
    }
    
    static var examples: [Player] {
        var players = [Player]()
        for num in 1...6 {
            let player = Player(name: "Player \(num)")
            for _ in 1...10 {
                player.addNewGameStats(stats: Stats.examples)
            }
            players.append(player)
        }
        
        return players
    }
    
    init(name: String) {
        self.name = name
    }
    
    // TODO: Determine how to grab these from CoreData, but for now just initialize them as empty
    private(set) var killPercentage: Double = 0
    private(set) var killPercentageLast10Games: [Double] = []
    private(set) var passRating: Double = 0
    private(set) var passRatingLast10Games: [Double] = []
    private(set) var freeBallRating: Double = 0
    private(set) var freeBallRatingLast10Games: [Double] = []
    private(set) var digRating: Double = 0
    private(set) var digRatingLast10Games: [Double] = []
    private(set) var pointScore: Int = 0
    private(set) var pointScoreLast10Games: [Int] = []
    
    // Update the player's stats with the latest stats from a game
    func addNewGameStats(stats: [Stats]) {
        
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
        killPercentage = kills/hitAttempts
        killPercentageLast10Games.append(killPercentage)
        if killPercentageLast10Games.count > 10 {
            killPercentageLast10Games.removeFirst()
        }
        
        passRating = passes/passAttempts
        passRatingLast10Games.append(passRating)
        if passRatingLast10Games.count > 10 {
            passRatingLast10Games.removeFirst()
        }
        
        freeBallRating = freeball/freeballReceives
        freeBallRatingLast10Games.append(freeBallRating)
        if freeBallRatingLast10Games.count > 10 {
            freeBallRatingLast10Games.removeFirst()
        }
        
        digRating = digs/digAttempts
        digRatingLast10Games.append(digRating)
        if digRatingLast10Games.count > 10 {
            digRatingLast10Games.removeFirst()
        }
        
        pointScore = pointsScored
        pointScoreLast10Games.append(pointScore)
        if pointScoreLast10Games.count > 10 {
            pointScoreLast10Games.removeFirst()
        }
        
    }
}
