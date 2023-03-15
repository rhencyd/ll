//
//  MenuItem.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct DishView: View {
    
    @ObservedObject private var dish: Dish
    
    init(_ dish: Dish) {
        self.dish = dish
    }
    
    
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
//                Image(dish.image ?? "Greek salad")
                AsyncImage(url: URL(string: dish.image!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .cornerRadius(8)
                
            }
        .padding(.horizontal,20)
        .frame(height: 120)
    }
}

struct MenuItem_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DishView(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Greek Salad"
        dish.itemDescription = "The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons"
        dish.image = "Greek salad"
        dish.price = "12"
        return dish
    }
}

