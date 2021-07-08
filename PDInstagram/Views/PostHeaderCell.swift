//
//  PostHeaderCell.swift
//  PDInstagram
//
//  Created by User on 6/24/21.
//

import UIKit

class PostHeaderCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreActionButton: UIButton!
    
    static let contentHeight:CGFloat = 54
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2
        iconImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func more(_ sender: Any) {
    }
    

}
