//
//  MainTabBarController.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    let photoHelper = PhotoHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        delegate = self
        tabBar.unselectedItemTintColor = UIColor.black
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == Constants.TabBar.ADD {
            photoHelper.presentActionSheet(from: self)
            photoHelper.completionHandler = {image in
                
                // Upload
                PostService.create(for: image) {
                    NotificationCenter.RefreshHomePageNotification()
                }
            }
            return false
        }
        return true
    }
}
