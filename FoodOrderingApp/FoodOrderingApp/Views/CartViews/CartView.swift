//
//  CartView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/17/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var mapAPI: MapAPI
    @Environment(\.dismiss) var dismiss
    
    @State var isEditOn: Bool = false
    @State var numberOfItems: Int = 0
    
    @AppStorage("line1_address") var currentUserLine1: String?
    
    
    @State var cartSubTotal: Double = 0
    
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
                    
                    Button {
                        dismiss()
                        navigationStateManager.cartErased.toggle()
                    } label: {
                        Text("Add dishes to my cart!").primaryButton()
                    }
                }
                .toolbar(.hidden)
                
            } else {
                
                if isEditOn {
                    
                    ZStack {
                        
                        VStack {
                            
                            Rectangle()
                                .foregroundColor(Color("PrimaryColor1"))
                                .frame(maxHeight: .infinity)
                            
                            
                            VStack {
                                List {
                                    
                                    ForEach($itemAddedViewModel.itemAdded) { $item in
                                        
                                        NavigationLink(value: ScreenNavigationValue.editCart(item)) {
                                            ItemCartPreview(dish: item, isEditOn: true, stepperValue: $item.dishQty, subTotal: $item.subTotal)
                                        }
                                    }
                                    
                                }
                                .listStyle(.plain)
                                
                                HStack {
                                    
                                    Text("Subtotal")
                                        .cardTitle()
                                    
                                    Spacer()
                                    
                                    Text("$ \(String(format: "%.2f", itemAddedViewModel.subTotal))")
                                        .cardTitle()
                                    
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 45)
                                
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.81)
                            .onAppear {
                                numberOfItems = 0
                            }
                            
                        }
                        
                        Text("Item updated!")
                            .font(Font.custom("Karla-Bold", size: 18))
                            .foregroundColor(Color("HighlightColor2"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color("PrimaryColor2"))
                            .opacity(itemAddedViewModel.isItemChanged ? 1 : 0)
                            .offset(y: itemAddedViewModel.isItemChanged ? 0 : 400 )
                            .animation(
                                Animation.easeInOut(duration: 1),
                                value: itemAddedViewModel.isItemChanged)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    itemAddedViewModel.isItemChanged = false
                                }
                            }
                    }
                    
                    .toolbarBackground(.hidden)
                    .edgesIgnoringSafeArea(.top)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    
                }
                else {
                    
                    VStack {
                        
                        List {
                            ForEach($itemAddedViewModel.itemAdded) { $item in
                                
                                ItemCartPreview(dish: item, isEditOn: false, stepperValue: $item.dishQty, subTotal: $item.subTotal)
                                
                            }
                            
                            .onDelete(perform: itemAddedViewModel.deleteItem)
                            
                            Button {
                                dismiss()
                                navigationStateManager.cartErased.toggle()
                            } label: {
                                Text("Add another dish!").secondaryButton()
                            }
                        }
                        .listStyle(.plain)
                        .padding(.top, 5)
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("Subtotal")
                                .cardTitle()
                            
                            Spacer()
                            
                            Text("$ \(String(format: "%.2f", itemAddedViewModel.subTotal))")
                                .cardTitle()
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        
                        NavigationLink(value: ScreenNavigationValue.checkout) {
                            Text("Checkout").primaryButton()
                        }
                        .simultaneousGesture(TapGesture().onEnded({ tap in
                            let address = currentUserLine1 ?? "2108 N CALIFORNIA AVE"
                            mapAPI.getLocation(address: address, delta: 0.1)
                            print(mapAPI.locations)
                        }))
                        .padding(.bottom, 10)
                        
                    }
                    .toolbarBackground(.white, for: .navigationBar)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        .navigationBarBackButtonHidden()
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                    isEditOn ? isEditOn.toggle() : dismiss()
                    
                } label: {
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(!isEditOn ? Color("PrimaryColor1") :  Color("HighlightColor1"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(!isEditOn ? "My Cart".uppercased() : "Edit my cart".uppercased())
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(
                        !isEditOn ?
                        Color("HighlightColor2") :
                            Color("HighlightColor1"))
            }
            
            if !isEditOn && itemAddedViewModel.cartItemsNumber > 0 {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEditOn.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("PrimaryColor1"))
                    }
                    
                }
                
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
            .environmentObject(NavigationStateManager())
    }
}
