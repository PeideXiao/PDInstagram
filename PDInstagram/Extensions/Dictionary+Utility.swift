//
//  Dictionary+Utility.swift
//  PDInstagram
//
//  Created by User on 7/12/21.
//

import Foundation

extension Dictionary {
    
    /*
        Updates the value stored in the dictionary for the given key, or adds a new key-value pair if the key does not exist.
     */
    
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k);
        }
    }
}
