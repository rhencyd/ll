//
//  HamburgerMenu.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/20/23.
//

import SwiftUI

struct HamburgerMenuView: View {
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @AppStorage("first_name") var currentUserFirstName: String?
    @AppStorage("last_name") var currentUserLastName: String?
    
    @EnvironmentObject var hamburguerMenu: HamburguerMenu
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            
            Button {
                hamburguerMenu.showSideMenu.toggle()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("PrimaryColor1"))
            }
            .padding(.top, 20)
            .padding(.bottom, 40)

            
            if isCurrentUserSignedIn {
                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFit()
                        .frame(width: 80)
                        .padding(.trailing, 10)
                    
                    
                    HStack {
                        Text(currentUserFirstName ?? "Paola")
                    }
                    .font(Font.custom("Karla-Bold", size: 22))
                    .foregroundColor(Color("PrimaryColor1"))
                    .padding(.trailing, -20)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, -20)
            } else {
                Button {
                    navigationStateManager.guestModeOn = false
                    hamburguerMenu.showSideMenu.toggle()
                    
                } label: {
                    Text("Sign In / Sign up").primaryButton()
                }
            }
            
            
            Rectangle()
                .foregroundColor(Color("PrimaryColor1"))
                .cornerRadius(1)
                .padding(.horizontal, -15)
                .frame(maxWidth: .infinity)
                .frame(height: 3)
                .padding(.bottom,20)
            
            // Account
            
            
            if isCurrentUserSignedIn {
                
                Button {
                    hamburguerMenu.showSideMenu.toggle()
                    navigationStateManager.seeUser()
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "person")
                        Text("Account")
                            .cardTitle()
                        
                    }.foregroundColor(Color("PrimaryColor1"))
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "suit.heart")
                        Text("Favourite")
                            .cardTitle()
                        
                    }.foregroundColor(Color("PrimaryColor1"))
                }
                
            }
                Button {
                    hamburguerMenu.showSideMenu.toggle()
                    navigationStateManager.seeHistory()
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "clock")
                        Text("History")
                            .cardTitle()
                        
                    }.foregroundColor(Color("PrimaryColor1"))
                }
            
            
            Button {
                
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: "doc")
                    Text("Privacy policy")
                        .cardTitle()
                    
                }.foregroundColor(Color("PrimaryColor1"))
            }
            
            Button {
                
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: "info.circle")
                    Text("About")
                        .cardTitle()
                    
                }.foregroundColor(Color("PrimaryColor1"))
            }
            
            
            
            if isCurrentUserSignedIn {
                Button {
                    isCurrentUserSignedIn = false
                    PersistenceController.shared.clear()
                    hamburguerMenu.showSideMenu.toggle()
                    navigationStateManager.popToRoot()
                    
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                        Text("Log out")
                            .cardTitle()
                        
                    }.foregroundColor(Color("PrimaryColor1"))
                }
            }
            
            Spacer()
            
        }
        .padding(40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.regularMaterial)
        .onDisappear {
            hamburguerMenu.showSideMenu = false
        }
    }
}

struct HamburgerMenu_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerMenuView()
            .environmentObject(NavigationStateManager())
            .environmentObject(HamburguerMenu())
    }
}
