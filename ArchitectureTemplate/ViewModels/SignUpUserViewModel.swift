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
    
    //getters
    func getTitleValue(for type: RegistrationCellType) -> String {
        return type.rawValue
    }

    func getValue(for type: RegistrationCellType) -> String? {
        switch type {
            case .email:
                return model.email
            case .firstName:
                return model.firstName
            case .lastName:
                return model.lastName
            case .profession:
                return model.profession
            case .genger:
                return model.gender
            case .city:
                return model.city
            case .address:
                return model.address
            case .phone:
                return model.phone
            default: return ""
        }
    }

    //setters
    func valueChanged(for type: RegistrationCellType, value: String) {
        switch type {
            case .email:
                model.email = value
            case .firstName:
                model.firstName = value
            case .lastName:
                model.lastName = value
            case .profession:
                model.profession = value
            case .genger:
                model.gender = value
            case .city:
                model.city = value
            case .address:
                model.address = value
            case .phone:
                model.phone = value
            default: break
        }
    }
    
    //actions
    func validate(for type: RegistrationCellType) -> Bool {
        //TODO: Replace with regex rules
        switch type {
            case .email:
                let value = model.email ?? ""
                return (value.count > 0)
            case .firstName:
                let value = model.firstName ?? ""
                return (value.count > 0)
            case .lastName:
                let value = model.lastName ?? ""
                return (value.count > 0)
            case .profession:
                let value = model.profession ?? ""
                return (value.count > 0)
            case .genger:
                let value = model.gender ?? ""
                return (value.count > 0)
            case .city:
                let value = model.city ?? ""
                return (value.count > 0)
            case .address:
                let value = model.address ?? ""
                return (value.count > 0)
            case .phone:
                let value = model.phone ?? ""
                return (value.count > 0)
            default: break
        }
        
        return false
    }
}
