//
//  UITableView+Utility.swift
//  PDInstagram
//
//  Created by User on 7/7/21.
//

import Foundation
import UIKit

protocol CellIdentifiable {
    static var cellIdentifier:String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self )
    }
}

extension UITableViewCell: CellIdentifiable {}

extension UITableView {
    func dequeueResuableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
           fatalError("Error dequeuing cell for identifier: \(T.cellIdentifier)")
        }
        return cell
    }
}
