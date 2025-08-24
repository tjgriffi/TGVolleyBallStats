//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct SetView: View {
    @State var setViewModel: SetViewModel
    
    @Environment(\.router) private var router
    
    var body: some View {
        List {
            ForEach(setViewModel.rallies) { rally in
                RallyView(rally: rally)
            }
            addRallyButton
        }
    }
    
    private var addRallyButton: some View {
        Button(
            action: {
                router.navigate(to: .addRally(setViewModel: $setViewModel))
            }, label: {
                Text("Add Rally")
                    .font(.title)
            }
        )
    }
}

struct RallyView: View {
    let rally: Rally
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Rotation: \(rally.rotation)")
                Spacer()
                Text("\(rally.rallyStart)")
                Spacer()
                Text("\(rally.point)")
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    switch rally.rallyStart {
                    case .serve:
                        Text("Player: \(rally.stats.last?.player ?? "Default Name")")
                    case .receive:
                        Text("Player: \(rally.stats.last?.player ?? "Default Name")")
                    }
                    
                    Spacer()
                    Text("\(rally.stats.last?.stat ?? .freeBallError)")
                }
            }
        }
    }
}

struct AddRallyView: View {
    @State var playerName: String
    @State var rotation: Int = 1
    @State var rallyStart: RallyStart = .receive
    @State var pointGained: Int = 0
    @State var stat: Stats = .none
    var names: [String]
    @State var playerAndStats: [PlayerAndStat] = []
    @Binding var setViewModel: SetViewModel
    @Environment(\.router) private var router
    
    var body: some View {
        List {
            Picker("What started the rally?", selection: $rallyStart) {
                ForEach(RallyStart.allCases) { rallyStartOption in
                    Text(rallyStartOption.rawValue.capitalized)
                        .tag(rallyStartOption)
                }
            }
            .pickerStyle(.menu)
            Picker("Which rotation?", selection: $rotation) {
                ForEach(1..<6) { rotationOption in
                    Text("\(rotationOption)")
                        .tag(rotationOption)
                }
            }
            .pickerStyle(.menu)
            Picker("Points Gained?", selection: $pointGained) {
                Text("\(0)")
                    .tag(0)
                Text("\(1)")
                    .tag(1)
            }
            ForEach(playerAndStats, id: \.id) { playerAndStat in
                HStack(alignment: .center) {
                    Spacer()
                    Text(playerAndStat.player )
                    Spacer()
                    Text("\(playerAndStat.stat)")
                    Spacer()
                }
            }
            Spacer()
            Picker("Player Name", selection: $playerName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                        .tag(name)
                }
            }
            .pickerStyle(.menu)
            Picker("Stat", selection: $stat) {
                ForEach(Stats.allCases, id: \.self) { stat in
                    Text("\(stat.rawValue)")
                        .tag(stat)
                }
            }
            .pickerStyle(.menu)
            Button("Add Another Stat") {
                if stat != .none {
                    playerAndStats.append(PlayerAndStat(player: playerName, stat: stat))
                    
                    // Reset the appropriate values
                    playerName = names.first ?? "Player name"
                    stat = .none
                } else {
                    // MARK: Alert
                }
            }
        }
        Button  {
            // MARK:  Store/Send up the saved Rally
            // Store the Rotation, RallyStart and PlayerNameAndStat values into a rally object
            let rally = Rally(
                rotation: rotation,
                rallyStart: rallyStart,
                point: pointGained,
                stats: playerAndStats)
            
            // Update the setViewModel's rallies
            setViewModel.addRally(rally: rally)
            
            // Navigate backwards in the navigation stack
            router.goBack()
        } label: {
            Text("DONE")
        }

    }
}

enum RallyStart: String, CaseIterable, Identifiable {
    case serve
    case receive
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .serve:
            return .blue
        case .receive:
            return .red
        }
    }
}

struct PlayerAndStat: Identifiable {
    let player: String
    let stat: Stats
    let id = UUID()
}
