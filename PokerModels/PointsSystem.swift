//
//  PointsSystem.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

protocol PointsSystem {
    func points(for position: Int) -> Int
}

struct FormulaOnePointsSystem: PointsSystem {
    
    let pointsStructure = [
        1:25,
        2:18,
        3:15,
        4:12,
        5:10,
        6:8,
        7:6,
        8:4,
        9:2,
        10:1
    ]
    
    func points(for position: Int) -> Int {
        guard let points = pointsStructure[position] else {
            return 0
        }
        return points
    }
}
