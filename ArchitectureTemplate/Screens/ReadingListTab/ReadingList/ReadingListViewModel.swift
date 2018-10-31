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
    func registerCells(for tableView: UITableView)
    func getNumberOfRows() -> Int
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell
    func getRowIndex(from id: Int) -> Int
    
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
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: NewTableCell.identifier, bundle: nil), forCellReuseIdentifier: NewTableCell.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return readingListService.getItemsCount()
    }
    
    func getRowIndex(from id: Int) -> Int {
        return readingListService.getObjectIndex(from: id)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: NewTableCell.identifier, for: indexPath) as? NewTableCell
        let count = readingListService.getItemsCount()
        if index < count, let model = readingListService.getItem(index: index) {
            cell?.customInit(item: model, delegate: delegate as? NewTableCellDelegate)
        }
        return cell ?? UITableViewCell()
    }
    
}
