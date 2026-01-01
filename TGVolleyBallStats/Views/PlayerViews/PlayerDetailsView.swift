//
//  PlayerDetailedView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import SwiftUI
import Charts

struct PlayerDetailsView: View {
    let playerDetailsViewModel: PlayerDetailsViewModel
    let focusedStat: ChartPlayerStats
    
    var body: some View {
        List {
            let listOfStats = playerDetailsViewModel.getAListOfStat(focusedStat)
            Group {
                Section {
                    SimpleStatsChartHeaderView(focusedStat: focusedStat, playerDetailsViewModel: playerDetailsViewModel)
                    
                }
                Section {
                    trendLineHeaderView(trendLine: playerDetailsViewModel.getTrendlineForStat(stat: focusedStat) ?? TrendLine(slope: 0.0, intercept: 0.0, rSquared: 0.0))
                }
                PlayerDetailGraphView(listOfStats: listOfStats)
                
                PlayerDetailsGridView(focusedStat: focusedStat, listOfStats: listOfStats)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
    }
    
    struct trendLineHeaderView: View {
        var trendLine: TrendLine
        
        var body: some View {
            HStack {
                Text("Your overall trend appears to be ")
                if trendLine.slope > 0 {
                    Text("improving")
                        .bold()
                        .foregroundStyle(.blue)
                } else if trendLine.slope < 0 {
                    Text("regressing")
                        .bold()
                        .foregroundStyle(.red)
                } else {
                    Text("stable")
                        .bold()
                }
            }
        }
    }

}

#Preview {
    PlayerDetailsView(playerDetailsViewModel: .preview, focusedStat: .kill)
}
