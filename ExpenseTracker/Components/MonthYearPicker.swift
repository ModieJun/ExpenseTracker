//
//  MonthYearPicker.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 25/6/2021.
//

import Foundation
import SwiftUI

struct MonthYearPickerView: View {
    @Binding var month:Int;
    @Binding var year:Int;
    var body: some View{
        NavigationView{
            GeometryReader { geometry in
                HStack(alignment:.center){
                    Picker("Year",selection: self.$year) {
                        ForEach(2000...2021, id: \.self) {
                            Text(String($0))
                        }
                    }.frame(width: geometry.size.width/2, height: 100, alignment: .center)
                    .clipped()
        
                    Picker(selection: self.$month,label:Text("Month"),content: {
                        ForEach(1..<13){ value in
                            Text("\(value)")
                        }
                    }).frame(width: geometry.size.width/2, height: 100, alignment: .center)
                    .clipped()
                }
            }
            .navigationTitle("Select Month & Year")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

struct MonthYearPicker_Previews: PreviewProvider {
    @State static var month = 1
    @State static var year = 2021
    static var previews: some View {
        MonthYearPickerView(month: $month, year: $year
        )
    }
}

