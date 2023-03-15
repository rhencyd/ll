//
//  MenuItem.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct DishView: View {
    
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
//                Image(dish.image ?? "Greek salad")
//                AsyncImage(url: URL(string: dish.image!)) { image in
//                    image.resizable()
//                } placeholder: {
//                    ProgressView()
//                }
//                    .scaledToFill()
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(8)
                
                
                AsyncImage(url: URL(string: dish.image!)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                            image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "questionmark")
                            .font(.headline)
                    default:
                        Image(systemName: "questionmark")
                            .font(.headline)
                    }
                }
                
                
            }
        .frame(height: 120)
    }
}

struct MenuItem_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = DishEntity(context: context)
    static var previews: some View {
        DishView(dish: oneDish())
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

