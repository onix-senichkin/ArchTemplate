//
//  ProfileTabCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol ProfileTabCoordinatorTransitions: class {
    
    func logout()
}

class ProfileTabCoordinator: TabBarItemCoordinatorType {

    let rootController = UINavigationController()
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "icProfile"), selectedImage: nil)
    private var serviceHolder: ServiceHolder
    private weak var transitions: ProfileTabCoordinatorTransitions?
    
    init(serviceHolder: ServiceHolder, transitions: ProfileTabCoordinatorTransitions) {
        self.serviceHolder = serviceHolder
        self.transitions = transitions
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem

        let coordinator = ProfileCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
    
    deinit {
        print("ProfileTabCoordinator deinit")
    }
}

extension ProfileTabCoordinator: ProfileCoordinatorTransitions {
    
    func logout() {
        transitions?.logout()
    }
    
}

