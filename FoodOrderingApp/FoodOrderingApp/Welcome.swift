//
//  Onboarding.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI



struct Welcome: View {
    
    @State var isLoading: Bool = false
    @State private var isLoggedIn: Bool = false
    @StateObject var navigationStateManager = NavigationStateManager()
    
    
    var body: some View {
        
        NavigationStack(path: $navigationStateManager.selectionPath) {
            
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
                
                Text("User defaults logged in? - \(UserDefaults.standard.bool(forKey: kIsLoggedIn).description)")
                Text("Screen # \(navigationStateManager.selectionPath.count)")
                
            }.onAppear{
                isLoading.toggle()
                
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            
            .navigationDestination(for: ScreenNavigationValue.self) { screen in
                switch screen {
                case .userProfile: UserProfile()
                case .home: Home()
                case .welcome: Welcome()
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }

            .toolbar(.hidden, for: .automatic)
        }
        .preferredColorScheme(.light)
        .environmentObject(navigationStateManager)
    }
    
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}


