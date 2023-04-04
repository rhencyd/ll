//
//  MenuItem.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct DishPreView: View {
    
    var dish: DishEntity
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading) {
                Text(dish.title ?? "Dish").cardTitle()
                Spacer()
                
                Text(dish.itemDescription ?? "Description").paragraphText()
                Spacer()
                HStack(spacing: 4) {
                    Text("$").leadText()
                    Text(dish.price ?? "10").leadText()
                    Spacer()
                    
                }
            }
            Spacer()
            
            ImageDownloaded(
                url: dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", key: "\(dish.id)")
            .scaledToFill()
            .frame(width: 90, height: 90)
            .cornerRadius(8)
            
        }
        .frame(height: 120)
    }
}

struct MenuItem_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = DishEntity(context: context)
    static var previews: some View {
        DishPreView(dish: oneDish())
    }
    static func oneDish() -> DishEntity {
        let dish = DishEntity(context: context)
        dish.title = "Greek Salad"
        dish.itemDescription = "The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons"
        dish.image = "Greek salad"
        dish.price = "12"
        return dish
    }
}

