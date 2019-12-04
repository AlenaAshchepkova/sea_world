//
//  Penguin.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 25.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

class Penguin: SeaAnimal {
    
    private let reproduceCycle: Int = 3
    
    init(location: SeaLocation) {
        super.init(animalClassName:"penguin", location: location)
    }
    
    override func nextStep(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {

        if (super.getLifeCycleStep() % reproduceCycle == 0 && super.getLifeCycleStep() != 0) {
            super.addLifeCycleStep()
            return self.reproduceOnself(availableLocations: availableLocations, neighbors:neighbors)
        }
            
        super.addLifeCycleStep()
        return super.tryToSwim(availableLocations: availableLocations, neighbors: neighbors)
    }
    
    override func reproduceOnself(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {
        
        let animals: [SeaAnimal] = super.reproduceOnself(availableLocations: availableLocations, neighbors: neighbors)
        var resultArray:[Penguin] = []
        
        for animal in animals {
            resultArray.append(Penguin(location: animal.getLocation()))
        }
        
        return resultArray
    }
}

