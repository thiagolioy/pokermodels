//
//  Player.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct Player {
    let name: String
    private(set) var eventActions: [EventAction] = []
    
}

extension Player: Equatable {}

public func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
}

extension Player {
    func buyIn() -> PlayerAction {
        return PlayerAction(player: self, pokerAction: .buyIn)
    }
    
    func rebuy() -> PlayerAction {
        return PlayerAction(player: self, pokerAction: .rebuy)
    }
    
    func addOn() -> PlayerAction {
        return PlayerAction(player: self, pokerAction: .addOn)
    }
    
    mutating func addEvent(action: EventAction) {
        eventActions.append(action)
    }
}
