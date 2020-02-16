//
//  EventPlayer.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation



public struct EventPlayer {

    public typealias Position = Setted<Int>
    public typealias Points = Setted<Int>
    public typealias PrizePercentage = Setted<Double>

    public enum Status {
        case won, active, lost
    }
    
    public let status: Status
    public let player: Player
    public let position: Position
    public let points: Points
    public let prizePercentage: PrizePercentage
    
    public init(status: EventPlayer.Status = .active, player: Player,
                position: EventPlayer.Position = .notSetted,
                points: EventPlayer.Points = .notSetted,
                prizePercentage: EventPlayer.PrizePercentage = .notSetted) {
        self.status = status
        self.player = player
        self.position = position
        self.points = points
        self.prizePercentage = prizePercentage
    }
    
}

extension EventPlayer: Equatable {}

public func ==(lhs: EventPlayer, rhs: EventPlayer) -> Bool {
    return lhs.status == rhs.status &&
        lhs.player == rhs.player &&
        lhs.position == rhs.position &&
        lhs.points == rhs.points
}
