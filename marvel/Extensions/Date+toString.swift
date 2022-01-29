//
//  Date+toString.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import Foundation

extension Date {
    func getDateFor(year: Int) -> Date? {
         return Calendar.current.date(byAdding: .year, value: year, to: Date())
    }
    
    func getFormattedDate() -> String {
        return day + "-" + monthInNumber + "-" + year
    }
    
    var ddMMMMyyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-yyyy"
        return dateFormatter.string(from: self)
    }
    
    var monthUTC: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
        
    var monthInNumber: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return String(components.month ?? 0).dateFormatter()
    }
    
    var monthInNumberUTC: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
        
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var dayUTC: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eeee"
        return dateFormatter.string(from: self)
    }
        
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var yearUTC: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
        
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var hourUTC: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
