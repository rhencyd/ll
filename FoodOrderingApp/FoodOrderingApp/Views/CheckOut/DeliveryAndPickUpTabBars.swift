//
//  DeliveryAndPickUpTabBars.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/31/23.
//

import SwiftUI

struct DeliveryAndPickUpTabBars: View {
    
    @State private var tabSelection: TabBarITem = TabBarITem(title: "delivery")
    
    @Binding var verifyAddress: Bool
    @Binding var customerAddress: String
    @Binding var subTotal: Double
    @Binding var time: Double
    @Binding var distance: Double
    @Binding var isDeliveryButtonPressed: Bool
    @Binding var totalOrder: Double
    @Binding var dropOffOption: DropOffOption
    @Binding var deliveryInstructions: String
    @Binding var finalTip: Double
    @Binding var deliveryFee: Double
    @Binding var showAlert: Bool
    @Binding var disableButton: Bool
    
    var body: some View {
        
        CustomTabBarContainer(selection: $tabSelection) {
            DeliveryOptionsView(customerAddress: $customerAddress, subTotal: $subTotal, time: $time, distance: $distance, verifyAddress: $verifyAddress, isDeliveryButtonPressed: $isDeliveryButtonPressed, totalOrder: $totalOrder, dropOffOption: $dropOffOption, deliveryInstructions: $deliveryInstructions, finalTip: $finalTip, deliveryFee: $deliveryFee, showAlert: $showAlert, disableButton: $disableButton)
                .tabBarItem(tab: TabBarITem(title: "delivery"), selection: $tabSelection)
            
            PickUpOptionView()
                .tabBarItem(tab: TabBarITem(title: "pick up"), selection: $tabSelection)
        }
        
    }
}

struct DeliveryAndPickUpTabBars_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryAndPickUpTabBars(verifyAddress: .constant(false), customerAddress: .constant("Houston"), subTotal: .constant(35), time: .constant(34534), distance: .constant(43545345), isDeliveryButtonPressed: .constant(false), totalOrder: .constant(32.45), dropOffOption: .constant(.leaveIt), deliveryInstructions: .constant(""), finalTip: .constant(32), deliveryFee: .constant(32), showAlert: .constant(false), disableButton: .constant(false))
    }
}
