//
//  SeaLocation.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 29.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

class SeaLocation: Equatable {
    
    var x: Int
    var y: Int
    
    init(xLocation: Int, yLocation: Int) {
        x = xLocation
        y = yLocation
    }
    
    static func == (lhs: SeaLocation, rhs: SeaLocation) -> Bool {
        return (lhs.x == rhs.x && lhs.y == rhs.y)
    }
}

