//
//  Defines.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

typealias EmptyClosureType = () -> ()
typealias SimpleClosure<T> = (T) -> ()

struct Defines {
    
    static let serverURL = "https://customServerIp/"
    
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_IPHONE_SIMULATOR != 0 // simulator
        //return TARGET_IPHONE_SIMULATOR != 0 // device
    }
    
    static var isIPad: Bool {
        return UIScreen.main.traitCollection.userInterfaceIdiom == .pad
    }
    
    static var isIphone5Size: Bool {
        return UIScreen.main.nativeBounds.width == 640.0
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    static var deviceOrientation: UIInterfaceOrientation {
        if let orientation = UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue) {
            return orientation
        }
        return .portrait
    }
    
    static var isIOS10: Bool {
        if #available(iOS 11, *) {
            //ios 11+
            return false
        } else {
            return true
        }
    }
}
