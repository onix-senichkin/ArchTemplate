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

    private var authCoordinator: AuthFlowCoordinator?
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    private func start() {
        startPreloginFlow()
    }
    
    private func startServices() {
        serviceHolder.removeAllService() //clean services before login, to remove old user data after logout
        
        let userService = UserService()
        let readingListService = ReadingListService()
        let featureListService = FeatureListService()
        
        serviceHolder.add(UserServiceType.self, for: userService)
        serviceHolder.add(ReadingListService.self, for: readingListService)
        serviceHolder.add(FeatureListService.self, for: featureListService)
    }
    
    private func startPreloginFlow() {
        startServices() //clean services before login, to remove old user data after logout

        authCoordinator = AuthFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        authCoordinator?.start()
        
        tabBarCoordinator = nil
    }

    private func enterApp() {
        //start user location service only after login
        let userLocationService = UserLocationService()
        serviceHolder.add(UserLocationService.self, for: userLocationService)

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

