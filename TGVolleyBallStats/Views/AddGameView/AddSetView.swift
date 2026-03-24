//
//  AddSetView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 2/10/26.
//


import SwiftUI

struct AddSetView: View {
    @Environment(\.dismiss) private var dismiss
    let gameViewModel: GameViewModel

    @State private var showAddRallyView: Bool = false
    
    var body: some View {
        VStack {

            // Show a list of current Rallies
            List {
                Section("Rally Results") {
                    ForEach(gameViewModel.rallies, id: \.id) { rally in
                        AddSetRallyRow(rally: rally, showAddRally: $showAddRallyView)
                    }
                }
                
                Section("Save changes") {
                    Button("Save") {
                        // Gather all of the rally data, and create a new Set for our game
                        gameViewModel.doneCreatingSetClicked()
                        
                        // We should go back to the Add Game View
                        dismiss()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                // Have a button for adding a new rally
                Button("Add Rally") {
                    showAddRallyView = true
                }
            }
        }
        .navigationDestination(isPresented: $showAddRallyView) {
            AddRallyView(isPresented: $showAddRallyView, gameViewModel: gameViewModel)
        }
        .navigationTitle("Current Set")

    }
}

struct AddSetRallyRow: View {
    
    let rally: Rally
    @Binding var showAddRally: Bool
    
    var body: some View {
        Button {
            showAddRally = true
        } label: {
            Text("R\(rally.rotation), Began with: \(rally.rallyStart.rawValue), Point \(rally.point == 0 ? "Lost" : "Won" )")
        }
        .tint(.black)
    }
}

#Preview("No Sets") {
    NavigationStack {
        AddSetView(gameViewModel: GameViewModel.previewNoSets)
    }
}

#Preview("No Sets, full rallies") {
    NavigationStack {
        AddSetView(gameViewModel: .previewNoSetsFullRally)
    }
}
