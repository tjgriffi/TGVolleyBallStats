//
//  PlayerOverviewView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/31/25.
//

import SwiftUI

struct PlayerOverviewView: View {
    let playerDetailsViewModel: PlayerDetailsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ChartPlayerStats.allCases) { stat in
                    Section {
                        NavigationLink {
                            PlayerDetailsView(playerDetailsViewModel: playerDetailsViewModel, focusedStat: stat)
                        } label: {
                            SimpleStatsLineChartView(focusedStat: stat, playerDetailsViewModel: playerDetailsViewModel)
                        }
                    }
                }
            }
            .navigationTitle("Your Overview of Stats")
        }
    }
}

#Preview {
    PlayerOverviewView(playerDetailsViewModel: .preview)
}
