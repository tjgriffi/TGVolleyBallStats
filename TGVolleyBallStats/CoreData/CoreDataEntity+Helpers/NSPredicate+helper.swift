//
//  NSPredicate+helper.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/20/26.
//

import Foundation

extension NSPredicate {
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
}
