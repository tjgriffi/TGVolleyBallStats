//
//  AddGameView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/22/26.
//

import SwiftUI

struct AddGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let gameViewModel: GameViewModel
    @State var playerName: String = ""
    @Binding var newGameAdded: Bool
    @State var selectedPlayers = [Player]()
    @State var isPlayersSectionExpanded: Bool = true
    @State var isGameSectionExpanded: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Section("Players", isExpanded: $isPlayersSectionExpanded) {
                        ForEach(gameViewModel.players) { player in
                            SelectPlayerRow(playerName: player.name)
                        }
                    }
                    .onTapGesture {
                        isPlayersSectionExpanded.toggle()
                    }
                    Section("Games", isExpanded: $isGameSectionExpanded) {
                        ForEach(gameViewModel.setValues) { set in
                            Section {
                                Text("Set \(set.id)")
                                    .font(.title2)
                                SimpleSetView(set: set)
                            }
                        }
                    }
                }
                TextField("Player name goes here", text: $playerName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button {
                    Task {
                        
                        await gameViewModel.doneCreatingGame()
                    }
                } label: {
                    Rectangle()
                        .overlay {
                            Text("Add Game")
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
                        .opacity(gameViewModel.game.playerIDs.isEmpty ? 0.5 : 1)
                }
                .disabled(gameViewModel.game.playerIDs.isEmpty)
            }
            
            if gameViewModel.state == .gameSavedSuccess {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
//                    .onTapGesture {
//                        showAddPlayerView.toggle()
//                    }
                
                Group {
                    VStack {
                        Text("Game was successfully saved!!")
                        Button {
                            newGameAdded.toggle()
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                    .frame(width: 300, height: 200)
                }
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 20)
                }
            }
        }

    }
}

#Preview("Add game view") {
    NavigationStack {
        AddGameView(gameViewModel: GameViewModel.previewNoSets, newGameAdded: .constant(false))
    }
}

//#Preview("Pre Set creation with rallies") {
//    NavigationStack {
//        AddGameView(gameViewModel: .previewNoSetsFullRally, newGameAdded: .constant(false))
//    }
//}
//
//#Preview("Game") {
//    NavigationStack {
//        AddGameView(gameViewModel: .preview, newGameAdded: .constant(false))
//    }
//}

struct SelectPlayerRow: View {
    @State var isSelected: Bool = false
    var playerName: String
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .onTapGesture {
                    isSelected.toggle()
                }
            
            Text(playerName)
        }
    }
}
