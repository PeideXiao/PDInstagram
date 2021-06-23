//
//  User.swift
//  PDInstagram
//
//  Created by User on 6/22/21.
//

import Foundation
import FirebaseDatabase

struct User: Codable {
    let uid: String
    let username: String
    let email: String
    let imageUrl: String?
    
    static var current:User? {
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: Constants.UserDefaults.currentUser)
            UserDefaults.standard.synchronize()
        }
        
        get {
            guard let data = UserDefaults.standard.value(forKey: Constants.UserDefaults.currentUser) as? Data, let user = try? JSONDecoder().decode(User.self, from: data) else { return nil }
            return user
            
        }
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
              let username = dict["name"] as? String,
              let email = dict["email"] as? String
        else { return nil }
        self.uid = snapshot.key
        self.username = username
        self.email = email
        self.imageUrl = dict["image_url"] as? String
    }
}
