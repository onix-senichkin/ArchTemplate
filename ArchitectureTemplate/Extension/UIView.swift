//
//  UIViewController.swift
//  Benchmrk
//
//  Created by Denis Senichkin on 11/9/18.
//  Copyright © 2018 Onix. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class var identifier: String {
        let separator = "."
        let fullName = String(describing: self)
        if fullName.contains(separator) {
            let items = fullName.components(separatedBy: separator)
            if let name = items.last {
                return name
            }
        }
        
        return fullName
    }
}

