//
//  Home.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var screenNavigator: NavigationStateManager
    @State var isLoggedOut: Bool = false
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Header()
                HeroSection()
                MenuBreakDown()
                Menu()
                Spacer()
            }
            .navigationDestination(for: ScreenNavigationValue.self) { screen in
                switch screen {
                case .userProfile: UserProfile()
                case .home: Home()
                case .welcome: Welcome()
                }
            }
        }
        
        
//        .onAppear(perform: {
//            //persistence.clear()
//            if UserDefaults.standard.bool(forKey: kIsLoggedIn) == false {
//                isLoggedOut = true
//            }
//        })
//
//        .navigationDestination(isPresented: $isLoggedOut) {
//            Welcome()
//        }
        
        
        
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(NavigationStateManager())
    }
}
