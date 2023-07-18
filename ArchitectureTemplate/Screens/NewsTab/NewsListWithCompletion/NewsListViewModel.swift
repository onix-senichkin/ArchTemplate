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
    
    //getters
    var newsInfo: NewsInfoModel? { get }
    
    //datasource
    func getNumberOfRows() -> Int
    func getRowIndex(from objId: Int) -> Int

    //actions
    func getNews(sBlock: @escaping EmptyClosureType, eBlock: @escaping SimpleClosure<String?>)
    func btnActionClicked(_ objId: Int)
    func showNewDetails(_ index: Int)
}

class NewsListViewModel: NewsListViewModelType {
    
    fileprivate let coordinator: NewsListCoordinatorType
    private var readingListService: ReadingListServiceType
    
    private var items: [NewViewModel] = []
    private var curNewsInfo: NewsInfoModel?
    
    init(_ coordinator: NewsListCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.readingListService = serviceHolder.get(by: ReadingListService.self)
    }
        
    deinit {
        print("NewsListViewModel - deinit")
    }
    
    //getters
    var newsInfo: NewsInfoModel? {
        return curNewsInfo
    }
    
    //actions
    func getNews(sBlock: @escaping EmptyClosureType, eBlock: @escaping SimpleClosure<String?>) {
        
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
    
    //TODO - research how to return to main thread
    func getNewsAsync(sBlock: @escaping EmptyClosureType, eBlock: @escaping SimpleClosure<String?>) {
        Task {
            async let result1 = GetNewsRequest().performRequestAsync(to: [NewModel].self)
            async let result2 = GetNewsInfoRequest().performRequestAsync(to: NewsInfoModel.self)
            
            let results = await (result1, result2)
            
            switch results.0 {
            case .success(let response):
                let models = response.map( { NewViewModel(new: $0) } )
                self.items = models
            case .error(let message):
                eBlock(message)
                return
            }
            print("getNews result1 \(results.0)")

            switch results.1 {
            case .success(let response):
                self.curNewsInfo = response
            case .error(let message):
                eBlock(message)
                return
            }
            print("getNews result2 \(results.1)")
            
            await MainActor.run {
                sBlock()
            }
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
extension NewsListViewModel {
    
    func getNumberOfRows() -> Int {
        return items.count
    }

    func getRowIndex(from objId: Int) -> Int {
        let filtered = items.filter( { $0.newId == objId } )
        if let first = filtered.first, let index = items.firstIndex(of: first) {
            return index
        }
        
        return 0
    }
    
    func getItem(index: Int) -> NewViewModel? {
        if index < items.count {
            let model = items[index]
            return model
        }
        return nil
    }
}
