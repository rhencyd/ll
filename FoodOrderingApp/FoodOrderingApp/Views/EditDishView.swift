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
//    @EnvironmentObject var extraItemsViewModel : ExtraItemsViewModel
    
    
    @State var dish: ItemAdded
//    @Binding var extraItem: [ExtraItemsModel]
//    @Binding var itemQty: Int // dish qty
//    @Binding var subTotal: Double
//    @Binding var specialRequest: String
    
    
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
                        
                            
                        ForEach($dish.extraItem) { $extraItem in
                                
//                                ForEach($dish.extraItem) { $currentItem in
                                    
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
                                            
                                            // custom stepper
                                            
                                            Spacer()
                                            
                                            CustomStepper(
                                                stepperValue: $extraItem.extrItemQty,
                                                needStroke: false,
                                                fillColor: Color.white)
                                            
                                            .onChange(of: extraItem.extrItemQty, perform: { newValue in
                                                
                                                
                                                
    //                                            calculteSubtotal()
                                                
    //                                            ForEach($dish.extraItem) { $item in
    //                                                if extraItem.extraItemTitle == item.extraItemTitle {
    //                                                    item.extrItemQty = newValue
    //                                                }
    //                                            }
                                                
//                                                for extra in dish.extraItem {
//
//                                                    if extraItem.extraItemTitle == extra.extraItemTitle {
//
//                                                        dish.extraItem.removeAll {
//                                                            $0.id == extra.id
//                                                        }
//
//                                                        dish.extraItem.append(ExtraItemsModel(extraItemPrice: extra.extraItemPrice, extraItemTitle: extra.extraItemTitle, extrItemQty: newValue))
//
//                                                    }
//                                                    else {
//                                                        dish.extraItem.append(ExtraItemsModel(extraItemPrice: extra.extraItemPrice, extraItemTitle: extra.extraItemTitle, extrItemQty: newValue))
//                                                    }
//
//                                                    print(dish.extraItem)
//                                                }
                                                
                                            })
                                            
                                        }
                                    }
                                    .padding(.horizontal)
                                    
//                                }
                                
                                
                            }
