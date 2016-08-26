//
//  DateHelper.swift
//  SwiftDatePickerDialog
//
//  Created by Kristijan Kontus on 26/08/2016.
//  Copyright © 2016 kkontus. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getCurrentDate() -> String {
        return getDateForFormat("yyyy-MM-dd")
    }
    
    static func getCurrentDay() -> String {
        return getDateForFormat("dd")
    }
    
    static func getCurrentMonth() -> String {
        return getDateForFormat("MM")
    }
    
    static func getCurrentYear() -> String {
        return getDateForFormat("yyyy")
    }
    
    static func getCurrentYearAndMonth() -> String {
        return getDateForFormat("yyyy-MM")
    }
    
    static func getToday() -> String {
        return getCurrentDate() //just because of more intuitive name when using periods
    }
    
    static func getTomorrow() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getNextDay(calendar, daysAfter: 1)
    }
    
    static func getTomorrow(dateString: String) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        
        return getNextDayForGivenDate(calendar, dateFormatter: dateFormatter, daysAfter: 1, dateString: dateString)
    }
    
    static func getYesterday() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getPreviousDay(calendar, daysBefore: 1)
    }
    
    static func getYesterday(dateString: String) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        
        return getPreviousDayForGivenDate(calendar, dateFormatter: dateFormatter, daysBefore: 1, dateString: dateString)
    }
    
    static func getThisMonth() -> String {
        return getCurrentYearAndMonth() //just because of more intuitive name when using periods
    }
    
    static func getNextMonth() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getNextMonth(calendar, monthsAfter: 1)
    }
    
    static func getNextMonth(dateString: String) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        
        return getNextMonthForGivenDate(calendar, dateFormatter: dateFormatter, monthsAfter: 1, dateString: dateString)
    }
    
    static func getLastMonth() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getPreviousMonth(calendar, monthsBefore: 1)
    }
    
    static func getLast6Month() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getPreviousMonth(calendar, monthsBefore: 5)
    }
    
    static func getLast6MonthList() -> [String] {
        var last6Months = [String]()
        let calendar = NSCalendar.currentCalendar()
        for i in (0...5) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last6Months.append(month)
        }
        return last6Months
    }
    
    static func getLast4Month() -> String {
        let calendar = NSCalendar.currentCalendar()
        return getPreviousMonth(calendar, monthsBefore: 3)
    }
    
    static func getLast4MonthList() -> [String] {
        var last4Months = [String]()
        let calendar = NSCalendar.currentCalendar()
        for i in (0...3) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last4Months.append(month)
        }
        return last4Months
    }
    
    static func getLast4MonthDictionary() -> [(name: String, translated: String)] {
        var last4Months = [(name: String, translated: String)]()
        let calendar = NSCalendar.currentCalendar()
        for i in (0...3) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last4Months.append(name: month, translated: month)
        }
        return last4Months
    }
    
    static func getFirstDateOfCurrentMonth() -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter)
        
        return dateFormatter.stringFromDate(startOfMonth)
    }
    
    static func getLastDateOfCurrentMonth() -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter)
        let endOfMonth = getLastDayOfMonth(calendar, startOfMonth: startOfMonth)
        
        return dateFormatter.stringFromDate(endOfMonth)
    }
    
    static func getFirstDateOfGivenMonth(dateString: String) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter, dateString: dateString)
        
        return dateFormatter.stringFromDate(startOfMonth)
    }
    
    static func getLastDateOfGivenMonth(dateString: String) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter, dateString: dateString)
        let endOfMonth = getLastDayOfMonth(calendar, startOfMonth: startOfMonth)
        
        return dateFormatter.stringFromDate(endOfMonth)
    }
    
    static func getFirstDayOfCurrentMonth() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date)
        
        return String(range.location)
    }
    
    static func getLastDayOfCurrentMonth() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date)
        
        return String(range.length)
    }
    
    static func getFirstDayOfGivenMonth(dateString: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let date = dateFormatter.dateFromString(dateString)
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date!)
        
        return String(range.location)
    }
    
    static func getLastDayOfGivenMonth(dateString: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let date = dateFormatter.dateFromString(dateString)
        let calendar = NSCalendar.currentCalendar()
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date!)
        
        return String(range.length)
    }
    
    static func getNumberOfDaysBetweenDates(dateFrom: String, dateTo: String) -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let startDate = dateFormatter.dateFromString(dateFrom)
        let endDate = dateFormatter.dateFromString(dateTo)
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: startDate!, toDate: endDate!, options: [])
        
        return components.day + 1
    }
    
    static func isValidDateFormat(string: String, dayProvided: Bool) -> Bool {
        var pattern = "^(19|20)\\d\\d-(0[1-9]|1[012])$" // for format "yyyy-MM"
        if dayProvided {
            pattern = "^(19|20)\\d\\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$" // for format "yyyy-MM-dd"
        }
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: 0)) {
            let matched = regex.matchesInString(string, options: [], range: NSMakeRange(0, string.characters.count))
            if matched.count > 0 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    static func getNextDayForGivenDate(calendar: NSCalendar, daysAfter: Int, dateObject: NSDate) -> NSDate {
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: dateObject)
        components.day += daysAfter
        return calendar.dateFromComponents(components)!
    }
    
    static func getDateObjectForGivenDateString(dateString: String) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date!)
        return calendar.dateFromComponents(components)!
    }
    
    static func getDateStringForGivenDateObject(dateObject: NSDate, format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(dateObject)
    }
    
    private static func getDateForFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(NSDate())
    }
    
    private static func getFirstDayOfMonth(calendar: NSCalendar, dateFormatter: NSDateFormatter) -> NSDate {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = NSDate()
        let components = calendar.components([.Year, .Month], fromDate: date)
        return calendar.dateFromComponents(components)!
    }
    
    private static func getFirstDayOfMonth(calendar: NSCalendar, dateFormatter: NSDateFormatter, dateString: String) -> NSDate {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        let components = calendar.components([.Year, .Month], fromDate: date!)
        return calendar.dateFromComponents(components)!
    }
    
    private static func getLastDayOfMonth(calendar: NSCalendar, startOfMonth: NSDate) -> NSDate {
        let components2 = NSDateComponents()
        components2.month = 1
        components2.day = -1
        return calendar.dateByAddingComponents(components2, toDate: startOfMonth, options: [])!
    }
    
    private static func getPreviousDay(calendar: NSCalendar, daysBefore: Int) -> String {
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.day -= daysBefore
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getPreviousDayForGivenDate(calendar: NSCalendar, dateFormatter: NSDateFormatter, daysBefore: Int, dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date!)
        components.day -= daysBefore
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getPreviousMonth(calendar: NSCalendar, monthsBefore: Int) -> String {
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.month -= monthsBefore
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getNextDay(calendar: NSCalendar, daysAfter: Int) -> String {
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.day += daysAfter
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getNextDayForGivenDate(calendar: NSCalendar, dateFormatter: NSDateFormatter, daysAfter: Int, dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date!)
        components.day += daysAfter
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getNextMonth(calendar: NSCalendar, monthsAfter: Int) -> String {
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.month += monthsAfter
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
    private static func getNextMonthForGivenDate(calendar: NSCalendar, dateFormatter: NSDateFormatter, monthsAfter: Int, dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date!)
        components.month += monthsAfter
        let dateInTheMiddleOfPeriod = calendar.dateFromComponents(components)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.stringFromDate(dateInTheMiddleOfPeriod)
    }
    
}
