//
//  Location.swift
//  PokerModels
//
//  Created by Thiago Lioy on 15/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation
import CoreLocation

public struct Location {
    let address: String
    let complement: String
    let coordinate: CLLocationCoordinate2D?
}

extension Location: Equatable {}

public func ==(lhs: Location, rhs: Location) -> Bool {
    return lhs.address == rhs.address &&
        lhs.complement == rhs.complement &&
        lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
        lhs.coordinate?.longitude == rhs.coordinate?.longitude
}
