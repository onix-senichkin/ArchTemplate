//
//  UserViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

class UserViewModel {
    
    private let userModel: UserModel
    
    init(user: UserModel) {
        self.userModel = user
    }

    //MARK: Getters
    var userEmail: String {
        return userModel.email
    }

    var userName: String {
        return userModel.userName
    }
}
