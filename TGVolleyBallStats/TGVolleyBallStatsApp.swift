//
//  TGVolleyBallStatsApp.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

@main
struct TGVolleyBallStatsApp: App {
    @State private var router = Router()
    let names = ["TJ", "Karen", "Mitchell", "Lem", "Ryan", "Megan"]
    let rallies2: [Rally] = []
    let rallies3: [Rally] = []
    
    let set1 = VolleyBallSet(rallies: [
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
    let set2 = VolleyBallSet(rallies: [
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
    let set3 = VolleyBallSet(rallies: [
        Rally(
            rotation: 0,
            rallyStart: .serve,
            point: 1,
            stats: [PlayerAndStat(player: "Lem", stat: .ace)]
        )
    ])
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                GameView(gameViewModel: GameViewModel(
                    playerNames: names, sets: [set1, set2, set3], gameName: "AirplaneModeIVL"))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .addRally(let onCompletion):
                        AddRallyView(playerName: names.first ?? "Player Name", names: names, onCompletion: onCompletion)
                    case .setDetailView(let rallies):
                        SetDetailView(setViewModel: SetDetailViewModel(rallies: rallies))
                    case .addSet:
                        // Create a setdetailView with an empty setDetailViewModel
                        SetDetailView(setViewModel: SetDetailViewModel(rallies: []))
                    default:
                        Circle()
                    }
                }
            }
            .environment(\.router, router)
        }
    }
}
