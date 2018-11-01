//
//  Registration3ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol Registration3ViewModelType {
    
}

class Registration3ViewModel: Registration3ViewModelType {
    
    fileprivate let coordinator: Registration3CoordinatorType
    private var serviceHolder: ServiceHolder
    private var newUserModel: SignUpUserModel
    
    init(_ coordinator: Registration3CoordinatorType, serviceHolder: ServiceHolder, newUserModel: SignUpUserModel) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.newUserModel = newUserModel
    }
    
    
    deinit {
        print("Registration3ViewModel - deinit")
    }
    
}
