//
//  AddExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 24/6/2021.
//

import Foundation
import CoreData
import Combine

class AddExpenseViewModel: NSObject,ObservableObject {
    @Published var amount:String = "" ;
    @Published var date:Date = Date();
    @Published var category:Category?;
    
    var expense:Expense?{
        didSet{
            //populate the values in the view model
            setupViewModel()
        }
    }
    
    private let dataContainer:DataContainer
    
    init(preview:Bool=false) {
        if(preview){
            self.dataContainer = DataContainer.preview
        }else{
            self.dataContainer = DataContainer.shared
        }
        super.init()
    }
    
    private func setupViewModel(){
        self.amount = String(format: "%f", self.expense!.amount)
        self.category = self.expense?.category
        self.date = self.expense?.date ?? Date()
    }
    
    func addExpense(){
        let newExpense = Expense(context: self.dataContainer.managedObjectContext)
        newExpense.uuid = UUID()
        newExpense.amount = Double.init(self.amount) ?? 0.00
        newExpense.date = self.date;
        newExpense.category = self.category!
        
        self.dataContainer.saveContext()
    }
    
    
    func updateExpense(){
        self.expense?.amount = Double.init(self.amount) ?? 0.00
        self.expense?.date = date
        self.expense?.category = category
        self.dataContainer.saveContext()
    }
    
    func deleteExpense(){
        self.dataContainer.managedObjectContext.delete(self.expense!)
        self.dataContainer.saveContext()
    }
}
