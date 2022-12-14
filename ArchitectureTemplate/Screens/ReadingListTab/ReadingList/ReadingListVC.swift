//
//  ReadingListVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class ReadingListVC: UITableViewController {
    
    var viewModel: ReadingListViewModelType!
    
    deinit {
        print("ReadingListVC - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setup() {
        self.navigationItem.title = "Reading.Title".localized
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellType: NewTableCell.self)
    }
}

//MARK:- UITableViewDataSource
extension ReadingListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: NewTableCell = tableView.dequeCell(for: indexPath), let item = viewModel.getItem(index: indexPath.row) {
            cell.configure(item: item, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK:- UITableViewDelegate
extension ReadingListVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showNewDetails(indexPath.row)
    }
}

//MARK:- NewTableCellDelegate
extension ReadingListVC: NewTableCellDelegate {
    
    func btnActionClicked(_ objId: Int) {

        let rowIndex = viewModel.getRowIndex(from: objId)
        if rowIndex < tableView.numberOfRows(inSection: 0) {
            viewModel.removeFromReadingList(objId)
            let indexPath = IndexPath(row: rowIndex, section: 0)
            self.tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            self.tableView.endUpdates()
        }
    }
}
