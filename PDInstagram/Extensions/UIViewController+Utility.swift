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

extension UIViewController {
    
    struct Screen {
        static let Height = UIScreen.main.bounds.height
        static let Width = UIScreen.main.bounds.width
    }

    /* statusBarHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top
     iPhone11: 48
     iPhone12/12 pro/12 pro max: 47
     iPhone12 mini: 44 but navigation bar starts with 50, this seems to be bug for Apple.
     Other iPhones: 44.
     */
    
    var statusBarHeight: CGFloat {
         if #available(iOS 13.0, *) {
             return UIApplication.shared.windows.first{ $0.isKeyWindow }?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
         } else {
             return UIApplication.shared.statusBarFrame.height
         }
     }
    
    // 44.0
    var naviBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0
    }
    
    var topBarHeight: CGFloat {
        return statusBarHeight + naviBarHeight
    }
    
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
}
