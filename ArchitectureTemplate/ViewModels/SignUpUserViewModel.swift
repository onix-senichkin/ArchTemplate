//
//  SignUpUserViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

class SignUpUserViewModel: NSObject {
    
    private let model: SignUpUserModel
    
    init(model: SignUpUserModel) {
        self.model = model
    }
    
    func valueChanged(type: RegistrationCellType, value: String) {
        switch type {
            case .email:
                model.email = value
            case .firstName:
                model.firstName = value
            case .lastName:
                model.lastName = value
            case .phone:
                model.phone = value
            default: break
        }
    }
}
