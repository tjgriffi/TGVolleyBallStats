//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct GameView: View {
    var gameViewModel: GameViewModel
    @Environment(\.router) private var router
    
    var body: some View {
        Text(gameViewModel.gameName)
            .font(.title)
        NavigationStack {
            ForEach(gameViewModel.sets) { volleyballSet in
                
                GameSetView(
                    setNumber: SetViewNumber.first, finalScores: gameViewModel.getSetScores(for: volleyballSet)
                )
            }
            .navigationTitle("Game Screen")
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

struct GameSetView: View {
    private(set) var setNumber: SetViewNumber
    var finalScores: RallyFinalScore
    
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
                    Text("\(finalScores.home) - \(finalScores.away)")
                        .foregroundStyle(.white)
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
            }
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

struct RallyFinalScore {
    var home: Int
    var away: Int
}

#Preview {
    GameView(gameViewModel: .preview)
}
