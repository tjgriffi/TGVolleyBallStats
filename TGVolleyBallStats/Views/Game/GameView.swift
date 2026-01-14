//
//  ContentView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import SwiftUI

struct RallyFinalScore {
    var home: Int
    var away: Int
}

struct GameView: View {
    
    let gameViewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text(formattedGameDate())
                .font(.title)
            List {
                ForEach(gameViewModel.setValues) { set in
                    Section {
                        Text("Set \(set.id)")
                            .font(.title2)
                        SimpleSetView(set: set)
                    }
                }
            }
        }
    }
    
    func formattedGameDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: gameViewModel.game.date)
    }
}

import Charts

struct SimpleSetView: View {
    let set: GameViewModel.SetValues
    
    var body: some View {
        VStack {
            HStack {
                Text("Best Rotation ")
                Text(String(set.bestRotation.rotation))
                    .foregroundStyle(.blue)
            }
            HStack {
                Text("With the following points gained")
                Text(String(set.bestRotation.pointsGained))
                    .foregroundStyle(.blue)
            }
            HStack {
                Text("Worst Rotation ")
                Text(String(set.worstRotation.rotation))
                    .foregroundStyle(.red)
            }
            HStack {
                Text("With the following points lost")
                Text(String(set.worstRotation.pointsLost))
                    .foregroundStyle(.red)
            }
            Chart {
                // MARK: TODO- Add in logic for showing and hiding the stats we want to see or dont want to see
                BarMark(x: .value("kills","kills"), y: .value("total kills", set.kills))
                BarMark(x: .value("aces", "aces"), y: .value("total aces", set.aces))
                BarMark(x: .value("digs","digs"), y: .value("total digs", set.digs))
                BarMark(x: .value("passes","passes"), y: .value("total good passes", set.passes))
                BarMark(x: .value("kill block", "kill block"), y: .value("total kill blocks", set.killBlocks))
                BarMark(x: .value("blocks", "blocks"), y: .value("total blocks", set.blocks))
                
                BarMark(x: .value("hitting errors","hitting errors"), y: .value("total hitting errors", set.hittingErrors))
                    .foregroundStyle(.pink)
                BarMark(x: .value("bad passes", "bad passes"), y: .value("total bad passes", set.shanks))
                    .foregroundStyle(.pink)
                BarMark(x: .value("serve errors", "serve errors"), y: .value("total serve errors", set.serveErrors))
                    .foregroundStyle(.pink)
                BarMark(x: .value("block errors", "block errors"), y: .value("total block errors", set.blockingErrors))
                    .foregroundStyle(.pink)
            }
        }
    }
}

#Preview {
    GameView(gameViewModel: .preview)
}
