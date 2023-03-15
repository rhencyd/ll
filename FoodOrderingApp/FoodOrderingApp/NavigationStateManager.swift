//
//  NavigationStateManager.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/11/23.
//

import Foundation
import SwiftUI

enum ScreenNavigationValue: Hashable, Codable {
    case home
    case userProfile
    case welcome
}

class NavigationStateManager: ObservableObject {
    
    @Published var selectionPath: [ScreenNavigationValue] = []
    
    
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
