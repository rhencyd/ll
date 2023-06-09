//
//  TabItemProfilePicture.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/15/23.
//

import SwiftUI

struct TabItemProfilePicture: View {
    
    var image: String
    
    var body: some View {
        Image(image) // need to make it changeble
            .resizable()
            .clipShape(Circle())
            .scaledToFit()
            .frame(height: 45)
    }
}

struct TabItemCartImage: View {
    
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    
    var body: some View {
        
        ZStack {
            
            Image(systemName: "basket")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .foregroundColor(Color("PrimaryColor1"))
            
            if itemAddedViewModel.cartItemsNumber > 0 {
                ZStack {
                    Circle()
                        .frame(width: 18)
                        .foregroundColor(Color("PrimaryColor1"))
                    
                    Text(String(itemAddedViewModel.cartItemsNumber))
                        .font(Font.custom("Karla-Bold", size: 13))
                        .foregroundColor(Color("PrimaryColor2"))
                    
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom, 0.5)
            }
            
        }
        .frame(width:45, height: 45)
    }
}

struct TabItemProfilePicture_Previews: PreviewProvider {
    
    @State static var numberOfItems: Int = 3
    
    static var previews: some View {
        TabItemCartImage()
            .environmentObject(CartViewModel())
    }
}
