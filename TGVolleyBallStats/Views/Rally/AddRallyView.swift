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
            
            StatisticView(rotation: $rotation, rallyStart: $rallyStart, pointGained: $pointGained)
            
            List {
                Section("Rally Statistics") {
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
            
        }
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction ) {
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
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddRallySheet = true
                } label: {
                    Text("Add Statistic")
                }
            }
            
        }
        .sheet(isPresented: $showAddRallySheet) {
            // Update the values on dismissal of the sheet
//            self.selectedName = nil
//            self.selectedStat = nil
        } content: {
            if let name = selectedName, let stat = selectedStat {
                AddRallySheet(
                    playerNames: gameViewModel.getSelectedPlayers().map({ player in
                        player.name
                    }),
                    selectedName: name,
                    selectedStat: stat,
                    entries: $entries, indexToEdit: entries.firstIndex(where: { entry in
                        return entry.player == name && entry.stat == stat
                    }) ?? -1
                )
            } else {
                AddRallySheet(
                    playerNames:
                        gameViewModel.getSelectedPlayers().map({ player in
                        player.name
                    }),
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

struct StatisticView: View {
    
    @Binding var rotation: Int
    @Binding var rallyStart: RallyStart
    @Binding var pointGained: Bool
    
    var body: some View {
        List {
            Section {
                Picker("Rotation", selection: $rotation) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                }
                .pickerStyle(.menu)
            }
            
            Section {
                Picker("Rally start", selection: $rallyStart) {
                    Text("Serve").tag(RallyStart.serve)
                    Text("Receive").tag(RallyStart.receive)
                }
                .pickerStyle(.menu)
                
            }
            
            Section {
                Picker("Won or Lost", selection: $pointGained) {
                    Text("Won").tag(true)
                    Text("Lost").tag(false)
                }
                .pickerStyle(.menu)
            }
            
        }
        .scrollDisabled(true)
    }
}

#Preview {
    NavigationStack {
        AddRallyView(
            isPresented: .constant(true),
            gameViewModel: GameViewModel.preview)
    }
}

#Preview("AddRallySheet") {
    AddRallySheet(
        playerNames: [VBSConstants.coreDataPlayerName1, VBSConstants.coreDataPlayerName1],
        selectedName: nil,
        selectedStat: nil,
        entries: .constant([PlayerAndStat]()), indexToEdit: 0)
}

#Preview("StatisticView") {
    StatisticView(rotation: .constant(1), rallyStart: .constant(.serve), pointGained: .constant(true))
}
