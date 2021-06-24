//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 13/6/2021.
//

import Foundation

class ExpenseModel {
    var amount: String;
    var date: Date;
    
    init(amount:String, date:Date) {
        self.amount = amount
        self.date = date
    }
}
