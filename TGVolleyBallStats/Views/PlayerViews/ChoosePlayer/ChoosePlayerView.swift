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
    
    private var isAddPlayerDisabled: Bool {
        switch choosePlayerVM.state {
        case .initial, .empty, .loaded:
            return false
        case .loading, .error(_):
            return true
        }
    }
    
    var body: some View {
        ZStack {
            Group {
                switch choosePlayerVM.state {
                case .initial, .empty:
                    // MARK: Make this more presentable (it looks stale at the moment)
                    Text("Please add players")
                case .loading:
                    ProgressView()
                case .loaded:
                    List(choosePlayerVM.players) { player in
                        NavigationLink {
                            PlayerOverviewView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
                        } label: {
                            Text(player.name)
                        }
                    }
                    .refreshable {
                        choosePlayerVM.getPlayers()
                    }
                case .error(let string):
                    Text("Error: \(string)")
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
                    .disabled(isAddPlayerDisabled)
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
                storageManager: StorageManager.preview)
            ))
            .environment(\.managedObjectContext, StorageManager.preview.container.viewContext)
    }
}
