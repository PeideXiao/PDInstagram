//
//  String_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/23/20.
//

import Foundation
import RNCryptor

extension String {
    
    var containsOnlyDigits: Bool {
        let notDigets = NSCharacterSet.decimalDigits.inverted;
        return rangeOfCharacter(from: notDigets, options: String.CompareOptions.literal, range: nil) == nil;
    }
    
    var containsOnlyLetters: Bool {
        let notLetters = NSCharacterSet.letters.inverted;
        return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil;
    }
    
    var isAlphanumeric: Bool {
        let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
        return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    
    func matches(_ expression: String) -> Bool {
        if let range = range(of: expression, options: .regularExpression, range: nil, locale: nil) {
            return range.lowerBound == startIndex && range.upperBound == endIndex
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
        //matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
}

extension String {
    // encrypt
    func encrypt() -> Data? {
        guard let data = self.data(using: .utf8) else {
            print("Encryption - Value data could not be formed")
            return nil;
        }
        let cipherData:Data = RNCryptor.encrypt(data: data, withPassword: Constants.EncryptionKey);
        return cipherData;
    }
    
    // decrypt
    
    func decrpte(data: Data) -> String? {
        
        do {
            let data:Data = try RNCryptor.decrypt(data: data, withPassword: Constants.EncryptionKey)
            let decryptedString = String(data: data, encoding: .utf8)
            return decryptedString
            
        } catch{
            print("Encryption - Decryption error:\n\(error)")
        }
        return nil
    }
}


// Date

extension String {
    
    var formattedDate: Date? {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        
        // Attempt to Parse Date
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        if let date = dateFormatter.date(from: self) { return date; }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        if let date = dateFormatter.date(from: self) { return date; }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ";
        if let date = dateFormatter.date(from: self) { return date; }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        if let date = dateFormatter.date(from: self) { return date; }
        dateFormatter.dateFormat = "MM/dd/yyyy";
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent;
        if let date = dateFormatter.date(from: self) { return date; }
        dateFormatter.dateFormat = "M/d/yy";
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent;
        if let date = dateFormatter.date(from: self) { return date; }
        
        return Date();
    }
    
//    timeTramp
    
    
}


extension String {
        func splitToDictionary()->[String: String]? {
        var temp = [String : String]()
        for subString in  self.split(separator: "&") {
            guard let key = subString.split(separator: "=").first,  let value = subString.split(separator: "=").last else { return nil }
            temp[String(key)] = String(value)
        }
        return temp;
    }
}


extension String {
    func splitTo(with charactor: Character)-> [Substring] {
        let temp = self.prefix(self.count - 1); // get rid of '.'
        let subStrings = temp.split(separator: " ")
        return subStrings
    }
}


extension MutableCollection {
  /// Shuffles the contents of this collection.
  mutating func shuffle() {
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d = Int(arc4random_uniform(numericCast(unshuffledCount)))
      let i = index(firstUnshuffled, offsetBy: d)
      swapAt(firstUnshuffled, i)
    }
  }
}

extension Sequence {
  /// Returns an array with the contents of this sequence, shuffled.
  func shuffled() -> [Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
}

extension String {
  func garbled() -> String {
    return String(shuffled())
  }
}
