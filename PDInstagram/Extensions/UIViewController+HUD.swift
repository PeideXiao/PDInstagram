//
//  UIViewController+HUD.swift
//  PDInstagram
//
//  Created by User on 7/12/21.
//

import Foundation
import MBProgressHUD
import UIKit

protocol MBProgressHUDable {
    func showNetworkIndicator(with title: String?, and message: String?) -> MBProgressHUD
    func hide(hud: MBProgressHUD)
    func showToastHint(text: String)
}

extension MBProgressHUDable where Self: UIViewController {
    
    func showNetworkIndicator(with title: String?, and message: String?) -> MBProgressHUD {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.detailsLabel.text = message
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
        return indicator
    }
    
    func hide(hud: MBProgressHUD) {
        hud.hide(animated: true)
    }
    
    func showToastHint(text: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.mode = .text
        indicator.label.text = text
        indicator.show(animated: true)
        indicator.hide(animated: true, afterDelay: 2.0)
    }
}


extension UIViewController: MBProgressHUDable {}
