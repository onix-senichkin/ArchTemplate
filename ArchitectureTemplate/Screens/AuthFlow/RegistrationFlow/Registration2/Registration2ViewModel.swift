//
//  Registration2ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

enum Registration2CellType: Int {
    case gender = 0
    case city
    case address
    case phone
}

protocol Registration2ViewModelType {
    
    //actions
    func backClicked()
    func nextClicked()
    func validate() -> Bool
    func createUser(completion: @escaping SimpleClosure<String?>)
    
    //datasource
    func registerCells(for tableView: UITableView)
    func getNumberOfRows() -> Int
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell
    func getIndex(for type: RegistrationCellType) -> Int
}

class Registration2ViewModel: Registration2ViewModelType {
    
    fileprivate let coordinator: Registration2CoordinatorType
    private var userService: UserServiceType
    private var newUser: SignUpUserViewModel
    private var bValidateModeOn = false
    
    init(_ coordinator: Registration2CoordinatorType, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.coordinator = coordinator
        self.userService = serviceHolder.get(by: UserService.self)
        self.newUser = newUser
    }
    
    deinit {
        print("Registration2ViewModel - deinit")
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
        let items = [RegistrationCellType.gender, RegistrationCellType.city, RegistrationCellType.address, RegistrationCellType.phone]
        for cellType in items {
            if !newUser.validate(for: cellType) {
                return false
            }
        }
        return true
    }
    
    func createUser(completion: @escaping SimpleClosure<String?>) {
        userService.createUser(newUser: newUser, completion: completion)
    }
}

//MARK: Datasource
extension Registration2ViewModel {
    
    func getIndex(for type: RegistrationCellType) -> Int {
        switch type {
            case .gender: return 0
            case .city: return 1
            case .address: return 2
            case .phone: return 3
            default: return 0
        }
    }
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: RegistrationCellNoModel.identifier, bundle: nil), forCellReuseIdentifier: RegistrationCellNoModel.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return 4
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        var cell: RegistrationCellNoModel?
        guard let cellType = Registration2CellType(rawValue: indexPath.row) else { return cell ?? UITableViewCell() }

        cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCellNoModel.identifier, for: indexPath) as? RegistrationCellNoModel
        let cellDelegate = delegate as? RegistrationCellDelegate
        var newCellType:RegistrationCellType = .defaultType
        switch cellType {
            case .gender:
                newCellType = .gender
            case .city:
                newCellType = .city
            case .address:
                newCellType = .address
            case .phone:
                newCellType = .phone
        }

        cell?.customInit(type: newCellType, returnKeyType: .done, model: newUser, delegate: cellDelegate, dataDelegate: self)
        cell?.selectionStyle = .none

        //activate validate mode to cell
        if bValidateModeOn {
            cell?.validate()
        }
        
        return cell ?? UITableViewCell()
    }
    
}

//MARK:- RegistrationCellDataDelegate
extension Registration2ViewModel: RegistrationCellDataDelegate {
    
    func valueChanged(for type: RegistrationCellType, value: String) {
        newUser.valueChanged(for: type, value: value)
    }
    
    func validate(for type: RegistrationCellType) -> Bool {
        return newUser.validate(for:type)
    }
}
