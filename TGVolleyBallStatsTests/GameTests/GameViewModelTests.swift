//
//  GameViewModelTests.swift
//  TGVolleyBallStatsTests
//
//  Created by Terrance Griffith on 6/18/26.
//

import Foundation
import Testing
@testable import TGVolleyBallStats

struct GameViewModelTests {
    
    struct MockGameRepository: GameRepository {
        func saveGame(_ game: TGVolleyBallStats.Game) async throws {
            
        }
        
        func getGame(with id: UUID) -> TGVolleyBallStats.Game? {
            return nil
        }
        
        func deleteGame(withID id: UUID) {

        }
        
        func getGames() -> [TGVolleyBallStats.Game] {
            return []
        }
    }
    
    struct MockPlayerRepository: PlayerRepository {
        func savePlayer(_ name: String) async throws {
            
        }
        
        func getPlayers(with ids: [UUID]) -> [TGVolleyBallStats.Player] {
            return []
        }
        
        func deletePlayer(withID id: UUID) throws {
            
        }
        
        func getPlayers() -> [TGVolleyBallStats.Player] {
            []
        }
        
        func updatePlayer(with player: TGVolleyBallStats.Player) async throws {
            
        }
    }
    
    /// Helper enum that determines the sets a game should have
    private enum GameState {
        case noSets
        case standard
    }
    
    /// Helper function for generating games with different set states
    /// - Parameter gameState: Enum that dictates sets the game should be generated
    /// - Returns: A game object with the state specified by `gameState`
    private func setupGame(gameState: GameState) -> Game {
        let playerIDs = Player.examples.map { $0.id }
        
        var vSets: [VSet]
        switch gameState {
        case .noSets:
            vSets = []
        case .standard:
            vSets = (1...3).map { _ in VSet.generateSet(withPlayers: Player.examples) }
        }
        
        return Game(
            id: UUID(),
            date: Date(),
            players: playerIDs,
            sets: vSets
        )
    }

    @Test func set_has_been_added_to_game_with_no_sets() async throws {
        // Given
        let game = setupGame(gameState: .noSets)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        var vSet = VSet.example
        let comparedVSet = vSet
        
        let gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        #expect(gameViewModel.setValues.isEmpty)
        #expect(gameViewModel.game.sets.isEmpty)
        
        let expectedSetValuesSize = gameViewModel.setValues.count + 1
        let expectedSetSize = gameViewModel.game.sets.count + 1
        
        // When
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues should have increased by 1")
        #expect(gameViewModel.game.sets.count == expectedSetSize, "The game's sets should have increased by 1")
        #expect(gameViewModel.currentRotation == 1, "Current rotation should reset to 1")
        
        guard let lastSet = gameViewModel.game.sets.last else {
            Issue.record("Set was removed so there is no set to compare")
            return
        }
        
        #expect(lastSet.id == vSet.id, "The last set should be the one that was selected")
        
    }
    
    @Test func set_has_been_added_to_game_with_sets() async throws {
        // Given
        let game = setupGame(gameState: .standard)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        var vSet = VSet.example
        let comparedVSet = vSet
        
        let gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        #expect(!gameViewModel.setValues.isEmpty)
        #expect(!gameViewModel.game.sets.isEmpty)
        
        let expectedSetValuesSize = gameViewModel.setValues.count + 1
        let expectedSetSize = gameViewModel.game.sets.count + 1
        
        // When
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues should have increased by 1")
        #expect(gameViewModel.game.sets.count == expectedSetSize, "The game's sets should have increased by 1")
        #expect(gameViewModel.currentRotation == 1, "Current rotation should reset to 1")
        
    }
    
