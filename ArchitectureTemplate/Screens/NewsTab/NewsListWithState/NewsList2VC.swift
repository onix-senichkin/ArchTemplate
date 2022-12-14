//
//  NewsListVC2.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

private let kCellHeight:CGFloat = 75

class NewsListVC2: UIViewController {
    
    var viewModel: NewsList2ViewModel! {
        didSet {
            viewModel.callback = { [weak self] state in
                self?.parseCallback(state: state)
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    deinit {
        print("NewsListVC2 - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupCollectionView()
        localize()
        getNewsItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems) //fix for blink on reload data
    }
    
    private func setup() {
        
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier) // default
        collectionView.registerNib(NewCollectionCell.self)
    }
    
    private func localize() {
        self.navigationItem.title = "News.Title".localized
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
        collectionView.reloadData()
    }
    
    fileprivate func errorReceived(errorStr: String?) {
        AlertHelper.showAlert(msg: errorStr)
    }
}

//MARK:- UITableViewDataSource
extension NewsListVC2: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: NewCollectionCell = collectionView.dequeCell(for: indexPath), let item = viewModel.getItem(index: indexPath.row) {
            cell.configure(item: item, delegate: self)
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
    }
}

extension NewsListVC2: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.0, height: kCellHeight)
    }
}

//MARK:- UITableViewDelegate
extension NewsListVC2: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showNewDetails(indexPath.row)
    }
}

//MARK:- NewTableCellDelegate
extension NewsListVC2: NewTableCellDelegate {
    
    func btnActionClicked(_ objId: Int) {
        viewModel.btnActionClicked(objId)
        
        let index = viewModel.getRowIndex(from: objId)
        let indexPath = IndexPath(row: index, section: 0)
        self.collectionView.reloadItems(at: [indexPath])
    }
}
