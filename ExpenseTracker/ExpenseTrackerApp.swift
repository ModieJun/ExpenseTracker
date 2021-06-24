//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import SwiftUI
import PartialSheet

@main
struct ExpenseTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate;
    let sheetManager: PartialSheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            MainView()
                
                .environmentObject(sheetManager)
        }
    }
}
