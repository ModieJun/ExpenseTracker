//
//  ExpenseLIst.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 19/6/2021.
//

import SwiftUI

struct ExpenseList: View {
    @State var expenses:[Expense];//given expenses for dat
    @State var date:Date;
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text(date,style: .date).font(.headline)
            List{
                ForEach(expenses, id: \.self, content: {
                    exp in
                    ExpenseRecord(expense: exp)
                })
            }
        }
    }
    
    func localized()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: self.date)
    }
}

struct ExpenseList_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseList(expenses:ExpenseViewModel().expenses, date: Date())
            .environmentObject(ExpenseViewModel())
    }
}
