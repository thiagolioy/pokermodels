//
//  PrizeSystem.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

protocol PrizeSystem {
    func prizePercentage(for position: Int) -> Double
}

struct FirstToThirdPrizeSystem: PrizeSystem {
    
    let prizePercentageStructure = [
        1:0.60,
        2:0.30,
        3:0.10
    ]
    
    func prizePercentage(for position: Int) -> Double {
        guard let prizePercentage = prizePercentageStructure[position] else {
            return 0.0
        }
        return prizePercentage
    }
}
