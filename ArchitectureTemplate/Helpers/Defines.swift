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

class Defines {
    static let baseEndpoint: String = "https://server/api/"
    static let authEndpoint: String = "\(baseEndpoint)/auth"
    static let loginEndpoint: String = "\(authEndpoint)/login"
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
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var deviceOrientation: UIInterfaceOrientation {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .portrait
    }
}
