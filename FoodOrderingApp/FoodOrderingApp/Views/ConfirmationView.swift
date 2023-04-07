//
//  ConfirmationView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 4/1/23.
//

import SwiftUI
import MapKit

struct ConfirmationView: View {
    
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var screenNavigator: NavigationStateManager
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    @EnvironmentObject var mapAPI: MapAPI
    
    @Environment(\.dismiss) var dismiss
    
    @State var isOrderPlaced: Bool = true
    @State var isOrderBeingPrepared: Bool = true
    @State var isOrderOnTheWay: Bool = false
    @State var isOrderDelivered: Bool = false
    @State var isOrderReady: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    // order variables
    
    
    @State var orders: [CheckoutOrder]
    
    @State var items: [ItemAdded] = []
    @State var total: Double = 0
    @State var deliveryOption: Bool = true
    @State var dropOffOption: DropOffOption = .leaveIt
    @State var pickUpOption:Bool = false
    @State var deliveryInstructions: String = ""
    @State var courierTip: Double = 0
    @State var deliveryFee: Double = 0
    @State var deliverytime: Double = 0
    @State var deliveryAddress: String = "Chicago"
    @State var pickUpAddress: String = "160 N La Salle St, Chicago, IL 60601"
    @State var pickUpTime: Date = (Calendar.current.date(byAdding: .minute, value: 20, to: Date()) ?? Date())
    @State var pickUpSpecialRequest: String = ""
    @State var nameofOrder: String = "Adrian"
    @State var emailOrder: String = "adrian@email.com"
    @State var orderNumber: Int = 651243654263
    @State var subTotal: Double = 0
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Group {
                    
                    if deliveryOption {
                        
                        ForEach($mapAPI.locations) { $location in
                            
                            mapView(userLocation: $location.coordinate)
                                .frame(height: 250)
                                .environmentObject(mapAPI)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                            
                        }
                        .onAppear {
                            mapAPI.getLocation(address: deliveryAddress, delta: 0.1)
                        }
                        
                    } else {
                        
                        Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { location in
                            MapAnnotation(coordinate: location.coordinate) {
                                ZStack {
                                    
                                    Image(systemName: "building.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.blue)
                                    
                                    Text("Little Lemon").underline()
                                        .paragraphText()
                                        .offset(x: 60)
                                }
                                
                                
                            }
                        }
                        .frame(height: 250)
                        .environmentObject(mapAPI)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .onAppear {
                            mapAPI.getLocation(address: pickUpAddress, delta: 0.01)
                        }
                        
                        
                    }
                }
                
                VStack {
                    
                    Group {
                        
                        VStack {
                            
                            HStack(spacing: 10) {
                                
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 34)
                                    .foregroundColor(Color("PrimaryColor1"))
                                    .offset(y: -8)
                                
                                VStack(alignment: .leading) {
                                    Text("Order confirmed!".uppercased())
                                        .sectionTitle()
                                    
                                    Text("Order# - \(String(orderNumber))") // order.orderNumber
                                        .paragraphText()
                                }
                                
                                Spacer()
                                
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        Text("Little Lemon has all the ingredients ready to cook up a special treat for you!")
                        
                            .paragraphText()
                            .padding(.top, 5)
                        
                    }
                    
                    ScrollView {
                        
                        Group {
                            
                            
                            if deliveryOption {
                                
                                HStack {
                                    Text("Estimated time of delivery")
                                        .cardTitle()
                                    
                                    Spacer()
                                    
                                    Text("\(Int((deliverytime/60).rounded()) + 30) min")
                                        .cardTitle()
                                }
                                .padding(.top)
                                
                            }
                            
                            else {
                                
                                VStack(alignment: .leading ,spacing: 5) {
                                    Text("Estimated date of pick-up")
                                        .cardTitle()
                                    
                                    Text("\(dateFormatter.string(from: pickUpTime))")
                                        .paragraphText()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                                
                                
                            }
                            
                        }
                        
                        Group {
                            
                            if deliveryOption {
                                VStack {
                                    
                                    HStack {
                                        
                                        Image(systemName: isOrderPlaced ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                
                                            }
                                        
                                        if !isOrderBeingPrepared {
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                        }
                                        else {
                                            
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [100]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                            
                                        }
                                        
                                        Image(systemName: isOrderBeingPrepared ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                
                                                if !isOrderOnTheWay && !isOrderDelivered {
                                                    isOrderBeingPrepared.toggle()
                                                }
                                                if isOrderPlaced == false {
                                                    isOrderPlaced.toggle()
                                                }
                                            }
                                        
                                        
                                        if !isOrderOnTheWay {
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                        }
                                        else {
                                            
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [100]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                            
                                        }
                                        
                                        Image(systemName: isOrderOnTheWay ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                
                                                if !isOrderDelivered {
                                                    isOrderOnTheWay.toggle()
                                                }
                                                if isOrderPlaced == false {
                                                    isOrderPlaced.toggle()
                                                }
                                                if isOrderBeingPrepared == false {
                                                    isOrderBeingPrepared.toggle()
                                                }
                                            }
                                        
                                        
                                        if !isOrderDelivered {
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                        }
                                        else {
                                            
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [100]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                            
                                        }
                                        
                                        Image(systemName: isOrderDelivered ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                isOrderDelivered.toggle()
                                                if isOrderBeingPrepared == false {
                                                    isOrderBeingPrepared.toggle()
                                                }
                                                if isOrderOnTheWay == false {
                                                    isOrderOnTheWay.toggle()
                                                }
                                            }
                                        
                                        
                                    }
                                    
                                    HStack {
                                        
                                        Text("Placed")
                                            .paragraphTextMini()
                                        
                                        Spacer()
                                        
                                        Text("Preparing")
                                            .paragraphTextMini()
                                            .offset(x: 12)
                                        
                                        Spacer()
                                        
                                        Text("On the way")
                                            .paragraphTextMini()
                                            .offset(x: 10)
                                        
                                        Spacer()
                                        
                                        Text("Delivered")
                                            .paragraphTextMini()
                                            .offset(x: 8)
                                    }
                                    .padding(.horizontal, -10)
                                    
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                
                            }
                            
                            else {
                                VStack {
                                    
                                    HStack {
                                        
                                        Image(systemName: isOrderPlaced ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                isOrderBeingPrepared = false
                                                isOrderReady = false
                                            }
                                        
                                        if !isOrderBeingPrepared {
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                        }
                                        else {
                                            
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [500]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                            
                                        }
                                        
                                        Image(systemName: isOrderBeingPrepared ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                isOrderBeingPrepared.toggle()
                                                isOrderReady = false
                                            }
                                        
                                        if !isOrderReady {
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                        }
                                        else {
                                            
                                            Line()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [500]))
                                                .frame(height: 1)
                                                .padding(.horizontal, -8)
                                                .foregroundColor(Color("PrimaryColor1"))
                                            
                                        }
                                        
                                        Image(systemName: isOrderReady ? "circle.inset.filled" : "circle.dashed")
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .onTapGesture {
                                                isOrderReady.toggle()
                                            }
                                        
                                        
                                    }
                                    
                                    HStack {
                                        
                                        Text("Placed")
                                            .paragraphTextMini()
                                        
                                        Spacer()
                                        
                                        
                                        Text("Preparing")
                                            .paragraphTextMini()
                                        
                                        
                                        Spacer()
                                        
                                        Text("Ready")
                                            .paragraphTextMini()
                                        
                                    }
                                    .padding(.horizontal, -10)
                                    
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                                
                            }
                            
                        }
                        
                        Group {
                            Text(deliveryOption ? "Delivery address" : "Pick-up address").cardTitle()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                                .padding(.bottom, -2)
                            
                            VStack(alignment: .leading) {
                                Text(deliveryOption ? nameofOrder : "Little Lemon Chicago").paragraphText()
                                Text(deliveryOption ? deliveryAddress : pickUpAddress).paragraphText()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 1)
                            .padding(.bottom)
                            
                            Text(deliveryOption ? "Delivery Instructions" : "Special instrucions").cardTitle()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, -2)
                            
                            HStack{
                                
                                if deliveryOption {
                                    switch dropOffOption {
                                    case .handIt:
                                        Text("Hand it to me:")
                                            .paragraphText()
                                            .underline()
                                    case .leaveIt:
                                        Text("Leave at the door:")
                                            .paragraphText()
                                            .underline()
                                    }
                                    
                                    Text(deliveryInstructions.isEmpty ? "No special request" : deliveryInstructions)
                                        .paragraphText()
                                } else {
                                    
                                    Text(pickUpSpecialRequest.isEmpty ? "None" : pickUpSpecialRequest)
                                        .paragraphText()
                                    
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        }
                        
                        Group {
                            
                            VStack{
                                
                                Text("Items:").underline().cardTitle()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                
                                ForEach($items) { $item in
                                    ItemCartPreview(dish: item, isEditOn: true, stepperValue: $item.dishQty, subTotal: $item.subTotal)
                                }
                                .padding(.horizontal, 10)
                                
                            }
                            
                        }
                        
                        Group {
                            
                            Text("order summary".uppercased()).sectionTitle()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            //                            .padding(.leading, 20)
                                .padding(.top, 30)
                                .padding(.bottom, 5)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Subtotal").leadText()
                                    Spacer()
                                    Text("$ \(String(format: "%.2f", subTotal))")
                                        .leadText()
                                        .frame(width: 80, alignment: .leading)
                                }
                                
                                if deliveryOption {
                                    HStack {
                                        Text("Delivery Fee").leadText()
                                        Spacer()
                                        Text("$ \(String(format: "%.2f", deliveryFee))")
                                            .leadText()
                                            .frame(width:80, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("Courier Tip").leadText()
                                        Spacer()
                                        Text("$ \(String(format: "%.2f", courierTip))")
                                            .leadText()
                                            .frame(width:80, alignment: .leading)
                                    }
                                }
                                
                                HStack {
                                    Text("Tax").leadText()
                                    Spacer()
                                    Text("$ \(String(format: "%.2f", (deliveryOption ? (total - subTotal - deliveryFee - courierTip ) : (total - subTotal))))")
                                        .leadText()
                                        .frame(width:80, alignment: .leading)
                                }
                                
                                Rectangle()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                
                                
                                HStack {
                                    Text("Total").leadText()
                                    Spacer()
                                    Text("$ \(String(format: "%.2f", total))").leadText()
                                        .frame(width:80, alignment: .leading)
                                }
                                .padding(.top, 10)
                                
                            }.padding(.horizontal, 20)
                            
                        }
                        
                        Group {
                            
                            Text("We have sent a confirmation e-mail to \(emailOrder) with your Order# \(String(orderNumber)) with more details.")
                                .paragraphText()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            Button {
                                
                                for order in checkoutViewModel.order {
                                    checkoutViewModel.history.append(order)
                                }
                                itemAddedViewModel.itemAdded = []
                                itemAddedViewModel.cartItemsNumber = 0
                                checkoutViewModel.order = []
                                
                                screenNavigator.popToRoot()
                                
                                
                            } label: {
                                Text("Home Page")
                                    .primaryButton()
                                    .padding(.horizontal, -20)
                            }
                            .padding(.top)
                            .padding(.bottom, 10)
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                .padding(.horizontal, 20)
                
            }
            
        }
        .onAppear(perform: {
            getOrder()
        })
        .toolbarBackground(.white, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
        .toolbar {
            
            if checkoutViewModel.isHistory {
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
            }
            
            ToolbarItem(placement: .principal) {
                
                Image("littleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                
            }
            
            
            
        }
        
        
        
    }
    
    func getOrder() {
        
        for order in orders {
            items = order.items
            total = order.total
            deliveryOption = order.deliveryOption
            dropOffOption = order.dropOffOption
            pickUpOption = order.pickUpOption
            deliveryInstructions = order.deliveryInstructions
            courierTip = order.courierTip
            deliveryFee = order.deliveryFee
            deliverytime = order.deliverytime
            deliveryAddress = order.deliveryAddress
            pickUpAddress = order.pickUpAddress
            pickUpTime = order.pickUpTime
            pickUpSpecialRequest = order.pickUpSpecialRequest
            nameofOrder = order.nameofOrder
            emailOrder = order.emailOrder
            orderNumber = order.orderNumber
            
            for cartItem in items {
                subTotal += cartItem.subTotal
            }
            
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    
    static let context = PersistenceController.shared.container.viewContext
    
    static var previews: some View {
        ConfirmationView(
            orders: [CheckoutOrder(items: [ItemAdded(extraItem: [ExtraItemsModel(extraItemPrice: "1.4", extraItemTitle: "Avocado", extrItemQty: 3)],
                                                     dish: oneDish(),
                                                     dishQty: 2,
                                                     specialRequest: "none",
                                                     subTotal: 23.45)],
                                   total: 45.87,
                                   deliveryOption: true,
                                   dropOffOption: .leaveIt,
                                   pickUpOption: false,
                                   deliveryInstructions: "",
                                   courierTip: 3,
                                   deliveryFee: 45,
                                   deliverytime: 60,
                                   deliveryAddress: "Chicago",
                                   pickUpAddress: "160 N La Salle St, Chicago, IL 60601",
                                   pickUpTime: (Calendar.current.date(byAdding: .minute, value: 20, to: Date()) ?? Date()),
                                   pickUpSpecialRequest: "",
                                   nameofOrder: "Adrian",
                                   emailOrder: "adrian@email.com",
                                   orderNumber: 651243654263)])
        .environmentObject(MapAPI())
        .environmentObject(CheckoutViewModel())
        .environmentObject(CartViewModel())
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

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
