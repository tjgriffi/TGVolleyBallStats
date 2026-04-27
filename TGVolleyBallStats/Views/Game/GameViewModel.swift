//
//  GameViewModel 2.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 4/6/26.
//


import Foundation
import Playgrounds

@Observable
class GameViewModel {
    
    enum GameViewModelState {
        case gameSavedSuccess
        case errorSavingGame
        case initial
        case saving
    }
    
    var game: Game
    var setValues: [SetValues] = []
    var statsForCurrentRally: [PlayerAndStat] = []
    var rallies: [Rally] = []
    var vSet: [VSet] = []
    var currentRotation: Int = 1
    private var setCount = 1
    private var playerRepository: PlayerRepository
    private(set) var players: [Player] = []
    private(set) var selectedPlayers = Set<UUID>()
    private(set) var newGameAdded: Bool = false
    var hasSelectedPlayers: Bool { !selectedPlayers.isEmpty }
    private var gameSaved: Bool = false
    private var playersSaved: Bool = false
    
    func toggleSelectedPlayers(player: Player) {
        if selectedPlayers.contains(player.id) {
            selectedPlayers.remove(player.id)
        } else {
            selectedPlayers.insert(player.id)
        }
    }
    
    func getSelectedPlayers() -> [Player] {
        return playerRepository.getPlayers(with: Array(selectedPlayers))
    }
    
    
    private(set) var state: GameViewModelState = .initial
    
    private var gameRepository: GameRepository
    
    struct SetValues: Identifiable {
        let id: Int
        let kills: Int
        let digs: Int
        let aces: Int
        let passes: Int
        let spikes: Int
        let freeBall: Int
        let killBlocks: Int
        let freeballKills: Int
        let touches: Int
        let blocks: Int
        let hittingErrors: Int
        let blockingErrors: Int
        let settingErrors: Int
        let freeBallErrors: Int
        let shanks: Int
        let serveErrors: Int
        let rallySore: RallyFinalScore
        let bestRotation: (rotation: Int, pointsGained: Int)
        let worstRotation: (rotation: Int, pointsLost: Int)
    }
    
    // MARK: Rallies is for testing purposes
    init(game: Game,
         rallies: [Rally] = [],
         playerRepository: PlayerRepository,
         gameRepository: GameRepository) {
        
        self.game = game
        self.setValues = []
        self.rallies = rallies
        self.playerRepository = playerRepository
        self.gameRepository = gameRepository
        players = playerRepository.getPlayers()
        
        self.game.sets.forEach { [weak self] set in
            self?.setValues.append(self?.setupStats(for: set, setNumber: self?.setCount ?? 1) ?? SetValues.init(
            id: 0, kills: 0, digs: 0, aces: 0, passes: 0, spikes: 0, freeBall: 0, killBlocks: 0, freeballKills: 0, touches: 0, blocks: 0, hittingErrors: 0, blockingErrors: 0, settingErrors: 0, freeBallErrors: 0, shanks: 0, serveErrors: 0, rallySore: .init(home: 0, away: 0), bestRotation: (0,0), worstRotation: (0,0)
        )
            )
            self?.setCount += 1
        }
    }
    
    func initialSetup() {
        // Get the players for the given playerIDs
    }
    
    static var preview: GameViewModel = {
        GameViewModel(
            game: .emptyExample,
            playerRepository: CDPlayerRepository(
                cache: PlayerCache(),
                storageManager: .preview),
            gameRepository: CDGameRepository(
                storageManager: .preview,
                cache: GameCache())
        )
    }()
    
    static var previewNoSets: GameViewModel = {
        GameViewModel(
            game: .noSets,
            playerRepository: CDPlayerRepository(
                cache: PlayerCache(),
                storageManager: .preview),
                gameRepository: CDGameRepository(
                    storageManager: .preview,
                    cache: GameCache())
            )
    }()
    
    static var previewNoSetsFullRally: GameViewModel = {
        GameViewModel(
            game: .noSets,
            rallies: Rally.examples,
            playerRepository: CDPlayerRepository(
                cache: PlayerCache(),
                storageManager: .preview),
            gameRepository: CDGameRepository(
                storageManager: .preview,
                cache: GameCache())
        )
    }()
    
