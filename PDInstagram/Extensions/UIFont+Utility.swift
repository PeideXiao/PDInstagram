//
//  UIFont+Utility.swift
//  PDInstagram
//
//  Created by User on 7/8/21.
//

import Foundation
import UIKit

enum FontWeightStyle: String {
    case Regular = "Regular"
    case Medium = "Medium"
    case Bold = "Bold"
}

extension UIFont {
    static func printFontName() {
        for family: String in UIFont.familyNames {
            print(family)
//            GreatVibes-Regular
            
            for fontName: String in UIFont.fontNames(forFamilyName: family) {
                print("\(fontName)\r\n")
            }
        }
    }
    
    static var myRegular: UIFont {
        return UIFont(name: "GreatVibes-Regular", size: 13)!
    }
    
    
    static func AvenirNext(weight style:FontWeightStyle, _ size: CGFloat)-> UIFont {
        return UIFont(name: "AvenirNext-\(style.rawValue)", size: size)!
    }
}
