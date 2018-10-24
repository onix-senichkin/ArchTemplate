//
//  ProfileCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorTransitions: class {
    func logout()
}

protocol ProfileCoordinatorType {
    
    //navigation
    func logout()
}

class ProfileCoordinator: ProfileCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: ProfileCoordinatorTransitions?
    private weak var controller = Storyboard.profile.controller(withClass: ProfileVC.self)
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: ProfileCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
        
        controller?.viewModel = ProfileViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    deinit {
        print("ProfileCoordinator - deinit")
    }
    
    //navigation
    func logout() {
        transitions?.logout()
    }

    
}
