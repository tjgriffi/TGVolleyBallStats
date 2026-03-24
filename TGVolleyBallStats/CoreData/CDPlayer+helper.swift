//
//  CDPlayer+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/20/26.
//

import Foundation
import CoreData

extension CDPlayer {
    
    var id: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    
    var playerDateStats: Set<CDPlayerDateStat> {
        get { (playerDateStats_ as? Set<CDPlayerDateStat>) ?? [] }
        set { playerDateStats_ = newValue as NSSet }
    }
    
    // Setup the UUID here where the most critical values are needed
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    convenience init(name: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    
    static func delete(_ player: CDPlayer) {
        // Make sure we have a context
        guard let context = player.managedObjectContext else { return }
        
        context.delete(player)
    }
    
    
    static func fetch(_ predicate: NSPredicate = .all ) -> NSFetchRequest<CDPlayer> {
        
        let request = CDPlayer.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDPlayer.name_, ascending: true)]
        
        request.predicate = predicate
        
        return request
    }
    
    // Example
    static var example: CDPlayer {
        let context = StorageManager.shared.container.viewContext
        
        let player = CDPlayer(name: "Tester", context: context)
        
        return player
    }
}
