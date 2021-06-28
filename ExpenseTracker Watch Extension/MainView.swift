//
//  ContentView.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 28/6/2021.
//

import SwiftUI

struct Mainview: View {
    var body: some View {
        GeometryReader{ geo in
            List{
                NavigationLink("+Add Expense", destination:AddExpenseView()).frame(height:geo.size.height/2.5)
                
                NavigationLink(
                    destination: SummaryView(),
                    label: {
                        //TODO Summary Data
                        Text("Summary View")
                    }).frame(height:geo.size.height/2.5)
            }//List
        }//Georeader
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Mainview()
    }
}
