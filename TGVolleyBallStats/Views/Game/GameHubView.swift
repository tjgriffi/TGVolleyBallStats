//
//  GameHubView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 1/11/26.
//

import SwiftUI

struct GameHubView: View {
    @State var gameHubViewModel: GameHubViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(gameHubViewModel.games) { game in
                        NavigationLink {
                            GameView(gameViewModel: GameViewModel(game: game))
                        } label: {
                            GameHubListCell(game: game)
                        }
                    }
                }
                NavigationLink {
                    Text("Add Game View Goes Here")
                } label: {
                    AddGameListView()
                }
            }
            .navigationTitle("Games")
        }
    }
}

#Preview("GameHubView") {
    GameHubView(gameHubViewModel: GameHubViewModel(games: [Game.example]))
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
