//
//  UserProfile.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct UserProfile: View {
        
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    
    private let firstName = UserDefaults.standard.string(forKey: kFirstName)
    private let lastName = UserDefaults.standard.string(forKey: kLastName)
    private let email = UserDefaults.standard.string(forKey: kEmail)
    private let line1 = UserDefaults.standard.string(forKey: kLine1)
    private let line2 = UserDefaults.standard.string(forKey: kLine2)
    private let city = UserDefaults.standard.string(forKey: kCity)
    private let state = UserDefaults.standard.string(forKey: kState)
    private let zipCode = UserDefaults.standard.string(forKey: kZipCode)
    private let password = UserDefaults.standard.string(forKey: kPassword)
    
    var body: some View {
        
        ScrollView {
            
            Section {
                VStack {
                    // wait
        
                }
            } header: {
                Text("Personal Info").formHeaderSection()
            }

        }
        
        VStack {
            
            Text("Personal Information")
            Image("profile-image-placeholder")
            
            Text(firstName ?? "First Name")
            Text(lastName ?? "Last Name")
            Text(email ?? "youremail@example.com")

//            Text("Screen # \(navigationStateManager.path.count)")
//            Text("User defaults logged in? - \(UserDefaults.standard.bool(forKey: kIsLoggedIn).description)")
            
            
//            NavigationLink(value: ScreenNavigationValue.welcome) {
//                Text("Logout").primaryButton()
//            }.onTapGesture {
//                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
//            }
            
            Button {
                withAnimation(.spring()) {
                    isCurrentUserSignedIn = false
                }
            } label: {
                Text("Logout").primaryButton()
            }
            
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
        static var previews: some View {
            UserProfile()
                .environmentObject(NavigationStateManager())
    }
}
