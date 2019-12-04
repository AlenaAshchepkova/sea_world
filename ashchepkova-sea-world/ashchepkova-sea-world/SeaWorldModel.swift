//
//  SeaWorldModel.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 25.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

class SeaWorldModel {
    
    private let startPenguinsPercentage = 50.0
    private let startOrcasPercentage = 5.0
    private var _tableWidth: Int
    private var _tableHeight: Int
    private var animals: [SeaAnimal] = []
    private var gridArray:[[SeaCell]] = [[]]
    
    enum AnimalKind {
        case penguin
        case orca
    }
    
    init(tableWidth: Int, tableHeight: Int) {
        self._tableHeight = tableHeight
        self._tableWidth = tableWidth
        self.initializationWorld()
    }
    
    func setHeight(height: Int) {
        _tableHeight = height
    }
    
    func setWidth(width: Int) {
        _tableWidth = width
    }
    
    func getTableWidth() -> Int {
        return _tableWidth
    }
    
    func getTableHeight() -> Int {
        return _tableHeight
    }
    
    func initializationWorld() {
        
        gridArray = [[]]
        var innerArray: [SeaCell] = []

        for y in 0..<_tableHeight {
            for x in 0..<_tableWidth {
                innerArray.insert(SeaCell(), at: x)
            }
            gridArray.insert(innerArray, at: y)
        }
    }
    
    func createNewWorld () {
        self.initializationWorld()
        self.setupWorld()
     }
    
    func setupWorld () {
        animals = []

        //orcas
        self.setupAnimals(percentage: startOrcasPercentage, kind: AnimalKind.orca)
        //penguins
        self.setupAnimals(percentage: startPenguinsPercentage, kind: AnimalKind.penguin)
    }
    
    func setupAnimals (percentage: Double, kind: AnimalKind) {

        let startCount = Int(calculatePercentage(value: Double(calcGridCount()), percentageVal: percentage))
    
        for _ in 0..<startCount {
            
            var shouldAdd: Bool = true
            while (shouldAdd) {
                
                let randomX = Int.random(in: 0..<_tableWidth)
                let randomY = Int.random(in: 0..<_tableHeight)
           
               if (isCellEmptyByLocation(location: SeaLocation(xLocation: randomX, yLocation: randomY))) {
                
                    animals.append(createAnimal(location: SeaLocation(xLocation: randomX, yLocation: randomY), kind: kind))
                    shouldAdd = false
                }
            }
        }
    }
    
    func createAnimal (location: SeaLocation, kind: AnimalKind) -> SeaAnimal {

        if (kind == AnimalKind.penguin) {
            return Penguin(location: location)
            
        } else if (kind == AnimalKind.orca) {
            return Orca(location: location)
        }
        
        return SeaAnimal(animalClassName: "", location: location)
    }
    
    func stepAnimalOneByOne(xPosition: Int, yPosition: Int) {
                
        let animal: SeaAnimal? = self.getNextAnimal(location: SeaLocation(xLocation: xPosition, yLocation: yPosition))
        if (animal != nil) {
        
            let neighborsIndexesArray: [SeaLocation] = calcNeighborsForLocation(location: SeaLocation(xLocation: xPosition, yLocation: yPosition))
            let neighborsArray = calcNeighborsArray(indexesArray: neighborsIndexesArray)
            let changedAnimals = animal!.nextStep(availableLocations: neighborsIndexesArray, neighbors: neighborsArray)
            
            if (changedAnimals.count > 0) {
                self.updateAnimals(animalArray: changedAnimals)
            }
            self.updateAnimals(animalArray: [animal!])
        }
    }
        
    func simulatorTactEnded() {
        
        for animal in animals {
            animal.resetStepFinished()
        }
    }
        
    func getNextAnimal(location: SeaLocation) -> SeaAnimal? {
        
        for animal in animals {
            
            if (animal.getLocation() == location) {
                if animal.isStepFinished() {
                    return nil
                }
                
                return animal
            }
        }
        return nil
    }
    
    func calcNeighborsArray(indexesArray: [SeaLocation]) -> [SeaAnimal] {
    
        var resultArray: [SeaAnimal] = []
        
        for item in indexesArray {
            for animal in animals {
                if (animal.getLocation() == item) {
                    resultArray.append(animal)
                }
            }
        }
        
        return resultArray
    }
    
    func calcNeighborsForLocation(location: SeaLocation) -> [SeaLocation] {
        
        var neighborsIndexes: [SeaLocation] = []
        var tempX = 0
        var tempY = 0
        
        // cell 0
        tempX = location.x - 1
        tempY = location.y - 1
        if (tempX >= 0 && tempY >= 0) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 1
        tempX = location.x
        tempY = location.y - 1
        if (tempY >= 0) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 2
        tempX = location.x + 1
        tempY = location.y - 1
        if (tempY >= 0 && tempX < _tableWidth) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 3
        tempX = location.x - 1
        tempY = location.y
        if (tempY >= 0 && tempX >= 0) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 4 - self

        //cell 5
        tempX = location.x + 1
        tempY = location.y
        if (tempY < _tableHeight && tempX < _tableWidth) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 6
        tempX = location.x - 1
        tempY = location.y + 1
        if (tempY < _tableHeight && tempX >= 0) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 7
        tempX = location.x
        tempY = location.y + 1
        if (tempY < _tableHeight) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        //cell 8
        tempX = location.x + 1
        tempY = location.y + 1
        if (tempY < _tableHeight && tempX < _tableWidth) {
            neighborsIndexes.append(SeaLocation(xLocation: tempX, yLocation: tempY))
        }
        
        return neighborsIndexes
    }
    
    func calcGridCount () -> Int {
        return _tableWidth*_tableHeight;
    }
    
    func calculatePercentage (value:Double, percentageVal:Double)->Double {
        let val = value * percentageVal
        return val / 100.0
    }
    
    func isCellEmptyByLocation(location: SeaLocation) -> Bool {

        for animal in animals {
            if (animal.getLocation() == location) {
                return false
            }
        }
        
        return true
    }
    
    func getImageByLocation(location: SeaLocation) -> String {
        
        for animal in animals {
            if (animal.getLocation() == location) {
                return animal.imageName
            }
        }
        
        return SeaCell().getCellImage()
    }
    
    func updateAnimals(animalArray: [SeaAnimal]) {
    
        for newAnimal in animalArray {

            if let index = animals.firstIndex(of: newAnimal) {
            
                animals.remove(at: index)
            
                if newAnimal.getIsDiyingNow() {
                    break
                
                } else {
                    animals.append(newAnimal)
                    break
                }
                
            } else {
                //if has no such elements in array
                animals.append(newAnimal)
                break
            }
        }

        return
    }
}

