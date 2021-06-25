//
//  File.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 13/6/2021.
//

import Foundation
import Combine
import CoreData

class ExpenseViewModel: NSObject, ObservableObject {
    //MARK: Public Var
    @Published var expenses:[Expense] = [] { //should contain all the expenses
        didSet{
            NSLog("Updated the expenses of ViewModel")
            //Change in the expenses for this month
            //update the expenses for Month
            self.computeExpensesByEachDay()
            self.computeMonthTotal()
        }
    }
    
    @Published var expensesForMonth:Dictionary<Date,[Expense]> = Dictionary(){ //return array of array[Expenses] each array for each day
        didSet{
            NSLog("Expenses View model: didSet new expnenses for selected month")
        }
    }
    
    @Published var monthTotal:Double = 0.00
    
    var date:Date{
        didSet{
            self.setMonthBeginEndDate()
        }
    }

    var  dateBegin:Date?
    var  dateEnd:Date?
    
    //MARK: Private & Init
    private var cancellable = Set<AnyCancellable>() //this allows us to cancel any subscriptions that we want to create for the day
    private let dataContainer:DataContainer
    
    private let expensesFetchController:NSFetchedResultsController<NSFetchRequestResult>
    
    init(for date:Date = Date()){
        self.dataContainer = DataContainer.shared
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let sortDesript = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDesript]

        self.expensesFetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.dataContainer.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.date = date;
        super.init()
        self.setupFetchController()
    }
    
    private func setMonthBeginEndDate(){
        //Calc the date for the begining of the month
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self.date))
        self.dateBegin =  Calendar.current.date(from: comp)!
        
        //Calc the end for the end of the month
        var comp2 = DateComponents()
        comp2.month = -1
        comp2.day = -1
        self.dateEnd =  Calendar.current.date(byAdding: comp2, to: self.dateBegin!)!
    }
    
    private func setupFetchController(){
        self.expensesFetchController.delegate = self
        do {
            try expensesFetchController.performFetch()
            guard let fetchedExpenses = expensesFetchController.fetchedObjects as? [Expense] else { return }
            self.expenses = fetchedExpenses
        } catch  {
            NSLog("Error: Could not fetch objects in core data")
        }
    }
    
    private func saveContext(){
        self.dataContainer.saveContext()
    }
    
    private func computeExpensesByEachDay(){
        var filt:Dictionary<Date,[Expense]> = Dictionary()
        self.expenses.forEach({exp in
            if !filt.contains(where: {d, e in exp.date!.isEqualTo(date: d)}) { //if this date is not in the dict
                filt.updateValue(self.expenses.filter({ele in ele.date!.isEqualTo(date: exp.date!)}) , forKey: exp.date!) //add to the dick
            }
        })
        self.expensesForMonth = filt
    }
    
    private func computeMonthTotal(){
        var total = 0.00;
        self.expenses.forEach({
            ele in
            total += ele.amount
        })
        self.monthTotal = total
    }
}

//MARK: Delegate Call
extension ExpenseViewModel: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let expenses = controller.fetchedObjects as? [Expense] else { return }
        self.expenses = expenses
    }
}

//MARK: Public Methods
extension ExpenseViewModel {
    //Functions that are invoked by the viewmodel to Modify and update local data 
    
    /**
            Function is used to delete expenses from self.expensesForMonth<Date,[Expense]>
            based on provided date as key for dict , delete the expense at that specific index offset
     */
    func deleteExpense(at key:Date, offset:IndexSet){
        let values = self.expensesForMonth[key]
        for index in offset{
            let del = values![index] as NSManagedObject
            print("Index \(index) , Expense: \(del)")
            self.dataContainer.managedObjectContext.delete(del)
            self.saveContext()
        }
    }
    
    /**
            Used to remove element straight from all the expenses queried this month.
     */
    func removeExpenseAt(offset:IndexSet){
        for index in offset{
            let expenseDel = self.expenses[index]
            print("Index \(index) , Expense: \(expenseDel)")
            self.dataContainer.managedObjectContext.delete(expenseDel)
            self.saveContext()
        }
    }
    
    func addNewExpense(amount:String,category:Category,for date:Date = Date()) -> Void {
        let newExpense = Expense(context: self.dataContainer.managedObjectContext)
        newExpense.amount = Double.init(amount) ?? 0.00
        newExpense.category = category
        newExpense.date = date
        newExpense.uuid = UUID()
        self.saveContext()
    }
    
    var month:Int{
        return self.date.monthInt
    };
    
    var monthString:String{
        return self.date.monthString
    }
    
    var daysWithExpenses:Array<Date>{
        return self.expensesForMonth.keys.sorted(by: >)
    }
}
