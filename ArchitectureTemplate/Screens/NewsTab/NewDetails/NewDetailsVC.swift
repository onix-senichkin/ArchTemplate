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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)
    }

    private func setupUI() {
        self.title = "New full info"
            
        self.lbTitle.text = viewModel.newTitle
        self.lbDetails.text = viewModel.newDesc
        self.tableView.tableFooterView = UIView()
    }
}
