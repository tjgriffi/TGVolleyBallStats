//
//  GameViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/25/25.
//

import Foundation

class VolleyBallSet: Identifiable {
    private(set) var rallies: [Rally]
    private(set) var id = UUID()
    
    /// Generates a single set
    static var example: VolleyBallSet {
        return generateSet()
    }
    
    /// Generates three sets
    static var examples: [VolleyBallSet] {
        return (0...2).map { _ in
            generateSet()
        }
    }
    
    private static func generateSet() -> VolleyBallSet {
        var rallies = [Rally]()
        
        var homeScore = 0
        var oppScore = 0
        
        var rotation = 0
        var rallyStart = RallyStart.allCases.randomElement() ?? .receive
        
        let players = Player.examples
        var rallyCount = 0
        
        // Go through adding rallies to the list of rallies
        while (homeScore < 25 && oppScore < 25) {
            rallyCount += 1
            
            var playerStats = [PlayerAndStat]()
            playerStats.append(PlayerAndStat(player: players.randomElement()?.name ?? "Jacob", stat: Stats.allCases.randomElement() ?? .pass1))
            
            // Case where the rally ends on the first action
            if !isEndOfRally(stat: playerStats.last!.stat) {
                let pointGained = pointGained(stat: playerStats.last!.stat)
                
                if pointGained > 1 && rallyStart == .receive {
                    rallyStart = .serve
                    rotation = rotation > 6 ? 0 : rotation + 1
                } else if pointGained == 0 && rallyStart == .serve {
                    rallyStart = .receive
                    rotation = rotation > 6 ? 0 : rotation + 1
                }
                
                rallies.append(
                    Rally(
                        id: UUID(),
                        rotation: rotation,
                        rallyStart: rallyStart,
                        point: pointGained,
                        stats: playerStats)
                )

                // Update the scores
                if pointGained == 0 {
                    oppScore += 1
                } else {
                    homeScore += 1
                }
                continue
            }
            
            // Play out the rally
            while isEndOfRally(stat: playerStats.last!.stat) || playerStats.count < 27 {
                
                playerStats.append(PlayerAndStat(player: players.randomElement()?.name ?? "Jacob", stat: Stats.allCases.randomElement() ?? .hitError))
            }
            
            // Check if points were gained
            let pointGained = pointGained(stat: playerStats.last!.stat)
            
            if pointGained > 1 && rallyStart == .receive {
                rallyStart = .serve
                rotation = rotation > 6 ? 0 : rotation + 1
            } else if pointGained == 0 && rallyStart == .serve {
                rallyStart = .receive
                rotation = rotation > 6 ? 0 : rotation + 1
            }
            
            // Update the scores
            if pointGained == 0 {
                oppScore += 1
            } else {
                homeScore += 1
            }
            
            // Update the list of rallies
            rallies.append(
                Rally(
                    id: UUID(),
                    rotation: rotation,
                    rallyStart: rallyStart,
                    point: pointGained,
                    stats: playerStats)
            )
        }
        
        return VolleyBallSet(rallies: rallies)
        
    }
    
    private static func isEndOfRally(stat: Stats) -> Bool {
        return stat != .hitError &&
            stat != .kill &&
            stat != .killBlock &&
            stat != .blockError &&
            stat != .freeBallKill &&
            stat != .setError &&
            stat != .setterDump &&
            stat != .ace
    }
    
    private static func pointGained(stat: Stats) -> Int {
        return (stat == .kill ||
                stat == .killBlock ||
                stat == .freeBallKill ||
                stat == .setterDump) ? 1 : 0
    }
    
    init(rallies: [Rally]) {
        self.rallies = rallies
    }
}

@Observable
class GameViewModel {
    
    var game: Game
    var setValues: [SetValues] = []
    
    struct SetValues: Identifiable {
        let id: Int
        let kills: Int
        let digs: Int
        let aces: Int
        let passes: Int
        let spikes: Int
        let freeBall: Int
        let killBlocks: Int
        let freeballKills: Int
        let touches: Int
        let blocks: Int
        let hittingErrors: Int
        let blockingErrors: Int
        let settingErrors: Int
        let freeBallErrors: Int
        let shanks: Int
        let serveErrors: Int
        let rallySore: RallyFinalScore
        let bestRotation: (rotation: Int, pointsGained: Int)
        let worstRotation: (rotation: Int, pointsLost: Int)
    }
    
