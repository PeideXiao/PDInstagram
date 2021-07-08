//
//  UIImage+Size.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import UIKit


extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = self.size.height / UIScreen.main.bounds.height
        let widthRatio = self.size.width / UIScreen.main.bounds.width
        let ratio = fmax(heightRatio, widthRatio)
        return self.size.height / ratio
    }
}
