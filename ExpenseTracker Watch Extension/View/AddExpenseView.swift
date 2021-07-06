//
//  AddExpenseView.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 28/6/2021.
//

import SwiftUI

struct AddExpenseView: View {
    @State var date:Date = Date()
    @State var hasValue = false
    @State var amount = ""{
        mutating didSet{
            if (!hasValue && amount.count>0){
                hasValue = true
            }else{
                hasValue = false
            }
        }
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ fullview in
                VStack(alignment:.trailing,spacing:0){
    
                    HStack{
                        Text("\(amount != "" ? amount : "0")").font(.title2)
                        .padding(.vertical,1)
                        if(hasValue){
                            Image(systemName: "delete.left.fill")
                                .onTapGesture {
                                    
                                }
                        }
                    }
                    WatchKeyboard(amount: $amount, enterAction: {
                        self.addNewExpense()
                    })
                }//Vtack
            }//Geo
        }//Navigation View
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private func addNewExpense(){
        print("Go to the new category selection")
        print("After new cateogry selected then add expense")
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
