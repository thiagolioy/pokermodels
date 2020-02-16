//
//  Event.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct Event {
    public let name: String
    public let location: Location
    public let date: Date
    
    public let pointsSystem: PointsSystem
    public let prizeSystem: PrizeSystem
    public let costStructure: PokerCostStructure
    
    public let players: [EventPlayer]
    public let actions: [PlayerAction]
    
    public init(name: String, location: Location, date: Date,
                pointsSystem: PointsSystem = FormulaOnePointsSystem(),
                prizeSystem: PrizeSystem = FirstAndSecondPrizeSystem(),
                costStructure: PokerCostStructure = FriendlyPokerCost(),
                players: [EventPlayer], actions: [PlayerAction] = []) {
        self.name = name
        self.location = location
        self.date = date
        self.pointsSystem = pointsSystem
        self.prizeSystem = prizeSystem
        self.costStructure = costStructure
        self.players = players
        self.actions = actions
    }
}

extension Event: Equatable {}

public func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.name == rhs.name &&
        lhs.location == rhs.location &&
        lhs.date == rhs.date
}

extension Event {
    
    public var losers: [EventPlayer] {
        return players.filter { $0.status == .lost }
    }
    
    public var winner: EventPlayer? {
        return players.filter { $0.status == .won }.first
    }
    
    public var rank: [EventPlayer] {
        return players.sorted { $0.position > $1.position}
    }
}

extension Event {
    func position(for player: Player) -> EventPlayer.Position {
        guard let position = players.filter({ $0.player == player }).first?.position else {
            return .notSetted
        }
        return position
    }
    
    func points(for player: Player) -> EventPlayer.Points {
        guard let points = players.filter({ $0.player == player }).first?.points else {
            return .notSetted
        }
        return points
    }
    
    func prizePercentage(for player: Player) -> EventPlayer.PrizePercentage {
        guard let percentage = players.filter({ $0.player == player }).first?.prizePercentage else {
            return .notSetted
        }
        return percentage
    }
}

extension Event {
    public func cost(for player: Player) -> Double {
        let costFunction: PokerCostStructure = costStructure
        return actions.filter({ $0.player == player })
            .map({ costFunction.cost(of: $0.action) })
            .reduce(0.0, +)
    }
    
    public func prizePool() -> Double {
        let costFunction: PokerCostStructure = costStructure
        return actions.map({ costFunction.cost(of: $0.action) })
            .reduce(0.0, +)
    }
    
    public func revenue(for player: Player) -> Double {
        
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
    
    public func profit(for player: Player) -> Double {
        return revenue(for: player) - cost(for: player)
    }
}
