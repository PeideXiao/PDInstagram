//
//  LoginViewController.swift
//  PDInstagram
//
//  Created by User on 6/21/21.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

typealias FIRUser = FirebaseAuth.User
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI() else {
            return
        }
        authUI.delegate = self
        let providers:[FUIAuthProvider] = [FUIEmailAuth(),FUIGoogleAuth(scopes: [kGoogleUserInfoEmailScope]), FUIPhoneAuth(authUI: authUI)]
        authUI.providers = providers
        let vc = authUI.authViewController()
        self.present(vc, animated: true, completion: nil)
        
    }
    
    fileprivate func updateRootViewController() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.configureInitialRootViewController()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let result = authDataResult else { return }
        
        if let currentUser = Auth.auth().currentUser {
            UserService.user(uid: currentUser.uid) { user in
                guard let current = user else {
                    print("New user")
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: nil)
                    return
                }
                print("user exists \(current.username)")
                User.current = current
                self.updateRootViewController()
            }
        }
        
        
        print(result.user.displayName ?? "nil")
    }
}
