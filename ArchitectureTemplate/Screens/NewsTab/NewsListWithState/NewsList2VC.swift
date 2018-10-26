//
//  NewsListVC2.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class NewsListVC2: UIViewController {
    
    var viewModel: NewsList2ViewModel! {
        didSet {
            viewModel.callback = { [weak self] state in
                self?.parseCallback(state: state)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("NewsListVC2 - deinit")
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
        self.title = "News 2"
        viewModel.registerCells(for: tableView)
        tableView.tableFooterView = UIView()
    }
    
    private func getNewsItems() {
        viewModel.getNews()
    }
}

//MARK:- Viewmodel Callback state
extension NewsListVC2 {
    
    fileprivate func parseCallback(state: NewsList2ViewModelState) {
        switch state {
            case .itemsRecieved:
                itemReceived()
            case .error(let message):
                errorReceived(errorStr: message)
            default: break
        }
    }
    
    fileprivate func itemReceived() {
        tableView.reloadData()
    }
    
    fileprivate func errorReceived(errorStr: String) {
        AlertHelper.showAlert(msg: errorStr)
    }
}

//MARK:- UITableViewDataSource
extension NewsListVC2: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, delegate: self)
        return cell
    }
}

//MARK:- UITableViewDelegate
extension NewsListVC2: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK:- NewCellDelegate
extension NewsListVC2: NewCellDelegate {
    
    func btnActionClicked(_ index: Int) {
        viewModel.btnActionClicked(index)
        //self.tableView.reloadData()
        
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.endUpdates()
    }
}
