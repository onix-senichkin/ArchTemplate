//
//  ReadingListCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol ReadingListCoordinatorTransitions: class {
    
}

protocol ReadingListCoordinatorType {
    
    //navigation
    func showNewDetails(_ model: NewViewModel)
}

class ReadingListCoordinator: ReadingListCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: ReadingListCoordinatorTransitions?
    private weak var controller = Storyboard.readingList.controller(withClass: ReadingListVC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: ReadingListCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = ReadingListViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    deinit {
        print("ReadingListCoordinator - deinit")
    }
    
    //navigation
    func showNewDetails(_ model: NewViewModel) {
        guard let navigation = navigationController else { return }
        let coordinator = NewDetailsCoordinator(navigationController: navigation, transitions: self, serviceHolder: serviceHolder, model: model)
        coordinator.start()
    }
}

//MARK:- NewDetailsCoordinator Transitions
extension ReadingListCoordinator: NewDetailsCoordinatorTransitions {
    
}
