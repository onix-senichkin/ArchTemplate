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
    private weak var transitions: NewsTabCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    private var featureListService: FeatureListService

    init(serviceHolder: ServiceHolder, transitions: NewsTabCoordinatorTransitions) {
        self.serviceHolder = serviceHolder
        self.transitions = transitions
        self.featureListService = serviceHolder.get(by: FeatureListService.self)
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem

        //#ToDiscuss Feature list usage
        let useWithCompletion = featureListService.bUseNewsListWithCompletion
        if useWithCompletion {
            startNewsWithCompletion()
        } else {
            startNewsWithState()
        }
    }
    
    private func startNewsWithCompletion() {
        let coordinator = NewsListCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
    
    private func startNewsWithState() {
        let coordinator = NewsList2Coordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }

    deinit {
        print("NewsTabCoordinator deinit")
    }
}

extension NewsTabCoordinator: NewsListCoordinatorTransitions, NewsList2CoordinatorTransitions {
 
}
