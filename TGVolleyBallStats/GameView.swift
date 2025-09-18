//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct GameView: View {
    @State var gameViewModel: GameViewModel
    @Environment(\.router) private var router
    
    var body: some View {
        Text(gameViewModel.gameName)
            .font(.title)
        ForEach(Array(gameViewModel.sets.enumerated()), id: \.element.id) { index, set in
            
            let setColor = switch index {
            case 0:
                SetViewNumber.first
            case 1:
                SetViewNumber.second
            case 2:
                SetViewNumber.third
            case 3:
                SetViewNumber.fourth
            case 4:
                SetViewNumber.fifth
            default:
                SetViewNumber.first
            }
            
            SetView(setNumber: setColor, setViewModel: SetViewModel(rallies: set.rallies))
                .onTapGesture {
                    // Navigate to the detail view for the given set
                    router.navigate(to: .setDetailView(rallies: set.rallies))
                }
        }
        // Create set button: Creates an empty set
        Button(
            action: {
                // Navigate to a set detail view without any set information
                router.navigate(to: .addSet)
            }, label: {
                Text("Add Set")
            }
        )
    }
}

struct SetView: View {
    private(set) var setNumber: SetViewNumber
    @State var setViewModel: SetViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(setNumber.color())
                .frame(width: 200, height: 100)
            HStack {
                VStack(alignment: .center) {
                    Text("Set \(setNumber.rawValue)")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("\(setViewModel.getSetFinalScores().home) - \(setViewModel.getSetFinalScores().away)")
                        .foregroundStyle(.white)
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
            }
        }
    }
}

struct SetDetailView: View {
    @StateObject var setViewModel: SetDetailViewModel
    @Environment(\.router) private var router
    
    var body: some View {
        Text("Set 1")
            .font(.title2)
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
                router.navigate(to: .addRally { rally in
                    setViewModel.addRally(rally: rally)
                })
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
    @Environment(\.router) private var router
    
    let onCompletion: (Rally) -> Void
    
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
            onCompletion(rally)
            
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

enum SetViewNumber: String {
    case first = "1"
    case second = "2"
    case third = "3"
    case fourth = "4"
    case fifth = "5"
    
    func color() -> Color {
        switch self {
        case .first:
            return .blue
        case .second:
            return .red
        case .third:
            return .green
        case .fourth:
            return .yellow
        case .fifth:
            return .orange
        }
    }
}
