//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Junjie Lin on 18/6/2021.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var allCategories:[Category] = [] {
        willSet{
            NSLog("New Changes made to categories")
        }
    }
    
    @Published var availableCategories:[Category] = []{
        willSet{
            NSLog("New changes to Available Categories")
        }
    }
    
    private let categorySerice:CategoryService;
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        self.categorySerice = CategoryService.shared
        
        let allCategoryPublisher = self.categorySerice.allCategories.eraseToAnyPublisher()
        let availableCategoryPublisher = self.categorySerice.availabeCategories.eraseToAnyPublisher()
        
        allCategoryPublisher.sink{
            categories in
            self.allCategories = categories
        }
        .store(in: &self.cancellable)
        
        availableCategoryPublisher.sink{
            availableCategories in
            self.availableCategories = availableCategories
        }.store(in: &self.cancellable)
    }
    
    func addNewCategory(name:String){
        //TODO : Add a new category to the list
    }
    
    func disableCategory(index:IndexSet){
        //TODO  : make a certain category.availabe= NO
    }
    
    func deleteCategory(index:IndexSet){
        //TODO :Delete category from the coredata
        //ONLY if there are no expenses related to it then we cna delete it.
    }
    
    
}
