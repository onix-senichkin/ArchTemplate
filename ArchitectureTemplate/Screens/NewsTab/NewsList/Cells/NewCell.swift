//
//  NewCell.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class NewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customInit(index: Int, item: NewViewModel) {
        self.lbTitle.text = item.newTitle
        self.lbDesc.text = item.newDesc
    }
}

extension NewCell {
    
    @IBAction func btnActionClicked(_ sender: UIButton) {
        
    }

}
