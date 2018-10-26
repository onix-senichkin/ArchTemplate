//
//  ReadingListServices.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/26/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol ReadingListServiceType: Service {
    
    //actions
    func getItemsCount() -> Int
    func getItem(index: Int) -> NewViewModel?
    func addItem(_ item: NewViewModel)
}

class ReadingListService: ReadingListServiceType {
    
    private var items:[NewViewModel] = []
    
    //actions
    func getItemsCount() -> Int {
        return items.count
    }
    
    func action(for item: NewViewModel) {
        let existed = item.newInReadingList
        if existed {
            item.newInReadingList = false
            removeItem(item)
        } else {
            item.newInReadingList = true
            addItem(item)
        }
    }
    
    func getItem(index: Int) -> NewViewModel? {
        if index < items.count {
            return items[index]
        }
        
        return nil
    }
    
    func addItem(_ item: NewViewModel) {
        let filtered = items.filter( { $0.newId == item.newId } )
        if filtered.count > 0 {
            return
        }
        
        items.append(item)
    }

    func removeItem(_ item: NewViewModel) {
        let filtered = items.filter( { $0.newId == item.newId } )
        if filtered.count > 0 {
            for object in filtered {
                if let index = items.index(of: object) {
                    items.remove(at: index)
                }
            }
        }
    }

}
