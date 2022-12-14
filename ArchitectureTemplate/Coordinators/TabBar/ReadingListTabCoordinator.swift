//
//  ReadingListTabCoordinator.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol ReadingListTabCoordinatorTransitions: AnyObject {
    
}

class ReadingListTabCoordinator: TabBarItemCoordinatorType {

    let rootController = UINavigationController()
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Reading.Title".localized, image: UIImage(named: "icReadingList"), selectedImage: nil)
    private var serviceHolder: ServiceHolder
    private weak var transitions: ReadingListTabCoordinatorTransitions?
    
    init(serviceHolder: ServiceHolder, transitions: ReadingListTabCoordinatorTransitions) {
        self.serviceHolder = serviceHolder
        self.transitions = transitions
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        
        let coordinator = ReadingListCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
        
        let readingListService = self.serviceHolder.get(by: ReadingListService.self)
        readingListService.callBackBadgeCountChanged = { [weak self] in
            self?.updateBadgeCount()
        }
    }
    
    deinit {
        print("ReadingListTabCoordinator deinit")
    }
    
    func updateBadgeCount() {
        let readingListService = self.serviceHolder.get(by: ReadingListService.self)
        let count = readingListService.getItemsCount()
        if count > 0 {
            rootController.tabBarItem.badgeValue = String(count)
        } else {
            rootController.tabBarItem.badgeValue = nil
        }
    }
}

extension ReadingListTabCoordinator: ReadingListCoordinatorTransitions {
    
}
