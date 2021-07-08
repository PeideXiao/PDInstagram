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
        let parameters = ["name": nickname,
                          "email": user.email,
                          "icon_url":user.photoURL?.absoluteString]
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
