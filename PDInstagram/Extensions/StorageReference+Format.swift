//
//  StorageReference+Format.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import Foundation
import FirebaseStorage


extension StorageReference {
    
    static func newPostImageReference() -> StorageReference? {
        let dateFormatter = ISO8601DateFormatter()
        guard let user = User.current else { return nil}
        let timestamp = dateFormatter.string(from: Date())
        return Storage.storage().reference().child("images/posts/\(user.uid)/\(timestamp).jpg")
    }
    
}
