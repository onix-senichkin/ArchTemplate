//
//  SignInViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol SignInViewModelType {
    
    //getters
    var signUpTitle: NSAttributedString { get }
    
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
    
    //getters
    var signUpTitle: NSAttributedString {
        let underlineAttribute:[NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                NSAttributedString.Key.foregroundColor: UIColor.black]
        let underlineAttributedString = NSAttributedString(string: "Signin.SignupTitle".localized, attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    //actions
    func validate(email: String, password: String) -> String? {
        //#TODO Should be replaced with validate regex and rules
        if email.count == 0 {
            return "Signin.EmailBlankError".localized
        }
        
        if password.count == 0 {
            return "Signin.PassBlankError".localized
        }
        
        if password.count < 8 {
            return "Signin.PassWeakError".localized
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
