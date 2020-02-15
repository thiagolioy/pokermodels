//
//  Setted.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public enum Setted<V: Comparable> {
    case setted(V)
    case notSetted
    
    func value() -> V? {
        switch self {
        case .setted(let v):
            return v
        case .notSetted:
            return nil
        }
    }
}

extension Setted: Equatable {}

extension Setted: Comparable {
    public static func < (lhs: Setted<V>, rhs: Setted<V>) -> Bool {
        guard let lp = lhs.value(), let rp = rhs.value() else {
            return false
        }
        return lp < rp
    }
}
