//
//  DataCache.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/30/26.
//

import Foundation

protocol BaseCache<T>{
    associatedtype T
    
    func get(_ id: UUID) -> T?
    func setValue(_ value: T)
    func remove(_ key: UUID)
    func clear()
}


