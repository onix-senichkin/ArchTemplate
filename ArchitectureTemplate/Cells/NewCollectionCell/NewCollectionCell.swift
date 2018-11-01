//
//  NewCollectionCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/31/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewCollectionCellDelegate: class {
    
    func btnActionClicked(_ objId: Int)
}

class NewCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var ivContainer: UIView!
    
    private weak var delegate: NewTableCellDelegate?
    
    private var objId: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lbTitle.text = ""
        self.btnAction.setTitle("", for: .normal)
    }
    
    func customInit(item: NewViewModel, delegate: NewTableCellDelegate? = nil) {
        self.objId = item.newId
        self.delegate = delegate
        
        self.lbTitle.text = item.newTitle
        print("item \(item.newId)\nbtnAction \((self.btnAction.title(for: .normal)) ?? "")")
        self.btnAction.setTitle(item.newInReadingListTitle, for: .normal)
        self.ivContainer.backgroundColor = item.cellBkg
    }
    
    override func prepareForReuse() {
        self.lbTitle.text = ""
        self.btnAction.setTitle("", for: .normal)
    }
}

extension NewCollectionCell {
    
    @IBAction func btnActionClicked(_ sender: UIButton) {
        if objId >= 0 {
            delegate?.btnActionClicked(objId)
        }
    }
    
}
