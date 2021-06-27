//
//  InputKeyboard.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import Foundation

struct InputKeyboard: View {
    let height:CGFloat = 50
    @Binding var amount:String;
    let action: ()  -> Void
    
    var body: some View {
        GeometryReader { geo in //use horizontal view
            VStack(spacing:0){
                HStack(spacing:0){
                    ForEach(7...9,id:\.self){
                        num in
                        NumberButton(value: "\(num)", width: geo.size.width/4, amount: $amount)
                    }
                    Button(action: {print("SelectDate")}, label: {
                        Text(Date(),style: .date)
                            .font(.footnote)
                    }).frame(width: geo.size.width/4, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.gray,width: 0.3)
                }//HStack
                HStack(spacing:0){
                    ForEach(4...6,id:\.self){
                        num in
                        NumberButton(value: "\(num)", width: geo.size.width/4, amount: $amount)
                    }
                    //Add Addition Function
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("+")
                    }).frame(width: geo.size.width/4, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.gray,width: 0.3)
                }//H Stack
                HStack(spacing:0){
                    ForEach(1...3,id:\.self){
                        num in
                        NumberButton(value: "\(num)", width: geo.size.width/4, amount: $amount)
                    }
                    //TODO: Add Minus Function
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("-")
                    }).frame(width: geo.size.width/4, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.gray,width: 0.3)
                }//H Stack
                HStack(spacing:0){
                    NumberButton(value: ".", width: geo.size.width/4, amount: $amount)
                    NumberButton(value: "0", width: geo.size.width/4, amount: $amount)
                    NumberButton(value: "del", width: geo.size.width/4, amount: $amount)
                    Button{
                        self.action()
                    } label:{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .frame(width: geo.size.width/4, height: height, alignment: .center)
                    .background(Color.red)
                    
                }//H Stack
            }// VStack
            .accentColor(.gray) //Changes foreground color
        }
    }
}

struct NumberButton:View{
    var value:String
    var width:CGFloat
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
        })
        .padding(.all,0)
        .frame(width:width,height: 50,alignment: .center)
        .border(Color.gray,width: 0.3)
    }
}

struct InputKeyboard_Previews:
    PreviewProvider {
    @State static var amount = "";
    static var previews: some View {
        InputKeyboard(amount: $amount,action: {print("Additem")})
    }
}
