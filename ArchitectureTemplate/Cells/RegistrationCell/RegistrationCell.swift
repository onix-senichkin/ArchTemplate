//
//  RegistrationCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol RegistrationCellDelegate: AnyObject {
    
    func doneClicked(type: RegistrationCellType, value: String)
}

class RegistrationCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    
    private weak var delegate: RegistrationCellDelegate?
    private var cellType: RegistrationCellType = .defaultType
    private weak var model: SignUpUserViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tfInput.placeholder = nil
        tfInput.returnKeyType = .next
    }
    
    func customInit(type: RegistrationCellType, returnKeyType: UIReturnKeyType, model: SignUpUserViewModel, delegate: RegistrationCellDelegate?) {
        self.delegate = delegate
        self.cellType = type
        self.model = model
        
        lbTitle.text = model.getTitleValue(for: type)
        tfInput.placeholder = model.getTitleValue(for: type)
        tfInput.text = model.getValue(for: type)
        tfInput.returnKeyType = returnKeyType
    }
    
    override func becomeFirstResponder() -> Bool {
        return tfInput.becomeFirstResponder()
    }
    
    func validate() {
        guard let model = model else { return }
        let validated = model.validate(for: cellType)
        if validated {
            tfInput.layer.borderColor = UIColor.clear.cgColor
            tfInput.layer.borderWidth = 0
        } else {
            tfInput.layer.borderColor = UIColor.red.cgColor
            tfInput.layer.borderWidth = 1
        }
    }
}

extension RegistrationCell: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let value = textField.text ?? ""
        model?.valueChanged(for: cellType, value: value)
        self.validate()

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let value = textField.text ?? ""
        model?.valueChanged(for: cellType, value: value)
        self.validate()
        
        delegate?.doneClicked(type: cellType, value: value)
        return true
    }
}
