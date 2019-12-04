//
//  SeaAnimal.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 25.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

public class SeaAnimal: Equatable {

    var id = UUID()
    private var animalClassName: String = ""
    var imageName: String { return animalClassName }
    private var lifeCycleStep: Int = 0
    private var seaLocation: SeaLocation
    private var stepFinished: Bool = false
    private var isDiyingNow: Bool = false
    
    init (animalClassName: String, location: SeaLocation) {
        self.animalClassName = animalClassName
        self.seaLocation = location
    }
    
    public static func == (lhs: SeaAnimal, rhs: SeaAnimal) -> Bool {
        return lhs.id == rhs.id
    }
    
    func setNewLocation (newLocation: SeaLocation) {
        self.seaLocation = newLocation
    }
    
    func getLocation() -> SeaLocation {
        return seaLocation;
    }

    func addLifeCycleStep() {
        self.lifeCycleStep = self.lifeCycleStep+1
        stepFinished = true
    }
    
    func getLifeCycleStep() -> Int {
        return self.lifeCycleStep
    }
    
    func isStepFinished() -> Bool {
        return stepFinished
    }
    
    func resetStepFinished() {
        stepFinished = false
    }
    
    func getIsDiyingNow() -> Bool {
        return self.isDiyingNow
    }
    
    func nextStep(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {
        self.addLifeCycleStep()
        return []
    }
    
    func reproduceOnself(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {
        
        let randomCellIndexToMove: Int = Int.random(in: 0..<availableLocations.count-1)
        let locationForNewAnimal = availableLocations[randomCellIndexToMove]
        var isNewLocationAvailable: Bool = true
        
        for animal in neighbors {
            if (animal.getLocation() == locationForNewAnimal) {
                isNewLocationAvailable = false
                break
            }
        }

        if isNewLocationAvailable {
            return [SeaAnimal(animalClassName: self.animalClassName, location: locationForNewAnimal)]
        }
        
        return []
    }
    
    func tryToSwim(availableLocations: [SeaLocation], neighbors: [SeaAnimal])-> [SeaAnimal] {
        
        let randomCellIndexToMove: Int = Int.random(in: 0..<availableLocations.count-1)
        let newLocation = availableLocations[randomCellIndexToMove]
        var isNewLocationAvailable: Bool = true
        
        for animal in neighbors {
            if (animal.getLocation() == newLocation) {
                isNewLocationAvailable = false
                break
            }
        }

        if isNewLocationAvailable {
            self.seaLocation = SeaLocation(xLocation: newLocation.x, yLocation: newLocation.y)
        }
        
        return []
    }
    
    func kill(animal: SeaAnimal)-> [SeaAnimal] {
        
        animal.isDiyingNow = true
        self.seaLocation = SeaLocation(xLocation: animal.getLocation().x, yLocation: animal.getLocation().y)
        
        return [animal]
    }
    
    func die()->[SeaAnimal] {
        isDiyingNow = true
        return []
    }
    
    func calcPenguinAmongNeighbores(availableLocations: [SeaLocation], neighbors: [SeaAnimal]) -> [SeaAnimal] {
        
        var tempPenguins: [SeaAnimal] = []
        for animal in neighbors {

            if animal is Penguin {
                tempPenguins.append(animal as! Penguin)
            }
        }
        
        return tempPenguins
    }
}
