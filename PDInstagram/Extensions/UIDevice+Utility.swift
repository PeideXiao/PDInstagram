//
//  UIDevice_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/24/20.
//

import Foundation
import UIKit

extension UIDevice {
    
    class func appVersion() -> String {
        if let currentVersion:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String { return currentVersion; }
        else { return "???"; }
    }
    
    class func deviceLanguage() -> String {
        let languageCode:String? = Locale.current.languageCode;
        let scriptCode:String? = Locale.current.scriptCode;
        let regionCode:String? = Locale.current.regionCode;
        
        var cultureName:String = ((languageCode != nil) ? languageCode! : "") + "-" + ((scriptCode != nil) ? scriptCode! + "-" : "") + ((regionCode != nil) ? regionCode! : "");
        if (cultureName.last == "-") { cultureName = String(cultureName.dropLast()); }
        return cultureName;
    }
    
    class func deviceCountry() -> String {
        if let country:String = Locale.current.regionCode { return country; }
        return "US";
    }
    
    class func deviceID() -> String {
        let deviceID:String? = UIDevice.current.identifierForVendor?.uuidString;
        //print("Device ID: \(String(describing: deviceID))");
        if (deviceID == nil) { return ""; }
        else { return deviceID!; }
    }
}
