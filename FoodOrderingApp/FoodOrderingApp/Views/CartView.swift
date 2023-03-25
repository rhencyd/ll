//
//  CartView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/17/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var itemAddedViewModel: ItemAddedViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            List {
                ForEach($itemAddedViewModel.itemAdded) { $item in
                    ItemCartPreview(dish: item, stepperValue: $item.dishQty)
                }
            }
            .offset(y: -2)
//            .offset(y: -45)
            .listStyle(.plain)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Order Now").primaryButton()
            }

        }
        
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("PrimaryColor1"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("My Cart".uppercased())
                    .font(Font.custom("MarkaziText-SemiBold", size: 25))
                    .foregroundColor(Color("PrimaryColor1"))
            }
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ItemAddedViewModel())
    }
}