    @Test func set_has_not_been_edited_with_no_sets_in_game() async throws {
        // Given
        let game = setupGame(gameState: .noSets)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        let gameViewModel = GameViewModel(game: game,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        let expectedSetValuesSize = 0
        let expectedSetSize = 0
        
        gameViewModel.currentRotation = .random(in: (1...6))
        let expectedRotation = gameViewModel.currentRotation
        
        #expect(gameViewModel.setValues.isEmpty)
        #expect(gameViewModel.game.sets.isEmpty)
        #expect(gameViewModel.selectedVSet == nil)
        
        // When
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues count should be 0")
        #expect(gameViewModel.game.sets.count == expectedSetSize, "The game's sets count should be 0")
        #expect(gameViewModel.currentRotation == expectedRotation, "The rotation should not have changed")
        #expect(gameViewModel.selectedVSet == nil)
    }
    
    @Test func set_has_been_edited_with_sets_in_game_remove_rally() async throws {
        // Given
        let game = setupGame(gameState: .standard)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        // Remove a rally from the volleyball set
        var vSet = VSet.example
        let comparedVSet = vSet
        let removedRally = vSet.rallies.removeLast()
        
        // Add the set to the game
        game.sets.append(comparedVSet)
        
        var gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        let expectedSetValuesSize = gameViewModel.setValues.count
        let expectedSetSize = gameViewModel.game.sets.count
        
        gameViewModel.currentRotation = .random(in: (1...6))
        let expectedRotation = gameViewModel.currentRotation
        
        
        // Initial checks
        guard let _ = gameViewModel.selectedVSet else {
            Issue.record("A set was not selected for editing", severity: .error)
            return
        }
        
        #expect(!gameViewModel.setValues.isEmpty)
        #expect(!gameViewModel.game.sets.isEmpty)
        
        // When
        
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues count should have stayed the same")
        #expect(gameViewModel.game.sets.count == expectedSetValuesSize, "The game's sets count should have stayed the same")
        #expect(gameViewModel.currentRotation == expectedRotation, "The rotation should not have changed")
        #expect(gameViewModel.selectedVSet == nil, "Should be reset to nil")
        
        guard let lastSet = gameViewModel.game.sets.last else {
            Issue.record("Set was removed so there is no set to compare")
            return
        }
        
        #expect(lastSet.rallies.count == (comparedVSet.rallies.count - 1), "One set should have been removed")
        #expect(!lastSet.rallies.contains(where: { $0.id == removedRally.id }), "The set should not contain the removed rally")
        
    }
    
    @Test func set_has_been_edited_with_sets_in_game_add_rally() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        // Given
        let game = setupGame(gameState: .standard)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        // Add a rally to the volleyball set
        var vSet = VSet.example
        let comparedVSet = vSet
        
        let addedRally = Rally.example
        vSet.rallies.append(addedRally)
        
        // Add the set to the game
        game.sets.append(comparedVSet)
        
        let gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        let expectedSetValuesSize = gameViewModel.setValues.count
        let expectedSetSize = gameViewModel.game.sets.count
        
        gameViewModel.currentRotation = .random(in: (1...6))
        let expectedRotation = gameViewModel.currentRotation
        
        
        // Initial checks
        guard let _ = gameViewModel.selectedVSet else {
            Issue.record("A set was not selected for editing", severity: .error)
            return
        }
        
        #expect(!gameViewModel.setValues.isEmpty)
        #expect(!gameViewModel.game.sets.isEmpty)
        
        // When
        
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues count should have stayed the same")
        #expect(gameViewModel.game.sets.count == expectedSetValuesSize, "The game's sets count should have stayed the same")
        #expect(gameViewModel.currentRotation == expectedRotation, "The rotation should not have changed")
        #expect(gameViewModel.selectedVSet == nil, "Should be reset to nil")
        
        guard let lastSet = gameViewModel.game.sets.last else {
            Issue.record("Set was removed so there is no set to compare")
            return
        }
        
        #expect(lastSet.rallies.count == (comparedVSet.rallies.count + 1), "One set should have been added")
        #expect(lastSet.rallies.contains(where: { $0.id == addedRally.id }), "The set should contain the added rally")
        
    }
    
