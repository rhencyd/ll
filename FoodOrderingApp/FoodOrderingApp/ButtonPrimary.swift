//
//  ButtonPrimary.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/9/23.
//

import SwiftUI

struct ButtonPrimary: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Hello")
                .secondaryButton()
                
        }
    }
}

struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPrimary()
    }
}
