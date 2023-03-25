//
//  DishesModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/13/23.
//

import SwiftUI

class ServerDataViewModel {
    
    static let instance = ServerDataViewModel() // Singleton
    
    @Published var menuItems: [MenuItem] = []
    
    private init () {
        getData() // get data from the url defined below
    }
    
    func getData() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else { return }
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let fullMenu =  try? JSONDecoder().decode(MenuList.self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.menuItems = fullMenu.menu
                    print("Data Sucssesfully Downloaded")
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
