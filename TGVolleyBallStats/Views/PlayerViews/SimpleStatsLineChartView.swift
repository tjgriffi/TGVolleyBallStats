//
//  SimpleStatsLineChartView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/24/25.
//

import SwiftUI
import Charts

struct SimpleStatsLineChartView: View {
    var focusedStat: ChartPlayerStats
    var playerDetailsViewModel: PlayerDetailsViewModel
    
    var focusedText: String {
        switch focusedStat {
        case .kill:
            "kill percentage"
        case .pass:
            "pass rating"
        case .freeball:
            "freeball rating"
        case .dig:
            "dig rating"
        case .points:
            "points scored"
        }
    }
    
    var body: some View {
        // HeaderView
        VStack {
            if let improvement = playerDetailsViewModel.getImprovementFromLastGame(stat: focusedStat) {
                
                let linearGradient = LinearGradient(
                    colors: improvement > 0 ?  [Color.blue.opacity(0.7), Color.blue.opacity(0.3)] : [Color.red.opacity(0.7), Color.red.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom)
                SimpleStatsChartHeaderView(focusedStat: focusedStat, improvement: improvement)
                
                Chart(playerDetailsViewModel.getAListOfStat(focusedStat), id: \.date) { game in
                    AreaMark(x: .value("dates", game.date), y: .value("stat percentage", game.stat))
                        .foregroundStyle(linearGradient)
                }
                .frame(height: 70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
            }
        }
    }
}

#Preview {
    SimpleStatsLineChartView(focusedStat: .dig, playerDetailsViewModel: .preview)
            .padding()
}
