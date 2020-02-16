//
//  Player.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct Player {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}


extension Player: Equatable {}

public func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
}
