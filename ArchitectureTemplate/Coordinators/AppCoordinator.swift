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
        startInitialServices()
        startPreloginFlow()
    }
    
    private func startPreloginFlow() {
        authCoordinator = AuthFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        authCoordinator?.start()
        
        tabBarCoordinator = nil
    }

    private func enterApp() {
        startOtherServices()

        tabBarCoordinator = TabBarCoordinator(window: window, serviceHolder: serviceHolder, transitions: self)
        tabBarCoordinator?.start()
        
        //reopen saved deeplink
        let deepLinkService:DeepLinkManagerType = serviceHolder.get(by: DeepLinkManager.self)
        deepLinkService.reopenSavedLink()
        
        authCoordinator = nil
    }
    
    deinit {
        print("AppCoordinator - deinit")
    }
}

//MARK:- Services routine
extension AppCoordinator {
    
    private func startInitialServices() {
        let userService = UserService()
        let deepLinkManager = DeepLinkManager(coordinator: self, userService: userService)
        let featureListService = FeatureListService()
        
        serviceHolder.add(UserService.self, for: userService)
        serviceHolder.add(DeepLinkManager.self, for: deepLinkManager)
        serviceHolder.add(FeatureListService.self, for: featureListService)
    }
    
    private func startOtherServices() {
        //start user location service only after login
        let userLocationService = UserLocationService()
        let readingListService = ReadingListService()
        
        serviceHolder.add(UserLocationService.self, for: userLocationService)
        serviceHolder.add(ReadingListService.self, for: readingListService)
    }
    
    private func cleanServices() {
        serviceHolder.remove(by: UserLocationService.self)
        serviceHolder.remove(by: ReadingListService.self)
    }
}

//MARK: - Deeplinks routine
extension AppCoordinator {
    
    func handleLink(url: URL) {
        let deepLinkManager = serviceHolder.get(by: DeepLinkManager.self)
        deepLinkManager.handleLink(url: url)
    }
    
    func getTabBarCoordinator() -> TabBarCoordinator? {
        return tabBarCoordinator
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

        //clean up from prev user
        let userService = serviceHolder.get(by: UserService.self)
        let deepLinkService:DeepLinkManagerType = serviceHolder.get(by: DeepLinkManager.self)
        deepLinkService.clearSavedLink()
        userService.logout()
        
        cleanServices()
        startOtherServices()
        
        startPreloginFlow()
    }
}

