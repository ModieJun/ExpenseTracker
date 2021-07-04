//
//  AppDelegate.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 18/6/2021.
//

import Foundation
import UIKit

class AppDelegate: UIResponder,UIApplicationDelegate  {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("App Launched with options .... please initalize things here")
        
        CategoryService.shared.insertDefaultCategories()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did Enter background")
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Will Enter foreground")
    }
}
