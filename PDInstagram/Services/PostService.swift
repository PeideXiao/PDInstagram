//
//  PostService.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase

struct PostService {
    
    static func create(for image: UIImage, completionHandler: @escaping ()-> Void) {
        guard let ref = StorageReference.newPostImageReference() else {
            return
        }
        
        StorageService.uploadImage(image, at: ref) { url in
            guard let imageUrl = url else { return }
            self.create(for: imageUrl.absoluteString, aspectHeight: image.aspectHeight, completionHandler: completionHandler)
        }
    }
    
    static func create(for imageUrl: String, aspectHeight: CGFloat, completionHandler: @escaping ()-> Void) {
        let post = Post(imageUrl: imageUrl, height: aspectHeight)
        guard let user = User.current else { return }
        let newPostRef = DatabaseReference.toLocation(.posts(user.uid)).childByAutoId()
        guard let newPostKey = newPostRef.key else {
            completionHandler()
            return
        }
                
        
        
        UserService.followers(user: user) { followers in
            let timelinePostDict = ["poster_uid": user.uid]
            var updatedData:[String: Any] = ["timeline/\(user.uid)/\(newPostKey)": timelinePostDict]
            
            followers.forEach { follower in
                updatedData["timeline/\(follower)/\(newPostKey)"] = timelinePostDict
            }
            
            let postDict = post.dictValue()
            updatedData["posts/\(user.uid)/\(newPostKey)"] = postDict
            
            DatabaseReference.toLocation(.root).updateChildValues(updatedData) { error, dbRef in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                
                let postCountRef = DatabaseReference.toLocation(.user(user.uid)).child("post_count")
                
                postCountRef.runTransactionBlock { mutableData -> TransactionResult in
                     let currentCount = mutableData.value as? Int ?? 0
                    mutableData.value = currentCount + 1
                    return TransactionResult.success(withValue: mutableData)
                }
                
                completionHandler()
            }
        }
    }
    
    static func post(forKey postKey: String, posterUID: String, completion:@escaping(Post?)->()) {
        let ref = DatabaseReference.toLocation(.showPost(posterUID, postKey))
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let post = Post(snapshot: snapshot) else {
                completion(nil)
                return
            }
            
            LikeService.isLiked(post) { success in
                post.isLiked = success
                completion(post)
            }
        }
    }
}
