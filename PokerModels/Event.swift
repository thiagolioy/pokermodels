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
    let prizeSystem: PrizeSystem = FirstToThirdPrizeSystem()
    
    let players: [EventPlayer]
    let actions: [EventAction]
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
