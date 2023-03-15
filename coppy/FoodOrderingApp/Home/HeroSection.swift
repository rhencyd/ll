//
//  HeroSection.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct HeroSection: View {
    
    @State private var search: String = ""
    
    var body: some View {
        
        ZStack {
            // Background
            Color("PrimaryColor1")
            
            // Foreground
            
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Little Lemon")
                        .displayText()
                        .foregroundColor(Color("PrimaryColor2"))
                        .padding(.bottom, -30)
                    Text("Chicago")
                        .subTitle()
                        .foregroundColor(Color("HighlightColor1"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.bottom, -40)
                
                
                HStack (spacing: 20) {
                    VStack {
                        Spacer()
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .leadText()
                            .foregroundColor(Color("HighlightColor1"))
                        Spacer()
                    }
                    
                    Image("Hero image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 170)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 15)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $search)
                }
                .font(Font.custom("Karla-Regular", size: 16))
                .foregroundColor(Color("HighlightColor2"))
                .padding(12)
                .background(Color("HighlightColor1").cornerRadius(8))
                .disableAutocorrection(true)
                .padding(.horizontal,20)
                .padding(.bottom,20)
                
            }
            
            
        }
        .frame(height: 346)
        
    }
}

struct HeroSection_Previews: PreviewProvider {
    static var previews: some View {
        HeroSection()
    }
}
