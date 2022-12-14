//
//  RegistrationFooter.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/1/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

private let kBackTitle = "Common.Back".localized
private let kNextTitle = "Common.Next".localized

protocol RegistrationFooterDelegate: AnyObject {
    
    func backClicked()
    func nextClicked()
}

class RegistrationFooter: UIView {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    private weak var delegate: RegistrationFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        self.nibSetup() //load xib
        
        self.backgroundColor = .white
    }
    
    func customSetup(delegate: RegistrationFooterDelegate?, backTitle: String? = kBackTitle, nextTitle: String? = kNextTitle) {
        self.delegate = delegate
        self.btnBack.setTitle(backTitle?.localized, for: .normal)
        self.btnNext.setTitle(nextTitle?.localized, for: .normal)
    }
}

//MARK:- Actions
extension RegistrationFooter {
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        delegate?.backClicked()
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        delegate?.nextClicked()
    }

}
