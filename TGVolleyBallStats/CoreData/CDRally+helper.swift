//
//  CDRally+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import CoreData

extension CDRally {
    
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var pointGained: Bool {
        get { pointGained_ }
        set { pointGained_ = newValue }
    }
    
    // TODO: Need to convert this properly when creating a Rally object
    var rallyStart: Bool {
        get { rallyStart_ }
        set { rallyStart_ = newValue }
    }
    
    var rotation: Int16 {
        get { rotation_ }
        set { rotation_ = newValue }
    }
    
    var stats: Set<CDPlayerAndStat> {
        get { (stats_ as? Set<CDPlayerAndStat>) ?? [] }
        set { stats_ = newValue as NSSet }
    }
    
    convenience init(pointGained: Bool,
        rallyStart: Bool,
        rotation: Int16,
        context: NSManagedObjectContext) {
        self.init(context: context)
        self.pointGained = pointGained
        self.rallyStart = rallyStart
        self.rotation = rotation
    }
    
    override public func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    static func delete(_ rally: CDRally) {
        guard let context = rally.managedObjectContext else { return }
        
        context.delete(rally)
    }
    
    static func fetch(_ predicate: NSPredicate = .all ) -> NSFetchRequest<CDRally> {
        
        let request = CDRally.fetchRequest()
                        
        request.predicate = predicate
        
        return request
    }
    
    // MARK: Example
    static var example: CDRally {
        
        let context = StorageManager.preview.container.viewContext
        
        let rally = CDRally(pointGained: .random(), rallyStart: .random(), rotation: .random(in: 1...6), context: context)
        
        return rally
    }
}
