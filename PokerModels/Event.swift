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
    
    
    private(set) var actions: [EventAction] = []
    private(set) var activePlayers: [Player] = []
    private(set) var losers: [Player] = []
    
}

extension Event: Equatable {}

public func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.name == rhs.name &&
        lhs.location == rhs.location &&
        lhs.date == rhs.date
}

extension Event {
    func rank() -> [Player] {
           return activePlayers + losers.reversed()
       }
       
       mutating func add(players: [Player]) {
           activePlayers.append(contentsOf: players)
       }
       
       mutating func add(player: Player) {
           activePlayers.append(player)
       }
       
       mutating func didLose(player: Player) {
           activePlayers = activePlayers.filter{ $0 != player }
           losers.append(player)
       }
           
       mutating func add(action: PlayerAction) {
        var mutAction = action
        let eventAction = EventAction(event: self, action: action)
        mutAction.player.addEvent(action: eventAction)
        actions.append(eventAction)
       }
       
       func actions(for player: Player) -> [EventAction] {
           return actions.filter { $0.action.player == player }
       }
}
