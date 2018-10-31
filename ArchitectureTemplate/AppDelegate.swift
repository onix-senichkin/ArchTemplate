//
//  AppDelegate.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let window = window {
            appCoordinator = AppCoordinator(window: window)
        }
        
        //check for started url
        if let launchOptions = launchOptions, launchOptions[UIApplication.LaunchOptionsKey.url] != nil {
            if let url = launchOptions[UIApplication.LaunchOptionsKey.url] as? URL {
                _ = self.application(application, open: url)
            }
        }
        
        //check for started 3D shortcut
        /*if let launchOptions = launchOptions, launchOptions[UIApplication.LaunchOptionsKey.shortcutItem] != nil {
            if let shortcut = launchOptions[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                self.application(application, performActionFor: shortcut, completionHandler: { result in })
            }
        }*/
        
        //deep link test
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let urlString = "https://" + deepLinkHost + "/" + MethodsList.list.rawValue
            if let url = URL(string: urlString) {
                _ = self.application(application, open: url, options: [:])
            }
        }*/

        return true
    }
    
    // deep link
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let host = url.host, host == deepLinkHost { // deep link host
            appCoordinator?.handleLink(url: url)
            return true
        }
        
        return true
    }
    
    // Respond to Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    //3D touch
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let type = shortcutItem.type
        if let url = URL(string: type) {
            appCoordinator?.handleLink(url: url)
        }
    }
}

