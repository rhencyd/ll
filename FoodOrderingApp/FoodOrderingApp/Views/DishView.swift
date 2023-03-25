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
    @EnvironmentObject var itemAddedViewModel: ItemAddedViewModel
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    
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
            Header(navigationValue: ScreenNavigationValue.cartView, view: AnyView(TabItemCartImage()))
            
            ScrollView {
                
                ZStack {
                    
//                    AsyncImage(url: URL(string: dish.image!)) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }
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
                            .focused($specialInstructionsInFocus)
                            .frame(height: 200, alignment: .topLeading)
                            .background((Color("HighlightColor1")))
                            .cornerRadius(8)
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
//                itemAddedViewModel.cartItemsNumber += 1
                
                print(itemAddedViewModel.cartItemsNumber)
                print(itemAddedViewModel.itemAdded)
                dismiss()
//                navigationStateManager.goToHome()
                
                
            } label: {
                Text("Add for $\(String(format: "%.2f", subTotal))").primaryButton()
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        
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
            .environmentObject(ItemAddedViewModel())
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
