//
//  StorageManager.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 11/28/25.
//

import Foundation
import CoreData

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
        let player = CDPlayer(name: VBSConstants.coreDataPlayerName, context: context)
        
        var stats = [CDPlayerDateStat]()
        
        (1...3).forEach({ _ in
            let stat = CDPlayerDateStat(
                date: Date(),
                digRating: .random(in: (0...1)),
                passRating: .random(in: (0...1)),
                killPercentage: .random(in: (0...1)),
                freeBallRating: .random(in: (0...1)),
                pointScore: .random(in: (0...10)),
                context: context)
            stat.player_ = player
            stats.append(stat)
        })
        
        // Setup a game
        let game1 = CDGame(date: Date(), context: context)
        
        // Setup the set
        let set = CDVSet(context: context)
        
        // Setup the rallies
        let arrayVals = Array(0...20)
        
        set.rallies = arrayVals.reduce(into: Set<CDRally>()) { result, value in
            
            let rally = CDRally(pointGained: .random(), rallyStart: .random(), rotation: Int16(value/6) + 1, context: context)
            
            rally.stats = [1,2,3,4,5].reduce(into: Set<CDPlayerAndStat>()) { stats, _ in
                
                stats.insert(CDPlayerAndStat(playerName: VBSConstants.coreDataPlayerName, stat: Stats.allCases.randomElement()?.rawValue ?? "ace", context: context))
            }
            
            result.insert(rally)
        }
                
        player.playerDateStats = Set(stats)
        
        game1.sets.formUnion([set])
        
        player.games = Set([game1])
        game1.players = Set([player])
                
        return storageManager
    }
}
