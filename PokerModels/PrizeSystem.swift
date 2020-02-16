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

struct FirstAndSecondPrizeSystem: PrizeSystem {
    
    let prizePercentageStructure = [
        1:0.70,
        2:0.30
    ]
    
    func prizePercentage(for position: Int) -> Double {
        guard let prizePercentage = prizePercentageStructure[position] else {
            return 0.0
        }
        return prizePercentage
    }
}
