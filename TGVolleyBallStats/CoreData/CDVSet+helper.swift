//
//  CDVSet+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/24/26.
//

import Foundation
import CoreData

extension CDVSet {
    
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var players: Set<CDPlayer> {
        get { (players_ as? Set<CDPlayer>) ?? []  }
        set { players_ = newValue as NSSet }
    }
    
    var rallies: Set<CDRally> {
        get { (rallies_ as? Set<CDRally>) ?? [] }
        set { rallies_ = newValue as NSSet }
    }
    
    override public func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    static func delete(_ vSet: CDVSet) {
        guard let context = vSet.managedObjectContext else { return }
        
        context.delete(vSet)
    }
    
    static func fetch(_ predicate: NSPredicate = .all ) -> NSFetchRequest<CDVSet> {
        
        let request = CDVSet.fetchRequest()
                
        request.predicate = predicate
        
        return request
    }
    
    static var example: CDVSet {
        let context = StorageManager.preview.container.viewContext
        
        let vSet = CDVSet(context: context)
        
        return vSet
    }
}



