//
//  Championship.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

public struct Championship {
    let name: String
    var events: [Event] = []
    
    mutating func add(event: Event) {
        events.append(event)
    }
    
    func eventsList() -> [Event] {
        return events.map{$0}
    }
}
