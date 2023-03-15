////
////  DishesModel.swift
////  FoodOrderingApp
////
////  Created by Rhency Delgado on 3/13/23.
////
//
//import Foundation
//import CoreData
//

import SwiftUI

class DishesModel: ObservableObject {
    
    @Published var menuItems: [MenuItem] = []
    
    init () {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else { return }
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let fullMenu =  try? JSONDecoder().decode(MenuList.self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.menuItems = fullMenu.menu
                }
            } else {
                print("No data returned.")
            }
        }

    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping(_ data: Data?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
                
            else {
                print("Error Downloading data")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }.resume()
    }
}


//@MainActor class DishesModel: ObservableObject {
//
//    @Published var menuItems = [MenuItem]()
//
//    func reload(_ coreDataContext:NSManagedObjectContext) async {
//        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
//        let urlSession = URLSession.shared
//
//        do {
//            let (data, _) = try await urlSession.data(from: url)
//            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
//            menuItems = fullMenu.menu
//
//
//            // populate Core Data
//
//
//            Dish.deleteAll(coreDataContext)
//            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
//
//        }
//        catch {
//            print(String(describing: error))
//        }
//    }
//}
//
//
//
//
//
////    func getMenuData(_ coreDataContext: NSManagedObjectContext) {
////
////        persistence.clear()
////
////        let littleLemonAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
////        let url = URL(string: littleLemonAddress)
////
////        let request = URLRequest(url: url!)
////
////        let task = URLSession.shared.dataTask(with: request) { data, respone, error in
////            if let data = data,
////               let items = try? JSONDecoder().decode(MenuList.self, from: data) {
////                menuItems = items.menu
////                for dish in menuItems {
////                    let newDish = Dish(context: coreDataContext)
////                    newDish.title = dish.title
////                    newDish.category = dish.category
////                    newDish.price = dish.price
////                    newDish.itemDescription = dish.description
////                    newDish.image = dish.image
////                    try? coreDataContext.save()
////                }
////            }
////
////               let dataString = String(data: data, encoding: .utf8) {
////                print(dataString)
////            }
////        }
////        task.resume()
////    }
////}
