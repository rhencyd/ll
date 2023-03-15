////
//// Dish+Extension.swift
//
//
//
//import Foundation
//import CoreData
//
//
//extension Dish {
//
//    static func createDishesFrom(menuItems:[MenuItem],
//                                 _ context:NSManagedObjectContext) {
//
//        for dish in menuItems {
//            guard let _ = exists(title: dish.title, context) else {
//                continue
//            }
//            let newDish = Dish(context: context)
//            newDish.title = dish.title
//            newDish.category = dish.category
//            newDish.price = dish.price
//            newDish.itemDescription = dish.description
//            newDish.image = dish.image
//        }
//
//        // An easy way to create new dishes using .foreach method and mapping it to the name property
//        /*
//         menuItems.forEach {
//         if !(Dish.exists(name: $0.name, context) ?? true) {
//         let newDish = Dish(context: context)
//         newDish.name = $0.name
//         newDish.price = Float($0.price) ?? 0
//         }
//         }
//         */
//
//    }
//
//    static func request() -> NSFetchRequest<NSFetchRequestResult> {
//        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
//        request.returnsDistinctResults = true
//        request.returnsObjectsAsFaults = true
//        return request
//    }
//
//    class func deleteAll(_ context:NSManagedObjectContext) {
//        let request = Dish.request()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//
//        do {
//            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
//            try persistentStoreCoordinator.execute(deleteRequest, with: context)
//            save(context)
//
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    static func save(_ context:NSManagedObjectContext) {
//        guard context.hasChanges else { return }
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Unresolved error \(error), \(error.userInfo)")
//        }
//    }
//
//    static func exists(title: String,
//                       _ context:NSManagedObjectContext) -> Bool? {
//        let request = Dish.request()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
//        request.predicate = predicate
//
//        do {
//            guard let results = try context.fetch(request) as? [Dish]
//            else {
//                return nil
//            }
//            return results.count > 0
//        } catch (let error){
//            print(error.localizedDescription)
//            return false
//        }
//    }
//
//}
