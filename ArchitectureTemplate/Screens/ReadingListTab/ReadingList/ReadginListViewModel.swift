//
//  ReadingListViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol ReadingListViewModelType {
    
}

class ReadingListViewModel: ReadingListViewModelType {
    
    fileprivate let coordinator: ReadingListCoordinatorType
    private var serviceHolder: ServiceHolder
    private var readingListService: ReadingListService
    
    init(_ coordinator: ReadingListCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        self.readingListService = serviceHolder.get(by: ReadingListService.self)
    }
    
    
    deinit {
        print("ReadingListViewModel - deinit")
    }
    
}
