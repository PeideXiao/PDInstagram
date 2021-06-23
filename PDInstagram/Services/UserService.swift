//
//  UserService.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import FirebaseDatabase

struct UserService {
    
    static func userDatabaseReference(firUser: FIRUser)-> DatabaseReference {
        let dbRef = Database.database().reference()
        return dbRef.child("users").child(firUser.uid)
    }
    
    static func readDatabase(firUser: FIRUser, completion: @escaping(User?)->()) {
        let userRef = userDatabaseReference(firUser: firUser)
        userRef.observe(.value) { snapshot in
            completion(User(snapshot: snapshot))
        } withCancel: { error in
            assertionFailure(error.localizedDescription)
            completion(nil)
        }
    }
    
    static func writeToDatabase(firUser: FIRUser, parameters:[String:Any], completion: @escaping(User?)->()) {
        let userRef = userDatabaseReference(firUser: firUser)
        userRef.setValue(parameters) { error, _ in
            if let error = error {
                assertionFailure(error.localizedDescription)
                completion(nil)
            }
            
            readDatabase(firUser: firUser) { user in
                completion(user)
            }
        }
    }
}
