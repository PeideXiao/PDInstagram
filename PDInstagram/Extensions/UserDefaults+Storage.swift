//
//  UserDefault+Storage.swift
//  PDInstagram
//
//  Created by User on 7/12/21.
//

import Foundation
import UIKit

extension UserDefaults {
    
    static func save<T: Codable>(_ value:T, with key: String) {
         if let data = try? JSONEncoder().encode(value) {
             standard.setValue(data, forKey: key)
         }
     }
     
    static func value<T: Codable>(for key: String) -> T? {
         if let data = standard.value(forKey: key) as? Data,
            let result = try? JSONDecoder().decode(T.self, from: data) {
             return result
         }
         return nil
     }
}
