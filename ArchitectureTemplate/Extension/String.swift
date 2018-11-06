//
//  String.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/6/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
