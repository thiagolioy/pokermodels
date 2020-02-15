//
//  EventStoreTests.swift
//  PokerModelsTests
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import PokerModels

class EventStoreTests: XCTestCase {
    
    var event: Event!
    var sut: EventStore!
    
    override func setUp() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        let p4 = Player(name: "Kaique")
        let p5 = Player(name: "Victor")
        let p6 = Player(name: "Mohamd")
        let p7 = Player(name: "Felipe")
        
        let players = [p1, p2, p3, p4, p5, p6, p7]
        
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
        sut = EventStore()
    }
    
    override func tearDown() {
        event = nil
        sut = nil
    }
    
    func testCreateAnEventWithPlayers() {
        XCTAssertEqual(event.players.count, 7)
        XCTAssertEqual(event.actions.count, 0)
    }
    
    func testAddEventAction() {
        let action = EventAction(event: event, player: event.players[0].player, pokerAction: .buyIn)
        let newEvent = sut.add(eventAction: action, to: event)
        XCTAssertEqual(newEvent.actions.count, 1)
    }
    
    func testDidLose() {
        let p1 = event.players[0].player
        let newEvent = sut.playerDidLose(player: p1, on: event)
        
        XCTAssertEqual(newEvent.losers.count, 1)
        
        let losers = [
            EventPlayer(status: .lost,
                        player: p1,
                        position: .setted(7),
                        points: .setted(event.pointsSystem.points(for: 7)),
                        prizePercentage: .setted(event.prizeSystem.prizePercentage(for: 7))
                
            )
        ]
        
        XCTAssertEqual(newEvent.losers, losers)
    }
    
    func testShouldBeAbleToRankThePlayersWithoutAWinner() {
        let p1 = event.players[0].player
        let newEvent = sut.playerDidLose(player: p1, on: event)
        
        XCTAssertEqual(newEvent.losers.count, 1)
        
        XCTAssertEqual(newEvent.rank.count, 7)
    }
    
    func testShouldBeAbleToRankThePlayersWithAWinner() {
        let p1 = Player(name: "Sergio")
        let p2 = Player(name: "Thiago")
        let p3 = Player(name: "Jonas")
        let p4 = Player(name: "Kaique")
        let p5 = Player(name: "Victor")
        let p6 = Player(name: "Mohamd")
        let p7 = Player(name: "Felipe")
        
        let players = [p1, p2, p3, p4, p5, p6, p7]
        
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
        
        
        var ev = sut.playerDidLose(player: p2, on: event)
        ev = sut.playerDidLose(player: p3, on: ev)
        ev = sut.playerDidLose(player: p4, on: ev)
        ev = sut.playerDidLose(player: p5, on: ev)
        ev = sut.playerDidLose(player: p6, on: ev)
        ev = sut.playerDidLose(player: p7, on: ev)
        
        
        let expectedRank = [
            EventPlayer(status: .lost, player: p2, position: .setted(7), points: .setted(6), prizePercentage: .setted(0)),
            EventPlayer(status: .lost, player: p3, position: .setted(6), points: .setted(8), prizePercentage: .setted(0)),
            EventPlayer(status: .lost, player: p4, position: .setted(5), points: .setted(10), prizePercentage: .setted(0)),
            EventPlayer(status: .lost, player: p5, position: .setted(4), points: .setted(12), prizePercentage: .setted(0)),
            EventPlayer(status: .lost, player: p6, position: .setted(3), points: .setted(15), prizePercentage: .setted(0.1)),
            EventPlayer(status: .lost, player: p7, position: .setted(2), points: .setted(18), prizePercentage: .setted(0.3)),
            EventPlayer(status: .won, player: p1, position: .setted(1), points: .setted(25), prizePercentage: .setted(0.6))
        ]
        
        XCTAssertNotNil(ev.winner)
        XCTAssertEqual(ev.rank.count, expectedRank.count)
        XCTAssertEqual(ev.rank, expectedRank)
    }
    
    func testShouldHaveAWinnerAfterEveryoneElseLose() {
        let winner = event.players[0].player
        let everyoneElse = event.players.filter {$0.player != winner}
        
        var ev: Event = event
        everyoneElse.forEach {
            ev = sut.playerDidLose(player: $0.player, on: ev)
        }
        
        XCTAssertEqual(ev.losers.count, 6)
        XCTAssertNotNil(ev.winner)
        XCTAssertEqual(ev.winner?.player.name, winner.name)
        XCTAssertEqual(ev.players.count, 7)
    }
    
    func testShouldBeAbleToGetPlayerPoints() {
        let p1 = event.players[0].player
        let p3 = event.players[2].player
        let newEvent = sut.playerDidLose(player: p1, on: event)
      
        
        let points: Points = newEvent.points(for: p1)
        XCTAssertEqual(points, .setted(6))
        
        let notSettedPoints: Points = newEvent.points(for: p3)
        XCTAssertEqual(notSettedPoints, .notSetted)
    }
    
    func testShouldBeAbleToGetPlayerPrizePercentage() {
           let p1 = event.players[0].player
           let p3 = event.players[2].player
           let newEvent = sut.playerDidLose(player: p1, on: event)
         
           
           let points: PrizePercentage = newEvent.prizePercentage(for: p1)
           XCTAssertEqual(points, .setted(0.0))
           
           let notSettedPoints: PrizePercentage = newEvent.prizePercentage(for: p3)
           XCTAssertEqual(notSettedPoints, .notSetted)
    }
    
    func testShouldBeAbleToGetPlayerPosition() {
           let p1 = event.players[0].player
           let p3 = event.players[2].player
           let newEvent = sut.playerDidLose(player: p1, on: event)
         
           
           let points: Position = newEvent.position(for: p1)
           XCTAssertEqual(points, .setted(7))
           
           let notSettedPoints: Position = newEvent.position(for: p3)
           XCTAssertEqual(notSettedPoints, .notSetted)
       }
    
    
    func testShouldBeAbleToListTheLosers() {
        let p1 = event.players[0].player
        let p2 = event.players[1].player
        
        let ev = sut.playerDidLose(player: p1, on: event)
        
        let newEvent = sut.playerDidLose(player: p2, on: ev)
        
        XCTAssertEqual(newEvent.losers.count, 2)
        
        let losers = [
            EventPlayer(status: .lost,
                        player: p1,
                        position: .setted(7),
                        points: .setted(event.pointsSystem.points(for: 7)),
                        prizePercentage: .setted(event.prizeSystem.prizePercentage(for: 7))
            ),
            EventPlayer(status: .lost,
                        player: p2,
                        position: .setted(6),
                        points: .setted(event.pointsSystem.points(for: 6)),
                        prizePercentage: .setted(event.prizeSystem.prizePercentage(for: 6))
            )
        ]
        
        XCTAssertEqual(newEvent.losers.count, losers.count)
        XCTAssertEqual(newEvent.losers, losers)
        XCTAssertEqual(newEvent.players.count, 7)
    }
    
    func testShouldBeAbleToGetPrizePool() {
          XCTFail()
      }
    
}
