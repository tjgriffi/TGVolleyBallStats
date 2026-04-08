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
            playerStats.append(PlayerAndStat(id: UUID(), player: players.randomElement()?.name ?? "Jacob", stat: Stats.allCases.randomElement() ?? .pass1))
            
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
                
                playerStats.append(PlayerAndStat(id: UUID(), player: players.randomElement()?.name ?? "Jacob", stat: Stats.allCases.randomElement() ?? .hitError))
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



import Playgrounds

#Playground {
    let gameVewModel = GameViewModel(
        game: Game.example, playerRepository: CDPlayerRepository(
            context: StorageManager.preview.container.viewContext,
            cache: PlayerCache(),
            storageManager: .preview),
             gameRepository: CDGameRepository(
                storageManager: .preview,
                cache: GameCache()))
}
