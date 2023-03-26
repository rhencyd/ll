//
//  CartView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/17/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var itemAddedViewModel: ItemAddedViewModel
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            if itemAddedViewModel.cartItemsNumber < 1 {
            
                VStack {
                    
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "basket")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color("PrimaryColor1"))

                        Image(systemName: "questionmark.bubble.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity, alignment: .top)
                            .foregroundColor(Color("HighlightColor2"))
                            .padding(.horizontal, -20)
                            .padding(.vertical, -20)
                            
                    }
                    .frame(width: 200, height: 200)
                    
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Your cart is empty!")
                            .font(Font.custom("Karla-Bold", size: 25))
                        
                        Text("Looks like you haven't added any dishes to your cart yet")
                            .paragraphText()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,80)
                    }
                    
                    Spacer()
                    
                }.offset(y: -1)

                
            } else {
                List {
                    ForEach($itemAddedViewModel.itemAdded) { $item in
                        ItemCartPreview(dish: item, stepperValue: $item.dishQty)
                    }
                    .onDelete(perform: itemAddedViewModel.deleteItem)
                }
                .offset(y: -1)
                .listStyle(.plain)
            }
            
            Spacer()
            
            if itemAddedViewModel.cartItemsNumber < 1 {
                Button {
                    navigationStateManager.goToHome()
                } label: {
                    Text("Add dishes to my cart!").primaryButton()
                }
            } else {
                Button {
//                    needs code
                } label: {
                    Text("Checkout").primaryButton()
                }
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
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(Color("HighlightColor2"))
            }
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ItemAddedViewModel())
            .environmentObject(NavigationStateManager())
    }
}
