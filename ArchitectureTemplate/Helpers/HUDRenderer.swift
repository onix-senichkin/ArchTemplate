//
//  MBProgressHUD.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import MBProgressHUD

class HUDRenderer {
    
    class func showHUD() {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.windows.first else { return }
            MBProgressHUD.hide(for: view, animated: false)
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }
    
    class func hideHUD() {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.windows.first else { return }
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
