//
//  RegistrationFlowCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRegistrationCoordinatorProtocol {
    
    func nextClicked()
}

protocol RegistrationFlowCoordinatorTransitions : class {
    
    func userDidLogin()
}

class RegistrationFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: RegistrationFlowCoordinatorTransitions?
    
    private var serviceHolder: ServiceHolder
    private var newUser: SignUpUserViewModel
    
    init(navigationController: UINavigationController, transitions: RegistrationFlowCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        self.newUser = SignUpUserViewModel(model: SignUpUserModel())
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        let coordinator = Registration1Coordinator(navigationController: navigationController, transitions: self, serviceHolder: serviceHolder, newUser: newUser)
        coordinator.start()
    }
    
    deinit {
        print("RegistrationFlowCoordinator deinit")
    }
}

extension RegistrationFlowCoordinator: Registration1CoordinatorTransitions {
    
    func nextClicked(_ from: BaseRegistrationCoordinatorProtocol) {
        print("nextClicked \(from)")

        if from is Registration1Coordinator {
            let coordinator = Registration2Coordinator(navigationController: navigationController, transitions: self, serviceHolder: serviceHolder, newUser: newUser)
            coordinator.start()
        } else if from is Registration2Coordinator {
            
        }
    }
}

extension RegistrationFlowCoordinator: Registration2CoordinatorTransitions {
    
    func userWasCreated() {
        transitions?.userDidLogin()
    }
}
