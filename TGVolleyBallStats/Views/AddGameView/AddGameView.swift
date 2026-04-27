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
    @State var selectedPlayers = [UUID]()
    @State var isPlayersSectionExpanded: Bool = true
    @State var isSetSectionExpanded: Bool = true
    
    private var showSaveAlert: Binding<Bool> {
        
        Binding (
            get: { return gameViewModel.state == .errorSavingGame },
            set: { if !$0 { gameViewModel.resetState() } }
        )
    }
    
    var body: some View {
        ZStack {
            VStack {

                List {
                    Section("Players", isExpanded: $isPlayersSectionExpanded) {
                        ForEach(gameViewModel.players) { player in
                            SelectPlayerRow(
                                isSelected: gameViewModel.selectedPlayers.contains(player.id),
                                player: player)
                            .onTapGesture {
                                gameViewModel.toggleSelectedPlayers(player: player)
                            }
                        }
                    }
                    .onTapGesture {
                        isPlayersSectionExpanded.toggle()
                    }
                    
                    Section("Sets", isExpanded: $isSetSectionExpanded) {
                        ForEach(gameViewModel.setValues) { set in
                            Section {
                                Text("Set \(set.id)")
                                    .font(.title2)
                                SimpleSetView(set: set)
                            }
                        }
                    }
                    .onTapGesture {
                        isSetSectionExpanded.toggle()
                    }
                }
                Button {
                    Task {
                        
                        await gameViewModel.doneCreatingGame()
                    }
                } label: {
                    Rectangle()
                        .overlay {
                            Text("Save Game")
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
                        .opacity(!gameViewModel.hasSelectedPlayers ? 0.5 : 1)
                }
                .disabled(!gameViewModel.hasSelectedPlayers)
            }
            .alert("Something went wrong saving the game.  Please try again", isPresented: showSaveAlert ) {
                Button("Confirm") {
                    gameViewModel.resetState()
                }
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
    
    struct SelectPlayerRow: View {
        let isSelected: Bool
        let player: Player
        
        var body: some View {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                
                Text(player.name)
            }
        }
    }
}

#Preview("Add game view") {
    NavigationStack {
        AddGameView(gameViewModel: GameViewModel.preview, newGameAdded: .constant(false))
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
