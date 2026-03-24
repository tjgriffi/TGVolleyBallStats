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
                playerName.removeAll()
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

#Preview("Add game view") {
    NavigationStack {
        AddGameView(gameViewModel: GameViewModel.previewNoSets)
    }
}

#Preview("Pre Set creation with rallies") {
    NavigationStack {
        AddGameView(gameViewModel: .previewNoSetsFullRally)
    }
}
