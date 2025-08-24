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
    var names = ["TJ", "Karen", "Mitchell", "Lem", "Ryan", "Megan"]
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
            NavigationStack(path: $router.navigationPath) {
                SetView(
                    setViewModel: SetViewModel(
                        rallies: rallies
                    )
                )
                .navigationTitle("Set")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .addRally(let setViewModel):
                        AddRallyView(playerName: names.first ?? "Player Name", names: names, setViewModel: setViewModel)
                    default:
                        Circle()
                    }
                }
            }
            .environment(\.router, router)
        }
    }
}
