//
//  NSAttributedString.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 15.06.2022.
//  Copyright © 2022 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

private let fontSize: CGFloat = 17

extension NSMutableAttributedString {
    
    func normalSF(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil) -> NSMutableAttributedString {
        guard let font = UIFont.customFont(size, weight: .regular) else { return self }
                
        var attributes:[NSAttributedString.Key : Any] = [.font : font]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldSF(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil) -> NSMutableAttributedString {
        guard let font = UIFont.customFont(size, weight: .bold) else { return self }
        
        var attributes:[NSAttributedString.Key : Any] = [.font : font]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func semiboldSF(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil) -> NSMutableAttributedString {
        guard let font = UIFont.customFont(size, weight: .semibold) else { return self }
        
        var attributes:[NSAttributedString.Key : Any] = [.font : font]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
