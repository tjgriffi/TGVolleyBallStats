//
//  PlayerDetailsGridView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/31/25.
//

import SwiftUI
import Charts

struct PlayerDetailsGridView: View {
    let focusedStat: ChartPlayerStats
    let listOfStats: [GameDateStatTrendPoint]
    
    var body: some View {
        Grid(alignment: .center) {
            GridRow {
                Text("Date")
                Text(focusedStat.termForPlayerDetailsGrid())
            }
            Divider()
            ForEach(listOfStats) { game in
                
                GridRow {
                    Text(generateDateForGrid(date: game.date) ?? "")
                    Text(generatePercentage(game.stat) ?? "")
                }
                Divider()
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
    
    func generateDateForGrid(date: Date) -> String? {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter.string(from: date)
    }
}

#Preview {
    PlayerDetailsGridView(focusedStat: .kill, listOfStats: PlayerDetailsViewModel.preview.getAListOfStat(.kill))
        .padding()
}
