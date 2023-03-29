//
//  DishModelData.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/15/23.
//

import Foundation
import SwiftUI

struct ExtraItemsModel: Identifiable, Equatable {
    
    var extraItemPrice : String
    var extraItemTitle: String
    var extrItemQty: Int
    var id = UUID()
    
}

class ExtraItemsViewModel: ObservableObject {
    
    @Published var extraItemsArray: [ExtraItemsModel] = []
    
    init() {
        getExtraItems()
    }
    
    func getExtraItems() {
        
        let extraItem1 = ExtraItemsModel(extraItemPrice: "1.60", extraItemTitle: "Avocado", extrItemQty: 0)
        let extraItem2 = ExtraItemsModel(extraItemPrice: "1.00", extraItemTitle: "Seeds", extrItemQty: 0)
        let extraItem3 = ExtraItemsModel(extraItemPrice: "0.55", extraItemTitle: "Dressing", extrItemQty: 0)
        
        self.extraItemsArray.append(extraItem1)
        self.extraItemsArray.append(extraItem2)
        self.extraItemsArray.append(extraItem3)
    }
    
}

class DishesFiltering: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var startersfilter: Bool = false
    @Published var mainsfilter: Bool = false
    @Published var dessertsfilter: Bool = false
    @Published var sidesfilter: Bool = false
    
}

class HamburguerMenu: ObservableObject {
    @Published var showSideMenu: Bool = false
}
