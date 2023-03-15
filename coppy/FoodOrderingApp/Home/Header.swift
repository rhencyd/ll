//
//  Header.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct Header: View {
    
//    @EnvironmentObject var navigationStateManager: NavigationStateManager
    
    var body: some View {
        
        HStack {
            
            NavigationLink {
                Color.red
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
        
            
            NavigationLink(value: ScreenNavigationValue.userProfile) {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(Color("PrimaryColor1"))
            }
            
        }
       
        
        .padding(.horizontal, 20)
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
