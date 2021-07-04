//
//  SummaryExpenseViwe.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI

struct SummaryExpenseView: View {
    @StateObject var expensesViewmodel = ExpenseViewModel()
    
    var body: some View {
        NavigationView{
            GeometryReader { p in
                VStack {
                    Text("Summary for This Month")
                    //Summary for the Month
                    HStack{
                        ForEach(0..<12) { month in
                            VStack {
                              Spacer()
                              Rectangle()
                                .fill(Color.green)
                                .frame(width: 20, height: CGFloat(Int.random(in: 1...10)) * 15.0)
                              Text("\(month)")
                                .font(.footnote)
                                .frame(height: 20)
                            }
                          }//For
                    }//HStack
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: p.size.height/2, alignment: .center)
                    
                    //Summary for the Year
                    Text("Summary for Year")
                    HStack{
                        ForEach(0..<12) { month in
                            VStack {
                              Spacer()
                              Rectangle()
                                .fill(Color.green)
                                .frame(width: 20, height: CGFloat(Int.random(in: 1...10)) * 15.0)
                              Text("\(month)")
                                .font(.footnote)
                                .frame(height: 20)
                            }
                          }//For
                    }//HStack
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: p.size.height/3, alignment: .center)
                }//VStack
            } //Geometry
            .navigationTitle("Summary Expense")
        }
    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryExpenseView()
    }
}
