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

class SeaWorldViewModel: ObservableObject, Identifiable {

    @Published var totalClicked: Int = 0
    @Published var rows:[UISeaRow] = []
    
    
    init(){
        self.rows = [
            UISeaRow(cells: [
                UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "penguin")
            ]),
            
            UISeaRow(cells: [
                UISeaCell(imageName: "orca"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"),
            ]),
            
            UISeaRow(cells: [
                UISeaCell(imageName: "penguin"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell")
                
            ]),
            
            UISeaRow(cells: [
                UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "empty_cell"), UISeaCell(imageName: "penguin"), UISeaCell(imageName: "empty_cell")
                
            ])
        ]
    }
    
    func simulatorsTact() {
        //TODO: simulator's tact
        self.totalClicked = self.totalClicked+1
    }
    
    func createNewWorld () {
        //TODO: create new world
        self.totalClicked = 0
    }
}
