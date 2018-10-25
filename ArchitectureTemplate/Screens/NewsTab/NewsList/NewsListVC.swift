//
//  NewsListVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class NewsListVC: UIViewController {
    
    var viewModel: NewsListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("NewsListVC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getNewsItems()
    }
    
    private func setup() {
        viewModel.registerCells(for: tableView)
    }
    
    private func getNewsItems() {
        viewModel.getNews(sBlock: { [weak self] in
            self?.tableView.reloadData()
        }) { errorStr in
            AlertHelper.showAlert(msg: errorStr)
        }
    }
}

extension NewsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
}
