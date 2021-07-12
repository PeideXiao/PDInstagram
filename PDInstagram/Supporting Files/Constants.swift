//
//  Constants.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import UIKit

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
    
    struct Screen {
        static let WIDTH = UIScreen.main.bounds.width
        static let HEIGHT = UIScreen.main.bounds.height
    }
}

// MARK:- VoiceTube

extension Constants {
    static let EncryptionKey:String = "MyD0mingOL4dy-9902aF5y-F0r2D4ys4ndSom3Minutes-jEr8y2u66q-9O0fTh3m";
    static let AuthorizationKey:String =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiYmUxNTkwNThmNmU2OTRmNDQ0OGFjNjIxNDc4ODE5ZGFmZjIxNTA4YmFkNTkxNmJlYWIzZGU4OWYwMTIwZjY3Y2Q2OGMwNDhhYmE0YzI3YzgiLCJpYXQiOjE2MDEzMTY4MTQsIm5iZiI6MTYwMTMxNjgxNCwiZXhwIjoxNjMyODUyODE0LCJzdWIiOiI0MTIyMDAyIiwic2NvcGVzIjpbXX0.GgGaW541QdmxT8Ar5tFGmA6OHCao0Jq30F6veEApbzZjLiEa3GmoZ0cy0A7CwPA_nhISF9mK7pQetQNjShODdL5OT2oh19qZSUFyVJugUo_MpFO-K0hD97vptDnyrjzKGmeUNiL-1zP3wSRGoPXwZmo37PWtfoJBZMoNZhhK9vxsyEYAo45KsndhQCQ0_0c1lM1lMoQCcPZnlxLbsnB60Ux47CLl9snDfRwJXbllu_JUc5dxi0hUhiq78mt_6KIXMV1AlHz7N5aaHLVUHOgXifZ63LtOd8GzQmbJ3iaC_lFOWz7g5uz-BxXuyGdjwrxxhGE9L18pcDjPDVcCyWXDZfT7sxIPxlzowkDEhgJoMxxyQ8krBjWp3FfpiSwwvWd9ttXh9TbfURwX84kFDW2dOU8zNoAEX9W_oWr-696gDrby-KUMkn_dvbbEvY7llOjMfzIdtHOR_WqW9Z5NBPlYmR1XThwmkZOSZn84dDeN2N_noFP4X6tz74LNwLIzAY0mcP44rZGBM6AQ7kYxlyo3JL2JgSiQfiEaF765BVDZufd5oFMeF4thV7OD4N80Pz2oUU4USNZbXN6KqA9oQkTKHeljAbf_XTXByjTiaWLs9JQQ372rn_DMBfYzKMOMULdz3v4lIVLWB8oTe1f-N1nj9btvJLmevf58tKM1w9Pc30M";

    static let USER_ID = "4122002";
}
