//
//  Date_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/24/20.
//

import Foundation

extension Date {
    var dateTimeStrin: String  {
        var dateString:String = "";
        
        let formatter:DateFormatter = DateFormatter();
        formatter.amSymbol = "AM";
        formatter.pmSymbol = "PM";
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        formatter.timeZone = TimeZone(secondsFromGMT: 0);
        
        dateString = formatter.string(from: self);
        return dateString;
        
    }
    
    // Returns a date representing the start of a passed date
    var startOfDayDateForDate :Date {
        return Calendar.current.startOfDay(for: self);
    }
    
    // Returns a date representing the end of a passed date
    var endOfDayDateForDate :Date {
        if let date:Date = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self) { return date; }
        return Date();
    }
    
    func toString() -> String{
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "MM/dd";
        return formatter.string(from: self);
    }
}
