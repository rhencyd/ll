//
//  Onboarding.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI
struct Welcome: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        
            VStack {
                
                Image("OnBoardingImage")
                    .resizable().scaledToFill()
                    .frame(height: 314)
                
                Spacer()
                
                if isLoading {
                    Image("little-lemon-logo")
                        .resizable().scaledToFit()
                        .frame(height: 200)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isLoading.toggle()
                            }
                        }
                } else {
                    Onboarding()
                }
                
                Spacer()
                
            }
            
            .onAppear{
                isLoading.toggle()
            }
            
            .navigationDestination(for: ScreenNavigationValue.self) { screen in
                switch screen {
                case .userProfile: UserProfile()
                case .home: Home()
                case .welcome: Welcome()
                case .cartView: Text("Cart View")
                case .dishView: Text("Dish View")
                }
            }
            .toolbar(.hidden, for: .automatic)
    }
    
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}


