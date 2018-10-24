//
//  ProfileViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol ProfileViewModelType {
 
    //actions
    func logout()
}

class ProfileViewModel: ProfileViewModelType {
    
    fileprivate let coordinator: ProfileCoordinatorType
    private var serviceHolder: ServiceHolder
    private var userService: UserServiceType
    
    init(_ coordinator: ProfileCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.userService = serviceHolder.get(by: UserServiceType.self)
    }
    
    
    deinit {
        print("ProfileViewModel - deinit")
    }
    
    //actions
    func logout() {
        coordinator.logout()
    }
}
