//
//  Onboarding.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI

struct Onboarding: View {
    
    
    @State private var tabSelection: TabBarITem = TabBarITem(title: "sign in")
    
    var body: some View {
        CustomTabBarContainer(selection: $tabSelection) {
            SignInForm()
                .tabBarItem(tab: TabBarITem(title: "sign in"), selection: $tabSelection)
            
            SignUpForm()
                .tabBarItem(tab: TabBarITem(title: "sign up"), selection: $tabSelection)
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
