//
//  EventAction.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct EventAction {
    let event: Event
    let player: Player
    let pokerAction: PokerAction
}

extension EventAction: Equatable {}

public func ==(lhs: EventAction, rhs: EventAction) -> Bool {
    return lhs.event == rhs.event &&
        lhs.player == rhs.player &&
        lhs.pokerAction == rhs.pokerAction
}
