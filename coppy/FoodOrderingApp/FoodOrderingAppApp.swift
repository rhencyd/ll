//
//  FoodOrderingAppApp.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/2/23.
//

import SwiftUI

@main
struct FoodOrderingAppApp: App {
    
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            IntroView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
