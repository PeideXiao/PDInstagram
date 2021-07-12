//
//  BaseTabBarController.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/22/20.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.tabBar.barTintColor = UIColor.black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.AvenirNext(weight: .Regular, 11)], for: UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.AvenirNext(weight: .Medium, 11)], for: UIControl.State.selected)
    }

}
