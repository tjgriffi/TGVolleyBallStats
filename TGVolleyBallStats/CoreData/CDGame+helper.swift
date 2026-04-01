//
//  CDGame+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/23/26.
//

import Foundation
import CoreData

extension CDGame {
    
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var date: Date {
        
        get { date_ ?? Date() }
        set { date_ = newValue }
    }
    
    var players: Set<CDPlayer> {
        
        get { (players_ as? Set<CDPlayer>) ??  [] }
        set { players_ = newValue as NSSet }
    }
    
    var sets: Set<CDVSet> {
        
        get { (vSets_ as? Set<CDVSet>) ?? [] }
        set { vSets_ = newValue as NSSet }
    }
    
    // MARK: Initial setup
    override public func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    convenience init(date: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.date = date
    }
    
    static func delete(_ game: CDGame) {
        guard let context = game.managedObjectContext else { return }
        
        context.delete(game)
    }
    
    static func fetch(_ predicate: NSPredicate = .all ) -> NSFetchRequest<CDGame> {
        
        let request = CDGame.fetchRequest()
        
//        request.sortDescriptors = [NSSortDescriptor(key: "\(\CDGame.date_)", ascending: true)]
        
        request.predicate = predicate
        
        return request
    }
    
    // MARK: Example
    static var example: CDGame {
        
        let context = StorageManager.preview.container.viewContext
        
        let game = CDGame(date: Date(), context: context)
        
        // Setup the set
        let set1 = CDVSet(context: context)
        
        // Setup the rallies
        let arrayVals = Array(0...20)
        
        set1.rallies = arrayVals.reduce(into: Set<CDRally>()) { result, value in
            
            let rally = CDRally(pointGained: .random(), rallyStart: .random(), rotation: Int16(value/6) + 1, context: context)
            
            rally.stats = [1,2,3,4,5].reduce(into: Set<CDPlayerAndStat>()) { stats, _ in
                
                stats.insert(CDPlayerAndStat(playerName: VBSConstants.coreDataPlayerName, stat: Stats.allCases.randomElement()?.rawValue ?? "ace", context: context))
            }
            
            result.insert(rally)
        }
        
        game.sets.formUnion([set1])
        
        return game
    }
}
