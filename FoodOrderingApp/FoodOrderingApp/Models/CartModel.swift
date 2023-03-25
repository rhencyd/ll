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
    let specialRequest: String?
    let subTotal: Double
}

class ItemAddedViewModel: ObservableObject {
    
    @Published var itemAdded = [ItemAdded]()
    @Published var cartItemsNumber: Int = 0
        
    
    
    func addItemToCart(extras: [ExtraItemsModel], dish: DishEntity, qty: Int, request: String?, subTotal: Double) {
        
        let newItem = ItemAdded(extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
        self.itemAdded.append(newItem)
        self.cartItemsNumber += 1
        
    }
}

