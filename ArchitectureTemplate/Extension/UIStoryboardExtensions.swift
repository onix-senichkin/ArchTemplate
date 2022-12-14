//
//  UIStoryboardExtensions.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

struct Storyboard {
    static let launch = UIStoryboard(name: "LaunchScreen", bundle: nil)
    static let auth = UIStoryboard(name: "AuthFlow", bundle: nil)
    static let news = UIStoryboard(name: "News", bundle: nil)
    static let readingList = UIStoryboard(name: "ReadingList", bundle: nil)
    static let profile = UIStoryboard(name: "Profile", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    
    func controller<T: UIViewController>(withClass: T.Type) -> T? {
        let identifier = withClass.identifier
        return instantiateViewController(withIdentifier: identifier) as? T
    }
    
    func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }
