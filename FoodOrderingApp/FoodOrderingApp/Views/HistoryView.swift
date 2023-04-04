//
//  HistoryView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 4/3/23.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            if checkoutViewModel.history.count < 1 {
                
                VStack {
                    
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "list.bullet.clipboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color("PrimaryColor1"))
                        
                        Image(systemName: "questionmark.bubble.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity, alignment: .top)
                            .foregroundColor(Color("HighlightColor2"))
                            .padding(.horizontal, -20)
                            .padding(.vertical, -20)
                        
                    }
                    .frame(width: 200, height: 200)
                    
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("No orders found!")
                            .font(Font.custom("Karla-Bold", size: 25))
                        
                        Text("Looks like you haven't ordered any dishes yet")
                            .paragraphText()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,80)
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Order now!").primaryButton()
                    }
                }
                .toolbar(.hidden)
                
            }
            
            else {
                
                ForEach(checkoutViewModel.history) { order in
                    NavigationLink(value: ScreenNavigationValue.confirmation([order])) {
                        
                        HStack {
                            
                            Image(systemName: "basket.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("PrimaryColor1"))
                            
                            
                            
                            Text("Order number \(String(order.orderNumber))")
                                .foregroundColor(.black)
                                .leadText()
                                .padding(.horizontal, 20)
                            
                        }
                        
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded({ tap in
                        checkoutViewModel.isHistory = true
                        print(checkoutViewModel.isHistory.description)
                    }))
                }
                .padding(.top, 20)
                
                Spacer()
                
            }
            
            
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
                Text("History".uppercased())
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(Color("HighlightColor2"))
                
            }
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(CheckoutViewModel())
    }
}
