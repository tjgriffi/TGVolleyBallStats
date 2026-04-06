//
//  ChoosePlayerView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 3/25/26.
//

import SwiftUI

struct ChoosePlayerView: View {
    
    @State var choosePlayerVM: ChoosePlayerVM
    @State private var showAddPlayerView: Bool = false
    
    var body: some View {
        ZStack {
            List(choosePlayerVM.players) { player in
                NavigationLink {
                    PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
                } label: {
                    Text(player.name)
                }
            }
            .task {
                choosePlayerVM.getPlayers()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddPlayerView.toggle()
                    } label: {
                        if showAddPlayerView {
                            Text( "Close")
                        } else {
                            Text("Add Player")
                        }
                    }
                    
                }
            }
            .onChange(of: showAddPlayerView) { oldValue, newValue in
                // TODO: Look into a more robust way of triggering this
                if newValue == false {
                    Task {
                        choosePlayerVM.getPlayers()
                    }
                }
            }
            
            if showAddPlayerView {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showAddPlayerView.toggle()
                    }
                
                AddNewPlayerView(addNewPlayerVM: AddNewPlayerVM(playerRepository: choosePlayerVM.playerRepositry), shouldViewBeDismissed: $showAddPlayerView)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 20)
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChoosePlayerView(
            choosePlayerVM: ChoosePlayerVM(playerRepository: CDPlayerRepository(
                context: StorageManager.preview.container.viewContext)
            ))
            .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
    }
}
