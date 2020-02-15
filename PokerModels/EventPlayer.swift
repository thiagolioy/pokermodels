//
//  EventPlayer.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation


typealias Position = Setted<Int>
typealias Points = Setted<Int>
typealias PrizePercentage = Setted<Double>

public struct EventPlayer {
    enum Status {
        case won, active, lost
    }
    
    let status: Status
    let player: Player
    let position: Position
    let points: Points
    let prizePercentage: PrizePercentage
}

extension EventPlayer {
    init(player: Player) {
        status = .active
        self.player = player
        position = .notSetted
        points = .notSetted
        prizePercentage = .notSetted
    }
}

extension EventPlayer: Equatable {}

public func ==(lhs: EventPlayer, rhs: EventPlayer) -> Bool {
    return lhs.status == rhs.status &&
        lhs.player == rhs.player &&
        lhs.position == rhs.position &&
        lhs.points == rhs.points
}
