//
//  PostActionCell.swift
//  PDInstagram
//
//  Created by User on 6/24/21.
//

import UIKit

protocol PostActionCellDelegate: NSObjectProtocol {
    func didTapLikeButton(_ sender: UIButton,  _ cell:  PostActionCell)
}

class PostActionCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let contentHeight:CGFloat = 60
    weak var delegate: PostActionCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func like(_ sender: Any) {
        self.delegate?.didTapLikeButton(sender as! UIButton, self)
    }
}
