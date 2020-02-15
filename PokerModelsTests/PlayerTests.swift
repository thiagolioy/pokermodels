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

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEquality() {
        let p1 = Player(name: "Thiago")
        let p2 = Player(name: "Thiago")
        
        XCTAssertEqual(p1, p2)
    }
    
}

