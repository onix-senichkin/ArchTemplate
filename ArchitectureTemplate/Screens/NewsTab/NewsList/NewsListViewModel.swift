//
//  NewsListViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol NewsListViewModelType {
    
}

class NewsListViewModel: NewsListViewModelType {
    
    fileprivate let coordinator: NewsListCoordinatorType
    private var serviceHolder: ServiceHolder
    private var userService: UserServiceType
    
    init(_ coordinator: NewsListCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.userService = serviceHolder.get(by: UserServiceType.self)
    }
        
    deinit {
        print("NewsListViewModel - deinit")
    }
    
}
