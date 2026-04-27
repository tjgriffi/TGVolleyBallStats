//
//  GameHubView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/11/26.
//

import SwiftUI

struct GameHubView: View {
    @State var gameHubViewModel: GameHubViewModel
    @State var newGamedAdded: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(gameHubViewModel.games) { game in
                    NavigationLink {
                        GameView(
                            gameViewModel: GameViewModel(
                                game: game,
                                playerRepository: gameHubViewModel.playerRepository,
                                gameRepository: gameHubViewModel.gameRepository))
                    } label: {
                        GameHubListCell(game: game)
                    }
                }
            }
            .toolbar {
                NavigationLink {
                    // TODO: Need to evaluate if we want to pass in the gameviewmodel or gamehubviewmodel and then determine how we will pass the game value around
                    // TODO: Need to determine when the creation/addition of players commences
                    AddGameView(
                        gameViewModel: GameViewModel(
                            game: Game(
                                id: UUID(),
                                date: Date(),
                                players: [],
                                sets: []),
                            playerRepository: gameHubViewModel.playerRepository,
                            gameRepository: gameHubViewModel.gameRepository),
//                        gameViewModel: .previewNoSetsFullRally,
                        newGameAdded: $newGamedAdded)
                } label: {
//                        AddGameListView()
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.blue)
                }
//                .disabled(gameHubViewModel.enableAddGameButton)
            }
        }
        .navigationTitle("Games")
        .task {
            gameHubViewModel.loadGames()
        }
        .onChange(of: newGamedAdded) { oldValue, newValue in
            if newValue == true {
                Task {
                    gameHubViewModel.loadGames()
                }
            }
            
            newGamedAdded = false
        }
    }
}

#Preview("GameHubView") {
    NavigationStack {
        GameHubView(
            gameHubViewModel: GameHubViewModel(
                gameRepository: CDGameRepository(
                    storageManager: StorageManager.preview, cache: GameCache()),
                playerRepository: CDPlayerRepository(
                    cache: PlayerCache(),
                    storageManager: .preview)))
    }
}

struct GameHubListCell: View {
    var game: Game
    
    var body: some View {
        HStack {
            Image(systemName: "volleyball")
                .aspectRatio(1, contentMode: .fill)
            VStack(alignment: .leading) {
                Text(formattedGameDate())
                    .font(.title2)
                
                // MARK: - Determine if we want to show the game opponent
                Text("Team 1 vs Team 2")
            }
        }
    }
    
    func formattedGameDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: game.date)
    }
}

struct AddGameListView: View {
    var body: some View {
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
}
