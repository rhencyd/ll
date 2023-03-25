//
//  DownloadingDishesViewModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/18/23.
//

import Foundation
import Combine


class DownloadingDishesViewModel: ObservableObject {
    
    @Published var dataArray: [MenuItem] = []
    var cancelables = Set<AnyCancellable> ()
    
    let dataService = ServerDataViewModel.instance
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$menuItems
            .sink { [weak self] returnedMenuItems in
                self?.dataArray = returnedMenuItems
            }
            .store(in: &cancelables)
    }
    
}
