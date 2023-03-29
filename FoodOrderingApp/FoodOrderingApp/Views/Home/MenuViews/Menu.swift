//
//  Menu.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI
import Foundation
import CoreData


struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var noMoreDishes: Bool = false
    @EnvironmentObject var vm: DishesFiltering
    
    
    var body: some View {
        
        VStack {
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) { (dishes: [DishEntity]) in
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            NavigationLink(value: ScreenNavigationValue.dishView(dish)) {
                                DishPreView(dish: dish)
                            }
                        }
                    }.listStyle(.plain)
                }
        }
        .onAppear {
            getMenuData()
            
        }
    }
    
    func getMenuData() {
        
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let getUrl = URL(string: url)!
        let urlRequest = URLRequest(url: getUrl)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let data = data {
                let menuData = try? JSONDecoder().decode(MenuList.self, from: data)
                
                let menuItems = menuData!.menu
                
                for dish in menuItems {
                    
                    do {
                        let request = NSFetchRequest<DishEntity>(entityName: "DishEntity")
                        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", dish.title)
                        request.predicate = predicate
                        
                        let numberOfRecords = try viewContext.count(for: request)
//                        print("Current Dishes in Core data for \(dish.title) : \(numberOfRecords)")
                        
                        if numberOfRecords == 0 {
                            let newDish = DishEntity(context: viewContext)
                            newDish.title = dish.title
                            newDish.category = dish.category
                            newDish.price = dish.price
                            newDish.itemDescription = dish.description
                            newDish.image = dish.image
                            newDish.id = Int32(dish.id)
                            try? viewContext.save()
//                            print("------------------Now saving \(dish.title) in core-------------------")
                        }
                    } catch {
                        print("Error saving context \(error)")
                    }
            }
            }
            
        }
        task.resume()
    }
    

    
    func buildPredicate() -> NSCompoundPredicate {
        return NSCompoundPredicate(type: .and,
                                   subpredicates: [dessertsFilter(),
                                                   sidesFilter(),
                                                   mainsFilter(),
                                                   startersFilter(),
                                                   searchTextFilter()
                                                              ])
    }
    

    func dessertsFilter() -> NSPredicate {
        return !vm.dessertsfilter ?
        NSPredicate(value: true) :
        NSPredicate(format: "category CONTAINS[cd] %@", "desserts")
    }
    
    func sidesFilter() -> NSPredicate {
        return !vm.sidesfilter ?
        NSPredicate(value: true) :
        NSPredicate(format: "category CONTAINS[cd] %@", "sides")
    }
    
    func mainsFilter() -> NSPredicate {
        return !vm.mainsfilter ?
        NSPredicate(value: true) :
        NSPredicate(format: "category CONTAINS[cd] %@", "mains")
    }
    
    func startersFilter() -> NSPredicate {
        return !vm.startersfilter ?
        NSPredicate(value: true) :
        NSPredicate(format: "category CONTAINS[cd] %@", "starters")
    }
    
    func searchTextFilter() -> NSPredicate {
        return vm.searchText.isEmpty ?
        NSPredicate(value: true) :
        NSPredicate(format: "title CONTAINS[cd] %@", vm.searchText)
    }
    
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
