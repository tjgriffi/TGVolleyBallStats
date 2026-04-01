//
//  AddRallyView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 2/8/26.
//

import SwiftUI

struct AddRallyView: View {
    @State private var rallyStart: RallyStart = .receive
    @State private var pointGained: Bool = false
    @State private var rotation: Int = 1
    @State private var showAddRallySheet: Bool = false
    
    @State private var entries: [PlayerAndStat] = []
    
    @State private var selectedName: String?
    @State private var selectedStat: Stats?
    
    @Binding var isPresented: Bool
    
    var gameViewModel: GameViewModel

    var body: some View {
        VStack {
            RallyContextBarView(rotation: $rotation, startedServe: $rallyStart, pointWon: $pointGained)
            
            RotationPickerView(rotation: $rotation)
            
            Button {
                showAddRallySheet = true
            } label: {
                Text("Add Statistic")
            }
            
            List {
                ForEach(entries) { entry in
                    StatRow(playerStat: entry)
                        .swipeActions {
                            Button(role: .destructive) {
                                entries.removeAll { $0.id == entry.id }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            selectedName = entry.player
                            selectedStat = entry.stat
                            showAddRallySheet = true
                        }
                }
            }
        }
        .toolbar {
            Button {
                gameViewModel.doneCreatingRally(
                    entries: entries,
                    pointGained: pointGained,
                    rallyStart: rallyStart,
                    rotation: rotation)
                isPresented = false
            } label: {
                Text("Done")
            }
        }
        .sheet(isPresented: $showAddRallySheet) {
            // Update the values on dismissal of the sheet
            self.selectedName = nil
            self.selectedStat = nil
        } content: {
            if let name = selectedName, let stat = selectedStat {
                AddRallySheet(
                    playerNames: gameViewModel.game.playerIDs.map { $0.uuidString /*MARK: Need to address this issue (uuid is not a name) */ },
                    selectedName: name,
                    selectedStat: stat,
                    entries: $entries, indexToEdit: entries.firstIndex(where: { entry in
                        return entry.player == name && entry.stat == stat
                    }) ?? -1
                )
            } else {
                AddRallySheet(
                    playerNames: gameViewModel.game.playerIDs.map { $0.uuidString /*MARK: Need to address this issue (uuid is not a name) */ },
                    entries: $entries
                )
            }
        }
    }
}

struct RallyContextBarView: View {
    @Binding var rotation: Int
    @Binding var startedServe: RallyStart
    @Binding var pointWon: Bool
    
    var body: some View {
        
        HStack {
            Label("R\(rotation)", image: "arrow.triangle.2.circlepath.circle.fill")
            
            Picker("", selection: $startedServe) {
                Text("Serve").tag(RallyStart.serve)
                Text("Received").tag(RallyStart.receive)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 180)
            
            Spacer()
            
            Picker("", selection: $pointWon) {
                Text("Won").tag(true)
                Text("Lost").tag(false)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 160)
        }
        .background(.thinMaterial)
        
    }
}

struct RotationPickerView: View {

    @Binding var rotation: Int
    let positions = [1,2,3,4,5,6]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(), count: 3)) {
            ForEach(positions, id: \.self) { position in
                
                Button("R\(position)") {
                    rotation = position
                }
            }
        }
    }
}

struct StatRow: View {
    
    let playerStat: PlayerAndStat
    
    var body: some View {
        
        HStack {
            Text(playerStat.player)
                .font(.headline)
            
            Text(playerStat.stat.rawValue)
                .foregroundStyle(.secondary)
        }
    }
}

struct AddRallySheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let playerNames: [String]
    
    @State var selectedName: String?
    @State var selectedStat: Stats?
    
    @Binding var entries: [PlayerAndStat]
    var indexToEdit: Int = -1
    
    var body: some View {
        NavigationStack {
            List {
                Section("Names") {
                    ForEach(playerNames, id: \.self) { name in
                        HStack {
                            Text(name)
                            
                            Spacer()
                            
                            if selectedName == name {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            selectedName = name
                        }
                    }
                }
                
                Section("Stats") {
                    
                    ForEach(Stats.allCases) { stat in
                        
                        HStack {
                            Text(stat.rawValue)
                            
                            Spacer()
                            
                            if selectedStat == stat {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            selectedStat = stat
                        }
                    }
                }
            }
            .navigationTitle("Add Stat")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(indexToEdit != -1 ? "Edit" : "Add") {
                        if let name = selectedName,
                           let stat = selectedStat {
                            
                            if indexToEdit > -1 && indexToEdit < entries.count {
                                entries[indexToEdit] = PlayerAndStat(player: name, stat: stat)
                            } else {
                                entries.append(PlayerAndStat(player: name, stat: stat))
                            }
                            dismiss()
                        }
                    }
                    .disabled(selectedName == nil || selectedStat == nil)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddRallyView(
            isPresented: .constant(true),
            gameViewModel: GameViewModel.preview)
    }
}
