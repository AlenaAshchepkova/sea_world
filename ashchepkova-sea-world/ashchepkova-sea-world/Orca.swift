//
//  Orca.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 25.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

class Orca: SeaAnimal {
    
    private let reproduceCycle: Int = 8
    private let feedAttempt: Int = 3
    private var feelHungryTacts: Int = 0
    
    init(location: SeaLocation) {
        super.init(animalClassName: "orca", location:location)
    }
    
    override func nextStep(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {

        if (super.getLifeCycleStep() % reproduceCycle == 0 && super.getLifeCycleStep() != 0) {
            super.addLifeCycleStep()
            return self.reproduceOnself(availableLocations:availableLocations, neighbors: neighbors)
        }
        
        let penguinsToKill: [SeaAnimal] = calcPenguinAmongNeighbores(availableLocations: availableLocations, neighbors: neighbors)
        let victimsCount = penguinsToKill.count
        if (victimsCount > 0) {
            
            var randomAnimalIndexToKill = 0
            if (victimsCount > 1) {
                randomAnimalIndexToKill = Int.random(in: 0..<victimsCount-1)
            }
            
            self.feelHungryTacts = 0
            self.addLifeCycleStep()
            return kill(animal:penguinsToKill[randomAnimalIndexToKill])
        }
        
        self.feelHungryTacts = self.feelHungryTacts+1
        if self.feelHungryTacts == self.feedAttempt {
            return self.die()
        }
        
        self.addLifeCycleStep()
        return super.tryToSwim(availableLocations: availableLocations, neighbors: neighbors)
    }
    
    override func reproduceOnself(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {
        
        let animals: [SeaAnimal] = super.reproduceOnself(availableLocations: availableLocations, neighbors: neighbors)
        var resultArray:[Orca] = []
        
        for animal in animals {
            resultArray.append(Orca(location: animal.getLocation()))
        }
        
        return resultArray
    }
}

