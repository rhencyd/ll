////
////  CoreDataManager.swift
////  FoodOrderingApp
////
////  Created by Rhency Delgado on 3/13/23.
////
//
//import SwiftUI
//import CoreData
//
//
//class CoreDataViewModel: ObservableObject {
//    
//    let container: NSPersistentContainer
//    @Published var savedDishes: [DishEntity] = []
//    
//    init() {
//        container = NSPersistentContainer(name: "DishContainer")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("Error loading core data: \(error)")
//            } else {
//                print("Successfully loaded core data")
//            }
//        }
////        clear() // this func will erase all data from core data or cache
////        fetchDish() // this func will save all the dishes in the core data into an array
//    }
//    
//    func fetchDish() {
//        let request = NSFetchRequest<DishEntity>(entityName: "DishEntity")
//        do {
//           savedDishes = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching. \(error)")
//        }
//    }
//    
//    func clear() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DishEntity")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
//        saveData()
//    }
//    
//    func addDish(menuItems: [MenuItem]) {
//        for dish in menuItems {
//            let newDish = DishEntity(context: container.viewContext)
//            newDish.title = dish.title
//            newDish.category = dish.category
//            newDish.price = dish.price
//            newDish.itemDescription = dish.description
//            newDish.image = dish.image
//            newDish.id = Int32(dish.id)
//            saveData()
//        }
//    }
//    
//    func saveData() {
//        do {
//          try container.viewContext.save()
//            fetchDish()
//        } catch let error {
//            print("Error Saving: \(error)")
//        }
//        
//    }
//    
//    
//}
//
