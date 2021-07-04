//
//  DateHelpers.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 23/6/2021.
//

import Foundation
import SwiftUI

extension Date{
    
    func isEqualTo(date:Date)->Bool{
        let comp1 = Calendar.current.dateComponents([.year,.month,.day], from: self)
        let comp2 = Calendar.current.dateComponents([.year,.month,.day], from: date)
        return comp1.day == comp2.day && comp1.month == comp2.month && comp1.year == comp2.year
    }
    
    var monthInt:Int{
        return monthInt(for: self)
    }
    
    func monthInt(for date:Date)->Int{
        return Calendar.current.dateComponents([.month], from: date).month!
    }
    
    var monthString:String{
        return monthString(for: self)!
    }

    func monthString(for date:Date)->String?{
        let month = monthInt(for: date)
        return monthFromInt(int: month)
    }
    
    func monthFromInt(int:Int)->String?{
        switch int {
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAY"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
        default:
            return nil
        }
    }
    
    var year:String{
        let comp1 = Calendar.current.dateComponents([.year], from: self)
        return String(comp1.year!)
    }
    
    func yearAndMonthFrom(start d1:Date, end d2:Date){
        
    }
    
    func range(to end:Date)->ClosedRange<Int>?{
        let comp1 = Calendar.current.dateComponents([.year], from: self)
        let comp2 = Calendar.current.dateComponents([.year], from: end)
        return comp1.year!...comp2.year!
    }
    
    /// Returns the year and month components in a tuple
    /// - Parameter date: Date object
    func yearAndMonthFrom(date:Date)->(Int,Int){
        let components = Calendar.current.dateComponents([.year,.month], from: date )
        return (components.month! , components.year!)
    }
    
    /// Gets the date at the end of the month from month and date component
    ///     If (1,2021) passed , then will return 2021/01/31
    /// - Parameter components: (INT,INT) - (Month, Year) integer values from yearAndMonthFrom()
    /// - Returns: Date at the end of the month
    static func dateFromYearMonth(components:(Int,Int))->Date?{
        var comp = DateComponents()
        comp.month = components.0
        comp.year = components.1
        
        // Get the number of days in the month
        let range = Calendar.current.range(of: .day, in: .month, for: Calendar.current.date(from: comp)!)
        comp.day = range?.count
        
        return Calendar.current.date(from: comp)
    }
    
    /// Compute and returns the date for each week in this current month in an array format
    ///     Eg: If ther are 4 days in the first week Function should return
    ///         [[1, 2, 3, 4], [5,6,7,8,9,10,11,]]
    ///     Function assumes that the start of the week is sunday (Gregorian)
    /// - Returns: Array of Array of Dates -
    ///         - First nest array stores one array of each week
    ///         - Second the Date for that week
    func datesForEachWeekInMonth()->Array<Array<Date>>{
        return []
    }
    
    /// Gets the start abd end date of the week for the current date.
    /// - Returns: { start : Date , end: Date }
    ///     - Key: 'start' , 'end'
    func startAndEndOfWeek()->Dictionary<String,Date>{
        return Dictionary()
    }
}

extension Calendar{
    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: date))!
    }

    func endOfMonth(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date))!
    }
}
