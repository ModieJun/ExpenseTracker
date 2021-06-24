//
//  DateHelpers.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 23/6/2021.
//

import Foundation

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
        switch month {
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
}
