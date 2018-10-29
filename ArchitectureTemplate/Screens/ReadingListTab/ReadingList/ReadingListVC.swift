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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setup() {
        self.title = "Reading List"
        viewModel.registerCells(for: tableView)
        tableView.tableFooterView = UIView()
    }
}

//MARK:- UITableViewDataSource
extension ReadingListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
}

//MARK:- UITableViewDelegate
extension ReadingListVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK:- NewCellDelegate
extension ReadingListVC: NewCellDelegate {
    
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
