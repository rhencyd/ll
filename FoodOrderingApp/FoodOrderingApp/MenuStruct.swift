//
//  MenuStruct.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import Foundation


struct JSONMenu: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}

struct MenuItem: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id, description, price, image, category,
        title
    }
    
}

