//
//  IntroView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/14/23.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack{
            if isCurrentUserSignedIn {
                Home()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                withAnimation(.easeInOut(duration: 1)) {
                    Welcome()
                }
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }.preferredColorScheme(.light)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
