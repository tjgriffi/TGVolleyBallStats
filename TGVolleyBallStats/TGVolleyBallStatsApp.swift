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
                    players: Player.examples, sets: [set1, set2, set3], gameName: "AirplaneModeIVL"))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .addRally(let onCompletion):
                        RallyView(playerName: names.first ?? "Player Name", names: names, onCompletion: onCompletion)
                    case .setDetailView(let setViewModel):
                        SetView(setViewModel: SetViewModel(rallies: setViewModel.rallies))
                    case .addSet:
                        // Create a setdetailView with an empty setDetailViewModel
                        SetView(setViewModel: SetViewModel(rallies: []))
                    default:
                        Circle()
                    }
                }
            }
            .environment(\.router, router)
        }
    }
}
