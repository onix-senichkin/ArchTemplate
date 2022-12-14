//
//  NewDetailsVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/30/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class NewDetailsVC: UITableViewController {
    
    var viewModel: NewDetailsViewModelType!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDetails: UILabel!
    
    deinit {
        print("SignInVC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        localize()
    }
    
    private func setupUI() {
        self.lbTitle.text = viewModel.newTitle
        self.lbDetails.text = viewModel.newDesc
        self.tableView.tableFooterView = UIView()
    }
    
    private func localize() {
        self.title = "FullNew.Title".localized
    }
}
