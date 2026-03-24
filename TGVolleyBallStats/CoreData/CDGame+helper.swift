//
//  CDGame+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/23/26.
//

import Foundation
import CoreData

extension CDGame {
    
    var id: UUID {
        #if DEBUG
        id_!
        #else
        id_ ?? UUID()
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
        self.id_ = UUID()
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
        
        request.sortDescriptors = [NSSortDescriptor(key: "\(\CDGame.date_)", ascending: true)]
        
        request.predicate = predicate
        
        return request
    }
    
    // MARK: Example
    static var example: CDGame {
        
        let context = StorageManager.shared.container.viewContext
        
        let game = CDGame(date: Date(), context: context)
        
        return game
    }
}
