//
//  PlayerTest.swift
//  PokerModelsTests
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import XCTest
@testable import PokerModels

class PlayerTests: XCTestCase {

    func testShouldBeEqual() {
        let p1 = Player(name: "Thiago")
        let p2 = Player(name: "Thiago")
        
        XCTAssertEqual(p1, p2)
    }

    func testShouldNotBeEqual() {
        let p1 = Player(name: "Thiago")
        let p2 = Player(name: "Joao")
        
        XCTAssertNotEqual(p1, p2)
    }

}

