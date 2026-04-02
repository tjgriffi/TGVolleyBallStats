//
//  StorageManager.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 11/28/25.
//

import Foundation
import CoreData
import SwiftUI

// Keeps track of the data utilized by the different objects
struct StorageManager {
    static let shared = StorageManager()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "TGVolleyBallStatsApp")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
    
    // Save changes to the context
    func save() {
        
        // Check if the context actually has changes
        let context = container.viewContext
        
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
        
    }
    
    // MARK: Preview
    static var preview: StorageManager {
        let storageManager = StorageManager(inMemory: true)
        
        let context = storageManager.container.viewContext
        
        // Setup a player
        let player1 = CDPlayer(name: VBSConstants.coreDataPlayerName1, context: context)
        let player2 = CDPlayer(name: VBSConstants.coreDataPlayerName2, context: context)
        
        var stats1 = [CDPlayerDateStat]()
        var stats2 = [CDPlayerDateStat]()
        
        (1...3).forEach({ index in
            var stat = CDPlayerDateStat(
                date: Date(timeInterval: Double(60 * 60 * 10 * index), since: Date()),
                digRating: .random(in: (0...1)),
                passRating: .random(in: (0...1)),
                killPercentage: .random(in: (0...1)),
                freeBallRating: .random(in: (0...1)),
                pointScore: .random(in: (0...10)),
                context: context)
            stat.player_ = player1
            stats1.append(stat)
            
            stat = CDPlayerDateStat(
                date: Date(timeInterval: Double(60 * 60 * 10 * index), since: Date()),
                digRating: .random(in: (0...1)),
                passRating: .random(in: (0...1)),
                killPercentage: .random(in: (0...1)),
                freeBallRating: .random(in: (0...1)),
                pointScore: .random(in: (0...10)),
                context: context)
            stat.player_ = player2
            stats2.append(stat)
        })
        
        // Setup a game
        let game1 = CDGame(date: Date(timeInterval: 60 * 60 * 13 * 7, since: .now) , context: context)
        let game2 = CDGame(date: Date(timeInterval: 60 * 60 * 13 * 4, since: .now) , context: context)
        
        // Setup the set
        let set1 = CDVSet(context: context)
        let set2 = CDVSet(context: context)
        
        // Setup the rallies
        let arrayVals1 = Array(0...20)
        let arrayVals2 = Array(0...20)
        
        set1.rallies = arrayVals1.reduce(into: Set<CDRally>()) { result, value in
            
            let rally = CDRally(pointGained: .random(), rallyStart: .random(), rotation: Int16(value/6) + 1, context: context)
            
            rally.stats = [1,2,3,4,5].reduce(into: Set<CDPlayerAndStat>()) { stats, _ in
                
                stats.insert(CDPlayerAndStat(playerName: VBSConstants.coreDataPlayerName1, stat: Stats.allCases.randomElement()?.rawValue ?? "ace", context: context))
            }
            
            result.insert(rally)
        }
        
        set2.rallies = arrayVals2.reduce(into: Set<CDRally>()) { result, value in
            
            let rally = CDRally(pointGained: .random(), rallyStart: .random(), rotation: Int16(value/6) + 1, context: context)
            
            rally.stats = [1,2,3,4,5].reduce(into: Set<CDPlayerAndStat>()) { stats, _ in
                
                stats.insert(CDPlayerAndStat(playerName: VBSConstants.coreDataPlayerName1, stat: Stats.allCases.randomElement()?.rawValue ?? "ace", context: context))
            }
            
            result.insert(rally)
        }
        
                
        player1.playerDateStats = Set(stats1)
        player2.playerDateStats = Set(stats2)
        
        game1.sets.formUnion([set1])
        game2.sets.formUnion([set2])
        
        player2.games = Set([game2])
        game2.players = Set([player2])
        
        player1.games = Set([game1])
        game1.players = Set([player1])
                
        return storageManager
    }
}

private struct StorageManagerKey: EnvironmentKey {
    static let defaultValue = StorageManager.shared
}

extension EnvironmentValues {
    var storageManager: StorageManager {
        get { self[StorageManagerKey.self]}
        set { self[StorageManagerKey.self] = newValue }
    }
}
