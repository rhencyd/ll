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
    @StateObject var itemAddedViewModel: ItemAddedViewModel = ItemAddedViewModel()
    @StateObject var vm: DishesFiltering = DishesFiltering()
    @StateObject var hamburguerMenu: HamburguerMenu = HamburguerMenu()
    
    let persistenceController = PersistenceController.shared
    
    
    var body: some View {
        
        ZStack {
            VStack {
                
                HeroSection()
                    .environmentObject(vm)
                MenuBreakDown()
                    .environmentObject(vm)
                Menu()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(vm)

            }
            .offset(y: -45)
            
            
            HamburgerMenu()
                .padding(.trailing, 120)
                .offset(x: hamburguerMenu.showSideMenu ? 0 : -500)
                .animation(.spring(), value: hamburguerMenu.showSideMenu)
                .environmentObject(hamburguerMenu)
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                if itemAddedViewModel.cartItemsNumber > 0 || screenNavigator.guestModeOn {
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
                    
                    if hamburguerMenu.showSideMenu {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("PrimaryColor1"))
                            .offset(x: 10)
                    } else {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .foregroundColor(Color("PrimaryColor1"))
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                
                if hamburguerMenu.showSideMenu {
                    Text("")
                } else {
                    Image("littleLemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
            }
            
        }
        
        
        //            .environmentObject(itemAddedViewModel)
        .edgesIgnoringSafeArea(.bottom)
        
        .navigationDestination(for: ScreenNavigationValue.self) { screen in
            switch screen {
            case .userProfile: UserProfile()
            case .home: Home()
            case .welcome: Welcome()
            case .cartView:
                CartView()
                    .environmentObject(itemAddedViewModel)
                    .environmentObject(extraItemsViewModel)
            case .dishView(let dish):
                DishView(dish: dish)
                    .environmentObject(extraItemsViewModel)
                    .environmentObject(itemAddedViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ItemAddedViewModel())
            .environmentObject(NavigationStateManager())
    }
}
