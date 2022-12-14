//
//  ReadingListServices.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/26/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol ReadingListServiceType: Service {
    
    //callback
    var callBackBadgeCountChanged: EmptyClosureType? { get set }

    //getters
    func getObjectIndex(from id: Int) -> Int
    func getItemsCount() -> Int
    func getItem(index: Int) -> NewViewModel?
    
    //actions
    func getItem(objId: Int) -> NewViewModel?
    func addItem(_ item: NewViewModel)
    func removeItem(_ item: NewViewModel)
    func action(for item: NewViewModel)
}

class ReadingListService: ReadingListServiceType {
    
    var callBackBadgeCountChanged: EmptyClosureType?
    private var items:[NewViewModel] = [] {
        didSet {
            callBackBadgeCountChanged?()
        }
    }
    
    deinit {
        print("ReadingListService deinit")
    }

    //getters
    func getObjectIndex(from id: Int) -> Int {
        let filtered = items.filter( { $0.newId == id })
        if let first = filtered.first, let index = items.firstIndex(of: first) {
            return index
        }
        
        return 0
    }
    
    //actions
    func getItemsCount() -> Int {
        return items.count
    }
    
    func action(for item: NewViewModel) {
        let existed = item.newInReadingList
        if existed {
            removeItem(item)
        } else {
            addItem(item)
        }
    }

    func getItem(index: Int) -> NewViewModel? {
        if index < items.count {
            return items[index]
        }
        return nil
    }

    func getItem(objId: Int) -> NewViewModel? {
        let filtered = items.filter( { $0.newId == objId } )
        return filtered.first ?? nil
    }
    
    func addItem(_ item: NewViewModel) {
        let filtered = items.filter( { $0.newId == item.newId } )
        if filtered.count > 0 {
            return
        }
        
        item.newInReadingList = true
        items.append(item)
    }

    func removeItem(_ item: NewViewModel) {
        let filtered = items.filter( { $0.newId == item.newId } )
        if filtered.count > 0 {
            for object in filtered {
                if let index = items.firstIndex(of: object) {
                    object.newInReadingList = false
                    items.remove(at: index)
                }
            }
        }
    }

}
