//
//  NewViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

class NewViewModel: NSObject {
    
    private let newModel: NewModel
    
    init(new: NewModel) {
        self.newModel = new
    }
    
    //MARK: Getters
    var newId: Int {
        return newModel.id
    }
    
    var newTitle: String {
        return newModel.title
    }
    
    var newDesc: String {
        return newModel.desc
    }
    
    var newInReadingList: Bool {
        get {
            return newModel.inReadingList
        }
        set {
            newModel.inReadingList = newValue
        }
    }
    
    var newInReadingListTitle: String {
        let title = !newModel.inReadingList ? "Add" : "Remove"
        return title
    }
    
    var cellBkg: UIColor {
        let inReadingListBkg = RGBColor(225, 225, 225)
        let defaultBkg = UIColor.white
        return newModel.inReadingList ? inReadingListBkg : defaultBkg
    }
}
