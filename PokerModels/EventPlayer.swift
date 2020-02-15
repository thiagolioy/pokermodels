//
//  EventPlayer.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct EventPlayer {
    enum Status {
        case won, active, lost
    }
    enum PlayerPosition {
        case setted(Int)
        case notSetted
    }
    let status: Status
    let player: Player
    let position: PlayerPosition
}

extension EventPlayer: Equatable {}

public func ==(lhs: EventPlayer, rhs: EventPlayer) -> Bool {
    return lhs.status == rhs.status &&
        lhs.player == rhs.player &&
        lhs.position == rhs.position
}

extension EventPlayer.PlayerPosition: Equatable {}

extension EventPlayer.PlayerPosition: Comparable {}

fileprivate extension EventPlayer.PlayerPosition {
    func position() -> Int? {
        switch self {
        case .setted(let pos):
            return pos
        case .notSetted:
            return nil
        }
    }
}

func < (lhs: EventPlayer.PlayerPosition, rhs: EventPlayer.PlayerPosition) -> Bool {
    guard let lp = lhs.position(), let rp = rhs.position() else {
        return false
    }
    return lp < rp
}


