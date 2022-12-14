//
//  AlertHelper.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    class func showAlert(_ error: String?) {
        showAlert(msg: error)
    }
    
    class func getTopController(from: UIViewController? = nil) -> UIViewController? {
        var tryCount = 0
        
        if let controller = from {
            return controller
        } else if var controller = UIApplication.shared.windows.first?.rootViewController {
            if let tabBar = controller as? UITabBarController, let selected = tabBar.selectedViewController {
                if let nav = selected as? UINavigationController, let last =  nav.viewControllers.last {
                    controller = last
                } else if let vc = selected as UIViewController? {
                    controller = vc
                }
            }
            while let presented = controller.presentedViewController, tryCount < 1000 {
                tryCount += 1
                if let nav = presented as? UINavigationController, let last = nav.viewControllers.last {
                    controller = last
                } else if let vc = presented as UIViewController? {
                    controller = vc
                }
                DispatchQueue.main.async {
                    controller = presented
                }
            }
            return controller
        }
        return nil
    }
    
    class func showAlert(_ title: String? = "Error", msg: String?, from: UIViewController? = nil, leftBtnTitle: String? = "OK", rightBtnTitle: String? = nil, completion: SimpleClosure<Bool>? = nil) {
        let alertTitle = title ?? "Error"
        let alertMsg = msg ?? ""
        let alertLeftBtnTitle = leftBtnTitle ?? "Common.OK"
        
        DispatchQueue.main.async {
            HUDRenderer.hideHUD()
            
            guard let root = getTopController(from: from) else { return }
            
            let alertVC = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: alertLeftBtnTitle, style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil)
                completion?(false)
            })
            alertVC.addAction(ok)
            
            if let alertRightBtnTitle = rightBtnTitle {
                let action = UIAlertAction(title: alertRightBtnTitle, style: .default, handler: { _ in
                    alertVC.dismiss(animated: true, completion: nil)
                    completion?(true)
                })
                alertVC.addAction(action)
                alertVC.preferredAction = action
            }
            
            root.present(alertVC, animated: true, completion: nil)
        }
    }
    
    class func showAlert(msg: String?, from: UIViewController? = nil, leftBtnTitle: String? = "OK", rightBtnTitle: String? = nil, completion: SimpleClosure<Bool>? = nil) {
        let alertMsg = msg ?? ""
        let alertLeftBtnTitle = leftBtnTitle ?? "Common.OK"
        
        DispatchQueue.main.async {
            HUDRenderer.hideHUD()
            
            guard let root = getTopController(from: from) else { return }
            
            let alertVC = UIAlertController(title: nil, message: alertMsg, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: alertLeftBtnTitle, style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil)
                completion?(false)
            })
            alertVC.addAction(ok)
            
            if let alertRightBtnTitle = rightBtnTitle {
                let action = UIAlertAction(title: alertRightBtnTitle, style: .default, handler: { _ in
                    alertVC.dismiss(animated: true, completion: nil)
                    completion?(true)
                })
                alertVC.addAction(action)
            }
            
            root.present(alertVC, animated: true, completion: nil)
        }
    }
    
    class func createAlert(_ from: String) -> Error {
        let error = NSError(domain: "domain", code: 400, userInfo: [NSLocalizedDescriptionKey : from])
        return error
    }
}
