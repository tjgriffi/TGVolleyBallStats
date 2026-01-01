//
//  SimpleStatsChartHeaderView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/26/25.
//

import SwiftUI

struct SimpleStatsChartHeaderView: View {
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
        if let improvement = playerDetailsViewModel.getImprovementFromLastGame(stat: focusedStat) {
            VStack {
                HStack {
                    Image(systemName: improvement > 0 ? "arrow.up.right" : "arrow.down.right")
                        .foregroundStyle(improvement > 0 ? .blue : .red)
                        .bold()
                    Text("Your ") +
                    Text(focusedText) +
                    Text(" has ")
                }
                HStack {
                    improvementView(improvement: improvement)
                    Text("since this last game")
                }
            }
        }
    }
    
    struct improvementView: View {
        
        let improvement: Double
        
        var body: some View {
            HStack {
                if improvement > 0 {
                    Text("improved ")
                        .bold()
                    + Text("by ")
                    + Text(generatePercentage(improvement)!)
                        .foregroundStyle(.blue)
                        .bold()
                } else if improvement < 0 {
                    Text("decreased ")
                        .bold()
                    + Text("by ")
                    + Text(generatePercentage(improvement)!)
                        .foregroundStyle(.red)
                        .bold()
                } else {
                    Text("not changed ")
                        .bold()
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
}

#Preview {
    SimpleStatsChartHeaderView(focusedStat: .kill, playerDetailsViewModel: .preview)
        .padding()
}
