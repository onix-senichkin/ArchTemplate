//
//  TabBarCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

private enum TabBarItems: Int {
    case tabNews = 0
    case tabReadingList
    case tabProfile
}

protocol TabBarCoordinatorTransitions: class {
    
    func logout()
}

protocol TabBarItemCoordinatorType {
    var rootController: UINavigationController { get }
    var tabBarItem: UITabBarItem { get }
}

class TabBarCoordinator {
    
    private weak var window: UIWindow?
    private weak var transitions: TabBarCoordinatorTransitions?
    private let serviceHolder: ServiceHolder

    private let tabBarController = UITabBarController()
    private var tabCoordinators:[TabBarItemCoordinatorType] = [] // store references to coordinators to avoid immediately deallocate after init
    
    init(window: UIWindow, serviceHolder: ServiceHolder, transitions: TabBarCoordinatorTransitions) {
        self.window = window
        self.serviceHolder = serviceHolder
        self.transitions = transitions
        
        tabBarController.tabBar.barTintColor = RGBColor(240, 240, 240)
        tabBarController.tabBar.tintColor = RGBColor(20, 20, 20)
        
        //tab bar items coordinator init
        let firstTabCoord = NewsTabCoordinator(serviceHolder: serviceHolder, transitions: self)
        firstTabCoord.start()
        
        let secondTabCoord = ReadingListTabCoordinator(serviceHolder: serviceHolder, transitions: self)
        secondTabCoord.start()
        
        let thirdTabCoordinator = ProfileTabCoordinator(serviceHolder: serviceHolder, transitions: self)
        thirdTabCoordinator.start()
        
        tabCoordinators = [firstTabCoord, secondTabCoord, thirdTabCoordinator]
        tabBarController.viewControllers = [firstTabCoord.rootController, secondTabCoord.rootController, thirdTabCoordinator.rootController]
    }
    
    deinit {
        print("TabBarCoordinator deinit")
    }
    
    func start(animated: Bool = false) {
        guard let window = window else { return }
        
        if (animated) { // from login
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { [weak self] in
                window.rootViewController = self?.tabBarController
            }, completion: nil)
        } else {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

//MARK: NewsTabCoordinator Transitions
extension TabBarCoordinator: NewsTabCoordinatorTransitions {
    
}

//MARK: ReadingListTabCoordinator Transitions
extension TabBarCoordinator: ReadingListTabCoordinatorTransitions {
    
}

//MARK: ProfileTabCoordinator Transitions
extension TabBarCoordinator: ProfileTabCoordinatorTransitions {
    
    func logout() {
        transitions?.logout()
    }
}
