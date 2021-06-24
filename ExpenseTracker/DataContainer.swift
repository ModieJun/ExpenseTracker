//
//  Persistent.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 12/6/2021.
//

import Foundation
import CoreData

final class DataContainer {
    
    static var shared = DataContainer()
    
    static var preview: DataContainer = {
        let result = DataContainer(inMememory: true)
        let viewcontext = result.container.viewContext
        for _ in 0..<10 {
            let newExpense = Expense(context: viewcontext)
            newExpense.amount = 10
            newExpense.date = Date()
        }
        
        do{
            try viewcontext.save()
        }catch{
            let nserror = error as NSError
            fatalError("Error: \(nserror)")
        }
        
        return result
    }()
    
    // MARK: Core data Stack
    
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    private init(inMememory:Bool = false){
        let container = NSPersistentContainer (name: "ExpenseTracker") //create container with name
        if inMememory{
            container.persistentStoreDescriptions.first!.url  = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores{ description,error in
            if let error=error {
                fatalError("UNable to load the store: \(error)")
            }
        }
        self.container = container
    }
    
    //MARK: Context Saving
    func saveContext(){
        if self.container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch  {
                print("An Error has occured  while saving \(error)")
            }
        }
    }
    
    //flush Data - used for testing
    func flushData(){
        let fetchRequest:NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let objs = try! self.managedObjectContext.fetch(fetchRequest)
        
        for case let obj as NSManagedObject in objs {
            self.managedObjectContext.delete(obj)
        }
        self.saveContext()
    }
}

