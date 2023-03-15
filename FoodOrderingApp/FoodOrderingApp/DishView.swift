//
//  MenuItem.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct DishView: View {
    
    
    var body: some View {
        VStack {
            Text("Dish name")
            HStack{
                VStack {
                    Text("Description")
                    Spacer()
                    Text("Price")
                }
                Spacer()
                Image("Hero image")
                    .resizable().scaledToFit()
            }
            .padding(.horizontal,20)
        }
        .frame(height: 120)
    }
}

struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        DishView()
    }
}
