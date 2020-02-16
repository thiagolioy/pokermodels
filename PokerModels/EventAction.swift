//
//  EventAction.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct PlayerAction {
    let player: Player
    let action: PokerAction
}

extension PlayerAction: Equatable {}

public func ==(lhs: PlayerAction, rhs: PlayerAction) -> Bool {
    return lhs.player == rhs.player &&
        lhs.action == rhs.action
}
