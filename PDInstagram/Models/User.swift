//
//  User.swift
//  PDInstagram
//
//  Created by User on 6/22/21.
//

import Foundation
import FirebaseDatabase

class User: Codable {
    let uid: String
    let username: String
    let email: String
    let iconUrl: String?
    var isFollowed: Bool = false
    
    static var current:User? {
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return}
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
        self.iconUrl = dict["icon_url"] as? String
    }
    
    
    init(uid: String, username: String, iconUrl: String?) {
        self.uid = uid
        self.username = username
        self.email = ""
        self.iconUrl = iconUrl
    }
}
