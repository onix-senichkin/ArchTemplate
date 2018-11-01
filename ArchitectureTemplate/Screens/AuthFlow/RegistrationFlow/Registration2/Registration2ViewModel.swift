//
//  Registration2ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol Registration2ViewModelType {
    
}

class Registration2ViewModel: Registration2ViewModelType {
    
    fileprivate let coordinator: Registration2CoordinatorType
    private var serviceHolder: ServiceHolder
    private var newUserModel: SignUpUserModel
    
    init(_ coordinator: Registration2CoordinatorType, serviceHolder: ServiceHolder, newUserModel: SignUpUserModel) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.newUserModel = newUserModel
    }
    
    
    deinit {
        print("Registration2ViewModel - deinit")
    }
    
}
