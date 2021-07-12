//
//  ProfileViewController.swift
//  PDInstagram
//
//  Created by User on 6/28/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    var posts:[Post] = []
    var dbRef: DatabaseReference?
    var dbRefHandle: UInt = 0
    var user: User?
    var authHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveProfileInfo()
        
        authHandle = Auth.auth().addStateDidChangeListener({ _, user in
            guard user == nil else { return }
            User.current = nil
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate else { return }
            sceneDelegate.configureInitialRootViewController()
        })
        // Do any additional setup after loading the view.
    }
    
    deinit {
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
        self.dbRef?.removeObserver(withHandle: dbRefHandle)
    }
    
    @IBAction func findFriends(_ sender: Any) {
        
    }
    
    
    func retriveProfileInfo() {
        guard let current = User.current else { return }
        UserService.observeProfile(current) { [unowned self] dbRef, user, posts in
            self.dbRef = dbRef
            self.posts = posts
            self.user = user
            
            DispatchQueue.main.async {
                self.profileCollectionView.reloadData()
            }
        }
    }
    
    private func itemSize() -> CGSize {
        let margin: CGFloat = 10.0
        let spacing: CGFloat = 8.0
        let column: CGFloat = 3.0
        
        
        let width = (Constants.Screen.WIDTH - margin * 2 - (column - 1) * spacing) / column
        return CGSize(width: width, height: width)
    }
}


extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeaderView", for: indexPath) as! ProfileHeaderView
        
        guard let user = self.user else { return headerView }
        
        headerView.postCountLabel.text = "\(user.postCount)"
        headerView.postCount.text = "Posts"
        
        headerView.followerCountLabel.text = "\(user.followerCount)"
        headerView.followerCount.text = "Followers"
        
        headerView.followingCountLabel.text = "\(user.followingCount)"
        headerView.followingCount.text = "Followings"
        
        headerView.delegate = self
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.item]
        
        guard let url = URL(string: post.imageUrl) else { return cell }
        cell.postImageView.kf.setImage(with: url)
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
    
}

extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}


extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapSettingButton(sender: UIButton, reusableView: UICollectionReusableView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .default) { _ in
            
            do {
                try Auth.auth().signOut()
            } catch {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
        }
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
