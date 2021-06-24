//
//  ExpenseServce.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 14/6/2021.
//

import Foundation
import Combine
import CoreData

//MARK: Depreciated
class ExpenseService: NSObject {
    //MARK: Variables
    var expenses = CurrentValueSubject<[Expense],Never>([]){
        didSet{
            //expensesDidChange
            NSLog("Expenses did set with new values");
        }
    } //should  hold the expenses for the current month
    
    var date:Date = Date(){
        didSet{
            NSLog("Date for \(self) updated")
            //shoudl update the datebeign and end wth new values
            
            //perform new fetch on the date
            
        }
    }
    
    //USED IN PREDICATE QUERIES
    private var dateBegin:Date = Date()
    private var dateEnd:Date = Date()
    
    //MARK: Instances
    static let shared: ExpenseService = ExpenseService()
    
    static let preview: ExpenseService = ExpenseService(preview:true)
    
    //MARK: Private Variables
    private let expensesFetchController : NSFetchedResultsController<NSFetchRequestResult>
    
    private let dataContainer:DataContainer
    
    //MARK: Initializations
    private init(preview:Bool = false){
        if preview{
            self.dataContainer = DataContainer.preview
        }else{
            self.dataContainer = DataContainer.shared
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let sortDesript = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDesript]

        expensesFetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.dataContainer.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        setupFetchController()
    }
    
    //MARK: Private Methods
    
    private func saveContext(){
        self.dataContainer.saveContext()
    }
    
    private func setupFetchController(){
        self.expensesFetchController.delegate = self
        do {
            try expensesFetchController.performFetch()
            guard let fetchedExpenses = expensesFetchController.fetchedObjects as? [Expense] else { return }
            self.expenses.value = fetchedExpenses
        } catch  {
            NSLog("Error: Could not fetch objects in core data")
        }
    }
    
    private func setupPredicateAndFetch(){
        //With the new date/month , perform new informatino fetch with the new data
        let beginDate = date
        let endDate = date
        //get the date interval between the months
        
        let predicate = NSPredicate(format: "create >= %@ && create =< %@", argumentArray: [beginDate,endDate])
        expensesFetchController.fetchRequest.predicate = predicate
        
        //perform fetch
        try? expensesFetchController.performFetch() //update the the fetched results will trigger delegate method which shoudl update the current
    }
    
    //MARK: Public methods

    func fetchCurrentMonthExpense() -> [Expense]{
        return self.expenses.value
    }
    
    func addExpense(amount:String,forCategory category:Category,date:Date){
        let newExpense = Expense(context: self.dataContainer.managedObjectContext)
        newExpense.amount = Double.init(amount)!
        newExpense.category = category
        newExpense.date = Date()
        newExpense.uuid = UUID()
        self.saveContext()
    }
    
    func deleteExpense(expense:Expense){
        self.dataContainer.managedObjectContext.delete(expense)
        self.saveContext()
    }
    
    func updateExpense(withUuid uuid:UUID){
        //TODO impelement expense update 
        self.saveContext()
    }
    
}

    //MARK: Delegate Method
extension ExpenseService: NSFetchedResultsControllerDelegate{
    //The controller context changed so i need to catch the delegete function invocation
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let expenses = controller.fetchedObjects as? [Expense] else { return }
        self.expenses.value = expenses
    }
}
