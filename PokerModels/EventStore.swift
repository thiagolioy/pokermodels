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
        
        
        var position: EventPlayer.PlayerPosition = .notSetted
        if status == .lost {
            position = .setted(activePlayers.count + 1)
        } else if status == .won {
            position = .setted(1)
        }
        
        let changes = [
            EventPlayer(status: status, player: player, position: position)
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
