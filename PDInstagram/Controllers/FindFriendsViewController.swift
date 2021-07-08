//
//  FindFriendsViewController.swift
//  PDInstagram
//
//  Created by User on 6/28/21.
//

import UIKit

class FindFriendsViewController: UIViewController {
    
    @IBOutlet var friendsTableView: UITableView!
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        retriveFriends()
    }
    
    private func retriveFriends() {
        UserService.usersExcludingCurrentUser { users in
            self.users = users
            self.friendsTableView.reloadData()
        }
    }
    
    private func configureUI() {
        self.friendsTableView.tableFooterView = UIView()
    }
}

extension FindFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.friendCell) as! FriendCell
        cell.delegate = self
        let user = users[indexPath.row]
        if let str = user.iconUrl, let url = URL(string: str) {
            cell.iconImageView.kf.setImage(with: url)
        }
        cell.nameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FriendCell.height
    }
}


extension FindFriendsViewController: FriendCellDelegate {
    func didSelectFollowButton(_ sender: UIButton, _ cell: FriendCell) {
        guard let indexPath = friendsTableView.indexPath(for: cell) else { return }
        let user = users[indexPath.row]
        
        FollowService.setFollow(!user.isFollowed, user) { success in
            guard success else { return }
            user.isFollowed = !user.isFollowed
            DispatchQueue.main.async {
                self.friendsTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            }
        }
    }
}
