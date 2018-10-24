//
//  SignInVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class SignInVC: UITableViewController {
    
    var viewModel: SignInViewModelType!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    deinit {
        print("SignInVC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settupUI()
    }
    
    private func settupUI() {
        tfEmail.delegate = self
        tfPassword.delegate = self
        
        if Platform.isSimulator {
            tfEmail.text = "john.doe@gmail.com"
            tfPassword.text = "qwert1234"
        }
    }
}

//MARK: UITextFieldDelegate
extension SignInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        } else if textField == tfPassword {
            textField.resignFirstResponder()
            validate()
        }
        return true
    }
}

//MARK: Actions
extension SignInVC {
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        validate()
    }
    
    private func validate() {
        let email = tfEmail.text ?? ""
        let password = tfPassword.text ?? ""
        
        if let errorStr = viewModel.validate(email: email, password: password) {
            AlertHelper.showAlert(errorStr)
            return
        }
        
        view.endEditing(true)
        signIn(email: email, password: password)
    }
    
    private func signIn(email: String, password: String)
    {
        viewModel.login(email: email, password: password) { error in
            if let error = error {
                AlertHelper.showAlert(error)
            }
        }
    }
}
