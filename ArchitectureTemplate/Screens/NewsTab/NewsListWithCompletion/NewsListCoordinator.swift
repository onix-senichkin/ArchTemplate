//
//  NewsListCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewsListCoordinatorTransitions: class {
}

protocol NewsListCoordinatorType {
    
    func showNewDetails(_ model: NewViewModel)
}

class NewsListCoordinator: NewsListCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: NewsListCoordinatorTransitions?
    private weak var controller = Storyboard.news.controller(withClass: NewsListVC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: NewsListCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = NewsListViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    deinit {
        print("NewsListCoordinator - deinit")
    }
    
    //navigation
    func showNewDetails(_ model: NewViewModel) {
        guard let navigation = navigationController else { return }
        let coordinator = NewDetailsCoordinator(navigationController: navigation, transitions: self, serviceHolder: serviceHolder, model: model)
        coordinator.start()
    }
}

//MARK:- NewDetailsCoordinator Transitions
extension NewsListCoordinator: NewDetailsCoordinatorTransitions {
    
}
