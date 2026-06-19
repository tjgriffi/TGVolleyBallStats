//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct RallyFinalScore: Hashable {
    var home: Int
    var away: Int
}

struct GameView: View {
    
    let gameViewModel: GameViewModel
    
    @Binding var wasGamesUpdated: Bool
    @State var selectedSetValues: GameViewModel.SetValues?
    
    var body: some View {
        VStack {
            Text(formattedGameDate())
                .font(.title)
//            List(selection: $selectedSetValues) {
                List(gameViewModel.setValues, selection: $selectedSetValues) { setValue in
                    NavigationLink {
                        
                        // MARK: Don't do this instead go directly to the SetView to edit it
                        // Go to the AddGameView with an already completed Game
//                        AddGameView(gameViewModel: gameViewModel, wasGamesUpdated: $wasGamesUpdated)
                        
                        // Go to the AddSetView with an already completed set
                        AddSetView(gameViewModel: gameViewModel)
                    } label: {
                        Section {
                            Text("Set \(setValue.id)")
                                .font(.title2)
                            SimpleSetView(set: setValue)
                        }
                    }
                    .onTapGesture {
                        // Update the selectedVSet of the gameViewModel
                        if let selectedSetValues {
                            gameViewModel.selectedVSet(with: selectedSetValues)
                        }
                    }
                }
//            }
        }
    }
    
    func formattedGameDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: gameViewModel.game.date)
    }
}

#Preview {
    GameView(gameViewModel: .preview, wasGamesUpdated: .constant(true))
}
