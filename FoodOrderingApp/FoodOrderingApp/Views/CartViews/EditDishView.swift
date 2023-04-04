//
//  EditDishView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/26/23.
//

import SwiftUI

struct EditDishView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    
    @FocusState private var specialInstructions: Bool
    
    @State var dish: ItemAdded
    @State var currentToppings: [ExtraItemsModel] = []
    
    @State var showAlert: Bool = false
    @State var isItemUpdated: Bool = false
    
    @State var avocados: [ExtraItemsModel] = []
    @State var seeds: [ExtraItemsModel] = []
    @State var dressings: [ExtraItemsModel] = []
    
    @State var subTotal: Double = 0
    
    @State var stepperValue: Int = 0
    @State var specialRequest: String = ""
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                
                ImageDownloaded(
                    url: dish.dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", key: "\(dish.dish.id)")
                .scaledToFill()
                .frame(height: 250)
                .padding(.bottom, 25)
                
                
                VStack {
                    
                    // Dish info
                    VStack {
                        
                        HStack (spacing: 20) {
                            
                            // Dish name
                            Text(dish.dish.title ?? "Item").cardTitle()
                            
                            // Rating
                            HStack (spacing: 5) {
                                
                                ForEach(0..<5) { index in
                                    
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 15)
                                    
                                }
                            }
                            .foregroundColor(Color("HighlightColor2"))
                            
                            Spacer()
                            
                            // Dish price
                            Text("$ \(dish.dish.price ?? "10")")
                                .leadText()
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        
                        Text(dish.dish.itemDescription ?? "Dish Description")
                            .paragraphText()
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                    
                    // Customize options
                    
                    VStack {
                        
                        Text("Customize it")
                            .sectionCategory()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                        
                        
                        ForEach($currentToppings) { $extraItem in
                            
                            HStack {
                                HStack {
                                    Text(extraItem.extraItemTitle)
                                        .leadText()
                                        .frame(width:150, alignment: .leading)
                                        .padding(.bottom, 5)
                                    
                                    
                                    
                                    HStack {
                                        Text("$").leadText()
                                        Text(extraItem.extraItemPrice).leadText()
                                        
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    CustomStepper(
                                        stepperValue: $extraItem.extrItemQty,
                                        needStroke: false,
                                        fillColor: Color.white)
                                    .onChange(of: extraItem.extrItemQty) { newValue in
                                        
                                        calculteSubtotal()
                                        
                                        if subTotal == dish.subTotal && currentToppings.elementsEqual(dish.extraItem) && specialRequest == dish.specialRequest {
                                            isItemUpdated = false
                                        } else {
                                            isItemUpdated = true
                                        }


                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                            
                        }
                        
                        
                        
                        CustomStepper2(stepperValue: $stepperValue, needStroke: true, fillColor: Color.white)
                            .padding(.vertical,10)
                            .onChange(of: stepperValue, perform: { newValue in
                                
                                calculteSubtotal()
                                
                                if subTotal == dish.subTotal && currentToppings.elementsEqual(dish.extraItem) && specialRequest == dish.specialRequest {
                                    isItemUpdated = false
                                } else {
                                    isItemUpdated = true
                                }
                                
                            })
                        
                        Text("Special Instructions")
                            .sectionCategory()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                        
                        
                        TextField("Special requirements..." ,text: $specialRequest)
                            .font(Font.custom("Karla-Regular", size: 16))
                            .foregroundColor(Color("HighlightColor2"))
                            .padding(12)
                            .frame(height: 200, alignment: .topLeading)
                            .background((Color("HighlightColor1")))
                            .cornerRadius(8)
                            .focused($specialInstructions)
                            .onTapGesture {
                                specialInstructions.toggle()
                            }
                            .onChange(of: specialRequest) { newValue in
                                
                                if subTotal == dish.subTotal && currentToppings.elementsEqual(dish.extraItem) && specialRequest == dish.specialRequest {
                                    isItemUpdated = false
                                } else {
                                    isItemUpdated = true
                                }
                            }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                .onAppear {
                    getExtraItems()
                    stepperValue = dish.dishQty
                    specialRequest = dish.specialRequest
                    subTotal = dish.subTotal
                }
            }
            
            Button {
                
                if let row = itemAddedViewModel.itemAdded.firstIndex(where: { $0.id == dish.id }) {
                    itemAddedViewModel.itemAdded[row] = getItemUpdated()
                }
                itemAddedViewModel.isItemChanged = true
                
                dismiss()
                
            } label: {
                
                if isItemUpdated {
                    
                    VStack {
                        
                        if subTotal != dish.subTotal {
                            Text("New Subtotal: $\(String(format: "%.2f", subTotal))")
                                .font(Font.custom("Karla-Bold", size: 18))
                                .foregroundColor(Color("HighlightColor1"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .background(Color("PrimaryColor1"))
                            
//                            Text("Update my dish!").primaryButton()
                        }
//                        else {
//
//                            Text("Subtotal $\(String(format: "%.2f", subTotal))")
//                                .font(Font.custom("Karla-Bold", size: 18))
//                                .foregroundColor(Color("HighlightColor1"))
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 45)
//                                .background(Color("PrimaryColor1"))
//
////                            Text("Update my dish!").primaryButton()
//                        }
                        
                        Text(subTotal != dish.subTotal ? "Update my dish!" : "Update instructions! Subtotal: $\(String(format: "%.2f", subTotal))").primaryButton()
                        
                        
                        
                    }
                    
                }
                else {
                    Text("Subtotal $\(String(format: "%.2f", subTotal))")
                        .font(Font.custom("Karla-Bold", size: 18))
                        .foregroundColor(Color("HighlightColor1"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color("PrimaryColor1"))
                }
                
            }
            .disabled(!isItemUpdated)
            
            
        }
        .padding(.top, 5)
        
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        
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
                
                Image("littleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAlert.toggle()
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundColor(Color(#colorLiteral(red: 0.8467391729, green: 0.1176478192, blue: 0, alpha: 1)))
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this dish?"),
                        primaryButton:
                                .destructive(Text("DELETE"),
                                             action: {
                                                 self.itemAddedViewModel.itemAdded.removeAll {
                                                     $0.id == dish.id
                                                 }
                                                 
                                                 itemAddedViewModel.cartItemsNumber = itemAddedViewModel.itemAdded.count
                                                 
                                                 dismiss()
                        }),
                        secondaryButton:
                                .cancel(Text("Cancel"),
                                        action: {
                                            showAlert = false
                                        }))
                }
                

            }
            
        }
    }
    
    func calculteSubtotal() {
        
        let subTotalDishPrice = Double(stepperValue) * ((dish.dish.price as NSString?)?.doubleValue ?? 33.05)
        
        var extraItemsSubtotal: Double = 0
        
        for item in currentToppings {
            
            let price = (item.extraItemPrice as NSString).doubleValue
            let qty = Double(item.extrItemQty)
            let itemSubtotal = price * qty
            extraItemsSubtotal += itemSubtotal
        }
        
        subTotal = subTotalDishPrice + (extraItemsSubtotal * Double(stepperValue))
        
    }
    
    func getExtraItems() {
        
        for topping in dish.extraItem {
            currentToppings.append(topping)
        }
    }
    
    func getItemUpdated() -> ItemAdded {
        return ItemAdded(extraItem: currentToppings, dish: dish.dish, dishQty: stepperValue, specialRequest: specialRequest, subTotal: subTotal)
    }
    
    
}

struct EditDishView_Previews: PreviewProvider {
    
    static let context = PersistenceController.shared.container.viewContext
    let dish = DishEntity(context: context)
    
    static var previews: some View {
                EditDishView(dish: ItemAdded(
                    extraItem: [ExtraItemsModel(
                        extraItemPrice: "1.54",
                        extraItemTitle: "seeds",
                        extrItemQty: 5)],
                    dish: oneDish(),
                    dishQty: 5,
                    specialRequest: "none",
                    subTotal: 145))
        
        .environmentObject(CartViewModel())
        .environmentObject(ExtraItemsViewModel())
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
