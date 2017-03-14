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
        let calendar = Calendar.current
        return getNextDay(calendar, daysAfter: 1)
    }
    
    static func getTomorrow(_ dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        return getNextDayForGivenDate(calendar, dateFormatter: dateFormatter, daysAfter: 1, dateString: dateString)
    }
    
    static func getYesterday() -> String {
        let calendar = Calendar.current
        return getPreviousDay(calendar, daysBefore: 1)
    }
    
    static func getYesterday(_ dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        return getPreviousDayForGivenDate(calendar, dateFormatter: dateFormatter, daysBefore: 1, dateString: dateString)
    }
    
    static func getThisMonth() -> String {
        return getCurrentYearAndMonth() //just because of more intuitive name when using periods
    }
    
    static func getNextMonth() -> String {
        let calendar = Calendar.current
        return getNextMonth(calendar, monthsAfter: 1)
    }
    
    static func getNextMonth(_ dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        return getNextMonthForGivenDate(calendar, dateFormatter: dateFormatter, monthsAfter: 1, dateString: dateString)
    }
    
    static func getLastMonth() -> String {
        let calendar = Calendar.current
        return getPreviousMonth(calendar, monthsBefore: 1)
    }
    
    static func getLast6Month() -> String {
        let calendar = Calendar.current
        return getPreviousMonth(calendar, monthsBefore: 5)
    }
    
    static func getLast6MonthList() -> [String] {
        var last6Months = [String]()
        let calendar = Calendar.current
        for i in (0...5) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last6Months.append(month)
        }
        return last6Months
    }
    
    static func getLast4Month() -> String {
        let calendar = Calendar.current
        return getPreviousMonth(calendar, monthsBefore: 3)
    }
    
    static func getLast4MonthList() -> [String] {
        var last4Months = [String]()
        let calendar = Calendar.current
        for i in (0...3) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last4Months.append(month)
        }
        return last4Months
    }
    
    static func getLast4MonthDictionary() -> [(name: String, translated: String)] {
        var last4Months = [(name: String, translated: String)]()
        let calendar = Calendar.current
        for i in (0...3) {
            let month = getPreviousMonth(calendar, monthsBefore: i)
            last4Months.append(name: month, translated: month)
        }
        return last4Months
    }
    
    static func getFirstDateOfCurrentMonth() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter)
        
        return dateFormatter.string(from: startOfMonth)
    }
    
    static func getLastDateOfCurrentMonth() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter)
        let endOfMonth = getLastDayOfMonth(calendar, startOfMonth: startOfMonth)
        
        return dateFormatter.string(from: endOfMonth)
    }
    
    static func getFirstDateOfGivenMonth(_ dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter, dateString: dateString)
        
        return dateFormatter.string(from: startOfMonth)
    }
    
    static func getLastDateOfGivenMonth(_ dateString: String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let startOfMonth = getFirstDayOfMonth(calendar, dateFormatter: dateFormatter, dateString: dateString)
        let endOfMonth = getLastDayOfMonth(calendar, startOfMonth: startOfMonth)
        
        return dateFormatter.string(from: endOfMonth)
    }
    
    static func getFirstDayOfCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = Date()
        let calendar = Calendar.current
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date)
        
        return String(range.location)
    }
    
    static func getLastDayOfCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = Date()
        let calendar = Calendar.current
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date)
        
        return String(range.length)
    }
    
    static func getFirstDayOfGivenMonth(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = dateFormatter.date(from: dateString)
        let calendar = Calendar.current
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date!)
        
        return String(range.location)
    }
    
    static func getLastDayOfGivenMonth(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = dateFormatter.date(from: dateString)
        let calendar = Calendar.current
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date!)
        
        return String(range.length)
    }
    
    static func getNumberOfDaysBetweenDates(_ dateFrom: String, dateTo: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let startDate = dateFormatter.date(from: dateFrom)
        let endDate = dateFormatter.date(from: dateTo)
        
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: startDate!, to: endDate!, options: [])
        
        return components.day! + 1
    }
    
    static func isValidDateFormat(_ string: String, dayProvided: Bool) -> Bool {
        var pattern = "^(19|20)\\d\\d-(0[1-9]|1[012])$" // for format "yyyy-MM"
        if dayProvided {
            pattern = "^(19|20)\\d\\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$" // for format "yyyy-MM-dd"
        }
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0)) {
            let matched = regex.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count))
            if matched.count > 0 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    static func getNextDayForGivenDate(daysAfter: Int, dateObject: Date) -> Date {
        let calendar = Calendar.current
        let dateCalculated = calendar.date(byAdding: .day, value: daysAfter, to: dateObject)
        
        return dateCalculated!
    }
    
    static func getDateObjectForGivenDateString(_ dateString: String) -> Date {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: date!)
        return calendar.date(from: components)!
    }
    
    static func getDateStringForGivenDateObject(_ dateObject: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateObject)
    }
    
    private static func createDateFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter
    }
    
    private static func getDateForFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: Date())
    }
    
    private static func getFirstDayOfMonth(_ calendar: Calendar, dateFormatter: DateFormatter) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let components = (calendar as NSCalendar).components([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    private static func getFirstDayOfMonth(_ calendar: Calendar, dateFormatter: DateFormatter, dateString: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        let components = (calendar as NSCalendar).components([.year, .month], from: date!)
        return calendar.date(from: components)!
    }
    
    private static func getLastDayOfMonth(_ calendar: Calendar, startOfMonth: Date) -> Date {
        var components2 = DateComponents()
        components2.month = 1
        components2.day = -1
        return (calendar as NSCalendar).date(byAdding: components2, to: startOfMonth, options: [])!
    }
    
    private static func getPreviousDay(_ calendar: Calendar, daysBefore: Int) -> String {
        let dateFormatter = createDateFormatter(dateFormat: "yyyy-MM-dd")
        
        let dateCalculated = calendar.date(byAdding: .day, value: 0-daysBefore, to: Date())
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getPreviousDayForGivenDate(_ calendar: Calendar, dateFormatter: DateFormatter, daysBefore: Int, dateString: String) -> String {
        let date = dateFormatter.date(from: dateString)
        let dateCalculated = calendar.date(byAdding: .day, value: 0-daysBefore, to: date!)
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getPreviousMonth(_ calendar: Calendar, monthsBefore: Int) -> String {
        let dateFormatter = createDateFormatter(dateFormat: "yyyy-MM")
        
        let dateCalculated = calendar.date(byAdding: .month, value: 0-monthsBefore, to: Date())
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getNextDay(_ calendar: Calendar, daysAfter: Int) -> String {
        let dateFormatter = createDateFormatter(dateFormat: "yyyy-MM-dd")
        
        let dateCalculated = calendar.date(byAdding: .day, value: daysAfter, to: Date())
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getNextDayForGivenDate(_ calendar: Calendar, dateFormatter: DateFormatter, daysAfter: Int, dateString: String) -> String {
        let date = dateFormatter.date(from: dateString)
        let dateCalculated = calendar.date(byAdding: .day, value: daysAfter, to: date!)
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getNextMonth(_ calendar: Calendar, monthsAfter: Int) -> String {
        let dateFormatter = createDateFormatter(dateFormat: "yyyy-MM")
        
        let dateCalculated = calendar.date(byAdding: .month, value: monthsAfter, to: Date())
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
    private static func getNextMonthForGivenDate(_ calendar: Calendar, dateFormatter: DateFormatter, monthsAfter: Int, dateString: String) -> String {
        let date = dateFormatter.date(from: dateString)
        let dateCalculated = calendar.date(byAdding: .month, value: monthsAfter, to: date!)
        
        return dateFormatter.string(from: dateCalculated!)
    }
    
}
