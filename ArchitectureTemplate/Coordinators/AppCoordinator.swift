//
//  AppCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private let serviceHolder = ServiceHolder()
    private var userService: UserServiceType! //#TODO: Recheck this

    private var authCoordinator: AuthFlowCoordinator?
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    private func start() {
        startServices()
        startPreloginFlow()
    }
    
    private func startServices() {
        userService = UserService()
        
        serviceHolder.add(UserServiceType.self, for: userService)
    }
    
    private func startPreloginFlow() {
        authCoordinator = AuthFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        authCoordinator?.start()
        
        tabBarCoordinator = nil
    }

    private func enterApp() {
        tabBarCoordinator = TabBarCoordinator(window: window, serviceHolder: serviceHolder, transitions: self)
        tabBarCoordinator?.start()
        
        authCoordinator = nil
    }
    
    deinit {
        print("AppCoordinator - deinit")
    }

}

//MARK:- AuthFlowCoordinator Transitions
extension AppCoordinator: AuthFlowCoordinatorTransitions {

    func userDidLogin() {
        enterApp()
    }
}

//MARK:- TabBarCoordinator Transitions
extension AppCoordinator: TabBarCoordinatorTransitions {
    
    func logout() {
        startPreloginFlow()
    }
}

