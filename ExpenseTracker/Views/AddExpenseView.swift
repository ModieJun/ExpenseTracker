//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import AlertToast
import PartialSheet

struct AddExpenseView: View {
    @State var isCategorySelected: Bool = false;
    @State var isToastPresented=false;
    @Binding var isPresented:Bool;
    
    @State var selectedCategory:Category? = nil

    @StateObject var addExpenseViewModel:AddExpenseViewModel = AddExpenseViewModel()
    @StateObject  var categoryViewModel:CategoryViewModel = CategoryViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), content: {
                        ForEach(categoryViewModel.allCategories,id:\.self,content:{
                            ele in
                                Button{
                                    withAnimation(.easeIn(duration:1), {
                                        self.select(category: ele)
                                    })
                                }
                                label:{
                                    CategorySelection(categoryName: ele.name!, selected: selectedCategory?.name?.elementsEqual(ele.name!) ?? false )
                                }
                        }) //For Each
                    }).padding(.top,25) // Lazy Grid
                }//ScrollView
                .padding(.horizontal, 20)
                
                //MARK: Category selected
                if(self.isCategorySelected){
                    Spacer()
                    DatePickerSheet(date: $addExpenseViewModel.date)
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:0){
                        HStack{
                            Text("\((addExpenseViewModel.category?.name)!)")
                                .frame(maxWidth: .infinity,alignment: .center)
                                .font(.body)
                            Text("$\(addExpenseViewModel.amount)")
                                .frame(maxWidth:.infinity,alignment: .center)
                        }.frame(maxWidth: .infinity)
                        .padding()
                        InputKeyboard(amount: $addExpenseViewModel.amount,action: self.addExpense)
                    }.toast(isPresenting: self.$isToastPresented, alert: {
                        AlertToast(type: .loading, title: "Adding Expense....")
                    })
                } // Category Selected
                
            }//VStack
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationBarItems(trailing:Button("Close", action: {print("Close");self.isPresented.toggle()})
            )
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationView
        .addPartialSheet()
    }
    
    func select(category:Category) -> Void{
        
        if(self.isCategorySelected == false){
        //Simulate delay on the cateogry selected
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                withAnimation{
                        self.isCategorySelected.toggle()
                }
            })
        }
        addExpenseViewModel.category = category //set selected to change view model
    }
    
    func addExpense() -> Void {
        self.addExpenseViewModel.addExpense()
        
        self.isToastPresented.toggle()
        
        //Delay in adding Expense Record
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            withAnimation{
                self.isToastPresented.toggle()
                self.isPresented.toggle()
            }
        })
    }
}

struct DatePickerSheet:View {
    @Binding var date:Date
    @State private var datePickerPresented:Bool = false;
    
    
    var body: some View{
        Button{
            print("Present Dte")
            self.datePickerPresented.toggle()
        }
        label:{
            Text(date,style: .date)
        }.sheet(isPresented: $datePickerPresented, content: {
            DatePicker(
                "Date",
                selection:$date,
                in: ...Date() ,
                displayedComponents: [.date]
            ).datePickerStyle(WheelDatePickerStyle())
        })
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false;
    static var previews: some View {
        AddExpenseView(isPresented: $isPresented)
    }
}
