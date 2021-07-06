//
//  MonthYearPicker.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 25/6/2021.
//

import Foundation
import SwiftUI

struct MonthYearPickerView: View {
    let months = (0...11).map {$0}
    let years = (2020...2050).map {$0}
    
    @State private var date: Date
    var action: (Int, Int) -> Void
    
    @State private var selectedMonth:Int = 0
    @State private var selectedYear:Int = 2050
    
    init(date: Date, action: @escaping (Int, Int) -> Void) {
           self._date = State(initialValue: date)
           self.action = action
           
           let calendar = Calendar.current
           let month = calendar.component(.month, from: date)
           let year = calendar.component(.year, from: date)
           
           self._selectedMonth = State(initialValue: month - 1)
           self._selectedYear = State(initialValue: year)
   }
    
    var body: some View{
        VStack(alignment:.center){
            HStack{
                Text("Select Year and Month").bold()
                
            }.padding(.top,10)
            HStack(alignment:.center){
                GeometryReader { geometry in
                    Picker("Year",selection: self.$selectedYear) {
                        ForEach(years, id: \.self) {
                            Text(String($0))
                        }
                    }.frame(width:geometry.size.width,height: 100, alignment: .center)
                    .clipped()
                }
                    
                GeometryReader { geometry in
                    Picker(selection: self.$selectedMonth,label:Text("Month"),content: {
                        ForEach(1..<13){ value in
                            Text("\(value)")
                        }
                    })
                    .frame(width:geometry.size.width,height: 100, alignment: .center)
                    .clipped()
                }
            }//Hstack
            .frame(height:100)
            
            Button(action: {self.action(selectedMonth+1,selectedYear)}, label: {
                Text("Apply").padding()
                    .padding(.horizontal,100)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20.0)
            })
        }//Vstack
        .padding(.vertical,20)
        .background(Color.white)
        .animation(.none)
    }
}

struct MonthYearPicker_Previews: PreviewProvider {
    @State static var month = 1
    @State static var year = 2021
    @State static var date = Date()
    static var previews: some View {
        MonthYearPickerView(date: date, action: {
            month, year in
            var comp = Calendar.current.dateComponents([.year,.month], from: self.date)
            comp.month = month
            comp.year = year
            self.date = Calendar.current.date(from: comp)!
        })
    }
}

