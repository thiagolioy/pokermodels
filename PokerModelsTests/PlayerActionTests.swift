//
//  EventActionTests.swift
//  PokerModelsTests
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

import XCTest
@testable import PokerModels

class PlayerActionTests: XCTestCase {
    
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
        let p1 = Player(name: "Thiago")
        
        let e1 = PlayerAction(player: p1, action: .buyIn)
        let e2 = PlayerAction(player: p1, action: .buyIn)
        XCTAssertEqual(e1, e2)
    }
    
    func testShouldNotBeEqual() {
        let p1 = Player(name: "Thiago")
        
        let e1 = PlayerAction(player: p1, action: .buyIn)
        let e2 = PlayerAction(player: p1, action: .rebuy)
        XCTAssertNotEqual(e1, e2)
    }
    
}
