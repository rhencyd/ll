//
//  MenuBreakDown.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct MenuBreakDown: View {
    
    @State private var startersfilter: Bool = false
    @State private var mainsfilter: Bool = false
    @State private var dessertsfilter: Bool = false
    @State private var sidesfilter: Bool = false
    
    var body: some View {
        VStack {
            
            Text("order for delivery / pick - up".uppercased()).sectionTitle()
                .padding(.bottom, -2)
            
            HStack {
                
                Spacer()
                
                
                
                Text("Starters").categoryButton(isButtonSelected: startersfilter)
                    .onTapGesture {
                        startersfilter.toggle()
                    }
                
                Spacer()
                
                Text("Mains").categoryButton(isButtonSelected: mainsfilter)
                    .onTapGesture {
                        mainsfilter.toggle()
                    }

                Spacer()

                Text("Desserts").categoryButton(isButtonSelected: dessertsfilter)
                    .onTapGesture {
                        dessertsfilter.toggle()
                    }

                Spacer()

                Text("Sides").categoryButton(isButtonSelected: sidesfilter)
                    .onTapGesture {
                        sidesfilter.toggle()
                    }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            
        }
    }
}

struct MenuBreakDown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakDown()
    }
}
