//
//  Menu.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI
import Foundation


struct Menu: View {
    
    @StateObject var coreDataViewModel = CoreDataViewModel()
    @StateObject var dishesModel = DishesModel()
    
//    var menuItems: [MenuItem] = [MenuItem(id: 1, title: "Hola", description: "aqui description", price: "este es el precio", image: "https://picsum.photos/200/300", category: "Desserts")]
    
//    @Environment(\.managedObjectContext) private var viewContext
//    @ObservedObject var dishesModel = DishesModel()
//    let persistenceController = PersistenceController.shared
    
    
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(coreDataViewModel.savedDishes) { dish in
                    DishView(dish: dish)
                }
                .onDelete(perform: coreDataViewModel.deleteDish)
            }
            .listStyle(.plain)
        }
        
//            FetchedObjects {
//                (dishes: [Dish]) in
//                List {
//                    ForEach(dishes, id: \.self) { dish in
//                        DishView(dish)
//                    }
//                }
//            }
//            .onAppear(perform: {
//                persistenceController.clear()
//            })
        
//            .scrollContentBackground(.hidden)
        
//        .task {
//            await
//            dishesModel.reload(viewContext)
        }
//        .environment(\.managedObjectContext, viewContext)
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)
//    }
    
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
