//
//  NewsTabCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewsTabCoordinatorTransitions: class {
    
}

class NewsTabCoordinator: TabBarItemCoordinatorType {

    let rootController = UINavigationController()
    let tabBarItem: UITabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icNews"), selectedImage: nil)
    private var serviceHolder: ServiceHolder
    private weak var transitions: NewsTabCoordinatorTransitions?
    
    init(serviceHolder: ServiceHolder, transitions: NewsTabCoordinatorTransitions) {
        self.serviceHolder = serviceHolder
        self.transitions = transitions
    }
    
    func start() {
        rootController.setNavigationBarHidden(true, animated: false)
        rootController.tabBarItem = tabBarItem

        let coordinator = NewsListCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
    
    deinit {
        print("NewsTabCoordinator deinit")
    }
}

extension NewsTabCoordinator: NewsListCoordinatorTransitions {
    
}

