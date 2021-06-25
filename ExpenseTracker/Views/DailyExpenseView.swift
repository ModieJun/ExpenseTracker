//
//  DailyExpenseView.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI

struct DailyExpenseView: View {
    @StateObject var expensesViewModel:ExpenseViewModel = ExpenseViewModel()

    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment:.bottom){
                VStack{
                    HStack{
                        Text("Daily Expense")
                            .font(.title2)
                    }.padding(.top, 50)
                    
                    HStack{
                        Text("\(expensesViewModel.monthString)")
                        Spacer()
                        Text(String(format:"Total: $%.2f",expensesViewModel.monthTotal))
                    }.padding()
                    .padding(.horizontal, 20)
                    .frame(maxWidth:.infinity)
                    
                    //Expense List - based on date and the Expenses in That date
                    List{
                        ForEach(Array(expensesViewModel.daysWithExpenses),id:\.self){ key in
                            
                            Section(header:Text(key,style: .date).font(.headline)
                                    ,content: {
                                ForEach(expensesViewModel.expensesForMonth[key]!,id:\.self){ exp in
                                    ExpenseRecord(expense: exp)
                                    //TODO implement swipe to delete
                                    
                                }//For each expenses
                                .onDelete(perform: { indexSet in
                                    self.expensesViewModel.deleteExpense(at: key, offset: indexSet)
                                })
                            })//Section
                        }//For each key
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
        DailyExpenseView()
    }
}
