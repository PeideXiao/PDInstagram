//
//  ProfileHeaderView.swift
//  PDInstagram
//
//  Created by User on 7/9/21.
//

import UIKit
import Foundation

protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapSettingButton(sender: UIButton, reusableView: UICollectionReusableView)
}


class ProfileHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    weak var delegate: ProfileHeaderViewDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingButton.cornerRadius(value: 4.0)
    }
    
    
    @IBAction func setting(_ sender: Any) {
        self.delegate?.didTapSettingButton(sender: sender as! UIButton, reusableView: self)
    }
    
}
