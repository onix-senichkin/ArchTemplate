//
//  UIFont.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 15.06.2022.
//  Copyright © 2022 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func fontList() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    class func customFont(_ size: CGFloat, weight: Weight = .regular) -> UIFont? {
        // can be our custom fonts
        var customFont: UIFont?
        switch weight {
            case .bold: customFont = UIFont.systemFont(ofSize: size, weight: .bold) // just for sample
            case .semibold: customFont = UIFont.systemFont(ofSize: size, weight: .semibold)
            default: customFont = UIFont.systemFont(ofSize: size, weight: weight)
        }
        return customFont ?? UIFont.systemFont(ofSize: size)
    }
}
