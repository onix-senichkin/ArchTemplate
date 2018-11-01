//
//  SignInViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol SignInViewModelType {
    
    //actions
    func validate(email: String, password: String) -> String?
    func login(email: String, password: String, completion: @escaping SimpleClosure<String?>)
    func signUp()
}

class SignInViewModel: SignInViewModelType {
    
    fileprivate let coordinator: SignInCoordinatorType
    private var serviceHolder: ServiceHolder
    private var userService: UserServiceType
    
    init(_ coordinator: SignInCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.userService = serviceHolder.get(by: UserService.self)
    }
    
    deinit {
        print("SignInViewModel - deinit")
    }
    
    //actions
    func validate(email: String, password: String) -> String? {
        //#TODO Should be replaced with validate regex and rules
        if email.count == 0 {
            return "Email can't be blank"
        }
        
        if password.count == 0 {
            return "Password can't be blank"
        }
        
        if password.count < 8 {
            return "Password should be 8+ symbols"
        }

        return nil
    }
    
    func login(email: String, password: String, completion: @escaping SimpleClosure<String?>) {
        
        userService.login(email: email, password: password) { [weak self] errorStr in
            if let error = errorStr {
                completion(error)
                return
            }
            
            self?.coordinator.userDidLogin()
        }
    }
    
    func signUp() {
        coordinator.signUp()
    }
}
