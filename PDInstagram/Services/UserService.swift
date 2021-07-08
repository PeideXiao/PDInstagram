//
//  UserService.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import FirebaseDatabase

struct UserService {
    
    static func user(uid: String, completion: @escaping(User?)->()) {
        let userRef = DatabaseReference.Locatioin.user(uid).databaseReference()
        userRef.observe(.value) { snapshot in
            completion(User(snapshot: snapshot))
        } withCancel: { error in
            assertionFailure(error.localizedDescription)
            completion(nil)
        }
    }
    
    static func saveUser(uid: String, parameters:[String:Any], completion: @escaping(User?)->()) {
        let userRef = DatabaseReference.Locatioin.user(uid).databaseReference()
        userRef.setValue(parameters) { error, _ in
            if let error = error {
                assertionFailure(error.localizedDescription)
                completion(nil)
            }
            
            user(uid: uid) { user in
                completion(user)
            }
        }
    }
    
    // MARK:- Note the difference between when post is a struct and a class
    
    static func posts(uid: String, completion:@escaping ([Post])->Void) {
        let ref = DatabaseReference.Locatioin.posts(uid).databaseReference()
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let snaps = snapshot.children.allObjects as? [DataSnapshot] else {
                assertionFailure("snaps is null")
                return completion([])
            }
            
            let group = DispatchGroup()
            
            let posts:[Post] = snaps.reversed().compactMap({
                guard let post = Post(snapshot: $0) else { return nil }
                
                group.enter()
                LikeService.isLiked(post) { isLiked in
                    post.isLiked = isLiked
                    group.leave()
                }
                return post
            })
            
            group.notify(queue: .main) {
                completion(posts)
            }
            
        } withCancel: { error in
            assertionFailure(error.localizedDescription)
            completion([])
        }  
    }
    
    static func usersExcludingCurrentUser(_ completion:@escaping ([User]) -> Void) {
        let ref = DatabaseReference.Locatioin.users.databaseReference()
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                completion([])
                return
            }
            
            let users = snapshots.compactMap{ User(snapshot: $0) }.filter{ $0.uid != User.current?.uid }
            
            let group = DispatchGroup()
            
            users.forEach { user in
                group.enter()
                FollowService.isFollowed(user) { isFollowed in
                    user.isFollowed = isFollowed
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                completion(users)
            }
        }
    }
    
    static func followers(user: User, _ completion: @escaping([String])-> Void) {
        let dbRef = DatabaseReference.Locatioin.followers(user.uid).databaseReference()
        dbRef.observeSingleEvent(of: .value) { snapshot in
            guard let snapshot = snapshot.value as? [String: Bool] else {
                completion([])
                return
            }
            completion(Array(snapshot.keys))
        }
    }
    
    // deprecated
    static func timeline1(uid: String, completion:@escaping ([Post])->()) {
        let userRef = DatabaseReference.Locatioin.timeline(uid).databaseReference()
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let snaps = snapshot.children.allObjects as? [DataSnapshot] else{
                completion([])
                return
            }
            
            var posts:[Post] = []
            let group = DispatchGroup()
            for snap in snaps {
                guard let postValue = snap.value as? [String: Any], let posterUID = postValue["poster_uid"] as? String else {
                    completion([])
                    return
                }
                group.enter()
                PostService.post(forKey: snap.key, posterUID: posterUID) { post in
                    if let post = post {
                        posts.append(post)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                completion(posts.reversed())
            }
        }
    }
    
    static func timeline(pageSize: UInt, lastPostKey: String?, completion: @escaping([Post])->Void) {
        
        guard let user = User.current else {
            completion([])
            return
        }
        
        let timelineRef = DatabaseReference.toLocation(.timeline(user.uid))
        var query = timelineRef.queryOrderedByKey().queryLimited(toLast: pageSize)
        
        if let lastPostKey = lastPostKey {
            query = query.queryEnding(atValue: lastPostKey)
        }
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let snaps = snapshot.children.allObjects as? [DataSnapshot] else{
                completion([])
                return
            }
            
            var posts:[Post] = []
            let group = DispatchGroup()
            for snap in snaps {
                guard let postValue = snap.value as? [String: Any], let posterUID = postValue["poster_uid"] as? String else {
                    completion([])
                    return
                }
                group.enter()
                PostService.post(forKey: snap.key, posterUID: posterUID) { post in
                    if let post = post {
                        posts.append(post)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                completion(posts.reversed())
            }
        }
    }
}
