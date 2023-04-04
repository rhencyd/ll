//
//  DeliveryOptionsView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/30/23.
//

import SwiftUI

struct DeliveryOptionsView: View {
    
    @Binding var customerAddress: String
    @Binding var subTotal: Double
    @Binding var time: Double
    @Binding var distance: Double
    @Binding var verifyAddress: Bool
    @Binding var isDeliveryButtonPressed: Bool
    @Binding var totalOrder: Double
    @Binding var dropOffOption: DropOffOption
    @Binding var deliveryInstructions: String
    @Binding var finalTip: Double
    @Binding var deliveryFee: Double
    @Binding var showAlert: Bool
    @Binding var disableButton: Bool
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    
    @State var isOneDolarTip: Bool = true
    @State var isTwoDolarTip: Bool = false
    @State var isThreeDolarTip: Bool = false
    @State var otherTip: String = ""
    @State var handItTome: Bool = true
    
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            VStack(alignment: .leading) {
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("PrimaryColor1"))
                    
                    
                    Text(customerAddress)
                        .paragraphText()
                        .frame(height: 40)
                        
                    Spacer()
                    
                    Text("Change")
                        .font(Font.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("HighlightColor1"))
                        .frame(width: 100, height: 40)
                        .background(Color("PrimaryColor1"))
                        .cornerRadius(10)
                        .onTapGesture {
                            verifyAddress = true
                            disableButton = true
                        }
                }
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(Color("PrimaryColor1"))
                    
                    Text("Estimated delivery in \(Int((time/60).rounded()) + 30) min")
                        .paragraphText()
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            Section {
                
                button()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    
                    Text("Delivery Instructions").sectionCategory()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    TextField("Type your instructions here", text: $deliveryInstructions)
                        .font(Font.custom("Karla-Regular", size: 16))
                        .foregroundColor(Color("HighlightColor2"))
                        .padding(12)
                        .frame(height: 200, alignment: .topLeading)
                        .background((Color("HighlightColor1")))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
            } header: {
                Text("Drop-off options".uppercased()).sectionTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
            }
            
            
            
            Section {
                
                VStack {
                    
                    Text("Your tip can be a great contribution fulfilling their wish").paragraphText()
                    tip()
                    
                }
                
                
            } header: {
                Text("tip your curier".uppercased()).sectionTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 1)
            }
            
            Section {
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Subtotal").leadText()
                        Spacer()
                        Text("$ \(String(format: "%.2f", subTotal))").leadText()
                            .frame(width: 80, alignment: .leading)
                    }
                    
                    HStack {
                        Text("Delivery Fee").leadText()
                        Spacer()
                        Text("$ \(String(format: "%.2f", deliveryFeeFunc()))").leadText()
                            .frame(width:80, alignment: .leading)
                    }
                    
                    HStack {
                        Text("Courier Tip").leadText()
                        Spacer()
                        Text("$ \(String(format: "%.2f", finalTip))").leadText()
                            .frame(width:80, alignment: .leading)
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
                
            } header: {
                Text("order summary".uppercased()).sectionTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 5)
            }


            Button {
                isDeliveryButtonPressed = true
                verifyAddress = true
                showAlert = true
                disableButton = true
                
                dropOffOption = handItTome ? .handIt : .leaveIt
                deliveryInstructions = deliveryInstructions
                finalTip = finalTip
                deliveryFee = deliveryFeeFunc()
                totalOrder = total()
                
            } label: {
                Text("Proceed to Pay")
                    .primaryButton()
                    .padding(.top, 10)
            }
            .disabled(disableButton)
        }
        .onAppear {
            calculateCourierTip()
            
            if isCurrentUserSignedIn {
                disableButton = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    disableButton = false
                }
            }
        }
        
    }
    
    func button() -> some View {
        
        Button {
            handItTome.toggle()
        } label: {
            
            ZStack {
                
                HStack {
                    Text(!handItTome ? "Hand it to me" : "")
                        .font(Font.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("SecundaryColor3"))
                        .frame(width: 200, height: 32)
                        .background(Color.white)
                        
                    
                    Text(handItTome ? "Leave at the door" : "")
                        .font(Font.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("SecundaryColor3"))
                        .frame(width: 200, height: 32)
                        .background(Color.white)
                }
                
                
                Text(handItTome ? "Hand it to me" : "Leave at the door")
                    .font(Font.custom("Karla-ExtraBold", size: 16))
                    .foregroundColor(Color("HighlightColor1"))
                    .frame(width: 200, height: 32)
                    .background(Color("PrimaryColor1"))
                    .cornerRadius(8)
                    .offset(x: handItTome ? -90 : 90)
                    .animation(.spring(), value: handItTome)
                
            }
            
        }
    }
    
    func tip() -> some View {
        
        HStack {
            Text("$1.00").categoryButton(isButtonSelected: isOneDolarTip)
                .onTapGesture {
                    isOneDolarTip.toggle()
                    isTwoDolarTip = false
                    isThreeDolarTip = false
                    otherTip = ""
                    calculateCourierTip()
                }
            
            Text("$2.00").categoryButton(isButtonSelected: isTwoDolarTip)
                .onTapGesture {
                    isOneDolarTip = false
                    isTwoDolarTip.toggle()
                    isThreeDolarTip = false
                    otherTip = ""
                    calculateCourierTip()
                }
            
            Text("$3.00").categoryButton(isButtonSelected: isThreeDolarTip)
                .onTapGesture {
                    isTwoDolarTip = false
                    isOneDolarTip = false
                    isThreeDolarTip.toggle()
                    otherTip = ""
                    calculateCourierTip()
                }
            
            HStack{
                Text("$")
                    .padding(.leading, 10)
                TextField("", text: $otherTip)
                    .onChange(of: otherTip, perform: { newValue in
                        calculateCourierTip()
                    })
                    .keyboardType(.decimalPad)
            }
            .font(Font.custom("Karla-ExtraBold", size: 16))
                .foregroundColor(Color("PrimaryColor1"))
                .frame(width: 130, height: 40)
                .background(Color("SecundaryColor3"))
                .cornerRadius(16)
            
            .onTapGesture {
                isOneDolarTip = false
                isTwoDolarTip = false
                isThreeDolarTip = false
                calculateCourierTip()
            }
        }
        
    }
    
    func deliveryFeeFunc() -> Double {
        
        let distance = distance
        let factor = 0.3
        let distanceInMiles = distance / 1609
        let deliveryFee = factor * distanceInMiles
        return deliveryFee
    }
    
    func calculateCourierTip(){
        if isOneDolarTip {
            finalTip = 1
        } else if isTwoDolarTip {
            finalTip = 2
        } else if isThreeDolarTip {
            finalTip = 3
        } else if !otherTip.isEmpty {
            finalTip = (otherTip as NSString).doubleValue
        }
        else {
            finalTip = 0
        }
    }
    
    func tax() -> Double {
        let subtotal = subTotal + deliveryFeeFunc()
        let taxRate = 0.0825 // 8.25% tax example texas
        let tax = subtotal * taxRate
        return tax
    }
    
    func total() -> Double {
        let total = subTotal + deliveryFeeFunc() + finalTip + tax()
        return total
    }
}

struct DeliveryOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryOptionsView(customerAddress: .constant("1234 Street Dr, Apt 123, Chicago, IL, 60606"), subTotal: .constant(23), time: .constant(356), distance: .constant(46573), verifyAddress: .constant(false), isDeliveryButtonPressed: .constant(true), totalOrder: .constant(35), dropOffOption: .constant(.handIt), deliveryInstructions: .constant(""), finalTip: .constant(3), deliveryFee: .constant(2), showAlert: .constant(false), disableButton: .constant(false))
    }
}
