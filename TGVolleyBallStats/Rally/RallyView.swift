//
//  RallyView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 11/28/25.
//

import SwiftUI

struct RallyView: View {
    @State var playerName: String
    @State var rotation: Int = 1
    @State var rallyStart: RallyStart = .receive
    @State var pointGained: Int = 0
    @State var stat: Stats = .none
    var names: [String]
    @State var playerAndStats: [PlayerAndStat] = []
    @Environment(\.router) private var router
    
    let onCompletion: (Rally) -> Void
    @State var rally: Rally?
    
    var body: some View {
        List {
            Section(header: Text("Rally Stats")){
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
            Section(header: Text("Rally Events")) {
                ForEach(playerAndStats, id: \.id) { playerAndStat in
                    HStack(alignment: .center) {
                        Text(playerAndStat.player )
                        Spacer()
                        Text("\(playerAndStat.stat)")
                    }
                }
            }
        }
        Button  {
            // MARK:  Store/Send up the saved Rally
            // Store the Rotation, RallyStart and PlayerNameAndStat values into a rally object
            self.rally = Rally(
                rotation: rotation,
                rallyStart: rallyStart,
                point: pointGained,
                stats: playerAndStats)
            
            // Update the setViewModel's rallies
            onCompletion(rally ?? Rally(rotation: 0, rallyStart: RallyStart.serve, point: 0, stats: []))
            
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


#Preview {
//    RallyView(playerName: <#String#>, names: <#[String]#>, onCompletion: <#(Rally) -> Void#>)
}
