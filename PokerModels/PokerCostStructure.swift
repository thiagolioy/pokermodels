//
//  PokerCostStructure.swift
//  PokerModels
//
//  Created by Thiago Lioy on 16/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation



protocol PokerCostStructure {
    func cost(of action: PokerAction) -> Double
}

struct FriendlyPokerCost: PokerCostStructure {
    
    func cost(of action: PokerAction) -> Double {
        switch action {
        case .buyIn, .rebuy, .addOn:
            return 50.0
        }
    }
}
