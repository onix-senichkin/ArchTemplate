//
//  NewsList2ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

enum NewsList2ViewModelState {
    case none
    case itemsRecieved
    case error(message: String)
}

protocol NewsList2ViewModelType {
    
    //callback
    var callback: ((NewsList2ViewModelState) -> ())? { get set }
    
    //datasource
    func registerCells(for collectionView: UICollectionView)
    func getNumberOfRows() -> Int
    func getCell(collectionView: UICollectionView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UICollectionViewCell
    func getRowIndex(from objId: Int) -> Int

    //actions
    func getNews()
    func btnActionClicked(_ objId: Int)
    func showNewDetails(_ index: Int)
}

class NewsList2ViewModel: NewsList2ViewModelType {
    
    fileprivate let coordinator: NewsList2CoordinatorType
    private var readingListService: ReadingListServiceType
    
    private var items: [NewViewModel] = []
    
    var callback: ((NewsList2ViewModelState) -> ())?
    var state: NewsList2ViewModelState = .none {
        didSet {
            callback?(state)
        }
    }

    
    init(_ coordinator: NewsList2CoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.readingListService = serviceHolder.get(by: ReadingListService.self)
    }
        
    deinit {
        print("NewsList2ViewModel - deinit")
    }
    
    //datasource
    
    //actions
    func getNews() {
        
        let request = GetNewsRequest()
        request.getNews(sBlock: { [weak self] items in
            self?.items = items
            
            //add to reading list service
            for newModel in items {
                if newModel.newInReadingList {
                    self?.readingListService.addItem(newModel)
                }
            }
            
            self?.state = .itemsRecieved
        }) { [weak self] errorStr in
            self?.state = .error(message: errorStr)
        }
    }
    
    func btnActionClicked(_ objId: Int) {
        let filtered = items.filter( { $0.newId == objId } )
        if let first = filtered.first {
            readingListService.action(for: first)
        }
    }
    
    func showNewDetails(_ index: Int) {
        if index < items.count {
            let model = items[index]
            coordinator.showNewDetails(model)
        }
    }
}

//MARK: Datasource
extension NewsList2ViewModel {
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: NewCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewCollectionCell.identifier)
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
    
    func getCell(collectionView: UICollectionView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCollectionCell.identifier, for: indexPath) as? NewCollectionCell
        if index < items.count {
            let model = items[index]
            cell?.customInit(item: model, delegate: delegate as? NewTableCellDelegate)
        }
        return cell ?? UICollectionViewCell()
    }

}
