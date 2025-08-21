//
//  TGVolleyBallStatsApp.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

@main
struct TGVolleyBallStatsApp: App {
    
    var rallies: [Rally] = [
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ), Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 0,
            stats: [
                PlayerAndStat(player: "Lem", stat: .serve0),
                PlayerAndStat(player: "Mitchell", stat: .pass2),
                PlayerAndStat(player: "Meghan", stat: .set),
                PlayerAndStat(player: "TJ", stat: .hitError)
                   ]
        )
    ]
    var body: some Scene {
        WindowGroup {
            SetView(
                setViewModel: SetViewModel(
                    rallies: rallies
                )
            )
        }
    }
}
