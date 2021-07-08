//
//  Constants.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation

struct Constants {
    
    struct Segue {
        static let toCreateUsername = "createusername"
    }
    
    struct UserDefaults {
        static let currentUser = "currentuser"
    }
    
    struct Notification {
        static let UpdateRootViewController = "update_root_view_controller"
        static let RefreshHomePage = "refresh_home_view_controller"
    }
    
    struct TabBar {
        static let ADD = "Add"
        static let HOME = "Home"
        static let PROFILE = "Profile"
    }
    
    struct CellIdentifier {
        static let postImageCell = "postimagecell"
        static let postHeaderCell = "postheadercell"
        static let postActionCell = "postactioncell"
        static let friendCell = "friendcell"
    }
}
