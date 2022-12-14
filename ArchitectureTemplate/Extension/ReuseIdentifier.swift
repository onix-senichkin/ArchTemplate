//
//  ReuseIdentifier.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 16.06.2022.
//  Copyright © 2022 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UICollectionViewCell: NibLoadableView {}

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as? T else {
            return nil
        }
        
        return cell
    }
    
    func registerNibForHeader<T: UITableViewHeaderFooterView>(headerType: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func dequeSectionHeader<T: UITableViewHeaderFooterView>() -> T? {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            return nil
        }
        
        return cell
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellWithReuseIdentifier: cellType.nibName)
    }
    
    func dequeCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as? T else {
            return nil
        }
        
        return cell
    }
}

extension UITableView {
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastSection = indexPath.section
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}

extension UICollectionView {
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfItems(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}
