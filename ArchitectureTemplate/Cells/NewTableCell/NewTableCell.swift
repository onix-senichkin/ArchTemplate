//
//  NewTableCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

protocol NewTableCellDelegate: AnyObject {
    
    func btnActionClicked(_ objId: Int)
}

class NewTableCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    private weak var delegate: NewTableCellDelegate?
    
    private var objId: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(item: NewViewModel, delegate: NewTableCellDelegate? = nil) {
        self.objId = item.newId
        self.delegate = delegate

        self.lbTitle.attributedText = NSMutableAttributedString().normalSF("Title: ", color: .gray).boldSF(item.newTitle)
        self.lbDesc.attributedText = NSMutableAttributedString().normalSF("Value: ", color: .red).semiboldSF(item.newDesc, color: .blue)
        self.btnAction.setTitle(item.newInReadingListTitle, for: .normal)
        self.contentView.backgroundColor = item.cellBkg
    }
}

extension NewTableCell {
    
    @IBAction func btnActionClicked(_ sender: UIButton) {
        if objId >= 0 {
            delegate?.btnActionClicked(objId)
        }
    }

}
