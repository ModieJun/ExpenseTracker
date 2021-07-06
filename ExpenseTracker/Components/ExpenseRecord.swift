//
//  ExpenseRecord.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 13/6/2021.
//

import SwiftUI

struct ExpenseRecord: View {
    let expense:Expense;

    var body: some View {
            Button(action: {
                print("\(String(format: "%.2f", expense.amount)) pressed")
            }, label: {
                HStack(alignment:.center){
                    Image(systemName: "drop.fill")
                    Text("\((expense.category != nil) ? expense.category!.name! : "nil")")
                        .font(.body)
                        
                    Spacer()
                    Text("$\(String(format: "%.2f", expense.amount))").font(.body)
                }
            })
            .foregroundColor(.black)
            .padding(.horizontal,5)
            .padding(.vertical,5)
        
    }
}

struct ExpenseRecord_Previews: PreviewProvider {
    static let exp:Expense = {
        let temp = Expense()
        temp.amount = 12
        temp.date = Date()
        temp.uuid = UUID()
        
        let cat = Category()
        cat.available = true
        cat.name = "Food"
        temp.category = cat
        
        return temp  
    }()
    
    static var previews: some View {
        ExpenseRecord(expense:self.exp)
    }
}
