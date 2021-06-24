//
//  DailyExpenseView.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI

struct DailyExpenseView: View {
    @StateObject var expensesViewModel:ExpenseViewModel

    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment:.bottom){
                VStack{
                    HStack{
                        Text("Daily Expense")
                            .font(.title)
                    }.padding(.top, 50)
                    
                    HStack{
                        Text("Month \(expensesViewModel.monthString)")
                        Text("Month Expense $XXX")
                    }.padding()
                    
                    //Expense List - based on date and the Expenses in That date
                    List{
                        ForEach(expensesViewModel.expenses, id: \.self, content: {ele in
                            ExpenseRecord(expense: ele)
                        })
                        .onDelete(perform: expensesViewModel.removeExpenseAt)
                    }
                }
            }
            .padding(.bottom,100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DailyExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        DailyExpenseView(expensesViewModel: ExpenseViewModel(preview:true))
    }
}
