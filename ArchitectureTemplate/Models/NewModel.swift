//
//  NewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

class NewModel: Decodable {
    
    var id: Int
    var title: String
    var desc: String
    var inReadingList: Bool
}
