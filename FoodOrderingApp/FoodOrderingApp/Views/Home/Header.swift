//
//  Header.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct Header: View {
    
    @EnvironmentObject var hamburguerMenu: HamburguerMenu
    
    var navigationValue: ScreenNavigationValue
    var view: AnyView
    
    
    
    var body: some View {
        
        HStack {
            
//            NavigationLink {
//                Color.red
//            } label: {
//                Image(systemName: "list.bullet")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 35)
//                    .foregroundColor(Color("PrimaryColor1"))
//            }
//
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

            
            Spacer()
            
            Image("littleLemonLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            Spacer()
        
            
            NavigationLink(value: navigationValue) {
                view
            }
            
        }
        .padding(.horizontal, 20)
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(navigationValue: ScreenNavigationValue.userProfile,view: AnyView(Image(systemName: "heart")))
            .environmentObject(HamburguerMenu())
    }
}
