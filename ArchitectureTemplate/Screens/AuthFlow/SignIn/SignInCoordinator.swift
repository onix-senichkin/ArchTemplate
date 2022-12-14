//
//  SignInCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol SignInCoordinatorTransitions: AnyObject {
    
    func userDidLogin()
    func signUp()
}

protocol SignInCoordinatorType {
 
    func userDidLogin()
    func signUp()
}

class SignInCoordinator: SignInCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: SignInCoordinatorTransitions?
    private weak var controller = Storyboard.auth.controller(withClass: SignInVC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: SignInCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = SignInViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: false)
        }
    }
    
    deinit {
        print("SignInCoordinator - deinit")
    }
    
    func userDidLogin() {
        transitions?.userDidLogin()
    }
    
    func signUp() {
        transitions?.signUp()
    }
}
