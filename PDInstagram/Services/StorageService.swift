//
//  StorageService.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import UIKit
import FirebaseStorage

struct StorageService {
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion:@escaping (URL?)->()) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        reference.putData(imageData, metadata: nil) { metadata, error in
            
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
            reference.downloadURL { url, error in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    completion(nil)
                    return
                }
                completion(url)
            }
        }
    }
}


extension StorageReference {
    
}
