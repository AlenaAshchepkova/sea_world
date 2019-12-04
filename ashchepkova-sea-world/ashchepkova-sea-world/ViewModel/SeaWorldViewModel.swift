//
//  SeaWorldViewModel.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 23.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SeaWorldViewModel: ObservableObject {

    @Published var totalClicked: Int = 0
    @Published var rows:[UISeaRow] = []
    private var tableWidth = 10
    private var tableHeight = 15
    var model: SeaWorldModel
    
    init() {
        model = SeaWorldModel(tableWidth: tableWidth, tableHeight: tableHeight)
        self.model.createNewWorld()
        self.redrawPresentationArray()
    }
    
    func tableWasTapped () {
        self.simulatorTact()
        self.totalClicked = self.totalClicked+1
    }
    
    func simulatorTact() {
        
        for y in 0..<tableHeight {
            for x in 0..<tableWidth {
                self.model.stepAnimalOneByOne(xPosition: x, yPosition: y)
                self.redrawPresentationArray()
            }
        }
        self.model.simulatorTactEnded()
    }
    
    func redrawPresentationArray() {
        
        var presentationArray: [UISeaRow] = []
        
        for y in 0...tableHeight-1 {
            var tempCells:[UISeaCell] = []

            for x in 0...tableWidth-1 {
                tempCells.append(
                    UISeaCell(imageName:
                        self.model.getImageByLocation(location: SeaLocation(xLocation: x, yLocation: y))
                ))
            }
           presentationArray.append(UISeaRow(cells:tempCells))
        }
        self.rows = presentationArray
    }
    
    func buttonRefreshWasTapped () {
        self.model.createNewWorld()
        self.redrawPresentationArray()
        self.totalClicked = 0
    }
}
