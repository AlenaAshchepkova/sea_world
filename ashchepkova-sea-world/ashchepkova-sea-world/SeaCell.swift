//
//  SeaCell.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 25.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import Foundation

class SeaCell {
    
    private let defaultName = "empty_cell"
    private var _contentImageName: String?
    
    init() {
    }
    
    func getCellImage()-> String {
        
        if _contentImageName != nil {
            return _contentImageName!
        }
        
        return defaultName
    }
    
    func addContentImage (animalImageName: String) {
        _contentImageName = animalImageName
    }
    
    func cleanCell () {
        _contentImageName = nil
    }
    
    func isCellEmpty ()-> Bool {
        
        if (_contentImageName != nil) {
            return false
        }
        
        return true
    }
}

