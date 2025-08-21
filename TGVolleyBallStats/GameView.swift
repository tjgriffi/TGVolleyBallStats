//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct SetView: View {
    var setViewModel: SetViewModel
    var names = ["TJ", "Karen", "Mitchell", "Lem", "Ryan", "Megan"]
    
    @State private var path = [NavigationRoute]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(setViewModel.rallies) { rally in
                    RallyView(rally: rally)
                }
                addRallyButton
            }
            .navigationTitle("Set 1")
            .navigationDestination(for: NavigationRoute.self) { route in
                
                switch route {
                case .addRally:
                    AddRallyView(names: names)
                }
            }
        }
    }
    
    private var addRallyButton: some View {
        Button(
            action: {
                path.append(.addRally)
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
    @State var playerName: String = ""
    @State var rotation: Int = 1
    @State var rallyStart: RallyStart = .receive
    @State var stat: Stats = .ace
    var names: [String]
    @State var playerAndStats: [PlayerAndStat] = []
    
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
            ForEach(playerAndStats, id: \.id) { playerAndStat in
                HStack(alignment: .center) {
                    Spacer()
                    Text(playerAndStat.player )
                    Spacer()
                    Text("\(playerAndStat.stat)")
                    Spacer()
                }
            }
            Picker("Name", selection: $playerName) {
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
                playerAndStats.append(PlayerAndStat(player: playerName, stat: stat))
            }
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

enum NavigationRoute: Hashable {
    case addRally
}

struct PlayerAndStat: Identifiable {
    let player: String
    let stat: Stats
    let id = UUID()
}
