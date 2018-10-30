//
//  NewDetailsViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/30/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol NewDetailsViewModelType {
    
    //getters
    var newTitle: String { get }
    var newDesc: String { get }
}

class NewDetailsViewModel: NewDetailsViewModelType {
    
    fileprivate let coordinator: NewDetailsCoordinatorType
    private var model: NewViewModel
    
    init(_ coordinator: NewDetailsCoordinatorType, serviceHolder: ServiceHolder, model: NewViewModel) {
        self.coordinator = coordinator
        self.model = model
    }
    
    
    deinit {
        print("NewDetailsViewModel - deinit")
    }
    
    //getters
    var newTitle: String {
        return model.newTitle
    }
    
    var newDesc: String {
        return model.newDesc
    }
}
