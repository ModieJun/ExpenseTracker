//
//  SettingsView.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 29/6/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Navigation View")
            }//Vstack
        }//Navigation
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
