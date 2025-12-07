//
//  StorageManager.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 11/28/25.
//

import Foundation
import CoreData

// Keeps track of the data utilized by the different objects
class StorageManager {
    
    let set1Examples = VolleyBallSet(rallies: [
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
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
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        )
    ])
    let set2Examples = VolleyBallSet(rallies: [
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        ),
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        )
    ])
    let set3Examples = VolleyBallSet(rallies: [
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        )
    ])
    let playerExamples = ["TJ", "Karen", "Mitchell", "Lem", "Ryan", "Megan"]
}
