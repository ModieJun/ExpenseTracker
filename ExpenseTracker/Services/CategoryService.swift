//
//  CategoryService.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 18/6/2021.
//

import Foundation
import Combine
import CoreData


class CategoryService: NSObject {
    var allCategories = CurrentValueSubject<[Category],Never>([])
    var availabeCategories = CurrentValueSubject<[Category],Never>([])
    
    static var shared = CategoryService()
    
    private let dataContainer:DataContainer
    
    private let categoryFetchController : NSFetchedResultsController<NSFetchRequestResult>
    
    private override init(){
        self.dataContainer = DataContainer.shared
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let sortDesript = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDesript]
        
        self.categoryFetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.dataContainer.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        super.init()
        
        //After initialization do something
        
        self.categoryFetchController.delegate = self;
        
        do{
            try self.categoryFetchController.performFetch()
            guard let fetchedCategory = self.categoryFetchController.fetchedObjects as? [Category] else { return }
            self.allCategories.value = fetchedCategory
        }catch{
            NSLog("Error: Could not fetch Categories in core data")
        }
        insertDefaultCategories()
    }
    
    // Only should be invoked if there is nothing
    func insertDefaultCategories(){
        //default category inserter when the container is created
        let store = UserDefaults.standard
        let key = "categoryInserted"
        if store.bool(forKey: key){
            return
        }
        let defaultCategories = [
            "Food","Transportation","Entertainment","Health","Housing"
        ];
        
        defaultCategories.forEach{
            name in
            let newCat = Category(context: self.dataContainer.managedObjectContext)
            newCat.name=name;
            newCat.uuid=UUID()
            
            self.saveContext()
        }
        store.setValue(true, forKey: key)
    }
    /**
            Function is uses to filtere and remove duplicate categories inside core data
            : Uses the Category.Name as a determinant
     */
    func removeDuplicates(){
        let categories = Set(self.allCategories.value)
        categories.forEach({ cat in
            let duplicate = self.allCategories.value.filter({ele in ele.name == cat.name })
            
            if duplicate.count > 1 {
                //There is duplicate So remove the duplicate
                self.removeCategory(category: duplicate.first!) //expect that there is first
            }
        })
        
    }
    
    func addCategory(category:Category){
        
    }
    
    func removeCategory(category:Category){
        //TODO Do check up before category removed
            
        self.dataContainer.managedObjectContext.delete(category)
        self.saveContext()
    }
    
    func saveContext(){
        self.dataContainer.saveContext()
    }
}

extension CategoryService: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let categories = controller.fetchedObjects as? [Category] else {return}
        NSLog("Category context changed with new data ")
        self.allCategories.value = categories
    }
}
