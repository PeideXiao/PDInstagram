//
//  ProfileViewController.swift
//  PDInstagram
//
//  Created by User on 6/28/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func findFriends(_ sender: Any) {
        
    }
    
    @IBAction func logout(_ sender: Any) {
        User.current = nil
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate else { return }
        sceneDelegate.configureInitialRootViewController()
    }
}
