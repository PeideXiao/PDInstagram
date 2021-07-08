//
//  FollowService.swift
//  PDInstagram
//
//  Created by User on 6/28/21.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    
    static func follow(_ user: User, forCurrentUserWithSuccess success:@escaping(Bool)->()) {
        guard let currentUser = User.current else {
            success(false)
            return
        }
        
        let followData = ["followers/\(user.uid)/\(currentUser.uid)" : true,
                          "following/\(currentUser.uid)/\(user.uid)": true]
        
        let dbRef = Database.database().reference()
        dbRef.updateChildValues(followData) { error, ref in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
                return
            }
            
            var updatedData: [String: Any] = [:]
            UserService.posts(uid: user.uid) { posts in
                posts.forEach { post in
                    updatedData["timeline/\(currentUser.uid)/\(post.key!)"] = ["poster_uid":user.uid]
                }
                
                dbRef.updateChildValues(updatedData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }
                    NotificationCenter.RefreshHomePageNotification()
                    success(error == nil)
                })
            }
        }
    }
    
    static func unfollow(_ user: User, forCurrentUserWithSuccess success:@escaping(Bool)->()) {
        guard let currentUser = User.current else {
            success(false)
            return
        }
        
        // Use NSNull() object instead of nil because updateChildValues expects type [Hashable : Any]
        let followData = ["followers/\(user.uid)/\(currentUser.uid)" : NSNull(),
                          "following/\(currentUser.uid)/\(user.uid)": NSNull()]
        
        let dbRef = Database.database().reference()
        dbRef.updateChildValues(followData) { error, ref in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
                return
            }
            var updatedData: [String: Any] = [:]
            UserService.posts(uid: user.uid) { posts in
                posts.forEach { post in
                    updatedData["timeline/\(currentUser.uid)/\(post.key!)"] = NSNull()
                }
                
                dbRef.updateChildValues(updatedData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }
                    NotificationCenter.RefreshHomePageNotification()
                    success(error == nil)
                })
            }
        }
    }
    
    static func setFollow(_ follow: Bool, _ user: User, forCurrentUserWithSuccess success:@escaping(Bool)->()) {
        if follow {
            self.follow(user, forCurrentUserWithSuccess: success)
        } else {
            self.unfollow(user, forCurrentUserWithSuccess: success)
        }
    }
    
    static func isFollowed(_ user: User, completion: @escaping(Bool)->()) {
        guard let currentUser = User.current else {
            completion(false)
            return
        }
        let followRef = DatabaseReference.Locatioin.followers(user.uid).databaseReference()
        
        followRef.queryEqual(toValue: nil, childKey: currentUser.uid).observeSingleEvent(of: DataEventType.value) { snapshot in
            guard let _ = snapshot.value as? [String: Bool] else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
