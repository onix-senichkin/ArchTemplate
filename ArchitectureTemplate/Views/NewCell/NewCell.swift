//
//  NewCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewCellDelegate: class {
    
    func btnActionClicked(_ objId: Int)
}

class NewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    private weak var delegate: NewCellDelegate?
    
    private var objId: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customInit(item: NewViewModel, delegate: NewCellDelegate? = nil) {
        self.objId = item.newId
        self.delegate = delegate

        self.lbTitle.text = item.newTitle
        self.lbDesc.text = item.newDesc
        self.btnAction.setTitle(item.newInReadingListTitle, for: .normal)
        self.contentView.backgroundColor = item.cellBkg
        
        //self.btnAction.setNeedsLayout()
        //self.btnAction.layoutIfNeeded()
    }
}

extension NewCell {
    
    @IBAction func btnActionClicked(_ sender: UIButton) {
        if objId >= 0 {
            delegate?.btnActionClicked(objId)
        }
    }

}
