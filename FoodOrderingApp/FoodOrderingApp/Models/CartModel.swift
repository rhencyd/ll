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
    
//    var id: Int
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
//    @Published var id: Int = 0
    
    
    func addItemToCart(extras: [ExtraItemsModel], dish: DishEntity, qty: Int, request: String, subTotal: Double) {
        
//        id = itemAdded.count
        
        let newItem = ItemAdded(extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
//        let newItem = ItemAdded(id: id, extraItem: extras, dish: dish, dishQty: qty, specialRequest: request, subTotal: subTotal)
        self.itemAdded.append(newItem)
        self.cartItemsNumber = itemAdded.count
        
//        self.id = self.cartItemsNumber
        
        
    }
    
    func deleteItem(index: IndexSet) {
        itemAdded.remove(atOffsets: index)
        self.cartItemsNumber = itemAdded.count
        getSubtotal()
//        id -= 1
    }
    
    func getSubtotal() {
        subTotal = 0
        for dish in itemAdded {
            subTotal += dish.subTotal
        }
    }
    
    func updateDish() {
        
    }
    
//    public func item(id: ItemAdded.ID) -> ItemAdded {
//        itemAdded[id]
//    }
    
//    public func itemBinding(id: ItemAdded.ID) -> Binding<ItemAdded> {
//        Binding<ItemAdded> {
//            self.itemAdded[id]
//        } set: { newValue in
//            self.itemAdded[id] = newValue
//        }
//    }
    
}

