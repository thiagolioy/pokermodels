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
    
    func playerDidLose(player: Player, on event: Event) -> Event {
        
        let otherPlayers = event.players.filter { $0.player != player }
        var activePlayers = otherPlayers.filter { $0.status == .active}
        
        let loserPosition = activePlayers.count + 1
        
        let changes = [
            EventPlayer(status: .lost, player: player, position: .setted(loserPosition))
        ]
       
        let updatedPlayers = otherPlayers + changes
        
        let updatedEvent = Event(
            name: event.name,
            location: event.location,
            date: event.date,
            players: updatedPlayers,
            actions: event.actions
        )
        
        activePlayers = updatedEvent.players.filter {$0.status == .active}
        
        if activePlayers.count > 1 {
            return updatedEvent
        }
        
        let lastActive = activePlayers[0].player
        
        let winner = EventPlayer(status: .won, player: lastActive, position: .setted(1))
        
        let losers = updatedEvent.players.filter { $0.status == .lost }
        
        return  Event(
           name: event.name,
           location: event.location,
           date: event.date,
           players: losers + [winner],
           actions: event.actions
       )
        
    }
    
    
}
