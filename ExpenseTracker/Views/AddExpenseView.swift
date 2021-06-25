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
                        })
                    }).padding(.top,25)
                }.padding(.horizontal, 20)
                
                //MARK: Category selected
                if(self.isCategorySelected){
                    DatePickerSheet(date: $addExpenseViewModel.date)
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:nil){
                        HStack{
                            Text("\((addExpenseViewModel.category?.name)!)")
                                .frame(maxWidth: .infinity)
                                .font(.body)
                            Text("$\(addExpenseViewModel.amount)")
                                .font(.title)
                                .frame(maxWidth:.infinity,alignment: .leading)
                                .padding(.horizontal,50)
                            Button{
                                //Add to the ViewModelData
                                self.addExpenseViewModel.addExpense()
                                
                                self.isToastPresented.toggle()
                                
                                //Delay in adding Expense Record
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
                                    withAnimation{
                                        self.isToastPresented.toggle()
                                        self.isPresented.toggle()
                                    }
                                })
                            } label: {
                                Image(systemName: "plus")
                            }
                            .padding()
                            .padding(.horizontal,20)
                            .foregroundColor(.white)
                            .background(Color.red)
                        }.frame(maxWidth: .infinity)
                        InputKeyboard(amount: $addExpenseViewModel.amount)
                            .padding(.bottom,20)
                    }.toast(isPresenting: self.$isToastPresented, alert: {
                        AlertToast(type: .loading, title: "Adding Expense....")
                    })
                }
                
            }
            .ignoresSafeArea(.container, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            .navigationBarItems(trailing:Button("Close", action: {print("Close");self.isPresented.toggle()})
            )
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            
        }.addPartialSheet()
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
