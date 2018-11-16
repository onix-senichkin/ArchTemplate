//
//  Registration2Coordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol Registration2CoordinatorTransitions: class {
    
    func nextClicked(_ from: BaseRegistrationCoordinatorProtocol)
}

protocol Registration2CoordinatorType: BaseRegistrationCoordinatorProtocol {
    
    //actions
    func backClicked()
}

class Registration2Coordinator: Registration2CoordinatorType {
    
    private let navigationController: UINavigationController?
    private weak var transitions: Registration2CoordinatorTransitions?
    private weak var controller = Storyboard.auth.controller(withClass: Registration2VC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: Registration2CoordinatorTransitions?, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = Registration2ViewModel(self, serviceHolder: serviceHolder, newUser: newUser)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    deinit {
        print("Registration2Coordinator - deinit")
    }
    
    //actions
    func backClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func nextClicked() {
        transitions?.nextClicked(self)
    }

}
