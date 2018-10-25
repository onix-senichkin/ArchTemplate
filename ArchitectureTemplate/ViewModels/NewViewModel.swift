//
//  NewViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

class NewViewModel {
    
    private let newModel: NewModel
    
    init(new: NewModel) {
        self.newModel = new
    }
    
    //MARK: Getters
    var newId: Int {
        return newModel.id
    }
    
    var newTitle: String {
        return newModel.title
    }
    
    var newDesc: String {
        return newModel.desc
    }
}
