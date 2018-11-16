//
//  RegistrationDataSource.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/16/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

enum RegistrationCellType: String {
    case defaultType = ""
    case email = "RegistrationCell.Email"
    case firstName = "RegistrationCell.First"
    case lastName = "RegistrationCell.Last"
    case profession = "RegistrationCell.Prof"
    case gender = "RegistrationCell.Gender"
    case city = "RegistrationCell.City"
    case address = "RegistrationCell.Address"
    case phone = "RegistrationCell.Phone"
    case color = "RegistrationCell.Color"
    case season = "RegistrationCell.Season"
}

class CellTypeInfo {
    
    var tableView: UITableView?
    var indexPath: IndexPath?
    var cellType: RegistrationCellType?
    var delegate: UIViewController?
    var bValidateModeOn: Bool?
    var keyboardKeyType: UIReturnKeyType?
    
    init() {
    }
}

class RegistrationDataSource {

    private var newUser: SignUpUserViewModel
    
    init(with user: SignUpUserViewModel) {
        self.newUser = user
    }
    
    var currentUser: SignUpUserViewModel {
        return newUser
    }
}

//MARK: Validate
extension RegistrationDataSource {
    
    func validate(for items: [RegistrationCellType]) -> Bool {
        for cellType in items {
            if !newUser.validate(for: cellType) {
                return false
            }
        }
        return true
    }
}

//MARK: Datasource
extension RegistrationDataSource {
        
    func cellForTableView(cellInfo: CellTypeInfo) -> UITableViewCell? {
        guard let tableView = cellInfo.tableView, let indexPath = cellInfo.indexPath, let cellType = cellInfo.cellType  else {
            return nil
        }
        
        let bValidateModeOn = cellInfo.bValidateModeOn ?? false
        let keyboardNextType:UIReturnKeyType = cellInfo.keyboardKeyType ?? .next

        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCellNoModel.identifier, for: indexPath) as? RegistrationCellNoModel
        let cellDelegate = cellInfo.delegate as? RegistrationCellDelegate
        cell?.customInit(type: cellType, returnKeyType: keyboardNextType, model: newUser, delegate: cellDelegate, dataDelegate: self)
        cell?.selectionStyle = .none
        
        //activate validate mode to cell
        if bValidateModeOn {
            cell?.validate()
        }
        
        return cell
    }
    
}

//MARK:- RegistrationCellDataDelegate
extension RegistrationDataSource: RegistrationCellDataDelegate {
    
    func valueChanged(for type: RegistrationCellType, value: String) {
        newUser.valueChanged(for: type, value: value)
    }
    
    func validate(for type: RegistrationCellType) -> Bool {
        return newUser.validate(for:type)
    }
}
