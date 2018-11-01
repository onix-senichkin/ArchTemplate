//
//  Registration1Coordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol Registration1CoordinatorTransitions: class {
    
    func nextClicked(_ from: BaseRegistrationCoordinatorProtocol)
}

protocol Registration1CoordinatorType: BaseRegistrationCoordinatorProtocol {
    
    //actions
    func backClicked()
}

class Registration1Coordinator: Registration1CoordinatorType {
    
    private let navigationController: UINavigationController?
    private weak var transitions: Registration1CoordinatorTransitions?
    private weak var controller = Storyboard.auth.controller(withClass: Registration1VC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: Registration1CoordinatorTransitions?, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = Registration1ViewModel(self, serviceHolder: serviceHolder, newUser: newUser)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    deinit {
        print("Registration1Coordinator - deinit")
    }
    
    //actions
    func backClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func nextClicked() {
        transitions?.nextClicked(self)
    }

}
