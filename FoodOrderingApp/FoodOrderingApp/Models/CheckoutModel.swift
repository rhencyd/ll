//
//  CheckoutModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 4/1/23.
//

import Foundation

struct CheckoutOrder: Identifiable, Equatable, Hashable  {
    
    let id = UUID()
    let items: [ItemAdded]
    let total: Double
    let deliveryOption: Bool
    let dropOffOption: DropOffOption
    let pickUpOption:Bool
    let deliveryInstructions: String
    let courierTip: Double
    let deliveryFee: Double
    let deliverytime: Double
    let deliveryAddress: String
    let pickUpAddress: String
    let pickUpTime: Date
    let pickUpSpecialRequest: String
    let nameofOrder: String
    let emailOrder: String
    let orderNumber: Int
}

enum DropOffOption {
    case handIt
    case leaveIt
}


class CheckoutViewModel: ObservableObject {
    
    @Published var order = [CheckoutOrder]()
    @Published var history = [CheckoutOrder]()
    @Published var isHistory: Bool = false
    
    func getOrder(items: [ItemAdded], total: Double, deliveryOption: Bool, dropOffOption: DropOffOption, pickUpOption: Bool, deliveryInstructions: String, courierTip: Double, deliveryFee: Double, deliverytime: Double, deliveryAddress: String, pickUpAddress: String, pickUpTime: Date, pickUpSpecialRequest: String, nameofOrder: String, emailOrder: String) {
        
        self.order = []
        
        let orderNumber = Int.random(in: 0...99999999999)
        
        let newOrder =
        CheckoutOrder(
            items: items,
            total: total,
            deliveryOption: deliveryOption,
            dropOffOption: dropOffOption,
            pickUpOption: pickUpOption,
            deliveryInstructions: deliveryInstructions,
            courierTip: courierTip,
            deliveryFee: deliveryFee,
            deliverytime: deliverytime,
            deliveryAddress: deliveryAddress,
            pickUpAddress: pickUpAddress,
            pickUpTime: pickUpTime,
            pickUpSpecialRequest: pickUpSpecialRequest,
            nameofOrder: nameofOrder,
            emailOrder: emailOrder,
            orderNumber: orderNumber)
        
        self.order.append(newOrder)
        
    }
    
}

