//
//  ProfileViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

enum ProfileCells: Int {
    case name = 0
    case email
    case address
    case logout
    case map
}

protocol ProfileViewModelType {
    
    //getters
    func getUserName() -> String
    func getUserEmail() -> String
    func getUserAddress() -> String
    func getUserAddress(completion: @escaping SimpleClosure<String>)
 
    //actions
    func logout()
}

class ProfileViewModel: ProfileViewModelType {
    
    fileprivate let coordinator: ProfileCoordinatorType
    private var userService: UserServiceType
    private var userLocationServive: UserLocationServiceType
    
    init(_ coordinator: ProfileCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.userService = serviceHolder.get(by: UserServiceType.self)
        self.userLocationServive = serviceHolder.get(by: UserLocationService.self)
    }
    
    //getters
    func getUserName() -> String {
        return userService.userName
    }
    
    func getUserEmail() -> String {
        return userService.userEmail
    }
    
    func getUserAddress() -> String {
        return userLocationServive.userAddress ?? "n/a"
    }
    
    func getUserAddress(completion: @escaping SimpleClosure<String>) {
        userLocationServive.callBackUserAddressWasChanged = completion
    }
    
    deinit {
        print("ProfileViewModel - deinit")
    }
    
    //actions
    func logout() {
        coordinator.logout()
    }
}
