//
//  PlayerAction.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct PlayerAction {
    var player: Player
    let pokerAction: PokerAction
}

extension PlayerAction: Equatable {}

public func ==(lhs: PlayerAction, rhs: PlayerAction) -> Bool {
    return lhs.player == rhs.player && lhs.pokerAction == rhs.pokerAction
}