    init(game: Game) {
        self.game = game
        self.setValues = []
        
        var setCount = 1
        game.sets.forEach { set in
            setValues.append(setupStats(for: set, setNumber: setCount))
            setCount += 1
        }
    }
    
    static var preview: GameViewModel {
        GameViewModel(game: .example)
    }
    
    private func setupStats(for set: `Set`, setNumber: Int) -> SetValues {
        
        var kills = 0
        var digs = 0
        var aces = 0
        var spikes = 0
        var freeballs = 0
        var freeballKill = 0
        var killBlocks = 0
        var hittingErrors = 0
        var blockingErrors = 0
        var settingErrors = 0
        var freeballErrors = 0
        var shanks = 0
        var serveErrors = 0
        var servesIn = 0
        var touches = 0
        var block = 0
        var passes = 0
        var homeScore = 0
        var awayScore = 0
        var rotation: [Int: (pointsGained: Int, pointsLost: Int)] = [:]
        
        for rally in set.rallies {
            
            if rally.point == 0 {
                awayScore += 1
                rotation[rally.rotation, default: (pointsGained: 0, pointsLost: 0)].pointsLost += 1
            } else {
                homeScore += 1
                rotation[rally.rotation, default: (pointsGained: 0, pointsLost: 0)].pointsGained += 1
            }
            
            for playerStat in rally.stats {
                
                switch playerStat.stat {
                case .serve0:
                    serveErrors += 1
                case .serve1:
                    servesIn += 1
                case .serve2:
                    servesIn += 1
                case .serve3:
                    servesIn += 1
                case .ace:
                    servesIn += 1
                    aces += 1
                case .kill:
                    kills += 1
                case .hitError:
                    hittingErrors += 1
                case .hitAttempt:
                    spikes += 1
                case .set:
                    continue
                case .assistKill:
                    continue
                case .assitHockey:
                    continue
                case .setError:
                    settingErrors += 1
                case .setterDump:
                    kills += 1
                case .freeBallKill:
                    freeballKill += 1
                case .freeBall:
                    freeballs += 1
                case .freeBallError:
                    freeballErrors += 1
                case .killBlock:
                    killBlocks += 1
                case .block:
                    block += 1
                case .touch:
                    touches += 1
                case .blockError:
                    blockingErrors += 1
                case .pass0:
                    passes += 1
                case .pass1:
                    passes += 1
                case .pass2:
                    passes += 1
                case .pass3:
                    shanks += 1
                case .freeBallR1:
                    freeballs += 1
                case .freeBallR2:
                    freeballs += 1
                case .freeBallR3:
                    freeballs += 1
                case .dig0:
                    digs += 1
                case .dig1:
                    digs += 1
                case .dig2:
                    digs += 1
                case .dig3:
                    digs += 1
                case .none:
                    continue
                }
            }
        }
        
        var bestRotation: (rotation: Int, pointsGained: Int) = (1,0)
        var worstRotation: (rotation: Int, pointsLost: Int) = (1,0)
        
        rotation.forEach { keyValue in
            if bestRotation.pointsGained < keyValue.value.pointsGained {
                bestRotation = (
                    rotation: keyValue.key,
                    pointsGained: keyValue.value.pointsGained
                )
            }
            
            if worstRotation.pointsLost < keyValue.value.pointsLost {
                worstRotation = (
                    rotation: keyValue.key,
                    pointsLost: keyValue.value.pointsLost)
            }
        }
        
        return SetValues(
            id: setNumber,
            kills: kills,
            digs: digs,
            aces: aces,
            passes: passes,
            spikes: spikes,
            freeBall: freeballs,
            killBlocks: killBlocks,
            freeballKills: freeballKill,
            touches: touches,
            blocks: block,
            hittingErrors: hittingErrors,
            blockingErrors: blockingErrors,
            settingErrors: settingErrors,
            freeBallErrors: freeballErrors,
            shanks: shanks,
            serveErrors: serveErrors,
            rallySore: RallyFinalScore(
                home: homeScore,
                away: awayScore),
            bestRotation: bestRotation,
            worstRotation: worstRotation
        )
    }
}

import Playgrounds

#Playground {
    let gameVewModel = GameViewModel(game: Game.example)
}
