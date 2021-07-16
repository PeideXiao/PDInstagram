//
//  ProfileView.swift
//  BarDemo0714
//
//  Created by User on 7/15/21.
//

import UIKit

class ProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let contentView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView else {
            return
        }
        contentView.frame = frame
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
