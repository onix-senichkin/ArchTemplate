//
//  NewsList2Coordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewsList2CoordinatorTransitions: class {
}

protocol NewsList2CoordinatorType {
}

class NewsList2Coordinator: NewsList2CoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: NewsList2CoordinatorTransitions?
    private weak var controller = Storyboard.news.controller(withClass: NewsListVC2.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: NewsList2CoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = NewsList2ViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    deinit {
        print("NewsList2Coordinator - deinit")
    }
    
}