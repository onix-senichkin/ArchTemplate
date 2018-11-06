//
//  Registration2VC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class Registration2VC: BaseKeyboardAvoidVC {
    
    var viewModel: Registration2ViewModelType!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivFooterView: RegistrationFooter!
    
    deinit {
        print("Registration2VC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        localize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)
    }

    private func setup() {
        self.view.backgroundColor = RGBColor(230, 230, 230)
        
        fBottomOffset = ivFooterView.height // for keyboard offset logic
        viewModel.registerCells(for: tableView)
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        ivFooterView.customSetup(delegate: self)
    }
    
    private func localize() {
        self.navigationItem.title = "SignUpStep2.Title".localized
    }

}

//MARK:- UITableViewDataSource
extension Registration2VC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//MARK:- UITableViewDataSource
extension Registration2VC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.view.endEditing(true)
    }
}

//MARK:- RegistrationCellDelegate
extension Registration2VC: RegistrationCellDelegate {
    
    func doneClicked(type: RegistrationCellType, value: String) {
        
        let nextIndex = viewModel.getIndex(for: type) + 1
        let indexPath = IndexPath(row: nextIndex, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            cell.becomeFirstResponder()
        }
       
        if type == .phone {
            self.view.endEditing(true)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

//MARK:- RegistrationFooterDelegate
extension Registration2VC: RegistrationFooterDelegate {
    
    func backClicked() {
        viewModel.backClicked()
    }
    
    func nextClicked() {
        let validated = viewModel.validate()
        if !validated {
            tableView.reloadData()
        } else {
            createUser()
        }
    }
    
    private func createUser() {
        viewModel.createUser { [weak self] errorStr in
            if let errorStr = errorStr {
                AlertHelper.showAlert(errorStr)
                return
            }
            
            self?.viewModel.nextClicked()
        }
    }
}
