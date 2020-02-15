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
    
    var sut: Event!
    
    override func setUp() {
        let house = Location(address: "Avenida Santo Amaro 3131",
                             complement: "Apt. 1905",
                             coordinate: nil)
        
        sut = Event(name: "Thiago's Poker", location: house, date: Date())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInitialInstanceValues() {
        XCTAssert(sut.name == "Thiago's Poker")
        XCTAssert(sut.activePlayers.isEmpty)
        XCTAssert(sut.losers.isEmpty)
    }
    
    func testAddPlayer() {
        let p1 = Player(name: "Sergio")
        
        sut.add(player: p1)
        
        XCTAssert(sut.activePlayers.count == 1)
        XCTAssertEqual(sut.activePlayers[0], p1)
    }
    
    func testAddPlayers() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        
        let players = [p1, p2, p3]
        
        sut.add(players: players)
        
        XCTAssert(sut.activePlayers.count == 3)
        XCTAssertEqual(sut.activePlayers, players)
    }
    
    func testDidLose() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        
        let players = [p1, p2, p3]
        
        sut.add(players: players)
        
        sut.didLose(player: p2)
        
        XCTAssert(sut.activePlayers.count == 2)
        XCTAssert(sut.losers.count == 1)
        XCTAssertEqual(sut.activePlayers, [p1, p3])
        XCTAssertEqual(sut.losers, [p2])
    }
    
    func testShouldNotAllowEditionFromOutside() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        
        let players = [p1, p2, p3]
        
        sut.add(players: players)
        
        var actv = sut.activePlayers
        
        actv.append(Player(name: "Mohamd"))
        
        XCTAssert(sut.activePlayers.count == 3)
        XCTAssertEqual(sut.activePlayers, [p1, p2, p3])
    }
    
    func testRankInFinishedEvent() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        let p4 = Player(name: "Kaique")
        let p5 = Player(name: "Victor")
        let p6 = Player(name: "Mohamd")
        let p7 = Player(name: "Felipe")
        
        let players = [p1, p2, p3, p4, p5, p6, p7]
        
        sut.add(players: players)
        
        let lostOrder = [p5,p6,p2,p4,p3,p7]
        lostOrder.forEach {sut.didLose(player: $0)}
        
        XCTAssert(sut.rank().count == 7)
        
        XCTAssertEqual(sut.rank(), [p1, p7, p3, p4, p2, p6, p5])
        
    }
    
    func testRankInRunningEvent() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        let p4 = Player(name: "Kaique")
        let p5 = Player(name: "Victor")
        let p6 = Player(name: "Mohamd")
        let p7 = Player(name: "Felipe")
        
        let players = [p1, p2, p3, p4, p5, p6, p7]
        
        sut.add(players: players)
        
        let lostOrder = [p5,p6,p2,p4]
        lostOrder.forEach {sut.didLose(player: $0)}
        
        XCTAssert(sut.rank().count == 7)
        
        XCTAssertEqual(sut.rank(), [p1, p3, p7, p4, p2, p6, p5])
        
    }
    
    func testAddPlayerAction() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        
        sut.add(players: [p1, p2])
        
        sut.add(action: PlayerAction(player: p1, pokerAction: .buyIn))
        sut.add(action: PlayerAction(player: p2, pokerAction: .buyIn))
        sut.add(action: PlayerAction(player: p1, pokerAction: .rebuy))
        sut.add(action: PlayerAction(player: p1, pokerAction: .addOn))
        
        XCTAssert(sut.actions.count == 4)
    }
    
    func testActionsForPlayer() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        
        sut.add(players: [p1, p2])
        
        sut.add(action: PlayerAction(player: p1, pokerAction: .buyIn))
        sut.add(action: PlayerAction(player: p2, pokerAction: .buyIn))
        sut.add(action: PlayerAction(player: p1, pokerAction: .rebuy))
        sut.add(action: PlayerAction(player: p1, pokerAction: .addOn))
        
        
        
        XCTAssertEqual(sut.actions(for: p1).count, 3)
        XCTAssertEqual(p1.eventActions.count, 3)
        XCTAssertEqual(p1.eventActions, sut.actions(for: p1))
        XCTAssertEqual(p2.eventActions.count, 1)
        XCTAssertEqual(p2.eventActions, sut.actions(for: p2))
    }
    
    
    
}
