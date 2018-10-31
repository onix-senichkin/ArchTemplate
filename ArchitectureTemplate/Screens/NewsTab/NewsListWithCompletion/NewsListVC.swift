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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setup() {
        self.title = "News"
        viewModel.registerCells(for: tableView)
        tableView.tableFooterView = UIView()
    }
    
    private func getNewsItems() {
        viewModel.getNews(sBlock: { [weak self] in
            self?.tableView.reloadData()
        }) { errorStr in
            AlertHelper.showAlert(msg: errorStr)
        }
    }
}

//MARK:- Deeplink
extension NewsListVC {
    
    func showTopNew() {
        viewModel.showNewDetails(0)
    }
}

//MARK:- UITableViewDataSource
extension NewsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
}

//MARK:- UITableViewDelegate
extension NewsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showNewDetails(indexPath.row)
    }
}

//MARK:- NewCellDelegate
extension NewsListVC: NewCellDelegate {
    
    func btnActionClicked(_ objId: Int) {
        viewModel.btnActionClicked(objId)
        
        let index = viewModel.getRowIndex(from: objId)
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.endUpdates()

    }
}
