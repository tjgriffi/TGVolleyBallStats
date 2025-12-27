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
            SimpleStatsChartHeaderView(focusedStat: focusedStat, playerDetailsViewModel: playerDetailsViewModel)
                .aspectRatio(1, contentMode: .fit)
            
            Chart(playerDetailsViewModel.last10GamesWithStats) { game in
                LineMark(x: .value("dates", game.date), y: .value("kill percentage", game.killPercentage.value))
                    .foregroundStyle(by: .value("Stats", "Stats"))
                LineMark(x: .value("dates", game.date), y: .value("trend point", game.killPercentage.trendPoint))
                    .foregroundStyle(by: .value("Trendline", "Trendline"))
            }
            .chartForegroundStyleScale(["Trendline": .purple , "Stats": .blue])
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    func generatePercentage(_ value: Double?) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let value = value, let formattedPercentage = numberFormatter.string(from: NSNumber(value: value)) else {
            return nil
        }
        
        return formattedPercentage
    }
}

#Preview {
    SimpleStatsLineChartView(focusedStat: .kill, playerDetailsViewModel: .preview)
        .padding()
}
