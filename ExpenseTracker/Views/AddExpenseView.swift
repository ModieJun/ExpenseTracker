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
    @State var showOverlay = false
    @Binding var isPresented:Bool;
    
    @State var selectedCategory:Category? = nil

    @StateObject var addExpenseViewModel:AddExpenseViewModel = AddExpenseViewModel()
    @StateObject  var categoryViewModel:CategoryViewModel = CategoryViewModel()
    
    
    var body: some View {
        NavigationView{
            ZStack{
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
                        VStack(alignment: .trailing, spacing:0){
                            Button(action: {
                                showOverlay.toggle()
                            }, label: {
                                Text(addExpenseViewModel.date,style: .date)
                            })
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
                
                //MARK: Date selection
                VStack{
                    Spacer()
                    VStack{
                        DatePicker(
                            "Date",
                            selection:$addExpenseViewModel.date,
                            in: ...Date() ,
                            displayedComponents: [.date]
                        ).datePickerStyle(WheelDatePickerStyle())
                        Button(action: {
                            self.showOverlay.toggle()
                        }, label: {
                            Text("Close")
                                .padding()
                                .padding(.horizontal,100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20.0)
                        })
                    }
                    .padding()
                    .padding(.vertical,20)
                    .background(Color.white)
                }//VStack
                .offset(y:self.showOverlay ? 0 : UIScreen.main.bounds.height)
                .background(self.showOverlay ? Color.black
                                .opacity(0.3): Color.clear)
                .onTapGesture {
                    //Tapping on side the
                    self.showOverlay.toggle()
                }
            }//Zstack
            .edgesIgnoringSafeArea(.bottom)
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

struct AddExpenseView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false;
    static var previews: some View {
        AddExpenseView(isPresented: $isPresented)
    }
}
