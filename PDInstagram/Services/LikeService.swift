//
//  LikeService.swift
//  PDInstagram
//
//  Created by User on 6/27/21.
//

import Foundation
import FirebaseDatabase
struct LikeService {
    
    static func like(post: Post, success: @escaping(Bool)-> Void) {
        guard let user = User.current, let key = post.key else {
            success(false)
            return
        }
        
        let likeRef = DatabaseReference.Locatioin.likes(key, user.uid).databaseReference()
        
        likeRef.setValue(true) { error, dbRef in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
                return
            }
            
            let likeCountRef = DatabaseReference.Locatioin.likeCount(key, post.poster.uid).databaseReference()
            likeCountRef.runTransactionBlock { mutableData in
                let current = mutableData.value  as? Int ?? 0
                mutableData.value = current + 1
                return TransactionResult.success(withValue: mutableData)
            } andCompletionBlock: { error, _, _ in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    success(false)
                } else {
                    success(true)
                }
            }
        }
    }
    
    static func dislike(_ post: Post, success: @escaping(Bool)->Void) {
        
        guard let user = User.current, let key = post.key else {
            success(false)
            return
        }
        
        let likeRef = DatabaseReference.Locatioin.likes(key, user.uid).databaseReference()
        
        likeRef.removeValue { error, dbRef in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
                return
            }
            
            let likeCountRef = DatabaseReference.Locatioin.likeCount(key, post.poster.uid).databaseReference()
            likeCountRef.runTransactionBlock { mutableData in
                let current = mutableData.value as? Int ?? 0
                mutableData.value = current - 1
                return TransactionResult.success(withValue: mutableData)
                
            } andCompletionBlock: { error, _, _ in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    success(false)
                } else {
                    success(true)
                }
            }
        }
    }
    
    static func isLiked(_ post: Post, completioin: @escaping(Bool)-> Void) {
        guard let user = User.current, let key = post.key else {
            completioin(false)
            return
        }
        
        let likeRef = DatabaseReference.Locatioin.isLike(key).databaseReference()
        
        likeRef.queryEqual(toValue: nil, childKey: user.uid).observeSingleEvent(of: DataEventType.value) { snapshot in
            if let _ = snapshot.value as? [String: Bool] {
                completioin(true)
            } else  {
                completioin(false)
            }
        }
    }
    
    static func setIsLiked(_ isLiked: Bool, _ post: Post, _ completion: @escaping(Bool)-> Void) {
        if isLiked {
            like(post: post, success: completion)
        } else {
            dislike(post , success: completion)
        }
    }
}
