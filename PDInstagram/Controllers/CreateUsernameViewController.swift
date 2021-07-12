//
//  CreateUsernameViewController.swift
//  PDInstagram
//
//  Created by User on 6/22/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func next(_ sender: Any) {
        guard let user = Auth.auth().currentUser, let nickname = self.usernameTF.text, !nickname.isEmpty else {
            return
        }
        let parameters:[String: Any] = ["name": nickname,
                                        "email": user.email ?? "test@gmail.com",
                                        "icon_url":user.photoURL?.absoluteString ?? "",
                                        "post_count": 0,
                                        "follower_count": 0,
                                        "following_count":0 ]
        
        UserService.saveUser(uid: user.uid, parameters: parameters as [String : Any]) { user in
            guard let current = user else {
                return
            }
            
            User.current = current
            self.proceedToHomePage()
        }
    }
    
    func proceedToHomePage() {
        if let tabVC = UIStoryboard(type: .main).instantiateInitialViewController() as? UITabBarController {
            self.view.window?.rootViewController = tabVC
        }
    }
}
