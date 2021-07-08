//
//  DatabaseReference+Location.swift
//  PDInstagram
//
//  Created by User on 7/2/21.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    
    enum Locatioin {
        
        case root
        
        case users
        case user(String)
        
        case posts(String)
        case showPost(String, String)
        
        case isLike(String)
        case likes(String, String)
        case likeCount(String, String)
        
        case followers(String)
        case timeline(String)
        
        func databaseReference() -> DatabaseReference {
            
            let root = Database.database().reference()
            switch self {
            case .root:
                return root
                
            case .users:
                return root.child("users")
                
            case .user(let uid):
                return root.child("users").child(uid)
                
            case .posts(let uid):
                return root.child("posts").child(uid)
                
            case .showPost(let uid, let postKey):
                return  root.child("posts").child(uid).child(postKey)
                
            case .isLike(let postKey):
                return root.child("postLikes").child(postKey)
                
            case .likes(let postKey, let uid):
                return root.child("postLikes").child(postKey).child(uid)
                
            case .likeCount(let postKey, let uid):
                return root.child("posts").child(uid).child(postKey).child("likeCount")
                
            case .followers(let uid):
                return root.child("followers").child(uid)
                
                
            case .timeline(let uid):
                return root.child("timeline").child(uid)
                
            default:
                return root
            }
        }
        
    }
    
    static func toLocation(_ location: Locatioin)-> DatabaseReference {
        return location.databaseReference()
    }
    
}
