//
//  EventStore.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct EventStore {
    
    func add(eventAction: EventAction, to event: Event) -> Event {
        return Event(
            name: event.name,
            location: event.location,
            date: event.date,
            players: event.players,
            actions: event.actions + [eventAction]
        )
    }
    
    private func update(event: Event, player: Player, status: EventPlayer.Status) -> Event {
        
        let otherPlayers = event.players.filter { $0.player != player }
        let activePlayers = otherPlayers.filter { $0.status == .active}
        
        var position: Position = .notSetted
        var points: Points = .notSetted
        var prizePercentage: PrizePercentage = .notSetted
        
        if status == .lost {
            let pos = activePlayers.count + 1
            position = .setted(pos)
            points = .setted(event.pointsSystem.points(for: pos))
            prizePercentage = .setted(event.prizeSystem.prizePercentage(for: pos))
        } else if status == .won {
            let winnerPosition = 1
            position = .setted(winnerPosition)
            points = .setted(event.pointsSystem.points(for: winnerPosition))
            prizePercentage = .setted(event.prizeSystem.prizePercentage(for: winnerPosition))
        }
        
        let changes: [EventPlayer] = [
            EventPlayer(status: status,
                        player: player,
                        position: position,
                        points: points,
                        prizePercentage: prizePercentage
            )
        ]
        
        let updatedPlayers = otherPlayers + changes
        
        return Event(
            name: event.name,
            location: event.location,
            date: event.date,
            players: updatedPlayers,
            actions: event.actions
        )
    }
    
    
    func playerDidLose(player: Player, on event: Event) -> Event {
        
        let updatedEvent = update(event: event, player: player, status: .lost)
        
        let activePlayers = updatedEvent.players.filter {$0.status == .active}
        
        guard activePlayers.count == 1 else {
            return updatedEvent
        }
        
        let lastActive = activePlayers[0].player
        
        
        return update(event: updatedEvent, player: lastActive, status: .won)
    }
    
    
}
