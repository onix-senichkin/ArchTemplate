//
//  BaseKeyboardAvoidVC.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 11/2/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit

class BaseKeyboardAvoidVC: UIViewController {
    
    var fBottomOffset:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Keyboard
extension BaseKeyboardAvoidVC {
    
    private func findTableView() -> UITableView? {
        return findAllSubviews(view: self.view)
    }
    
    private func findAllSubviews(view: UIView) -> UITableView? {
        print("findAllSubviews \(view)")
        for subView in view.subviews {
            if subView is UITableView {
                return subView as? UITableView
            } else if subView.subviews.count > 0{
                if let result = findAllSubviews(view: subView) {
                    return result
                }
            }
        }
        
        return nil
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        //if let info = notification.userInfo, let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double, let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if let info = notification.userInfo, let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let offset = keyboardSize.height - fBottomOffset
            let tableView = findTableView()
            tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        let tableView = findTableView()
        tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
