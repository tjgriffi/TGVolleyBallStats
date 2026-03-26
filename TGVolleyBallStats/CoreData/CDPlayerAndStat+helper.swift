//
//  CDPlayerAndStat.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//
import CoreData

extension CDPlayerAndStat {
    
    var playerName: String {
        get { playerName_ ?? "" }
        set { playerName_ = newValue }
    }
    
    var stat: String {
        get { stat_ ?? "" }
        set { stat_ = newValue }
    }
    
    convenience init(
        playerName: String,
        stat: String,
        context: NSManagedObjectContext) {
            self.init(context: context)
            self.playerName = playerName
            self.stat = stat
    }
    
    static func delete(_ playerAndStat: CDPlayerAndStat) {
        guard let context = playerAndStat.managedObjectContext else { return }
        
        context.delete(playerAndStat)
    }
    
    static func fetch(_ predicate: NSPredicate = .all ) -> NSFetchRequest<CDPlayerAndStat> {
        
        let request = CDPlayerAndStat.fetchRequest()
                
        request.predicate = predicate
        
        return request
    }
    
    // MARK: Example
    static var example: CDPlayerAndStat {
        let context = StorageManager.preview.container.viewContext
        
        let playerAndStat = CDPlayerAndStat(playerName: "Player", stat: Stats.allCases.randomElement()?.rawValue ?? "ace" , context: context)
        
        return playerAndStat
    }
}
