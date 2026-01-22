//
//  AddGameView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/22/26.
//

import SwiftUI

struct AddGameView: View {
    let gameViewModel: GameViewModel
    @State var playerName: String = ""
    var body: some View {
        Text("Players: ")
        HStack {
            ForEach(gameViewModel.game.players) { player in
                Rectangle()
                    .overlay {
                        Text(player.name)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 50,height: 50)
                    .foregroundStyle(.green)
            }
        }
        List {
            ForEach(gameViewModel.setValues) { set in
                Section {
                    Text("Set \(set.id)")
                        .font(.title2)
                    SimpleSetView(set: set)
                }
            }
        }
        TextField("Player name goes here", text: $playerName)
            .textFieldStyle(.roundedBorder)
            .padding()
        Button {
            if !playerName.isEmpty {
                gameViewModel.game.players.append(Player(name: playerName))
            }
        } label: {
            Rectangle()
                .overlay {
                    Text("Add Player")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .frame(width: 200,height: 50)
                .cornerRadius(20)
                .foregroundStyle(.blue)
        }
        
        NavigationLink {
            AddSetView(gameViewModel: gameViewModel)
        } label: {
            Rectangle()
                .overlay {
                    Text("Add Set")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .frame(width: 200,height: 50)
                .cornerRadius(20)
                .foregroundStyle(.blue)
                .opacity(gameViewModel.game.players.isEmpty ? 0.5 : 1)
        }
        .disabled(gameViewModel.game.players.isEmpty)
    }
}

struct AddSetView: View {
    @Bindable var gameViewModel: GameViewModel
    @State var rallyStart: RallyStart = .serve
    @State var pointGained: Bool = false
    
    var body: some View {
        VStack {
            Picker(selection: $gameViewModel.game.players.animation()) {
                ForEach(gameViewModel.game.players) { player in
                    Text(player.name)
                }
            } label: {
                Text("Players for the game")
            }
            .pickerStyle(.palette)
            
            StatsGrid()
            
            HStack {
                Picker(selection: $rallyStart.animation()) {
                    ForEach(RallyStart.allCases) { rallyStart in
                        Text(rallyStart.rawValue)
                    }
                } label: {
                    Text("How the rally started")
                }
                .pickerStyle(.palette)
            }
            
            Toggle("Point Gained", isOn: $pointGained)
                .padding()
                
            HStack {
                Button {
                    gameViewModel.nextRallyClicked(pointGained: pointGained ? 1 : 0, rallyStart: rallyStart)
                } label: {
                    Rectangle()
                        .overlay(alignment: .center) {
                            Text("NextRally")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 200,height: 50)
                        .cornerRadius(20)
                }
                
                Button {
                    gameViewModel.doneCreatingSetClicked()
                } label: {
                    Rectangle()
                        .overlay(alignment: .center) {
                            Text("Done")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 200,height: 50)
                        .cornerRadius(20)
                        .foregroundStyle(.green)
                }
            }
        }

    }
}

struct StatsGrid: View {
    var body: some View {
        VStack {
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
            HStack {
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
                StatsPicker(stat: .ace, color: .red)
            }
        }
    }
}

struct StatsPicker: View {
    let stat: Stats
    let color: Color
    var clicked: Bool = false
    
    var body: some View {
        Circle()
            .overlay {
                Text(stat.rawValue)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .foregroundStyle(color)
            .opacity(clicked ? 1 : 0.5)
    }
}

#Preview("Add game view") {
    AddGameView(gameViewModel: GameViewModel.previewNoSets)
}

#Preview("Add Set view") {
    AddSetView(gameViewModel: GameViewModel.previewNoSets)
}
