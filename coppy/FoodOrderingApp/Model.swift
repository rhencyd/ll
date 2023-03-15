//
//  Model.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    let dishes = [
    MenuItem(id: 1, title: "Pabellon", description: "lo", price: "2", image: "Hero Image", category: "desserts")
    ]
    
    
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: kIsLoggedIn)
    @Published var isLoggedOut: Bool = true
    @Published var search: String = ""
    @Published var path:NavigationPath = NavigationPath()
}
