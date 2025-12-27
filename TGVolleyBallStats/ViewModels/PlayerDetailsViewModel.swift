//
//  PlayerDetailsViewModel.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 12/6/25.
//

import Foundation

@Observable class PlayerDetailsViewModel {
    
    let player: Player
    
    init(player: Player) {
        self.player = player
        
        initialSetup()
    }
    
    func initialSetup() {
        
        var chartStatDoubleDict: [ChartPlayerStats: [Double]] = [:]
        
        // Get the list of trendpoints needed for the user
        for stat in ChartPlayerStats.allCases {
            var stats: [Double]
            
            switch stat{
            case .dig:
                stats = last10Games.map { $0.digRating }
            case .freeball:
                stats = last10Games.map { $0.freeBallRating }
            case .kill:
                stats = last10Games.map { $0.killPercentage }
            case .pass:
                stats = last10Games.map { $0.passRating }
            case .points:
                stats = last10Games.map { Double($0.pointScore) }
            }
            
            if let trendLine = generateTrendLine(stats: stats) {
                chartStatDoubleDict[stat, default: []] = generateAListOfTrendPoints(trendline: trendLine, stat: stat)
            }
        }
        
        // Create the list of 10 games with the appropriate trend point attached
        var index = 0
        last10Games.forEach { game in
            
            // TODO:  Need to comeback and clean this up with proper error handling
            let playerWithStatAndTrend = PlayerDateStatTrendPoint(
                date: game.date,
                killPercentage: (value: game.killPercentage, trendPoint: chartStatDoubleDict[.kill]![index]),
                passRating: (value: game.passRating, trendPoint: chartStatDoubleDict[.pass]![index]),
                freeBallRating: (value: game.freeBallRating, trendPoint: chartStatDoubleDict[.freeball]![index]),
                digRating: (value: game.digRating, trendPoint: chartStatDoubleDict[.dig]![0]),
                pointScore: (value: Double(game.pointScore), trendPoint: chartStatDoubleDict[.points]![index])
            )
            index += 1
            last10GamesWithStats.append(playerWithStatAndTrend)
        }
    }
    
    static var preview: PlayerDetailsViewModel {
        PlayerDetailsViewModel(player: Player.example)
    }
    
    var killPercentage: Double? {
        player.last10GameStats.last?.killPercentage
    }
    
    var passRatingPercentage: Double? {
        player.last10GameStats.last?.passRating
    }
    
    var digRatingPercentage: Double? {
        player.last10GameStats.last?.digRating
    }
    
    var freeballRatingPercentage: Double? {
        player.last10GameStats.last?.freeBallRating
    }
    
    var pointsScored: Int? {
        guard let pointsScored = player.last10GameStats.last?.pointScore else {
            return nil
        }
        
        return pointsScored
    }
    
    var last10Games: [PlayerDateStats] {
        
        return player.last10GameStats
    }
    
    var last10GamesWithStats: [PlayerDateStatTrendPoint] = []
    
    /***
     In order to the find a trend line:
     1. Sum up the number of points (x)
     2. Sum up stats given (y)
     3. Sum the product of the points and stats (xy)
     4. Sum the squared value of the points (x^2)
     5. Get the numerator - the ( number of points (n) * the sum of the product of the points and stats (xy)) - ( Sum up the number of points (x) * Sum up stats given (y) )
     6.  Get the denominator - (number of points (n) * sum of the squared value of the points (x^2) ) - ( Sum up the number of points (x) * Sum up stats given (y))
     */
    func generateTrendLine(stats: [Double]) -> TrendLine? {
        let n = Double(stats.count)
        let sumY = stats.reduce(0.0) { $0 + $1 }
        let sumX = (0..<Int(n)).reduce(0.0) { $0 + Double($1)}
        var sumXY = 0.0
        
        for (index, statValue) in stats.enumerated() {
            sumXY = sumXY + (Double(index) * statValue)
        }
        
        var sumX2 = 0.0
        for index in 0..<stats.count {
            sumX2 += Double(index * index)
        }
        
        let numerator = (n * sumXY) - (sumX * sumY)
        let denominator = (n * sumX2) - (sumX * sumX)
        
        guard denominator != 0 else {
            return nil
        }
        
        let slope = numerator / denominator
        
        let intercept = ( sumY - (slope * sumX) ) / n
        
        let trendLine = TrendLine(slope: slope, intercept: intercept, rSquared: 0.0)
        
        // Get the r2
        let yAvg = sumY / n
        let ssTotal = stats.reduce(0) { $0 + pow($1 - yAvg, 2) }
        var ssRes = 0.0
        
        stats.enumerated().forEach({
            ssRes += pow($0.element - trendLine.generatePointFor(Double($0.offset)), 2)
        })
            
        let rSquared = ssTotal != 0 ? 1 - (ssRes / ssTotal) : 1
                
        return TrendLine(slope: slope, intercept: intercept, rSquared: rSquared)
    }
    
    func getImprovementFromLastGame(stat: Stats) -> Double? {
        
        guard last10Games.count > 0 else {
            return nil
        }
        
        var percentage = 0.0
        guard last10Games.count > 1 else {
            // We only use one value
            switch stat {
            case .kill:
                percentage = last10Games[0].killPercentage
            case .pass0:
                percentage = last10Games[0].passRating
            case .freeBall:
                percentage = last10Games[0].freeBallRating
            case .dig0:
                percentage = last10Games[0].digRating
            default:
                percentage = Double(last10Games[0].pointScore)
            }
            
            return percentage
        }
        
        let index = last10Games.count - 1
        switch stat {
        case .kill:
            percentage = last10Games[index].killPercentage / last10Games[index-1].killPercentage - 1
        case .pass0:
            percentage = last10Games[index].passRating / last10Games[index-1].passRating - 1
        case .freeBall:
            percentage = last10Games[index].freeBallRating / last10Games[index-1].freeBallRating - 1
        case .dig0:
            percentage = last10Games[index].digRating / last10Games[index-1].digRating - 1
        default:
            percentage = Double(last10Games[index].pointScore) / Double(last10Games[index-1].pointScore) - 1
        }
        
        return percentage
    }
    
    func getAListOfStat(_ stat: ChartPlayerStats) -> [Double] {
        
        switch stat {
        case .kill:
            return last10Games.map { $0.killPercentage }
        case .pass:
            return last10Games.map { $0.passRating }
        case .dig:
            return last10Games.map { $0.digRating }
        case .freeball:
            return last10Games.map { $0.freeBallRating }
        case .points:
            return last10Games.map { Double($0.pointScore) }
        }
    }
    
    func generateAListOfTrendPoints(trendline: TrendLine, stat: ChartPlayerStats) -> /*[(Int, Double)]*/[Double] {
        var index = -1

        return (0..<last10Games.count).map {_ in
            
            index += 1
            return trendline.generatePointFor(Double(index))
        }
    }
    
}

struct TrendLine {
    let slope: Double
    let intercept: Double
    let rSquared: Double
    
    func generatePointFor(_ value: Double) -> Double {
        
        return slope * value + intercept
    }
}

enum ChartPlayerStats: String, Identifiable, CaseIterable {
    case kill
    case pass
    case dig
    case freeball
    case points
    
    var id: String { return self.rawValue }
}

struct PlayerDateStatTrendPoint: Identifiable {
    var id: Date { return date }
    
    let date: Date
    let killPercentage: (value: Double, trendPoint: Double)
    let passRating: (value: Double, trendPoint: Double)
    let freeBallRating: (value: Double, trendPoint: Double)
    let digRating: (value: Double, trendPoint: Double)
    let pointScore: (value: Double, trendPoint: Double)
}
