//
//  UIScrollView+KeyboardAvoiding.swift
//  ScrollViewKeyboardAvoid
//
//  Created by Dmitrii Babii on 26.11.2022.
//

import UIKit

extension UIScrollView {
    
    
    
    func registerKeyboardAvoiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardRect: CGRect? = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardSize = keyboardRect?.size
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        let height = (keyboardSize?.height ?? 0.0)  - (self.superview?.safeAreaInsets.bottom ?? 0.0)
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        self.contentInset = insets
        self.scrollIndicatorInsets = insets
        UIView.animate(withDuration: duration ?? 0.0) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

        self.contentInset = UIEdgeInsets.zero
        self.scrollIndicatorInsets = UIEdgeInsets.zero
        UIView.animate(withDuration: duration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    
}

