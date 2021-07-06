//
//  WatchKeyboard.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 5/7/2021.
//

import SwiftUI

struct WatchKeyboard: View {
    @Binding var amount:String
    var enterAction:()->Void
    
    var body: some View {
        GeometryReader{
            geometry in
            VStack(spacing:0){
                HStack(spacing:0){
                    InputButton(value: "1", action: appendVal)
                    InputButton(value: "2", action: appendVal)
                    InputButton(value: "3", action: appendVal)
                }
                HStack(spacing:0){
                    InputButton(value: "4", action: appendVal)
                    InputButton(value: "5", action: appendVal)
                    InputButton(value: "6", action: appendVal)
                }
                HStack(spacing:0){
                    InputButton(value: "7", action: appendVal)
                    InputButton(value: "8", action: appendVal)
                    InputButton(value: "9", action: appendVal)
                }
                HStack(spacing:0){
                    InputButton(value: ".", action: appendVal)
                    InputButton(value: "0", action: appendVal)
                    InputButton(value: ">", action: appendVal)
                }
            }//Vstack
            .frame(width: geometry.size.width, height: geometry.size
                    .height, alignment: .center)
        }//Geo
    }
    
    private func appendVal(val:String)->Void{
        if (val == ">" && self.isAmountValid()){
            // Append the value into core data
            self.enterAction()
            return
        }
        if(val == "."){
            amount.contains(val) ? nil : amount.append(val);
            return
        }
        amount.append(val)
    }
    
    private func isAmountValid()->Bool{
        return self.amount.count>0 ? true : false
    }
}

struct InputButton:View{
    var value:String;
    var action: (String)->Void;
    @State var isPressed = false
    @GestureState var isDetectingPress = false
    
    var body: some View{
        GeometryReader{
            geometry in
            
            
            Text("\(value)")
                .font(.title2)
                .onTapGesture {
                    self.action(value)
                }
//                .gesture(LongPressGesture(minimumDuration: 0, maximumDistance:0)
//                            .updating($isDetectingPress, body: { (curr, gesture, _) in
//                                gesture = curr
//
//                            })
//                            .onEnded({_ in self.action(value)})
//                )
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                .background(Color.gray)
                .cornerRadius(geometry.size.height)
        }//parent container
        .scaleEffect(self.isPressed ? 2.0 : 1.0)
    }
}

struct WatchKeyboard_Previews: PreviewProvider {
    @State static var string = ""
    static var previews: some View {
        WatchKeyboard(amount: $string,enterAction: {print("Append New item")})
    }
}