//                        }
//                        } else {
//
//                            ForEach(dish.extraItem) { $extraItem in
//                                HStack {
//                                    HStack {
//                                        Text(extraItem.extraItemTitle)
//                                            .leadText()
//                                            .frame(width:150, alignment: .leading)
//                                            .padding(.bottom, 5)
//
//
//
//                                        HStack {
//                                            Text("$").leadText()
//                                            Text(extraItem.extraItemPrice).leadText()
//
//                                        }
//
//                                        // custom stepper
//
//                                        Spacer()
//
//                                        CustomStepper(
//                                            stepperValue: extraItem.extrItemQty,
//                                            needStroke: false,
//                                            fillColor: Color.white)
//
//                                        .onChange(of: extraItem.extrItemQty, perform: { newValue in
//
//
//                                        })
//
//                                    }
//                                }
//                                .padding(.horizontal)
//                            }
//
//                        }
                        
                       
                        
                        CustomStepper2(stepperValue: $stepperValue, needStroke: true, fillColor: Color.white)
                            .padding(.vertical,10)
                            .onChange(of: stepperValue, perform: { newValue in
                                
                                dish.dishQty = newValue
                                calculteSubtotal()
                                
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
                            
//                            .focused($specialInstructionsInFocus)
//                            .onTapGesture {
////                                specialInstructionsInFocus.toggle()
//                            }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                .onAppear {
                    stepperValue = dish.dishQty
                    specialRequest = dish.specialRequest
                    subTotal = dish.subTotal
                }
            }
            
            Button {
                
                
            } label: {
//                Text("Add for $\(String(format: "%.2f", subTotal))").primaryButton()
                Text("Update for $\(String(format: "%.2f", subTotal))").primaryButton()
            }

            
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
            
        }
    }
    private func optionalBinding<T>(val: Binding<T?>, defaultVal: T)-> Binding<T>{
        Binding<T>(
            get: {
                return val.wrappedValue ?? defaultVal
            },
            set: { newVal in
                val.wrappedValue = newVal
            }
        )
    }
    
    func calculteSubtotal() {

        let subTotalDishPrice = Double(dish.dishQty) * ((dish.dish.price as NSString?)?.doubleValue ?? 33.05)
        
        var extraItemsSubtotal: Double = 0
        
        for item in dish.extraItem {
            
            let price = (item.extraItemPrice as NSString).doubleValue
            let qty = Double(item.extrItemQty)
            let itemSubtotal = price * qty
            extraItemsSubtotal += itemSubtotal
        }
        
        subTotal = subTotalDishPrice + (extraItemsSubtotal * Double(dish.dishQty))
        
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
        
        /*
         EditDishView(dish: .constant(ItemAdded(
             extraItem: [ExtraItemsModel(
                 extraItemPrice: "1.54",
                 extraItemTitle: "seeds",
                 extrItemQty: 5)],
             dish: oneDish(),
             dishQty: 5,
             specialRequest: "none",
             subTotal: 145)))
         */
        
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




/*
 
 //
 //  DishView.swift
 //  FoodOrderingApp
 //
 //  Created by Rhency Delgado on 3/15/23.
 //

 import SwiftUI


 struct DishView: View {
     
     @Environment(\.dismiss) var dismiss
     @EnvironmentObject private var extraItemsViewModel : ExtraItemsViewModel
     @EnvironmentObject var itemAddedViewModel: CartViewModel
     @EnvironmentObject var navigationStateManager: NavigationStateManager
     @EnvironmentObject var hamburguerMenu: HamburguerMenu
     
     @State var specialInstructions: String = ""
     @State var itemQty: Int = 1
     @FocusState private var specialInstructionsInFocus: Bool
     
     @State var subTotal: Double = 0.00
     
     let dish: DishEntity
     @State var extraItems: [ExtraItemsModel] = []
     
     @State var avocados: [ExtraItemsModel] = []
     @State var seeds: [ExtraItemsModel] = []
     @State var dressings: [ExtraItemsModel] = []
     
     var body: some View {
         
         VStack{
             
             ScrollView {
                 
                 ZStack {
                     
                     ImageDownloaded(
                         url: dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true", key: "\(dish.id)")
                     .scaledToFill()
                     .frame(height: 10)
                     
                     
                     Button {
                         dismiss()
                     } label: {
                         Image(systemName: "arrow.backward.circle.fill")
                             .resizable()
                             .frame(width: 40, height: 40)
                             .foregroundColor(Color("PrimaryColor1"))
                     }
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .frame(maxHeight: .infinity, alignment: .top)
                     .padding(.horizontal, 15)
                     .padding(.top, -5)
                     
                     
                 }
                 .frame(height: 250)
                 .padding(.bottom, 25)
                 .padding(.top, 15)
                 
                 
                 VStack {
                     
                     // Dish info
                     VStack {
                         
                         HStack (spacing: 20) {
                             
                             // Dish name
                             Text(dish.title ?? "Item").cardTitle()
                             
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
                             Text("$ \(dish.price ?? "10")")
                                 .leadText()
                             
                         }
                         .padding(.horizontal, 20)
                         .padding(.vertical, 10)
                         
                         Text(dish.itemDescription ?? "Dish Description")
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
                         
                         ForEach($extraItemsViewModel.extraItemsArray) { $extraItem in
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
                                     
                                     // custom stepper
                                     
                                     Spacer()
                                     
                                     CustomStepper(
                                         stepperValue: $extraItem.extrItemQty,
                                         needStroke: false,
                                         fillColor: Color.white)
                                     .onAppear {
                                         if extraItem.extrItemQty > 0 {
                                             extraItem.extrItemQty = 0
                                         }
                                     }
                                     
                                     
                                     
                                     .onChange(of: extraItem.extrItemQty, perform: { newValue in
                                         
                                         getExtraItemTotal(
                                             itemPrice: extraItem.extraItemPrice,
                                             itemTitle: extraItem.extraItemTitle,
                                             qty: extraItem.extrItemQty)
                                         
                                         getCheckoutItem()
                                         calculteSubtotal()
                                     })
                                     
                                 }
                             }
                             .padding(.horizontal)
                         }
                         
                         CustomStepper2(stepperValue: $itemQty, needStroke: true, fillColor: Color.white)
                             .padding(.vertical,10)
                             .onChange(of: itemQty, perform: { newValue in
                                 calculteSubtotal()
                             })
                         
                         Text("Special Instructions")
                             .sectionCategory()
                             .frame(maxWidth: .infinity, alignment: .leading)
                             .padding(.bottom, 10)
                         
                         
                         TextField("Special requirements..." ,text: $specialInstructions)
                             .font(Font.custom("Karla-Regular", size: 16))
                             .foregroundColor(Color("HighlightColor2"))
                             .padding(12)
                             .frame(height: 200, alignment: .topLeading)
                             .background((Color("HighlightColor1")))
                             .cornerRadius(8)
                             
                             .focused($specialInstructionsInFocus)
                             .onTapGesture {
                                 specialInstructionsInFocus.toggle()
                             }
                         
                     }
                     .padding(.horizontal)
                     
                     Spacer()
                     
                 }
             }
             .task {
                 extraItems = []
                 calculteSubtotal()
             }
             
             
             Button {
                 
                 itemAddedViewModel.addItemToCart(extras: extraItems, dish: dish, qty: itemQty, request: specialInstructions, subTotal: subTotal)
                 
                 print(itemAddedViewModel.cartItemsNumber)
                 print(itemAddedViewModel.itemAdded)
                 dismiss()
                 
                 
             } label: {
                 Text("Add for $\(String(format: "%.2f", subTotal))").primaryButton()
             }
             Spacer()
         }
 //        .padding(.top, 5)
         
         .onAppear(perform: {
             if navigationStateManager.cartErased {
                 dismiss()
                 navigationStateManager.cartErased = false
             }
         })
         
         .navigationBarBackButtonHidden()
         .navigationBarTitleDisplayMode(.inline)
         .toolbarBackground(.hidden, for: .navigationBar)
         
         .toolbar {
             
             ToolbarItem(placement: .navigationBarTrailing) {
                 NavigationLink(value: ScreenNavigationValue.cartView) {
                     TabItemCartImage()
                 }
             }
             
             ToolbarItem(placement: .navigationBarLeading) {
                 
                 Button {
                     withAnimation(Animation.spring()) {
                         hamburguerMenu.showSideMenu.toggle()
                     }
                 } label: {
                     
                     Image(systemName: "list.bullet")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 35)
                         .foregroundColor(Color("PrimaryColor1"))
                     
                 }
             }
             
             ToolbarItem(placement: .principal) {
                 
                 Image("littleLemonLogo")
                     .resizable()
                     .scaledToFit()
                     .frame(height: 40)
                 
             }
             
         }
         
     }
     
     func getCheckoutItem () {
         
         extraItems = []
         
         if let lastAvocado = avocados.last {
             extraItems.append(lastAvocado)
         }
         
         if let lastDressing = dressings.last {
             extraItems.append(lastDressing)
         }
         
         if let lastSeed = seeds.last {
             extraItems.append(lastSeed)
         }
     }
     
     func getExtraItemTotal(itemPrice: String, itemTitle: String, qty: Int) {
         
         
         switch itemTitle {
         case "Avocado":
             let avocado = ExtraItemsModel(extraItemPrice: itemPrice, extraItemTitle: itemTitle, extrItemQty: qty)
             avocados.append(avocado)
             
         case "Seeds":
             let seed = ExtraItemsModel(extraItemPrice: itemPrice, extraItemTitle: itemTitle, extrItemQty: qty)
             seeds.append(seed)
             
         case "Dressing":
             let dressing = ExtraItemsModel(extraItemPrice: itemPrice, extraItemTitle: itemTitle, extrItemQty: qty)
             dressings.append(dressing)
         default:
             break
         }
         
     }
     
     
     func calculteSubtotal() {
         
         let subTotalDishPrice = Double(itemQty) * ((dish.price as NSString?)?.doubleValue ?? 33.05)
         
         var extraItemsSubtotal: Double = 0
         
         for item in extraItems {
             
             let price = (item.extraItemPrice as NSString).doubleValue
             let qty = Double(item.extrItemQty)
             let itemSubtotal = price * qty
             extraItemsSubtotal += itemSubtotal
         }
         
         subTotal = subTotalDishPrice + (extraItemsSubtotal * Double(itemQty))
         
     }
     
 }

 struct DishView_Previews: PreviewProvider {
     static let context = PersistenceController.shared.container.viewContext
     let dish = DishEntity(context: context)
     static var previews: some View {
         DishPreView(dish: oneDish())
             .environmentObject(ExtraItemsViewModel())
             .environmentObject(NavigationStateManager())
             .environmentObject(CartViewModel())
             .environmentObject(HamburguerMenu())
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

 
 */