//
//  ViewController.swift
//  ScrollViewKeyboardAvoid
//
//  Created by Dmitrii Babii on 26.11.2022.
//

import UIKit

class ScrollViewLoginController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.registerKeyboardAvoiding()
        // Do any additional setup after loading the view.
    }


}

