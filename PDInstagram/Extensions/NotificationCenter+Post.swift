//
//  NotificationCenter+Post.swift
//  PDInstagram
//
//  Created by User on 7/1/21.
//

import Foundation

extension NotificationCenter {
    static func RefreshHomePageNotification() {
        self.default.post(name: Notification.Name.init(rawValue: Constants.Notification.RefreshHomePage), object: nil, userInfo: nil)
    }
    
    static func RegisterRefreshHomePageNotification(_ observer: Any, selector aSelector: Selector, object anObject: Any?) {
        self.default.addObserver(observer, selector: aSelector, name: Notification.Name.init(Constants.Notification.RefreshHomePage), object: anObject)
    }
    
    static func RemoveRefreshHomePageNotificationRegister() {
        self.default.removeObserver(self, name: NSNotification.Name(Constants.Notification.RefreshHomePage), object: nil)
    }
}
