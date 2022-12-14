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

//MARK: Xib load routine
extension UIView {
    
    func nibSetup() {
        backgroundColor = .clear
        let subView = loadViewFromNib()
        subView.frame = bounds
        //subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //subView.translatesAutoresizingMaskIntoConstraints = true
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subView)
        self.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0).isActive = true
        //subView.backgroundColor = .green
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
}

//MARK: Frame routine
extension UIView {
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var top: CGFloat {
        return self.frame.origin.y
    }
    
    var bottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    var left: CGFloat {
        return self.frame.origin.x
    }
    
    var rigth: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    var size: CGSize {
        return self.frame.size
    }
}
