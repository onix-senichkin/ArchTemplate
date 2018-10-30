//
//  DeepLinkManager.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/30/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

let deepLinkHost = "www.onix.sample.app"

/*
 http://www.onix.sample.app/news
 http://www.onix.sample.app/list
 http://www.onix.sample.app/profile
 */

enum MethodsList: String {
    case news = "news"
    case list = "list"
    case profile = "profile"
    case undefined = "n/a"
}

protocol DeepLinkManagerType: Service {
    func handleLink(url: URL)
    func clearSavedLink()
    func reopenSavedLink()
}

class DeepLinkManager: NSObject, DeepLinkManagerType {
    
    fileprivate let appCoordinator: AppCoordinator
    fileprivate let userService: UserServiceType
    fileprivate var tmpLink: URL?

    init(coordinator: AppCoordinator, userService: UserService) {
        self.appCoordinator = coordinator
        self.userService = userService
    }
    
    //MARK: - Relogin logic
    func clearSavedLink() {
        tmpLink = nil
    }
    
    func reopenSavedLink() {
        if let link = tmpLink {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
                self?.handleLink(url: link)
                self?.clearSavedLink()
            }
        }
    }
}

//MARK:- Handle Link
extension DeepLinkManager {
    
    func handleLink(url: URL) {
        //app in not loaded, wait for relogin and the open url again
        if !userService.userLoggedIn {
            tmpLink = url
            return
        }
        tmpLink = nil

        let method = url.path.replacingOccurrences(of: "/", with: "")
        let methodEnum:MethodsList? = MethodsList.init(rawValue: method)
        guard let action = methodEnum else { return }
        print("DeepLinkManager \(action.rawValue)")
        
        switch action {
            case .news: showTabNews()
            case .list: showTabList()
            case .profile: showTabProfile()

            default: break
        }
    }
    
    //MARK: - Coordinators
    var newsCoordinator: NewsTabCoordinator? {
        let tabBarCoordinator = appCoordinator.getTabBarCoordinator()
        return tabBarCoordinator?.getTabCoordinator(index: TabBarItems.tabNews.rawValue)
    }

    var listCoordinator: ReadingListTabCoordinator? {
        let tabBarCoordinator = appCoordinator.getTabBarCoordinator()
        return tabBarCoordinator?.getTabCoordinator(index: TabBarItems.tabReadingList.rawValue)
    }

    var profileCoordinator: ProfileTabCoordinator? {
        let tabBarCoordinator = appCoordinator.getTabBarCoordinator()
        return tabBarCoordinator?.getTabCoordinator(index: TabBarItems.tabProfile.rawValue)
    }

}

//MARK: - News tab
extension DeepLinkManager {
    
    func showTabNews() {
        selectTabAction(TabBarItems.tabNews)
    }
}

//MARK: - List tab
extension DeepLinkManager {
    
    func showTabList() {
        selectTabAction(TabBarItems.tabReadingList)
    }
}

//MARK: - List tab
extension DeepLinkManager {
    
    func showTabProfile() {
        selectTabAction(TabBarItems.tabProfile)
    }
}

//MARK: - Helpers
extension DeepLinkManager {
    
    fileprivate func selectTabAction(_ index: TabBarItems) {

        appCoordinator.getTabBarCoordinator()?.selectTab(index: index)
    }
}
