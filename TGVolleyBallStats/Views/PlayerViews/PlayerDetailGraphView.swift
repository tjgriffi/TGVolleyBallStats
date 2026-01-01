//
//  PlayerDetailGraphView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/31/25.
//

import SwiftUI
import Charts

struct PlayerDetailGraphView: View {
    var listOfStats: [GameDateStatTrendPoint]
    
    var body: some View {
        Chart(listOfStats, id: \.date) { game in
            LineMark(x: .value("dates", game.date), y: .value("stat percentage", game.stat))
                .foregroundStyle(by: .value("Stats", "Stats"))
            LineMark(x: .value("dates", game.date), y: .value("trend point", game.trendPoint))
                .foregroundStyle(by: .value("Trendline", "Trendline"))
        }
        .aspectRatio(1, contentMode: .fit)
        .chartForegroundStyleScale(["Trendline": .purple , "Stats": .blue])
    }
    
}


#Preview {
    PlayerDetailGraphView(listOfStats: PlayerDetailsViewModel.preview.getAListOfStat(.dig))
}
