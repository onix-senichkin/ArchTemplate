//
//  Registration1VC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class Registration1VC: UIViewController {
    
    var viewModel: Registration1ViewModelType!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivFooterView: RegistrationFooter!
    
    deinit {
        print("Registration1VC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
        self.navigationItem.title = "Step 1"
        viewModel.registerCells(for: tableView)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        ivFooterView.customSetup(delegate: self)
    }
}

//MARK:- UITableViewDataSource
extension Registration1VC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
}

//MARK:- UITableViewDataSource
extension Registration1VC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.view.endEditing(true)
    }
}

//MARK:- RegistrationCellDelegate
extension Registration1VC: RegistrationCellDelegate {
    
    func doneClicked(type: RegistrationCellType, value: String) {
        viewModel.valueChanged(type: type, value: value)
        self.view.endEditing(true)
    }
}

//MARK:- RegistrationFooterDelegate
extension Registration1VC: RegistrationFooterDelegate {
    
    func backClicked() {
        viewModel.backClicked()
    }
    
    func nextClicked() {
        viewModel.nextClicked()
    }
}
