//
//  ExpenseTrackerApp.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 28/6/2021.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
