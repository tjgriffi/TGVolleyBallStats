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
                        Text("R\(rally.rotation), Began with: \(rally.rallyStart.rawValue), Point \(rally.point == 0 ? "Lost" : "Won" )")
                    }
                }
            }
            
            // Have a button for adding a new rally
            Button {
                showAddRallyView = true
            } label: {
                Text("Add Rally")
            }

        }
        .toolbar {
            Button("Done") {
                // Gather all of the rally data, and create a new Set for our game
                gameViewModel.doneCreatingSetClicked()
                
                // We should go back to the Add Game View
                dismiss()
            }
        }
        .navigationDestination(isPresented: $showAddRallyView) {
            AddRallyView(isPresented: $showAddRallyView, gameViewModel: gameViewModel)
        }
        .navigationTitle("Current Set")

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
