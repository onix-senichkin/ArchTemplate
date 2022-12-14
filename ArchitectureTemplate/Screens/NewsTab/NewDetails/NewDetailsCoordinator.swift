//
//  NewDetailsCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/30/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewDetailsCoordinatorTransitions: AnyObject {
}

protocol NewDetailsCoordinatorType {
}

class NewDetailsCoordinator: NewDetailsCoordinatorType {
    
    private let navigationController: UINavigationController?
    private weak var transitions: NewDetailsCoordinatorTransitions?
    private weak var controller = Storyboard.news.controller(withClass: NewDetailsVC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: NewDetailsCoordinatorTransitions?, serviceHolder: ServiceHolder, model: NewViewModel) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = NewDetailsViewModel(self, serviceHolder: serviceHolder, model: model)
    }
    
    func start() {
        guard let controller = controller else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    deinit {
        print("NewDetailsCoordinator - deinit")
    }
    
}
