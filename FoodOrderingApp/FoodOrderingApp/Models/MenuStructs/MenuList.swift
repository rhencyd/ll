//
//  MenuList.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/13/23.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
