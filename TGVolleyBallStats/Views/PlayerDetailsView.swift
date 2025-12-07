//
//  PlayerDetailedView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import SwiftUI

struct PlayerDetailsView: View {
    let playerDetailsViewModel: PlayerDetailsViewModel
    
    var body: some View {
        VStack {
            Text(playerDetailsViewModel.player.name)
            Spacer()
            if let killPercentage = playerDetailsViewModel.killPercentage {
                HStack {
                    Text("Kill Percentage: ") +
                    Text("\(killPercentage)")
                }
                .frame(width: 100)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: .blue, radius: 2)
                        .frame(width: 100, height: 100)
                }
            }
            Spacer()
            if let passRatingPercentage = playerDetailsViewModel.passRatingPercentage {
                HStack {
                    Text("Pass Rating: ") +
                    Text("\(passRatingPercentage)")
                }
                .frame(width: 100)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: .blue, radius: 2)
                        .frame(width: 100, height: 100)
                }
                
            }
            Spacer()
            if let digRatingPercentage = playerDetailsViewModel.digRatingPercentage {
                HStack {
                    Text("Dig Rating: ") +
                    Text("\(digRatingPercentage)")
                }
                .frame(width: 100)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: .blue, radius: 2)
                        .frame(width: 100, height: 100)
                }
                
            }
            Spacer()
            if let freeballRatingPercentage = playerDetailsViewModel.freeballRatingPercentage {
                HStack {
                    Text("Free Ball Rating: ") +
                    Text("\(freeballRatingPercentage)")
                }
                .frame(width: 100)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: .blue, radius: 2)
                        .frame(width: 100, height: 100)
                }
            }
            Spacer()
            HStack {
                Text("Points Scored Last Game: ") +
                Text(playerDetailsViewModel.pointsScored)
            }
            .frame(width: 100)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
                    .frame(width: 100, height: 100)
            }
            Spacer()
        }
    }
}

#Preview {
    PlayerDetailsView(playerDetailsViewModel: .preview)
}
