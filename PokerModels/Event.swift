//
//  Event.swift
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
    enum PlayerPosition: Equatable, Comparable {
        case setted(Int)
        case notSetted
        
        private func position() -> Int? {
            switch self {
            case .setted(let pos):
                return pos
            case .notSetted:
                return nil
            }
        }
        
        static func < (lhs: EventPlayer.PlayerPosition, rhs: EventPlayer.PlayerPosition) -> Bool {
            guard let lp = lhs.position(), let rp = rhs.position() else {
                return false
            }
            return lp < rp
        }
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

public struct Event {
    let name: String
    let location: Location
    let date: Date
    
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

//extension Event {
//    func rank() -> [Player] {
//           return activePlayers + losers.reversed()
//       }
//
//       mutating func add(players: [Player]) {
//           activePlayers.append(contentsOf: players)
//       }
//
//       mutating func add(player: Player) {
//           activePlayers.append(player)
//       }
//
//       mutating func didLose(player: Player) {
//           activePlayers = activePlayers.filter{ $0 != player }
//           losers.append(player)
//       }
//
//       mutating func add(action: PlayerAction) {
//        var mutAction = action
//        let eventAction = EventAction(event: self, action: action)
//        mutAction.player.addEvent(action: eventAction)
//        actions.append(eventAction)
//       }
//
//       func actions(for player: Player) -> [EventAction] {
//           return actions.filter { $0.action.player == player }
//       }
//}
