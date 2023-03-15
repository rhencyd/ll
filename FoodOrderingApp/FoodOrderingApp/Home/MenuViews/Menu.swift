//
//  Menu.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI
import Foundation


struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dishesModel = DishesModel()
    let persistenceController = PersistenceController.shared
    
    
    
    var body: some View {
        
            FetchedObjects {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        DishView(dish)
                    }
                }
            }
            .onAppear(perform: {
                persistenceController.clear()
            })
        
            .scrollContentBackground(.hidden)
        
        .task {
            await
            dishesModel.reload(viewContext)
        }
        .environment(\.managedObjectContext, viewContext)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
    
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
