//
//  RegistrationCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol RegistrationCellDataDelegate: class {
    
    func valueChanged(for type: RegistrationCellType, value: String)
    func validate(for type: RegistrationCellType) -> Bool
}

class RegistrationCellNoModel: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    
    private weak var actionDelegate: RegistrationCellDelegate?
    private weak var dataDelegate: RegistrationCellDataDelegate?
    
    private var cellType: RegistrationCellType = .defaultType
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tfInput.placeholder = nil
        tfInput.returnKeyType = .next
    }
    
    func customInit(type: RegistrationCellType, returnKeyType: UIReturnKeyType, model: SignUpUserViewModel, delegate: RegistrationCellDelegate?, dataDelegate: RegistrationCellDataDelegate? = nil) {
        self.actionDelegate = delegate
        self.dataDelegate = dataDelegate
        self.cellType = type
        
        lbTitle.text = model.getTitleValue(for: type)
        tfInput.placeholder = model.getTitleValue(for: type)
        tfInput.text = model.getValue(for: type)
        tfInput.returnKeyType = returnKeyType
    }
    
    override func becomeFirstResponder() -> Bool {
        return tfInput.becomeFirstResponder()
    }
    
    func validate() {
        guard let dataDelegate = dataDelegate else { return }
        let validated = dataDelegate.validate(for: cellType)
        if validated {
            tfInput.layer.borderColor = UIColor.clear.cgColor
            tfInput.layer.borderWidth = 0
        } else {
            tfInput.layer.borderColor = UIColor.red.cgColor
            tfInput.layer.borderWidth = 1
        }
    }
}

extension RegistrationCellNoModel: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let value = textField.text ?? ""
        dataDelegate?.valueChanged(for: cellType, value: value)
        self.validate()

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let value = textField.text ?? ""
        dataDelegate?.valueChanged(for: cellType, value: value)
        self.validate()
        
        actionDelegate?.doneClicked(type: cellType, value: value)
        return true
    }
}
