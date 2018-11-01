//
//  RegistrationCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

enum RegistrationCellType: String {
    case defaultType = ""
    case email = "Email"
    case firstName = "First Name"
    case lastName = "Last Name"
    case phone = "Phone"
}

protocol RegistrationCellDelegate: class {
    
    func doneClicked(type: RegistrationCellType, value: String)
}

class RegistrationCell: UITableViewCell {

    @IBOutlet weak var tfInput: UITextField!
    
    weak var delegate: RegistrationCellDelegate?
    var cellType: RegistrationCellType = .defaultType
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tfInput.placeholder = nil
        tfInput.returnKeyType = .next
    }
    
    func customInit(type: RegistrationCellType, returnKeyType: UIReturnKeyType, delegate: RegistrationCellDelegate?) {
        self.delegate = delegate
        self.cellType = type
        
        tfInput.placeholder = type.rawValue
        tfInput.returnKeyType = returnKeyType
    }
}

extension RegistrationCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.doneClicked(type: cellType, value: textField.text ?? "")
        return true
    }
}
