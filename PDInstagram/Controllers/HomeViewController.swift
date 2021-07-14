//
//  HomeViewController.swift
//  PDInstagram
//
//  Created by User on 6/24/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    var posts:[Post] = []
    let paginationHelper = PDPaginationHelper<Post>(serviceMethod: UserService.timeline)
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        reloadTimeline()
        review()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.RemoveRefreshHomePageNotificationRegister()
    }
    
    @objc private func retrivePosts() {
        refreshControl.beginRefreshing()
        guard let user = User.current else { return }
        UserService.posts(uid: user.uid) {[unowned self] posts in
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
                self.posts = posts
                postTableView.reloadData()
                
                if posts.count > 0 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        postTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.none, animated: false)
                    }
                }
            }
        }
    }
    
    @objc func retriveTimeline() {
        guard let user = User.current else { return }
        refreshControl.beginRefreshing()
        UserService.timeline1(uid: user.uid) { posts in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.posts = posts
                self.postTableView.reloadData()
                
                if posts.count > 0 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        self.postTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.none, animated: false)
                    }
                }
            }
        }
    }
    
    func reloadTimeline() {
        self.refreshControl.beginRefreshing()
        self.paginationHelper.reloadData(completion: { [unowned self] (posts) in
            self.posts = posts
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.postTableView.reloadData()
        })
    }
    
    private func configureUI() {
        postTableView.separatorStyle = .none
        postTableView.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(retriveTimeline), for: UIControl.Event.valueChanged)
        postTableView.addSubview(self.refreshControl)
    }
    
    private func registerNotification() {
        NotificationCenter.RegisterRefreshHomePageNotification(self, selector: #selector(refresh(notification:)), object: nil)
    }
    
    @objc func refresh(notification: Notification) {
        retriveTimeline()
    }
    
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell:PostHeaderCell = tableView.dequeueResuableCell()
            if let imageUrl = post.poster.iconUrl, let source = URL(string: imageUrl) {
                cell.iconImageView.kf.setImage(with: source)
                cell.nameLabel.text = post.poster.username
                cell.selectionStyle = .none
            }
            return cell
        case 1:
            let cell: PostImageCell = tableView.dequeueResuableCell()
            cell.selectionStyle = .none
            cell.previewImageView.kf.setImage(with: URL(string: post.imageUrl))
            return cell
        default:
            let cell: PostActionCell = tableView.dequeueResuableCell()
            cell.delegate = self
            cell.selectionStyle = .none
            cell.likeButton.isSelected = post.isLiked
            cell.likeLabel.text = "\(post.likeCount) likes"
            cell.dateLabel.text = self.dateFormatter.string(from: post.creationDate)
            cell.dateLabel.font = UIFont(name: "GreatVibes-Regular", size: 13)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.section]
        switch indexPath.row {
        case 0:
            return PostHeaderCell.contentHeight
        case 1:
            return post.imageHeight
        default:
            return PostActionCell.contentHeight
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section >= self.posts.count - 1 {
            paginationHelper.paginate(completion: { [unowned self] (posts) in
                self.posts.append(contentsOf: posts)
                DispatchQueue.main.async {
                    self.postTableView.reloadData()
                }
            })
        }
    }
}


extension HomeViewController: PostActionCellDelegate {
    func didTapLikeButton(_ sender: UIButton, _ cell: PostActionCell) {
        guard let indexPath = self.postTableView.indexPath(for: cell)
        else { return }
        
        sender.isUserInteractionEnabled = false
        let post = posts[indexPath.section]
        
        LikeService.setIsLiked(!post.isLiked, post) { success in
            
            defer {
                sender.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            
            post.likeCount += (post.isLiked) ? -1 : 1
            post.isLiked = !post.isLiked
            
            DispatchQueue.main.async {
                self.postTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            }
        }
    }
}
