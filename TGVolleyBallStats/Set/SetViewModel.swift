//
//  RallyViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import Foundation

struct Rally: Identifiable {
    var id = UUID()
    let rotation: Int
    let rallyStart: RallyStart
    let point: Int
    let stats: [PlayerAndStat]
}

class SetViewModel: ObservableObject {
    
    @Published private(set) var rallies: [Rally]
    
    init(rallies: [Rally]) {
        self.rallies = rallies
    }
    
    func addRally(rally: Rally) {
        rallies.append(rally)
    }
}
