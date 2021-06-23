//
//  UIStoryboard+Utility.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    enum SBType:String {
        case main
        case login
        
        var filename:String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: SBType, bundle: Bundle? = Bundle.main) {
        self.init(name: type.filename, bundle: bundle)
    }
    
}
