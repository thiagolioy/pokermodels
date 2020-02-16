//
//  PaymentDistribuitionTests.swift
//  PokerModelsTests
//
//  Created by Thiago Lioy on 16/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import PokerModels

class PaymentDistribuitionTests: XCTestCase {
    
    func testShouldCalculatePaymentDistribution() {
        let p1 = Player(name: "Mohamd")
        let p2 = Player(name: "Felipe")
        let p3 = Player(name: "Thiago")
        let p4 = Player(name: "Joao")
        
        let players = [p1, p2, p3, p4]
        
        let playerActions = [
            PlayerAction(player: p1, action: .buyIn),
            PlayerAction(player: p2, action: .buyIn),
            PlayerAction(player: p1, action: .rebuy),
            PlayerAction(player: p1, action: .rebuy),
            PlayerAction(player: p1, action: .rebuy),
            PlayerAction(player: p1, action: .addOn),
            PlayerAction(player: p2, action: .addOn),
            PlayerAction(player: p3, action: .buyIn),
            PlayerAction(player: p1, action: .rebuy),
            PlayerAction(player: p3, action: .rebuy),
            PlayerAction(player: p3, action: .addOn),
            PlayerAction(player: p4, action: .buyIn)
        ]
        
        let loc = Location(address: "Rua das pedras", complement: "92", coordinate: nil)
        
        var ev = Event(
            name: "Thiago's Poker",
            location: loc,
            date: Date(),
            players: players.map{EventPlayer(player: $0)},
            actions: playerActions
        )
        
        let store = EventStore()
        
        ev = store.playerDidLose(player: p1, on: ev)
        ev = store.playerDidLose(player: p2, on: ev)
        ev = store.playerDidLose(player: p4, on: ev)
        
        let dist = PaymentDistribuition()
        
        let transfers = dist.calculate(for: ev)
        
        XCTAssertEqual(transfers.count, 3)
        
        let transferTotal = transfers.map({$0.amount}).reduce(0, +)
        XCTAssertEqual(transferTotal, 400.0)
    }
    
    func testShouldCalculatePaymentDistributionMoreComplicatedEvent() {
        let p1 = Player(name: "Mohamd")
        let p2 = Player(name: "Kaique")
        let p3 = Player(name: "Thiago")
        let p4 = Player(name: "Jonas")
        let p5 = Player(name: "Victor")
        let p6 = Player(name: "Sergio")
        let p7 = Player(name: "Felipe")
        
        
        let players = [p1, p2, p3, p4, p5, p6, p7]
        
        let playerActions = [
            PlayerAction(player: p1, action: .buyIn),
            PlayerAction(player: p1, action: .rebuy),
            PlayerAction(player: p1, action: .rebuy),
            
            PlayerAction(player: p2, action: .buyIn),
            
            PlayerAction(player: p3, action: .buyIn),
            PlayerAction(player: p3, action: .rebuy),
            PlayerAction(player: p3, action: .addOn),
            
            PlayerAction(player: p4, action: .buyIn),
            
            PlayerAction(player: p5, action: .buyIn),
            PlayerAction(player: p5, action: .rebuy),
            PlayerAction(player: p5, action: .rebuy),
            PlayerAction(player: p5, action: .rebuy),
            PlayerAction(player: p5, action: .rebuy),
            PlayerAction(player: p5, action: .addOn),
            
            PlayerAction(player: p6, action: .buyIn),
            PlayerAction(player: p6, action: .rebuy),
            PlayerAction(player: p6, action: .addOn),
            
            PlayerAction(player: p7, action: .buyIn),
            PlayerAction(player: p7, action: .rebuy),
            PlayerAction(player: p7, action: .rebuy),
            PlayerAction(player: p7, action: .rebuy),
            PlayerAction(player: p7, action: .rebuy),
            PlayerAction(player: p7, action: .addOn)
        ]
        
        let loc = Location(address: "Rua das pedras", complement: "92", coordinate: nil)
        
        var ev = Event(
            name: "Thiago's Poker",
            location: loc,
            date: Date(),
            players: players.map{EventPlayer(player: $0)},
            actions: playerActions
        )
        
        let store = EventStore()
        
        ev = store.playerDidLose(player: p5, on: ev)
        ev = store.playerDidLose(player: p1, on: ev)
        ev = store.playerDidLose(player: p3, on: ev)
        ev = store.playerDidLose(player: p2, on: ev)
        ev = store.playerDidLose(player: p4, on: ev)
        ev = store.playerDidLose(player: p7, on: ev)
        
        let dist = PaymentDistribuition()
        
        let transfers = dist.calculate(for: ev)
        
        XCTAssertEqual(transfers.count, 6)
        
        let transferTotal = transfers.map({$0.amount}).reduce(0, +)
        XCTAssertEqual(transferTotal, 700.0)
    }
    
    
}


