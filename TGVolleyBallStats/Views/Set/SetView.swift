//
//  SetView.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 11/28/25.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var setViewModel: SetViewModel
    @Environment(\.router) private var router
    
    var body: some View {
        Text("Set 1")
            .font(.title2)
        List {
            ForEach(setViewModel.rallies) { rally in
                // TODO: Uncomment when ready to test the file
//                RallyView(rally: rally)
            }
            addRallyButton
        }
    }
    
    private var addRallyButton: some View {
        Button(
            action: {
                router.navigate(to: .addRally { rally in
                    setViewModel.addRally(rally: rally)
                })
            }, label: {
                Text("Add Rally")
                    .font(.title)
            }
        )
    }
}

struct SetRallyView: View {
    let rally: Rally
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Rotation: \(rally.rotation)")
                Spacer()
                Text("\(rally.rallyStart)")
                Spacer()
                Text("\(rally.point)")
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    switch rally.rallyStart {
                    case .serve:
                        Text("Player: \(rally.stats.last?.player ?? "Default Name")")
                    case .receive:
                        Text("Player: \(rally.stats.last?.player ?? "Default Name")")
                    }
                    
                    Spacer()
                    Text("\(rally.stats.last?.stat ?? .freeBallError)")
                }
            }
        }
        .onTapGesture {
            // TODO: Navigate to the add rally view with the rally as an input
        }
    }
}



//#Preview {
//    SetView()
//}