    private func setupStats(for set: VSet, setNumber: Int) -> SetValues {
        
        var kills = 0
        var digs = 0
        var aces = 0
        var spikes = 0
        var freeballs = 0
        var freeballKill = 0
        var killBlocks = 0
        var hittingErrors = 0
        var blockingErrors = 0
        var settingErrors = 0
        var freeballErrors = 0
        var shanks = 0
        var serveErrors = 0
        var servesIn = 0
        var touches = 0
        var block = 0
        var passes = 0
        var homeScore = 0
        var awayScore = 0
        var rotation: [Int: (pointsGained: Int, pointsLost: Int)] = [:]
        
        for rally in set.rallies {
            
            if rally.point == 0 {
                awayScore += 1
                rotation[rally.rotation, default: (pointsGained: 0, pointsLost: 0)].pointsLost += 1
            } else {
                homeScore += 1
                rotation[rally.rotation, default: (pointsGained: 0, pointsLost: 0)].pointsGained += 1
            }
            
            for playerStat in rally.stats {
                
                switch playerStat.stat {
                case .serve0:
                    serveErrors += 1
                case .serve1:
                    servesIn += 1
                case .serve2:
                    servesIn += 1
                case .serve3:
                    servesIn += 1
                case .ace:
                    servesIn += 1
                    aces += 1
                case .kill:
                    kills += 1
                case .hitError:
                    hittingErrors += 1
                case .hitAttempt:
                    spikes += 1
                case .set:
                    continue
                case .assistKill:
                    continue
                case .assitHockey:
                    continue
                case .setError:
                    settingErrors += 1
                case .setterDump:
                    kills += 1
                case .freeBallKill:
                    freeballKill += 1
                case .freeBall:
                    freeballs += 1
                case .freeBallError:
                    freeballErrors += 1
                case .killBlock:
                    killBlocks += 1
                case .block:
                    block += 1
                case .touch:
                    touches += 1
                case .blockError:
                    blockingErrors += 1
                case .pass0:
                    passes += 1
                case .pass1:
                    passes += 1
                case .pass2:
                    passes += 1
                case .pass3:
                    shanks += 1
                case .freeBallR1:
                    freeballs += 1
                case .freeBallR2:
                    freeballs += 1
                case .freeBallR3:
                    freeballs += 1
                case .dig0:
                    digs += 1
                case .dig1:
                    digs += 1
                case .dig2:
                    digs += 1
                case .dig3:
                    digs += 1
                case .none:
                    continue
                }
            }
        }
        
        var bestRotation: (rotation: Int, pointsGained: Int) = (1,0)
        var worstRotation: (rotation: Int, pointsLost: Int) = (1,0)
        
        rotation.forEach { keyValue in
            if bestRotation.pointsGained < keyValue.value.pointsGained {
                bestRotation = (
                    rotation: keyValue.key,
                    pointsGained: keyValue.value.pointsGained
                )
            }
            
            if worstRotation.pointsLost < keyValue.value.pointsLost {
                worstRotation = (
                    rotation: keyValue.key,
                    pointsLost: keyValue.value.pointsLost)
            }
        }
        
        return SetValues(
            id: setNumber,
            kills: kills,
            digs: digs,
            aces: aces,
            passes: passes,
            spikes: spikes,
            freeBall: freeballs,
            killBlocks: killBlocks,
            freeballKills: freeballKill,
            touches: touches,
            blocks: block,
            hittingErrors: hittingErrors,
            blockingErrors: blockingErrors,
            settingErrors: settingErrors,
            freeBallErrors: freeballErrors,
            shanks: shanks,
            serveErrors: serveErrors,
            rallySore: RallyFinalScore(
                home: homeScore,
                away: awayScore),
            bestRotation: bestRotation,
            worstRotation: worstRotation
        )
    }

    func doneCreatingSetClicked() {
        // Add the set to the list of sets for our game object

        let vSet = VSet(id: UUID(), rallies: rallies)
        game.sets.append(vSet)
        
        self.setValues.append(setupStats(for: vSet, setNumber: setCount))
        setCount += 1
        
        // Reset all of the other values
        currentRotation = 1
        rallies.removeAll()
    }
        
    func doneCreatingRally(entries: [PlayerAndStat], pointGained: Bool, rallyStart: RallyStart, rotation: Int) {
        
        // MARK: Add guards for making sure that the information is correct
        // ex: 0 < rotation < 7, entries is not empty
        let rally = Rally(
            id: UUID(), rotation: rotation,
            rallyStart: rallyStart,
            point: pointGained ? 1 : 0,
            stats: entries
        )
        
        rallies.append(rally)
    }
    
    
    // Tell the Game Repository to save the game that has currently been worked on
    func doneCreatingGame() async {

        // Base case check to make sure at least one set has been created in the Game
        guard game.sets.count > 0, state != .saving else{
            // Need at least 1 set for a game
            return
        }
        
        await MainActor.run {
            self.state = .saving
        }
        
        do {
            
            // Update the game
            if !gameSaved {
                try await gameRepository.saveGame(game)
                gameSaved = true
            }
            
            // Update each of the selected players information
            if !playersSaved {
                try await updatePlayers(playerRepository.getPlayers(with: Array(selectedPlayers)))
                playersSaved = true
            }
            
            await MainActor.run {
                self.state = .gameSavedSuccess
            }
        } catch {
            // TODO: Add appropriate error handling
            await MainActor.run {
                self.state = .errorSavingGame
            }
            print("Error: \(error)")
        }
    }
    
    private func updatePlayers(_ players: [Player]) async throws {
        

        for player in players {
            let stats = getStatsForPlayer(playerName: player.name)
            player.addNewGameStats(stats: stats, date: game.date)
            
            try await playerRepository.updatePlayer(with: player)
        }
    }
    
    private func getStatsForPlayer(playerName: String) -> [Stats] {
        
        var stats = [Stats]()
        game.sets.forEach { vSet in
            
            vSet.rallies.forEach { rally in
                
                rally.stats.forEach {
                    
                    if $0.player == playerName {
                        stats.append( $0.stat )
                    }
                }
            }
        }
        
        return stats
    }
    
    func resetState() {
        guard state != .saving else { return }
        
        state = .initial
    }
}

//#Playground("Save Game and Player") {
//    let playerRepository = CDPlayerRepository(
//        context: StorageManager.preview.container.viewContext,
//        cache: PlayerCache(),
//        storageManager: .preview)
//    let gameViewModel = GameViewModel(
//        game: Game(
//            id: UUID(),
//            date: Date(),
//            players: [],
//            sets: []),
//        playerRepository: playerRepository,
//        gameRepository:
//            CDGameRepository(
//                storageManager: StorageManager.preview,
//                cache: GameCache()))
//    
//    gameViewModel.players.forEach { player in
//        gameViewModel.toggleSelectedPlayers(player: player)
//    }
//
//    // Generate 3 sets
//    gameViewModel.doneCreatingSetClicked()
//    gameViewModel.doneCreatingSetClicked()
//    gameViewModel.doneCreatingSetClicked()
//    
//    // Save the game
//    await gameViewModel.doneCreatingGame()
//    
//    // Grab the players to see if they're updated
//    let players = playerRepository.getPlayers()
//}
