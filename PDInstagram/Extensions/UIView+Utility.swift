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
    
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0);
        drawHierarchy(in: bounds, afterScreenUpdates: true);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
}
