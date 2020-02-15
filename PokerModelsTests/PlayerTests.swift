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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEquality() {
        let player = Player(name: "Thiago Lioy")
        let player2 = Player(name: "Thiago Lioy")
        
        XCTAssertEqual(player, player2)
    }


}

