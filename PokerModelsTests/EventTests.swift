//
//  EventTests.swift
//  PokerModelsTests
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import PokerModels

class EventTests: XCTestCase {
    
    var event: Event!
    
    override func setUp() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        
        
        let players = [p1, p2, p3]
        
        let house = Location(address: "Avenida Santo 20",
        complement: "Apt. 15",
        coordinate: nil)
        
        event = Event(
            name: "Thiago's Poker",
            location: house,
            date: Date(),
            players: players.map{EventPlayer(player: $0)},
            actions: []
        )
    }
    
    override func tearDown() {
        event = nil
    }
    
    
    func testShouldBeEqual() {
        let event2 = Event(
            name: event.name,
            location: event.location,
            date: event.date,
            players: event.players,
            actions:event.actions
        )
        XCTAssertEqual(event, event2)
    }
    
    func testShouldNotBeEqual() {
        let ev3 = Event(
            name: "Thiago's Poker",
            location: event.location,
            date: Date(),
            players: [],
            actions: []
        )
        XCTAssertNotEqual(event, ev3)
    }
    
    func testShouldNotBeEqualIfActionsAreDifferent() {
        let ev3 = Event(
            name: "Thiago's Poker",
            location: event.location,
            date: Date(),
            players: event.players,
            actions: [ EventAction(event: event, player: event.players[0].player, pokerAction: .buyIn) ]
        )
        XCTAssertNotEqual(event, ev3)
    }
    
    
}
