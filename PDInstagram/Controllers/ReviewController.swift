//
//  ReviewController.swift
//  PDInstagram
//
//  Created by User on 7/13/21.
//

import Foundation
import UIKit

class ReviewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        review()
    }
    
    // Review
    func review() {
        let p1 = Person(name: "Peter", age: 20)
        let p2 = Person(name: "Peter", age: 30)
        print(p1 == p2) //true
    }
}


class Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String?
    var age: Int?
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
