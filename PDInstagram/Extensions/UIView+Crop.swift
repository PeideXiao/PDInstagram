//
//  UIView+Crop.swift
//  PDInstagram
//
//  Created by User on 6/30/21.
//

import Foundation
import UIKit

extension UIView {
     func cornerRadius(value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
}
