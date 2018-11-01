//
//  Registration3Coordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol Registration3CoordinatorTransitions: class {
}

protocol Registration3CoordinatorType {
}

class Registration3Coordinator: Registration3CoordinatorType {
    
    private let navigationController: UINavigationController?
    private weak var transitions: Registration3CoordinatorTransitions?
    private weak var controller = Storyboard.auth.controller(withClass: Registration3VC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: Registration3CoordinatorTransitions?, serviceHolder: ServiceHolder, newUserModel: SignUpUserModel) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = Registration3ViewModel(self, serviceHolder: serviceHolder, newUserModel: newUserModel)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    deinit {
        print("Registration3Coordinator - deinit")
    }
    
}
