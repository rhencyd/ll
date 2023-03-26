//
//  ItemCartPreview.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/17/23.
//

import SwiftUI

struct ItemCartPreview: View {
    
    
    
    @State var isCustomized:Bool = false
    
    @State var dish: ItemAdded
    @Binding var stepperValue: Int
    @State var subtotal: Double = 0
    
    var body: some View {
        
        HStack {
            HStack {
                ImageDownloaded(
                    url: dish.dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", key: "\(dish.dish.id)")
                
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                
                HStack {

                    VStack(alignment: .leading) {
                        
                        Text(dish.dish.title ?? "Title")
                            .cardTitle()
                        
                        Spacer()
                        
                        // Extras
                        ScrollView {
                            
                            if !dish.extraItem.isEmpty {
                                
                                ForEach(dish.extraItem) { item in
                                    HStack {
                                        Text("\(item.extraItemTitle)")
                                            .paragraphText()
                                            .frame(width: 90, alignment: .leading)
                                        
                                        Text("Qty: \(item.extrItemQty)")
                                            .paragraphText()
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                Spacer()
                            } else {
                                Text(dish.dish.itemDescription ?? "Item Description").paragraphText()
                            }
                        }
                        
                        Spacer()
                    }
                    
                }
                .onAppear {
                    subtotal = dish.subTotal
                }
            }
            
            Spacer()
            
            // Item Price and custom stepper
            VStack(alignment: .trailing) {
                Spacer()
                
                // Item price with alignment topTrailing
                Text("$\(String(format: "%.2f", subtotal))")
                    .leadText()
                    .foregroundColor(Color("PrimaryColor1"))
                
                
                Spacer()
                
                CustomStepper(
                    stepperValue: $stepperValue,
                    needStroke: false, fillColor: Color("SecundaryColor3"))
//                .onTapGesture {
//                    dish.subTotal = dish.subTotal * Double((stepperValue / dish.dishQty))
//                }
                .onChange(of: stepperValue) { newValue in
                    subtotal = dish.subTotal * Double(stepperValue)
                    print(stepperValue)
                    print(subtotal)
                }
            }
        }
        .frame(height: 90)
    }
}
    

struct ItemCartPreview_Previews: PreviewProvider {
    
    static let context = PersistenceController.shared.container.viewContext
    
    let extraItem1 = ExtraItemsModel(extraItemPrice: "1.60", extraItemTitle: "Avocado", extrItemQty: 0)
    
    static var dish: ItemAdded = ItemAdded(extraItem: oneExtraItem(), dish: oneDish(), dishQty: 2, specialRequest: "", subTotal: 14.56)
    
    static var previews: some View {
        ItemCartPreview(dish: dish, stepperValue: .constant(1))
    }
    
    
    static func oneExtraItem() -> [ExtraItemsModel] {
        var extraItems: [ExtraItemsModel] = []
        let extraItem1 = ExtraItemsModel(extraItemPrice: "1.60", extraItemTitle: "Avocado", extrItemQty: 0)
        let extraItem2 = ExtraItemsModel(extraItemPrice: "1.00", extraItemTitle: "Seeds", extrItemQty: 0)
        
        extraItems.append(extraItem1)
        extraItems.append(extraItem2)
        return extraItems
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
