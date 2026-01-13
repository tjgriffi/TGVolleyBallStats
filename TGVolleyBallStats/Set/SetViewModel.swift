//
//  RallyViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/13/25.
//

import Foundation

class SetViewModel: ObservableObject {
    
    @Published private(set) var rallies: [Rally]
    
    init(rallies: [Rally]) {
        self.rallies = rallies
    }
    
    func addRally(rally: Rally) {
        rallies.append(rally)
    }
}
