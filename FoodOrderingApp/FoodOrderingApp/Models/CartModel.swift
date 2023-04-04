//
//  CartModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/16/23.
//

import Foundation
import SwiftUI
import Combine

struct ItemAdded: Identifiable, Hashable, Equatable {
    
    var id = UUID()
    var extraItem: [ExtraItemsModel]
    let dish: DishEntity
    var dishQty: Int
    var specialRequest: String
    var subTotal: Double
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ItemAdded, rhs: ItemAdded) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class CartViewModel: ObservableObject {
    
    @Published var itemAdded = [ItemAdded]()
    @Published var cartItemsNumber: Int = 0
    @Published var subTotal: Double = 0
    @Published var isItemChanged: Bool = false
    @Published var orderSubtotal: Double = 0

    
    
    func addItemToCart(extras: [ExtraItemsModel], dish: DishEntity, qty: Int, request: String, subTotal: Double) {

        let newItem = ItemAdded(extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
        self.itemAdded.append(newItem)
        self.cartItemsNumber = itemAdded.count

    }
    
    func deleteItem(index: IndexSet) {
        itemAdded.remove(atOffsets: index)
        self.cartItemsNumber = itemAdded.count
        getSubtotal()
    }
    
    func getSubtotal() {
        subTotal = 0
        for dish in itemAdded {
            subTotal += dish.subTotal
        }
    }
    
    func updateDish() {
        
    }
    
}

