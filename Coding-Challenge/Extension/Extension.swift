//
//  Extension.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 26/11/2024.
//

import UIKit


extension UIImageView {
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.7
        self.layer.masksToBounds = true
    }
}
