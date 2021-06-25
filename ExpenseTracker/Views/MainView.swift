//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import CoreData

struct MainView: View {
    @State var isPresented :Bool = false //isPresented for AddExpenseView
    
    var body: some View{
        TabView{
            DailyExpenseView()
            .tabItem {
                Label("Daily", systemImage: "house")
            }
            
            SummaryExpenseView()
            .tabItem {
                Label("Summary", systemImage:"chart.bar")
            }
        }
        .accentColor(.red) //changes the tab color on active
        .overlay(
                Button{
                    //Should Show popup Add Expense view ontop
                    self.isPresented.toggle()
                }
                label: {
                        ZStack{
                            Circle().foregroundColor(.white)
                                .frame(width: 55, height: 55)
                                .shadow(radius: 2)
                        
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                .sheet(isPresented: $isPresented, content: {
                    AddExpenseView(isPresented:$isPresented)
                })
            .offset(x: 0, y: -15)
            ,alignment: .bottom
        )
    }
}

struct MainView_preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
