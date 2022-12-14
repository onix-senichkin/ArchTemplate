//
//  ReadingListViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol ReadingListViewModelType {
    
    //datasource
    func getNumberOfRows() -> Int
    func getRowIndex(from id: Int) -> Int
    func getItem(index: Int) -> NewViewModel?
    
    //actions
    func removeFromReadingList(_ objId: Int)
    func showNewDetails(_ objId: Int)
}

class ReadingListViewModel: ReadingListViewModelType {
    
    fileprivate let coordinator: ReadingListCoordinatorType
    private var readingListService: ReadingListServiceType
    
    init(_ coordinator: ReadingListCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.readingListService = serviceHolder.get(by: ReadingListService.self)
    }
    
    
    deinit {
        print("ReadingListViewModel - deinit")
    }
    
    //actions
    func removeFromReadingList(_ objId: Int) {
        if let model = readingListService.getItem(objId: objId) {
            readingListService.removeItem(model)
        }
    }
    
    func showNewDetails(_ index: Int) {
        if let model = readingListService.getItem(index: index) {
            coordinator.showNewDetails(model)
        }
    }
}

//MARK: Datasource
extension ReadingListViewModel {
    
    func getNumberOfRows() -> Int {
        return readingListService.getItemsCount()
    }
    
    func getRowIndex(from id: Int) -> Int {
        return readingListService.getObjectIndex(from: id)
    }
    
    func getItem(index: Int) -> NewViewModel? {
        let count = readingListService.getItemsCount()
        if index < count, let model = readingListService.getItem(index: index) {
            return model
        }
        return nil
    }
}
