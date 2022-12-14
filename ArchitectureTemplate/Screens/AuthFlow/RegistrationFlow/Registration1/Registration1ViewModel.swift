//
//  Registration1ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

enum Registration1CellType: Int {
    case email = 0
    case firstName
    case lastName
    case profession
}

protocol Registration1ViewModelType {
    
    //actions
    func backClicked()
    func nextClicked()
    func validate() -> Bool
    
    //datasource
    func registerCells(for tableView: UITableView)
    func getNumberOfRows() -> Int
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell
    func getIndex(for type: RegistrationCellType) -> Int
}

class Registration1ViewModel: Registration1ViewModelType {
    
    fileprivate let coordinator: Registration1CoordinatorType
    private var newUser: SignUpUserViewModel
    private var bValidateModeOn = false
    
    init(_ coordinator: Registration1CoordinatorType, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.coordinator = coordinator
        self.newUser = newUser
    }
    
    deinit {
        print("Registration1ViewModel - deinit")
    }
    
    //actions
    func backClicked() {
        coordinator.backClicked()
    }
    
    func nextClicked() {
        coordinator.nextClicked()
    }
    
    func validate() -> Bool {
        bValidateModeOn = true
        let items = [RegistrationCellType.email, RegistrationCellType.firstName, RegistrationCellType.lastName, RegistrationCellType.profession]
        for cellType in items {
            if !newUser.validate(for: cellType) {
                return false
            }
        }
        return true
    }
}

//MARK: Datasource
extension Registration1ViewModel {
    
    func getIndex(for type: RegistrationCellType) -> Int {
        switch type {
            case .email: return 0
            case .firstName: return 1
            case .lastName: return 2
            case .profession: return 3
            default: return 0
        }
    }
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: RegistrationCell.identifier, bundle: nil), forCellReuseIdentifier: RegistrationCell.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return 4
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        var cell: RegistrationCell?
        guard let cellType = Registration1CellType(rawValue: indexPath.row) else { return cell ?? UITableViewCell() }

        cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCell.identifier, for: indexPath) as? RegistrationCell
        let cellDelegate = delegate as? RegistrationCellDelegate
        switch cellType {
            case .email:
                cell?.customInit(type: .email, returnKeyType: .next, model: newUser, delegate: cellDelegate)
            case .firstName:
                cell?.customInit(type: .firstName, returnKeyType: .next, model: newUser, delegate: cellDelegate)
            case .lastName:
                cell?.customInit(type: .lastName, returnKeyType: .next, model: newUser, delegate: cellDelegate)
            case .profession:
                cell?.customInit(type: .profession, returnKeyType: .done, model: newUser, delegate: cellDelegate)
        }

        cell?.selectionStyle = .none

        //activate validate mode to cell
        if bValidateModeOn {
            cell?.validate()
        }
        
        return cell ?? UITableViewCell()
    }
    
}
