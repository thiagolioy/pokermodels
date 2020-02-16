//
//  Event.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct Event {
    let name: String
    let location: Location
    let date: Date
    
    let pointsSystem: PointsSystem = FormulaOnePointsSystem()
    let prizeSystem: PrizeSystem = FirstAndSecondPrizeSystem()
    let costStructure: PokerCostStructure = FriendlyPokerCost()
    
    let players: [EventPlayer]
    let actions: [PlayerAction]
}

extension Event: Equatable {}

public func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.name == rhs.name &&
        lhs.location == rhs.location &&
        lhs.date == rhs.date
}

extension Event {
    
    var losers: [EventPlayer] {
        return players.filter { $0.status == .lost }
    }
    
    var winner: EventPlayer? {
        return players.filter { $0.status == .won }.first
    }
    
    var rank: [EventPlayer] {
        return players.sorted { $0.position > $1.position}
    }
}

extension Event {
    func position(for player: Player) -> Position {
        guard let position = players.filter({ $0.player == player }).first?.position else {
            return .notSetted
        }
        return position
    }
    
    func points(for player: Player) -> Points {
        guard let points = players.filter({ $0.player == player }).first?.points else {
            return .notSetted
        }
        return points
    }
    
    func prizePercentage(for player: Player) -> PrizePercentage {
        guard let percentage = players.filter({ $0.player == player }).first?.prizePercentage else {
            return .notSetted
        }
        return percentage
    }
}

extension Event {
    func cost(for player: Player) -> Double {
        let costFunction: PokerCostStructure = costStructure
        return actions.filter({ $0.player == player })
            .map({ costFunction.cost(of: $0.action) })
            .reduce(0.0, +)
    }
    
    func prizePool() -> Double {
        let costFunction: PokerCostStructure = costStructure
        return actions.map({ costFunction.cost(of: $0.action) })
            .reduce(0.0, +)
    }
    
    func revenue(for player: Player) -> Double {
        
        let pool = prizePool()
        
        guard let eventPlayer = players.filter({$0.player == player}).first else {
            fatalError("Must be a registered player on the event")
        }
        
        switch eventPlayer.prizePercentage {
        case .setted(let percentage):
            return pool * percentage
        case .notSetted:
            return 0.0
        }
    }
    
    func profit(for player: Player) -> Double {
        return revenue(for: player) - cost(for: player)
    }
}
