//
//  ReadingListTabCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol ReadingListTabCoordinatorTransitions: class {
    
}

class ReadingListTabCoordinator: TabBarItemCoordinatorType {

    let rootController = UINavigationController()
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Reading list", image: UIImage(named: "icReadingList"), selectedImage: nil)
    private var serviceHolder: ServiceHolder
    private weak var transitions: ReadingListTabCoordinatorTransitions?
    
    init(serviceHolder: ServiceHolder, transitions: ReadingListTabCoordinatorTransitions) {
        self.serviceHolder = serviceHolder
        self.transitions = transitions
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        
        let coordinator = ReadingListCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
    
    deinit {
        print("ReadingListTabCoordinator deinit")
    }
}

extension ReadingListTabCoordinator: ReadingListCoordinatorTransitions {
    
}
