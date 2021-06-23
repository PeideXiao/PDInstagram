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
                          "image_url":"https://static01.nyt.com/images/2021/06/30/magazine/30mag-nets6/30mag-nets6-superJumbo.jpg"]
        UserService.writeToDatabase(firUser: user, parameters: parameters as [String : Any]) { user in
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
