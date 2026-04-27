//
//  AddNewPlayerVM.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 4/2/26.
//

import Foundation

@Observable
class AddNewPlayerVM {
    
    enum AddNewPlayerVMState: Equatable {
        case initial
        case loading
        case loaded
        case error(String)
    }
    
    enum AddNewPlayerVMError: LocalizedError {
        case saveFailed
        
        var errorDescription: String? {
            switch self {
            case .saveFailed:
                return "Failed to save the user. Please try again"
            }
        }
    }
    
    private let playerRepository: PlayerRepository
    private(set) var state: AddNewPlayerVMState
    var showErrorAlert: Bool
    
    init(playerRepository: PlayerRepository, state: AddNewPlayerVMState = .initial, showErrorAlert: Bool = false) {
        self.playerRepository = playerRepository
        self.state = state
        self.showErrorAlert = showErrorAlert
    }
    
    func addNewPlayer(with name: String) async {
        
        
        guard name.count > 0, state != .loading else {
            return
        }
        
        do {
            await MainActor.run {
                state = .loading
            }
            try await playerRepository.savePlayer(name)
            
            await MainActor.run {
                state = .loaded
            }
        } catch let error as CDRepositoryError {
            
            await MainActor.run {
                state = .error(error.errorDescription ?? "Unknown issue with Repository")
                showErrorAlert = true
            }
        } catch {
            
            await MainActor.run {
                state = .error(error.localizedDescription)
                showErrorAlert = true
            }
        }
    }
    
    func resetState() {
        guard state != .loading else { return }
        
        showErrorAlert = false
        state = .initial
    }
}

//import Playgrounds
//
//#Playground {
//    let storageManager = StorageManager.preview
//    var addNewPlayerVM = AddNewPlayerVM(playerRepository: CDPlayerRepository(
//        context: storageManager.container.viewContext,
//        storageManager: storageManager
//    ))
//    
//    Task {
//        await addNewPlayerVM.addNewPlayer(with: "Mark")
//    }
//}
