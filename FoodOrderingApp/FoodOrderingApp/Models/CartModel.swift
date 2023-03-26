//
//  CartModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/16/23.
//

import Foundation

struct ItemAdded: Identifiable {
    
    var id = UUID()
    let extraItem: [ExtraItemsModel]
    let dish: DishEntity
    var dishQty: Int
    var specialRequest: String?
    var subTotal: Double
}

class ItemAddedViewModel: ObservableObject {
    
    @Published var itemAdded = [ItemAdded]()
    @Published var cartItemsNumber: Int = 0
    
        
    
    
    func addItemToCart(extras: [ExtraItemsModel], dish: DishEntity, qty: Int, request: String?, subTotal: Double) {
        
        let newItem = ItemAdded(extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
        self.itemAdded.append(newItem)
        self.cartItemsNumber = itemAdded.count
    }
    
    func update(extras: [ExtraItemsModel], dish: DishEntity, qty: Int, request: String?, subTotal: Double, index: IndexSet) {
        
        let updatedItem = ItemAdded(extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
        
        deleteItem(index: index)
        
        self.itemAdded.append(updatedItem)
        
    }
    
    func deleteItem(index: IndexSet) {
        itemAdded.remove(atOffsets: index)
        self.cartItemsNumber = itemAdded.count
    }
}

