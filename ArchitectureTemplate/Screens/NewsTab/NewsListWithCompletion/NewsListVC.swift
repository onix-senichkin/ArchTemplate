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

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("NewsListVC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
        localize()
        getNewsItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setupUI() {
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellType: NewTableCell.self)
    }
    
    private func localize() {
        self.navigationItem.title = "News.Title".localized
    }

    private func getNewsItems() {
        viewModel.getNewsAsync(sBlock: { [weak self] in
            self?.updateUI()
        }) { errorStr in
            AlertHelper.showAlert(msg: errorStr)
        }
    }
    
    private func updateUI() {
        self.tableView.reloadData()
        self.lbTitle.text = viewModel.newsInfo?.title
        self.lbSubtitle.text = viewModel.newsInfo?.subtitle
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
        if let cell: NewTableCell = tableView.dequeCell(for: indexPath), let item = viewModel.getItem(index: indexPath.row) {
            cell.configure(item: item, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK:- UITableViewDelegate
extension NewsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showNewDetails(indexPath.row)
    }
}

//MARK:- NewTableCellDelegate
extension NewsListVC: NewTableCellDelegate {
    
    func btnActionClicked(_ objId: Int) {
        viewModel.btnActionClicked(objId)
        
        let index = viewModel.getRowIndex(from: objId)
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.endUpdates()

    }
}
