//
//  Stats.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import Foundation

enum Stats: String, CaseIterable, Identifiable {
    case serve0
    case serve1
    case serve2
    case serve3
    case ace
    case kill
    case hitError
    case hitAttempt
    case set
    case assistKill
    case assitHockey
    case setError
    case setterDump
    case freeBallKill
    case freeBall
    case freeBallError
    case killBlock
    case block
    case touch
    case blockError
    case pass0
    case pass1
    case pass2
    case pass3
    case freeBallR1
    case freeBallR2
    case freeBallR3
    case dig0
    case dig1
    case dig2
    case dig3
    
    var id: String { rawValue }
    
    /// Determines if a stat is offensive or defensive
    /// - Returns: bool with the result of if the stat is offensive or defensive
    func isOffensive() -> Bool {
        switch self {
        case .serve0,.serve1,.serve2,.serve3,.ace,.kill,.hitError,.hitAttempt,.set,.assistKill,.assitHockey,.setError,.setterDump,.freeBallKill,.freeBall,.freeBallError:
            return true
        default:
            return false
        }
    }
}
