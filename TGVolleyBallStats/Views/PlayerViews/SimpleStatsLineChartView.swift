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
            VStack {
                Chart(playerDetailsViewModel.last10Games) { game in
                    LineMark(x: .value("dates", game.date), y: .value("kill percentage", game.killPercentage))
                        .foregroundStyle(by: .value("Stats", "Stats"))
                }
                .chartLegend(.hidden)
                .aspectRatio(1, contentMode: .fit)
                
                if let trendLine = playerDetailsViewModel.generateTrendLine(stats: playerDetailsViewModel.getAListOfStat(focusedStat)) {
                    let indexAndPoints = playerDetailsViewModel.generateAListOfTrendPoints(trendline: trendLine, stat: focusedStat)
                    Text("There appears to be a ")
                    if trendLine.slope > 0 {
                        Text("positve ")
                            .bold()
                            .foregroundStyle(.blue)
                    } else if trendLine.slope < 0 {
                        Text("negative ")
                            .bold()
                            .foregroundStyle(.red)
                    } else {
                        Text("stable ")
                            .bold()
                    }
                    Text("trend with your recent games")
                    Chart(indexAndPoints, id: \.0) { value in
                        
                        LineMark(x: .value("index", value.0), y: .value("trend points", value.1))
                            .foregroundStyle(by: .value("Trendline", "Trendline"))
                    }
//                    .chartXAxis(.hidden)
//                    .chartYAxis(.hidden)
//                    .chartLegend(.hidden)
                    .chartForegroundStyleScale(["Trendline": .purple, "Stats": .blue])
                    .chartYScale(domain: [0,1.0])
                    .aspectRatio(1, contentMode: .fit)
                }
            }
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
