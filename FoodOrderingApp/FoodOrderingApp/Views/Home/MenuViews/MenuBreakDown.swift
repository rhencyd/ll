//
//  MenuBreakDown.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct MenuBreakDown: View {
    
    @EnvironmentObject var vm: DishesFiltering
    
    var body: some View {
        VStack {
            
            Text("order for delivery / pick - up".uppercased()).sectionTitle()
                .padding(.bottom, -2)
            
            HStack {
                
                Spacer()
                
                
                
                Text("Starters").categoryButton(isButtonSelected: vm.startersfilter)
                    .onTapGesture {
                        vm.startersfilter.toggle()
                        vm.mainsfilter = false
                        vm.dessertsfilter = false
                        vm.sidesfilter = false
                    }
                
                Spacer()
                
                Text("Mains").categoryButton(isButtonSelected: vm.mainsfilter)
                    .onTapGesture {
                        vm.startersfilter = false
                        vm.mainsfilter.toggle()
                        vm.dessertsfilter = false
                        vm.sidesfilter = false
                    }

                Spacer()

                Text("Desserts").categoryButton(isButtonSelected: vm.dessertsfilter)
                    .onTapGesture {
                        vm.startersfilter = false
                        vm.mainsfilter = false
                        vm.dessertsfilter.toggle()
                        vm.sidesfilter = false
                    }

                Spacer()

                Text("Sides").categoryButton(isButtonSelected: vm.sidesfilter)
                    .onTapGesture {
                        vm.startersfilter = false
                        vm.mainsfilter = false
                        vm.dessertsfilter = false
                        vm.sidesfilter.toggle()
                    }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
        }
    }
}

struct MenuBreakDown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakDown()
            .environmentObject(DishesFiltering())
    }
}
