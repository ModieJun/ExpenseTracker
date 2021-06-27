//
//  DailyExpenseView.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI

struct DailyExpenseView: View {
    @StateObject var expensesViewModel:ExpenseViewModel = ExpenseViewModel()
    
    @State var isMonthPickerPresented = false;
    @State var selectedMonth: Date = Date(){
        didSet{
            print("New date selected - reload data")
            self.reloadData()
        }
    }
    
    var body: some View {
        //Hack around to invoke didSet for datePicker
        let dateBinding = Binding(
            get: { self.selectedMonth },
            set: {
                self.selectedMonth = $0
            }
        )
        
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
                            self.isMonthPickerPresented.toggle()
                        }
                        label: {
                            HStack(alignment:.center){
                                Text(selectedMonth,style:.date)
                                    .font(.title2)
                                Image(systemName:"arrowtriangle.down.fill")
                            }
                        }
                        .sheet(isPresented: $isMonthPickerPresented, content: {
                            //TODO: change to selected year and month picker
                            DatePicker("Selected Month and Year", selection: dateBinding,in: ...Date() , displayedComponents: [.date])
                                .datePickerStyle(WheelDatePickerStyle())
                                
                        }).foregroundColor(.black)
                        
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
                }
            }
            .padding(.bottom,100)
        }
        .edgesIgnoringSafeArea(.all)
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