    @Test func set_has_been_edited_with_sets_in_game_change_a_rally() async throws {

        // Given
        let game = setupGame(gameState: .standard)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        // Change the rally to the volleyball set
        var vSet = VSet.example
        var comparedVSet = vSet
        
        let originalRally = Rally.example
        var modifiedOriginalRally = originalRally
        
        modifiedOriginalRally.point = -1
        
        comparedVSet.rallies.append(originalRally)
        vSet.rallies.append(modifiedOriginalRally)
        
        // Add the set to the game
        game.sets.append(comparedVSet)
        
        var gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        let expectedSetValuesSize = gameViewModel.setValues.count
        let expectedSetSize = gameViewModel.game.sets.count
        
        gameViewModel.currentRotation = .random(in: (1...6))
        let expectedRotation = gameViewModel.currentRotation
        
        
        // Initial checks
        guard let _ = gameViewModel.selectedVSet else {
            Issue.record("A set was not selected for editing", severity: .error)
            return
        }
        
        #expect(expectedSetValuesSize != 0)
        #expect(expectedSetSize != 0)
        
        // When
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues count should have stayed the same")
        #expect(gameViewModel.game.sets.count == expectedSetValuesSize, "The game's sets count should have stayed the same")
        #expect(gameViewModel.currentRotation == expectedRotation, "The rotation should not have changed")
        #expect(gameViewModel.selectedVSet == nil, "Should be reset to nil")
        
        guard let lastSet = gameViewModel.game.sets.last else {
            Issue.record("Set was removed so there is no set to compare")
            return
        }
        
        #expect(lastSet.rallies.count == comparedVSet.rallies.count, "Sets should have the same count")
        
        guard let editedRally = lastSet.rallies.first(where: { $0.id == modifiedOriginalRally.id }) else {
            Issue.record("The edited rally could not be found")
            return
        }
        
        #expect(editedRally.point != originalRally.point, "edited rally should have a different point value")
        
    }
    
    @Test func random_set_in_game_with_sets_is_edited() async throws {
        
        // Given
        let game = setupGame(gameState: .standard)
        let playerRepo = MockPlayerRepository()
        let gameRepo = MockGameRepository()
        
        // Change the rally to the volleyball set
        var vSet = game.sets[Int.random(in: 0...(game.sets.count-1))]
        var comparedVSet = vSet
        
        let originalRally = Rally.example
        var modifiedOriginalRally = originalRally
        
        modifiedOriginalRally.point = -1
        
        comparedVSet.rallies.append(originalRally)
        vSet.rallies.append(modifiedOriginalRally)
        
        // Add the set to the game
        game.sets.append(vSet)
        
        var gameViewModel = GameViewModel(game: game,
                                          selectedVSet: vSet,
                                          playerRepository: playerRepo,
                                          gameRepository: gameRepo)
        
        let expectedSetValuesSize = gameViewModel.setValues.count
        let expectedSetSize = gameViewModel.game.sets.count
        
        gameViewModel.currentRotation = .random(in: (1...6))
        let expectedRotation = gameViewModel.currentRotation
        
        
        // Initial checks
        guard let _ = gameViewModel.selectedVSet else {
            Issue.record("A set was not selected for editing", severity: .error)
            return
        }
        
        #expect(expectedSetValuesSize != 0)
        #expect(expectedSetSize != 0)
        
        // When
        gameViewModel.doneCreatingSetClicked()
        
        // Then
        #expect(gameViewModel.setValues.count == expectedSetValuesSize, "The setValues count should have stayed the same")
        #expect(gameViewModel.game.sets.count == expectedSetValuesSize, "The game's sets count should have stayed the same")
        #expect(gameViewModel.currentRotation == expectedRotation, "The rotation should not have changed")
        #expect(gameViewModel.selectedVSet == nil, "Should be reset to nil")
        
        guard let modifiedSet = gameViewModel.game.sets.first(where: { $0.id == vSet.id }) else {
            Issue.record("Set was removed so there is no set to compare")
            return
        }
        
        #expect(modifiedSet.rallies.count == comparedVSet.rallies.count, "Sets should have the same count")
        
        guard let editedRally = modifiedSet.rallies.first(where: { $0.id == modifiedOriginalRally.id }) else {
            Issue.record("The edited rally could not be found")
            return
        }
        
        #expect(editedRally.point != originalRally.point, "edited rally should have a different point value")
    }

}
