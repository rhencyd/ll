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
        VStack {
            Header()
            HeroSection()
            MenuBreakDown()
            Menu()
            Text("User defaults logged in? - \(UserDefaults.standard.bool(forKey: kIsLoggedIn).description)")
            Spacer()
        }.onAppear(perform: {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) == false {
                isLoggedOut = true
            }
        })
        
        .navigationDestination(isPresented: $isLoggedOut) {
            Welcome()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(NavigationStateManager())
    }
}
