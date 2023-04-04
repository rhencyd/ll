//
//  Home.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var screenNavigator: NavigationStateManager
    @StateObject private var extraItemsViewModel: ExtraItemsViewModel = ExtraItemsViewModel()
    @StateObject var itemAddedViewModel: CartViewModel = CartViewModel()
    @StateObject var vm: DishesFiltering = DishesFiltering()
    @StateObject var checkoutViewModel: CheckoutViewModel = CheckoutViewModel()
    @StateObject private var mapAPI: MapAPI = MapAPI()
    @EnvironmentObject var hamburguerMenu: HamburguerMenu
    
    @State var isHistory: Bool = false
    
    
    var body: some View {
        
        VStack {
            
            HeroSection()
                .onAppear {
                    PersistenceController.shared.clear()
                }
            
            MenuBreakDown()
            
            Menu()
            
        }
        .environmentObject(vm)
        
        
        .padding(.top, 5)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        
        
        .onAppear(perform: {
            screenNavigator.cartErased = false
        })
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                if itemAddedViewModel.cartItemsNumber >= 1 || screenNavigator.guestModeOn {
                    NavigationLink(value: ScreenNavigationValue.cartView) {
                        TabItemCartImage()
                            .environmentObject(itemAddedViewModel)
                            .environmentObject(hamburguerMenu)
                    }
                } else {
                    NavigationLink(value: ScreenNavigationValue.userProfile) {
                        TabItemProfilePicture(image: "profile-image-placeholder")
                    }
                }
            }
            
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                    withAnimation(Animation.spring()) {
                        hamburguerMenu.showSideMenu.toggle()
                    }
                } label: {
                    
                    Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .foregroundColor(Color("PrimaryColor1"))
                    
                }
            }
            
            ToolbarItem(placement: .principal) {
                
                Image("littleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                
            }
            
        }
        
        .navigationDestination(for: ScreenNavigationValue.self) { screen in
            switch screen {
            case .userProfile:
                UserProfile()
            case .home: Home()
            case .welcome: Welcome()
            case .cartView:
                CartView()
                    .environmentObject(itemAddedViewModel)
                    .environmentObject(extraItemsViewModel)
                    .environmentObject(mapAPI)
            case .dishView(let dish):
                DishView(dish: dish)
                    .environmentObject(extraItemsViewModel)
                    .environmentObject(itemAddedViewModel)
            case .editCart(let item):
                EditDishView(dish: item)
                    .environmentObject(itemAddedViewModel)
                
            case .checkout:
                CheckOutView()
                    .environmentObject(itemAddedViewModel)
                    .environmentObject(checkoutViewModel)
                    .environmentObject(mapAPI)
                
            case .confirmation(let orders):
                ConfirmationView(orders: orders)
                    .environmentObject(checkoutViewModel)
                    .environmentObject(itemAddedViewModel)
                    .environmentObject(mapAPI)
                
            case .payment:
                PaymentScreen()
                    .environmentObject(checkoutViewModel)
                    .environmentObject(itemAddedViewModel)
                
            case .history:
                HistoryView()
                    .environmentObject(checkoutViewModel)
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(CartViewModel())
            .environmentObject(NavigationStateManager())
    }
}
