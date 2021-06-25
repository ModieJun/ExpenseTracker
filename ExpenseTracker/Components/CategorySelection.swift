//
//  CategorySelection.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 24/6/2021.
//

import SwiftUI

struct CategorySelection: View {
    
    let categoryName:String;
    @State var selected:Bool;
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                .foregroundColor( .white)
                .frame(width: 55, height: 55)
                    .shadow(color:selected ? .red : .gray ,radius: 1 )
                //TODO: Image responsive sizing
                Image("\(categoryName.lowercased())")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            Text(categoryName)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
    
}

struct CategorySelection_Previews: PreviewProvider {
    @State static var selected:Bool = true
    static var previews: some View {
        CategorySelection(categoryName: "food", selected: selected)
    }
}
