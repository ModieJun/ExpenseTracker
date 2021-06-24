//
//  InputKeyboard.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import Foundation

struct InputKeyboard: View {
    @Binding var amount:String;
    
    var body: some View {
        VStack{
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)){
                
                ForEach(1...9,id:\.self){ value in
                    NumberButton(value: "\(value)", amount: $amount)
                }
                NumberButton(value: ".", amount: $amount)
                NumberButton(value: "0", amount: $amount)
                NumberButton(value: "del", amount: $amount)
            }
        }
    }
}

struct NumberButton:View{
    var value:String
    @Binding var amount:String
    
    var body: some View{
        Button(action: {
            if value.count>1{
                if(!amount.isEmpty){
                    amount.removeLast()
                }
            }else{
                if(self.value == "."){
                    amount.contains(value) ? nil : amount.append(self.value);
                    return
                }
                amount.append(self.value)
            }
        }, label: {
            VStack{
                if value.count>1{
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                }else{
                    Text(value)
                        .font(.title)
                }
            }
            .foregroundColor(.black)
            .frame(width: 121, height:40, alignment: .center)
            .padding(.vertical,15)
//            .padding(.horizontal,50)
        })
    }
}

struct InputKeyboard_Previews:
    PreviewProvider {
    @State static var amount = "";
    static var previews: some View {
        InputKeyboard(amount: $amount)
    }
}
