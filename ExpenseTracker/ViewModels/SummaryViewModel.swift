//
//  SummaryViewModel.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 26/6/2021.
//

import Foundation
import CoreData
/**
    Summary View model is used in the summary view to provide visual information
    about expense habits for the user.
 
    The User will be able to see two types of informaiton
        * How money was used in for the curent month by day - chart
        * How money was used for each week (where was the money used)
 */
class SummaryViewModel: NSObject,ObservableObject {
    @Published var summaryForMonthByDay:Dictionary<Date,[Expense]> = Dictionary() {
        didSet{
            
        }
    }
    
    @Published var summaryForMonthByWeek:Dictionary<String,[Expense]> = Dictionary() {
        didSet{
            
        }
    }
    
    private let summaryController:NSFetchedResultsController<NSFetchRequestResult>
    
    override init() {
        self.summaryController = NSFetchedResultsController()
    }
}

extension SummaryViewModel : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
