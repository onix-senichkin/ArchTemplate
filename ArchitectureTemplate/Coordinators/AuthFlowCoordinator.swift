//
//  AuthCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol AuthFlowCoordinatorTransitions : class {
    
    func userDidLogin()
}

class AuthFlowCoordinator {
    
    private let window:UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private weak var transitions: AuthFlowCoordinatorTransitions?
    
    private var serviceHolder: ServiceHolder
    private var userService: UserServiceType
    
    init(window: UIWindow, transitions: AuthFlowCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        self.userService = serviceHolder.get(by: UserService.self)
        self.userService.logout()
    }
    
    func start() {
        rootNav.setNavigationBarHidden(true, animated: false)
        
        let coordinator = SignInCoordinator(navigationController: rootNav, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
        
        window.rootViewController = rootNav
        window.makeKeyAndVisible()
    }
    
    deinit {
        print("AuthFlowCoordinator deinit")
    }
}

extension AuthFlowCoordinator: SignInCoordinatorTransitions {
    
    func userDidLogin() {
        transitions?.userDidLogin()
    }
}

