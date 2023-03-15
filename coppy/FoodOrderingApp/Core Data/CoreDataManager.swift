//
//  CoreDataManager.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/13/23.
//

import SwiftUI
import CoreData


class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedDishes: [DishEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DishContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<DishEntity>(entityName: "DishEntity")
        do {
           savedDishes = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addDish(menuItems: [MenuItem]) {
        for dish in menuItems {
            let newDish = DishEntity(context: container.viewContext)
            newDish.title = dish.title
            newDish.category = dish.category
            newDish.price = dish.price
            newDish.itemDescription = dish.description
            newDish.image = dish.image
            saveData()
        }
    }
    
    func deleteDish(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedDishes[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateDish(entity: DishEntity) {
        let currentTitle = entity.title ?? ""
        let newTitle = currentTitle
        entity.title = newTitle
        saveData()
    }
    
    func saveData() {
        do {
          try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error Saving: \(error)")
        }
        
    }
    
}


struct CoreDataManager: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoreDataManager_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataManager()
    }
}
