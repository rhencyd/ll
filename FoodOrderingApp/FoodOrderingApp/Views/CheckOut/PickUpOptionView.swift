//
//  PickUpOptionView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/31/23.
//

import SwiftUI

struct PickUpOptionView: View {
    
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    
    
    @State var asapPickUp: Bool = true
    @State var specialRequest: String = ""
    @State var subTotal: Double = 0
    @State var pickUpAddress: String = "160 N La Salle St, Chicago, IL 60601"
    
    
    
    @State var selectedDate: Date = (Calendar.current.date(byAdding: .minute, value: 20, to: Date()) ?? Date())
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .minute, value: 20, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 4, to: Date())!
        return min...max
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            VStack {
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "building.2")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("PrimaryColor1"))
                    
                    
                    Text(pickUpAddress)
                        .paragraphText()
                        .frame(height: 40)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Slider()
                    .padding(.top)
                
                if !asapPickUp {
                    
                    VStack {
                        
                        
                        DatePicker(selection: $selectedDate, in: dateClosedRange) {
                            Text("Select the best time that fist you")
                                .paragraphText()
                        }
                        .datePickerStyle(.compact)
                        .font(Font.custom("Karla-Regular", size: 16))
                        
                        .padding(.top)
                        
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("PrimaryColor1"))
                            
                            Text("Pick up on \(dateFormatter.string(from: selectedDate))")
                                .leadText()
                            
                        }
                        .padding(.top, 30)
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                }
                
                
                VStack(alignment: .leading) {
                    
                    Text("Special requests").sectionCategory()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    
                    TextField("Any request you may have...", text:$specialRequest )
                        .font(Font.custom("Karla-Regular", size: 16))
                        .foregroundColor(Color("HighlightColor2"))
                        .padding(12)
                        .frame(height: 200, alignment: .topLeading)
                        .background((Color("HighlightColor1")))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                VStack {
                    
                    Text("order summary".uppercased()).sectionTitle()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 30)
                        .padding(.bottom, 5)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Subtotal").leadText()
                            Spacer()
                            Text("$ \(String(format: "%.2f", subTotal))").leadText()
                                .frame(width: 80, alignment: .leading)
                        }
                        
                        HStack {
                            Text("Tax").leadText()
                            Spacer()
                            Text("$ \(String(format: "%.2f", tax()))").leadText()
                                .frame(width:80, alignment: .leading)
                        }
                        
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                        
                        
                        HStack {
                            Text("Total").leadText()
                            Spacer()
                            Text("$ \(String(format: "%.2f", total()))").leadText()
                                .frame(width:80, alignment: .leading)
                        }
                        .padding(.top, 10)
                        
                    }.padding(.horizontal, 60)
                    
                    
                }
                
                NavigationLink(value: ScreenNavigationValue.payment) {
                    Text("Proceed to Pay")
                        .primaryButton()
                        .padding(.top, 10)
                    
                }
                .simultaneousGesture(TapGesture().onEnded({ action in
                    
                    checkoutViewModel.getOrder(
                        items: itemAddedViewModel.itemAdded,
                        total: total(),
                        deliveryOption: false,
                        dropOffOption: .leaveIt,
                        pickUpOption: true,
                        deliveryInstructions: "",
                        courierTip: 0,
                        deliveryFee: 0,
                        deliverytime: 0,
                        deliveryAddress: "",
                        pickUpAddress: pickUpAddress,
                        pickUpTime: asapPickUp ? Calendar.current.date(byAdding: .minute, value: 20, to: Date())! : selectedDate,
                        pickUpSpecialRequest: specialRequest,
                        nameofOrder: "",
                        emailOrder: "")
                    
                    print(checkoutViewModel.order)
                    
                }))
                
            }
            .onAppear() {
                subTotal = itemAddedViewModel.subTotal
            }
            
        }
        
    }
    
    func Slider() -> some View {
        
        Button {
            asapPickUp.toggle()
        } label: {
            
            ZStack {
                
                HStack {
                    Text(!asapPickUp ? "ASAP - 20 min" : "")
                        .font(Font.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("SecundaryColor3"))
                        .frame(width: 200, height: 32)
                        .background(Color.white)
                    
                    
                    Text(asapPickUp ? "Schedule" : "")
                        .font(Font.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("SecundaryColor3"))
                        .frame(width: 200, height: 32)
                        .background(Color.white)
                }
                
                
                Text(asapPickUp ? "ASAP - 20 min" : "Schedule")
                    .font(Font.custom("Karla-ExtraBold", size: 16))
                    .foregroundColor(Color("HighlightColor1"))
                    .frame(width: 200, height: 32)
                    .background(Color("PrimaryColor1"))
                    .cornerRadius(8)
                    .offset(x: asapPickUp ? -90 : 90)
                    .animation(.spring(), value: asapPickUp)
                
            }
            
        }
    }
    
    func tax() -> Double {
        let subtotal = subTotal
        let taxRate = 0.0825 // 8.25% tax example texas
        let tax = subtotal * taxRate
        return tax
    }
    
    func total() -> Double {
        let total = subTotal + tax()
        return total
    }
}

struct PickUpOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpOptionView()
    }
}
