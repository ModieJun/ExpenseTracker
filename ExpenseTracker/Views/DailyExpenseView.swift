//
//  DailyExpenseView.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import Combine

struct DailyExpenseView: View {
    @StateObject var expensesViewModel:ExpenseViewModel = ExpenseViewModel()
    
    @State var isMonthPickerPresented = false;
    @State var selectedMonth: Date = Date(){
        didSet{
            print("New date selected - reload data")
            self.reloadData()
        }
    }
    @State private var showOverlay = false
    
    var body: some View {
        
        return GeometryReader{ geo in
            ZStack(alignment:.bottom){
                VStack{
                    HStack{
                        Text("Daily Expense")
                            .font(.title2)
                    }.padding(.top, 50)
                    
                    HStack{
                        Button{
                            print("present month Picker")
//                            self.isMonthPickerPresented.toggle()
                            self.showOverlay.toggle()
                        }
                        label: {
                            HStack(alignment:.center){
                                Text("\(selectedMonth.monthString)  \(selectedMonth.year)")
                                    .font(.title2)
                                Image(systemName:"arrowtriangle.down.fill")
                            }
                        }//Month year button
                        .sheet(isPresented: $isMonthPickerPresented, content: {
                            //TODO: change to selected year and month picker
                            MonthYearPickerView(date: self.selectedMonth , action: {
                                month, year  in
                                self.selectedMonth = Date.dateFromYearMonth(components: (month,year))!
                                self.isMonthPickerPresented.toggle()
                            })
                        })
                        .foregroundColor(.black)
                        
                        Spacer()
                        Text(String(format:"Total: $%.2f",expensesViewModel.monthTotal))
                    }
                    .padding()
                    .padding(.horizontal, 10)
                    .frame(maxWidth:.infinity)
                    
                    //Expense List - based on date and the Expenses in That date
                    List{
                        ForEach(Array(expensesViewModel.datesWithExpenses),id:\.self){ key in
                            
                            Section(header:Text(key,style: .date).font(.headline)
                                    ,content: {
                                ForEach(expensesViewModel.expensesForMonth[key]!,id:\.self){ exp in
                                    ExpenseRecord(expense: exp)
                                }//For each expenses
                                .onDelete(perform: { indexSet in
                                    self.expensesViewModel.deleteExpense(at: key, offset: indexSet)
                                })
                            })//Section
                        }//For each key
                    }// List
                }//Vstack
                
                
                //MARK: Overlay Date input
                VStack{
                    Spacer()
                    MonthYearPickerView(date: self.selectedMonth, action: {
                        month, year  in
                        self.selectedMonth = Date.dateFromYearMonth(components: (month,year))!
                        self.showOverlay.toggle()
                    })
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y:self.showOverlay ? 0 : UIScreen.main.bounds.height)
                    //offset from screen
                }//VStack
                .background(self.showOverlay ? Color.black
                                .opacity(0.3): Color.clear)
                .onTapGesture {
                    //Tapping on side the
                    self.showOverlay.toggle()
                }
                
            }//ZStack
            .padding(.bottom,95)
            .animation(.default)
        }//Geometry
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func reloadData(){
        self.expensesViewModel.date = self.selectedMonth
    }
}

struct DailyExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        DailyExpenseView()
    }
}
