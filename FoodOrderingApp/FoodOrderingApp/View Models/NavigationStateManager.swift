//
//  NavigationStateManager.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/11/23.
//

import Foundation
import SwiftUI

enum ScreenNavigationValue: Hashable {
    case home
    case userProfile
    case welcome
    case dishView(DishEntity)
    case cartView
}

class NavigationStateManager: ObservableObject {
    
    @Published var selectionPath = [ScreenNavigationValue]()
    @Published var guestModeOn: Bool = false
    @Published var cartErased: Bool = false
    
    
    
    func popToRoot() {
        selectionPath = []
    }
    
    func goToHome() {
        selectionPath = [ScreenNavigationValue.home]
    }
    
    func seeUser() {
        selectionPath = [ScreenNavigationValue.userProfile]
    }
    
}
