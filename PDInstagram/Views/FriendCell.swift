//
//  FriendCell.swift
//  PDInstagram
//
//  Created by User on 6/30/21.
//

import UIKit

protocol FriendCellDelegate: NSObjectProtocol {
    func didSelectFollowButton(_ sender: UIButton, _ cell: FriendCell)
}

class FriendCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    
    static let height: CGFloat = 60.0
    weak var delegate: FriendCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.cornerRadius(value: iconImageView.bounds.width/2.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func followButtonDidClick(_ sender: Any) {
        self.delegate?.didSelectFollowButton(sender as! UIButton, self)
    }
}
