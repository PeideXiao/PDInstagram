//
//  Post.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import UIKit
import Firebase

class Post: NSObject, PDKeyed {
    var key: String? = nil
    let imageUrl: String
    let imageHeight: CGFloat
    let creationDate: Date
    var likeCount: Int
    let poster: User
    var isLiked: Bool = false
    
    init(imageUrl: String, height: CGFloat) {
        self.imageUrl = imageUrl
        self.imageHeight = height
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current!
    }
    
    func dictValue() -> [String: Any] {
        
        guard let user = User.current
        else { return [:] }
        
        let poster = ["uid": user.uid,
                        "username": user.username,
                        "icon_url": user.iconUrl]
        
        return ["imageUrl": imageUrl,
                "height":imageHeight,
                "createOn":creationDate.timeIntervalSince1970,
                "likeCount": likeCount,
                "poster": poster,
                "isLiked": isLiked
                ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
        let imageUrl = value["imageUrl"] as? String,
        let imageHeight = value["height"] as? CGFloat,
        let createOnInterval = value["createOn"] as? TimeInterval,
        let likeCount = value["likeCount"] as? Int,
        let poster = value["poster"] as? [String: Any],
        let uid = poster["uid"] as? String,
        let username = poster["username"] as? String
        else { return nil }
        
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createOnInterval)
        self.key = snapshot.key
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username, iconUrl: poster["icon_url"] as? String)
    }
}
