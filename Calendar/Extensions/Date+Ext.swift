//
//  Date+Ext.swift
//  Calendar
//
//  Created by Hansa Anuradha on 2023-02-03.
//

import Foundation

extension Date {
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.end
    }
    
    var endOfDay: Date {
        Calendar.current.dateInterval(of: .day, for: self)!.end
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        let endDateAdjusment = Calendar.current.date(byAdding: .day, value: -1, to: self.endOfMonth)!
        return Calendar.current.component(.day, from: endDateAdjusment)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var monthFullName: String {
        self.formatted(.dateTime.month(.wide))
    }
}
