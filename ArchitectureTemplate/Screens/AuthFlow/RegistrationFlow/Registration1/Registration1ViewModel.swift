//
//  Registration1ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

protocol Registration1ViewModelType {
    
    //actions
    func backClicked()
    func nextClicked()
    func valueChanged(type: RegistrationCellType, value: String)
    func validate() -> Bool
    
    //datasource
    func registerCells(for tableView: UITableView)
    func getNumberOfRows() -> Int
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell
}

class Registration1ViewModel: Registration1ViewModelType {
    
    fileprivate let coordinator: Registration1CoordinatorType
    private var serviceHolder: ServiceHolder
    private var newUser: SignUpUserViewModel
    
    init(_ coordinator: Registration1CoordinatorType, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
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
    
    func valueChanged(type: RegistrationCellType, value: String) {
        newUser.valueChanged(type: type, value: value)
    }
    
    func validate() -> Bool {
     
        return false
    }
}

//MARK: Datasource
extension Registration1ViewModel {
    
    //email
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: RegistrationCell.identifier, bundle: nil), forCellReuseIdentifier: RegistrationCell.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return 1
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCell.identifier, for: indexPath) as? RegistrationCell
        cell?.customInit(type: .email, returnKeyType: .done, delegate: delegate as? RegistrationCellDelegate)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
}
