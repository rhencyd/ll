//
//  ItemCartPreview.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/17/23.
//

import SwiftUI

struct ItemCartPreview: View {
    
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    @State var dish: ItemAdded
    @State var showAlert: Bool = false
    @State var isEditOn: Bool
    @State var originalSubTotal: Double = 0
    
    @Binding var stepperValue: Int
    @Binding var subTotal: Double
    
    
    
    var body: some View {
        
        HStack {
            HStack {
                ImageDownloaded(
                    url: dish.dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", key: "\(dish.dish.id)")
                
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text(dish.dish.title ?? "Title")
                            .cardTitle()
                        
                        Spacer()
                        
                        // Extras
                        ScrollView {
                            
                            VStack(spacing: 3) {
                                
                                ForEach(dish.extraItem) { item in
                                    
                                    if item.extrItemQty > 0 {
                                        
                                        HStack {
                                            Text("\(item.extraItemTitle)")
                                                .paragraphText()
                                                .frame(width: 90, alignment: .leading)
                                            
                                            Text("Qty: \(item.extrItemQty)")
                                                .paragraphText()
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                
                                Rectangle()
                                    .frame(height: 0.5)
                                    .frame(maxWidth: .infinity)
                                
                                
                            }
                            .offset(y: -4)
                            
                            Spacer()
                            
                            Text(dish.dish.itemDescription ?? "Item Description")
                                .paragraphText()
                                .offset(y: -10)
                            
                            Rectangle()
                                .frame(height: 0.5)
                                .frame(maxWidth: .infinity)
                                .padding(.top, -10)
                            
                            Text("Special Request: \(dish.specialRequest.isEmpty ? "None" : dish.specialRequest)")
                                .paragraphText()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, -10)
                            
                            
                            Spacer()
                            
                        }
                        
                        Spacer()
                    }
                    
                }
                .onAppear {
                    originalSubTotal = dish.subTotal
                    itemAddedViewModel.getSubtotal()
                }
            }
            
            Spacer()
            
            if isEditOn {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", subTotal))")
                        .leadText()
                        .foregroundColor(Color("HighlightColor2"))
                    
                    
                    Text("Qty: \(dish.dishQty)")
                        .leadText()
                        .foregroundColor(Color("HighlightColor2"))
                    
                    Spacer()
                }
                
            }
            
            else {
                
                // Item Price and custom stepper
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    // Item price with alignment topTrailing
                    Text("$\(String(format: "%.2f", subTotal))")
                        .leadText()
                        .foregroundColor(Color("PrimaryColor1"))
                    
                    
                    Spacer()
                    
                    CustomStepper(
                        stepperValue: $stepperValue,
                        needStroke: false, fillColor: Color("SecundaryColor3"))
                    .onChange(of: stepperValue) { newValue in
                        
                        if stepperValue > 0 {
                            
                            let unitPrice = dish.subTotal / Double(dish.dishQty)
                            let subtotal = unitPrice * Double(newValue)
                            
                            subTotal = subtotal
                            
                            dish.dishQty = newValue
                            dish.subTotal = subtotal
                            
                            print(dish.subTotal)
                            itemAddedViewModel.getSubtotal()
                            
                        }
                        else {
                            showAlert.toggle()
                        }
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this dish?"),
                            primaryButton: .destructive(
                                Text("DELETE"),
                                action: {
                                    
                                    self.itemAddedViewModel.itemAdded.removeAll {
                                        $0.id == dish.id
                                    }
                                    itemAddedViewModel.getSubtotal()
                                    itemAddedViewModel.cartItemsNumber = itemAddedViewModel.itemAdded.count
                                    
                                }),
                            secondaryButton: .cancel(Text("Cancel"), action: {
                                stepperValue = 1
                                dish.subTotal = originalSubTotal
                                
                                showAlert = false
                            }))
                    }
                }
                
            }
            
            
        }
        .frame(height: 95)
    }
    
}


struct ItemCartPreview_Previews: PreviewProvider {
    
    static let context = PersistenceController.shared.container.viewContext
    
    let extraItem1 = ExtraItemsModel(extraItemPrice: "1.60", extraItemTitle: "Avocado", extrItemQty: 0)
    
    static var dish: ItemAdded = ItemAdded(extraItem: oneExtraItem(), dish: oneDish(), dishQty: 2, specialRequest: "", subTotal: 14.56)
    
    static var previews: some View {
        ItemCartPreview(dish: dish, isEditOn: false, stepperValue: .constant(1), subTotal: .constant(30))
            .environmentObject(CartViewModel())
    }
    
    
    static func oneExtraItem() -> [ExtraItemsModel] {
        var extraItems: [ExtraItemsModel] = []
        let extraItem1 = ExtraItemsModel(extraItemPrice: "1.60", extraItemTitle: "Avocado", extrItemQty: 0)
        let extraItem2 = ExtraItemsModel(extraItemPrice: "1.00", extraItemTitle: "Seeds", extrItemQty: 0)
        
        extraItems.append(extraItem1)
        extraItems.append(extraItem2)
        return extraItems
    }
    
    
    static func oneDish() -> DishEntity {
        let dish = DishEntity(context: context)
        dish.title = "Greek Salad"
        dish.itemDescription = "The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons"
        dish.image = "Greek salad"
        dish.price = "12"
        return dish
    }
}
