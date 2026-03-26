//
//  CDPlayerDateStat.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/21/26.
//

import Foundation
import CoreData

extension CDPlayerDateStat {
    
    var date: Date {
        get { date_ ?? Date()  }
        set { date_ = newValue }
    }
    
    var digRating: Double {
        get { digRating_ }
        set { digRating_ = newValue }
    }
    
    var passRating: Double {
        get { passRating_ }
        set { passRating_ = newValue }
    }
    
    var killPercentage: Double {
        get { killPercentage_ }
        set { killPercentage_ = newValue }
    }
    
    var freeBallRating: Double {
        get { freeBallRating_ }
        set { freeBallRating_ = newValue }
    }
    
    var pointScore: Int {
        get { Int(pointScore_) }
        set { pointScore_ = Int16(newValue) }
    }
    
    convenience init(date: Date,
                     digRating: Double,
                     passRating: Double,
                     killPercentage: Double,
                     freeBallRating: Double,
                     pointScore: Int,
                     context: NSManagedObjectContext) {
        
        self.init(context: context)
        self.date = date
        self.digRating = digRating
        self.passRating = passRating
        self.killPercentage = killPercentage
        self.freeBallRating = freeBallRating
        self.pointScore = pointScore
    }
    
    static func delete(_ playerDateStat: CDPlayerDateStat) {
        guard let context = playerDateStat.managedObjectContext else { return }
        
        context.delete(playerDateStat)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDPlayerDateStat> {
        
        let request = CDPlayerDateStat.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDPlayerDateStat.date_ , ascending: true)]
        
        request.predicate = predicate
        
        return request
    }
    
    // MARK: Example
    static var example: CDPlayerDateStat {
        let context = StorageManager.preview.container.viewContext
        
        let playerDateStat = CDPlayerDateStat(
            date: Date(),
            digRating: .random(in: 0.0...1.0) ,
            passRating: .random(in: 0.0...1.0),
            killPercentage: .random(in: 0.0...1.0),
            freeBallRating: .random(in: 0.0...1.0),
            pointScore: .random(in: 0...12),
            context: context)
        
        return playerDateStat
    }
}
