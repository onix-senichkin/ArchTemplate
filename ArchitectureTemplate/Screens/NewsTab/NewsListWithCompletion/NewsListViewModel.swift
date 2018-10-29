//
//  NewsListViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsListViewModelType {
    
    //datasource
    func registerCells(for tableView: UITableView)
    func getNumberOfRows() -> Int
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell
    func getRowIndex(from objId: Int) -> Int

    //actions
    func getNews(sBlock: @escaping EmptyClosureType, eBlock: @escaping SimpleClosure<String>)
    func btnActionClicked(_ objId: Int)
}

class NewsListViewModel: NewsListViewModelType {
    
    fileprivate let coordinator: NewsListCoordinatorType
    private var readingListService: ReadingListServiceType
    
    private var items: [NewViewModel] = []
    
    init(_ coordinator: NewsListCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.readingListService = serviceHolder.get(by: ReadingListService.self)
    }
        
    deinit {
        print("NewsListViewModel - deinit")
    }
    
    //datasource
    
    //actions
    func getNews(sBlock: @escaping EmptyClosureType, eBlock: @escaping SimpleClosure<String>) {
        
        let request = GetNewsRequest()
        request.getNews(sBlock: { [weak self] items in
            self?.items = items
            
            //add to reading list service
            for newModel in items {
                if newModel.newInReadingList {
                    self?.readingListService.addItem(newModel)
                }
            }
            
            sBlock()
        }) { errorStr in
            eBlock(errorStr)
        }
    }
    
    func btnActionClicked(_ objId: Int) {
        let filtered = items.filter( { $0.newId == objId } )
        if let first = filtered.first {
            readingListService.action(for: first)
        }
    }
}

//MARK: Datasource
extension NewsListViewModel {
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: NewCell.identifier, bundle: nil), forCellReuseIdentifier: NewCell.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return items.count
    }

    func getRowIndex(from objId: Int) -> Int {
        let filtered = items.filter( { $0.newId == objId } )
        if let first = filtered.first, let index = items.index(of: first) {
            return index
        }
        
        return 0
    }

    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: NewCell.identifier, for: indexPath) as? NewCell
        if index < items.count {
            let model = items[index]
            cell?.customInit(item: model, delegate: delegate as? NewCellDelegate)
        }
        return cell ?? UITableViewCell()
    }
}