//
//  SummaryExpenseViwe.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI

struct SummaryExpenseView: View {
    var body: some View {
        NavigationView{
            Text("SummaryExpense View")
            
            .navigationTitle("Summary Expense")
        }
    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryExpenseView()
    }
}
