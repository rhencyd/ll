//
//  PaymentScreen.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 4/1/23.
//

import SwiftUI

struct PaymentScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var screenNavigator: NavigationStateManager
    
    @State var googlePay: Bool = false
    @State var applePay: Bool = false
    @State var creditCard: Bool = true
    @State var paypal: Bool = false

    
    @State var spacing: CGFloat = 40
    @State var total: Double = 0
    
    
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                HStack(spacing: 70) {
                    
                    VStack(alignment: .center, spacing: spacing) {
                        
                        Image("google pay logo").resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 50)
                        
                        Image("apple pay logo").resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 50)
                        
                        
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .fixedSize()
                            .padding(.vertical, 1)
                        
                        Image("paypal logo").resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .padding(.vertical, 10)
                        
                        
                    }
                    
                    VStack(alignment: .leading, spacing: spacing) {
                        
                        Text("Google Pay")
                            .paragraphText()
                            .frame(height: 50)
                            .offset(y: 4)
                        
                        Text("Apple pay")
                            .paragraphText()
                            .frame(height: 50)
                            .offset(y: 4)
                        
                        Text("Credit card")
                            .paragraphText()
                            .frame(height: 50)
                            .padding(.vertical, 1)
                        
                        Text("Paypal")
                            .paragraphText()
                            .frame(height: 50)
                            .padding(.vertical, 10)
                            .offset(y: -10)
                        
                    }
                    
                    VStack(spacing: spacing) {
                        
                        Image(systemName: googlePay ? "circle.inset.filled" : "circle" )
                            .resizable()
                            .foregroundColor(Color("PrimaryColor1"))
                            .frame(width:20, height: 20)
                            .frame(height: 50)
                            .offset(y: -5)
                            .onTapGesture {
                                googlePay.toggle()
                                applePay = false
                                creditCard = false
                                paypal = false
                            }
                        
                        Image(systemName: applePay ? "circle.inset.filled" : "circle" )
                            .resizable()
                            .foregroundColor(Color("PrimaryColor1"))
                            .frame(width:20, height: 20)
                            .frame(height: 50)
                            .offset(y: -5)
                            .onTapGesture {
                                applePay.toggle()
                                googlePay = false
                                creditCard = false
                                paypal = false
                            }
                        
                        Image(systemName: creditCard ? "circle.inset.filled" : "circle" )
                            .resizable()
                            .foregroundColor(Color("PrimaryColor1"))
                            .frame(width:20, height: 20)
                            .frame(height: 50)
                            .offset(y: -10)
                            .onTapGesture {
                                creditCard.toggle()
                                applePay = false
                                googlePay = false
                                paypal = false
                            }
                        
                        Image(systemName: paypal ? "circle.inset.filled" : "circle" )
                            .resizable()
                            .foregroundColor(Color("PrimaryColor1"))
                            .frame(width:20, height: 20)
                            .offset(y: -10)
                            .frame(height: 50)
                            .onTapGesture {
                                paypal.toggle()
                                applePay = false
                                creditCard = false
                                googlePay = false
                            }
                    }
                    
                }
                
                Rectangle()
                    .frame(height: 1)
                    .padding()
                
            }
            .padding(.top, 50)
            .onAppear {
                getTotal()
            }
            
            HStack {
                Text("Total").leadText()
                Spacer()
                Text("$ \(String(format: "%.2f", total))").leadText()

            }
            .padding(.horizontal, 40)
            
            
            Spacer()
            

                NavigationLink(value: ScreenNavigationValue.confirmation(checkoutViewModel.order)) {
                        Text("Confirm and Pay")
                            .primaryButton()
                            .padding(.top, 10)
                }
                .simultaneousGesture(TapGesture().onEnded({ tap in
                    checkoutViewModel.isHistory = false
                }))
            
        }
        
        .toolbarBackground(.white, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                    dismiss()
                    
                } label: {
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("PrimaryColor1"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("select payment method".uppercased())
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(Color("HighlightColor2"))
                
            }
            
        }
    }
    
    func getTotal() {
        for order in checkoutViewModel.order {
            total = order.total
        }
    }
    
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen()
    }
}
