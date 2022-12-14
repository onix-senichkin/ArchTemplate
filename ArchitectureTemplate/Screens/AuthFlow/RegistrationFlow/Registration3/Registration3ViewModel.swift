//
//  Registration3ViewModel.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

enum Registration3CellType: Int {
    case color = 0
    case season
    case count
}

protocol Registration3ViewModelType {
    
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

class Registration3ViewModel: Registration3ViewModelType {
    
    fileprivate let coordinator: Registration3CoordinatorType
    private var userService: UserServiceType
    private var bValidateModeOn = false
    private var dataSource: RegistrationDataSource
    
    init(_ coordinator: Registration3CoordinatorType, serviceHolder: ServiceHolder, newUser: SignUpUserViewModel) {
        self.coordinator = coordinator
        self.userService = serviceHolder.get(by: UserService.self)
        self.dataSource = RegistrationDataSource(with: newUser)
    }
    
    deinit {
        print("Registration3ViewModel - deinit")
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
        let items = [RegistrationCellType.color, RegistrationCellType.season]
        return dataSource.validate(for: items)
    }
    
    func createUser(completion: @escaping SimpleClosure<String?>) {
        let newUser = dataSource.currentUser
        userService.createUser(newUser: newUser, completion: completion)
    }
}

//MARK: Datasource
extension Registration3ViewModel {
    
    func getIndex(for type: RegistrationCellType) -> Int {
        switch type {
            case .season: return 0
            case .color: return 1
            default: return 0
        }
    }
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: RegistrationCellNoModel.identifier, bundle: nil), forCellReuseIdentifier: RegistrationCellNoModel.identifier)
    }
    
    func getNumberOfRows() -> Int {
        return Registration3CellType.count.rawValue
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, delegate: UIViewController) -> UITableViewCell {
        
        guard let cellType = Registration3CellType(rawValue: indexPath.row) else { return UITableViewCell() }
        var newCellType:RegistrationCellType = .defaultType
        var keyboardNextType:UIReturnKeyType = .next
        switch cellType {
            case .color:
                newCellType = .color
            case .season:
                newCellType = .season
                keyboardNextType = .done
            default: break
        }

        let cellInfo = CellTypeInfo()
        cellInfo.tableView = tableView
        cellInfo.indexPath = indexPath
        cellInfo.delegate = delegate
        cellInfo.bValidateModeOn = bValidateModeOn
        cellInfo.keyboardKeyType = keyboardNextType
        cellInfo.cellType = newCellType
        
        return dataSource.cellForTableView(cellInfo: cellInfo) ?? UITableViewCell()

    }
}
