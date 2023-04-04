//
//  CheckOutView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/29/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct CheckOutView: View {
    
    
    @EnvironmentObject var mapAPI: MapAPI
    @EnvironmentObject var itemAddedViewModel: CartViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var addressHasChanged: Bool = false
    @State var isDeliveryButtonPressed: Bool = false
    @State var showAlert: Bool = false
    @State var disableButton: Bool = false
    
    @State var time: Double = 0
    
    
    // order variables - Bindings
    @State var totalOrder: Double = 0
    @State var address: String = ""
    @State var nameofOrder: String = ""
    @State var emailOrder: String = ""
    @State var dropOffOption: DropOffOption = .handIt
    @State var deliveryInstructions: String = ""
    @State var courierTip: Double = 0
    @State var deliveryFee: Double = 0

    
    
    // delivery address variables
    @State var verifyAddress: Bool = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var line1: String = ""
    @State var line2: String = ""
    @State var city: String = ""
    @State var zipCode: String = ""
    @State var stateSelection: String = "IL"
    
    
    enum VerifyDeliveryAddress: Hashable {
        case firstName
        case lastName
        case email
        case line1
        case line2
        case city
        case zipCode
        case stateSelection
        case button
    }
    
    @FocusState private var fieldInFocus: VerifyDeliveryAddress?
    
    
    // verification of fields
    @State var wrongFirstName: Bool = false
    @State var wrongLastName: Bool = false
    @State var wrongEmail: Bool = false
    @State var wrongLine1: Bool = false
    @State var wrongCity: Bool = false
    @State var wrongZipCode: Bool = false
    
    
    // App Storage
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @AppStorage("first_name") var currentUserFirstName: String?
    @AppStorage("last_name") var currentUserLastName: String?
    @AppStorage("email_address") var currentUserEmail: String?
    @AppStorage("line1_address") var currentUserLine1: String?
    @AppStorage("line2_address") var currentUserLine2: String?
    @AppStorage("city") var currentUserCity: String?
    @AppStorage("state") var currentUserState: String?
    @AppStorage("zip_code") var currentUserZipCode: String?
    @AppStorage("complete_address") var currentUserCompleteAddress: String?
    
    
    // set change activity
    @State var firstNameHasChanged: Bool = false
    @State var lastNameHasChanged: Bool = false
    @State var emailHasChanged: Bool = false
    @State var line1HasChanged: Bool = false
    @State var line2HasChanged: Bool = false
    @State var cityHasChanged: Bool = false
    @State var stateHasChanged: Bool = false
    @State var zipCodeHasChanged: Bool = false
    
    // comparable variables
    
    @State var CfirstName: String = ""
    @State var ClastName: String = ""
    @State var Cemail: String = ""
    @State var Cline1: String = ""
    @State var Cline2: String = ""
    @State var Ccity: String = ""
    @State var CzipCode: String = ""
    @State var CstateSelection: String = "IL"
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                ForEach($mapAPI.locations) { $location in
                    mapView(userLocation: $location.coordinate)
                        .frame(height: 250)
                        .padding(.top, 5)
                }
                
                DeliveryAndPickUpTabBars(
                    verifyAddress: $verifyAddress,
                    customerAddress: $address,
                    subTotal: $itemAddedViewModel.subTotal,
                    time: $mapAPI.time,
                    distance: $mapAPI.distance,
                    isDeliveryButtonPressed: $isDeliveryButtonPressed,
                    totalOrder: $totalOrder,
                    dropOffOption: $dropOffOption,
                    deliveryInstructions: $deliveryInstructions,
                    finalTip: $courierTip,
                    deliveryFee: $deliveryFee,
                    showAlert: $showAlert,
                    disableButton: $disableButton)
                
            }
            .disabled(verifyAddress)
            .onAppear {
                
                getFirstDirection()
                
                if isCurrentUserSignedIn {
                    nameofOrder = "\((currentUserFirstName ?? "User name").capitalized) \((currentUserLastName ?? "last name").capitalized)"
                    emailOrder = currentUserEmail ?? "email"
                }
                
            }
            
            
            .overlay (
                updateAddress()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("PrimaryColor1"), lineWidth: 3)
                            .edgesIgnoringSafeArea(.bottom)
                    })
                    .padding(.top, 250)
                    .offset(y: verifyAddress ? 0 : UIScreen.main.bounds.height)
                    .animation(.spring(), value: verifyAddress)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isThereChanges()
                        }
                    })
            )
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Please verify your information before proceeding"))
        }
        
        
        .toolbarBackground(.white, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .modifier(AdaptsToSoftwareKeyboard())
        .ignoresSafeArea(.keyboard)
    
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
                Text("Checkout".uppercased())
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(Color("HighlightColor2"))
        
            }
            
        }
    }
    
    func updateAddress() -> some View {
        
        ScrollView {
            
                
                VStack(spacing: 15) {
                    
                    
                    HStack {
                        
                        Text("delivery address".uppercased()).sectionTitle()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 20)
                        
                        Spacer()
                        
                        Button {
                           verifyAddress = false
                            disableButton = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("PrimaryColor1"))
                        }
                        .offset(x: -10, y: -10)
                    }
                    
                    
                   
                    
                    
                    HStack {
                        
                        // name of:
                        
                        VStack(alignment: .leading) {
                            
                            Text("First Name")
                                .font(Font.custom("Karla-Bold", size: 16))
                                .padding(.bottom, 3)
                            
                            
                            ZStack(alignment: .trailing) {
                                
                                TextField(firstName, text: $firstName)
                                    .normalTextInput()
                                    .lineLimit(1)
                                    .textContentType(.givenName)
                                    .focused($fieldInFocus, equals: .firstName)
                                    .onChange(of: firstName, perform: { newValue in
                                        
                                        let firstNameIsValid = firstName.count > 2
                                        
                                        if firstNameIsValid {
                                            wrongFirstName = false
                                        }
                                        else {
                                            wrongFirstName = true
                                        }
                                        
                                        isThereChanges()
                                        
                                    })
                                    .onSubmit {
                                        
                                        if wrongFirstName || firstName.isEmpty {
                                            fieldInFocus = .firstName
                                            firstName = ""
                                        } else {
                                            fieldInFocus = .lastName
                                        }
                                        
                                    }
                                    .onAppear {
                                        firstName = CfirstName
                                    }
                                
                                    if !wrongFirstName && !firstName.isEmpty {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 11, height: 11)
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .padding(.horizontal, 15)
                                            .onAppear {
                                                firstNameHasChanged = true
                                            }
                                            .onDisappear {
                                                firstNameHasChanged = false
                                            }
                                    }
                            }
                            
                            if wrongFirstName {
                                Text("First Name should be at least three characters long")
                                    .font(Font.custom("Karla-Regular", size: 10))
                                    .foregroundColor(Color.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, -5)
                            }
                        }
                        
                        
                        // last name
                        
                        VStack(alignment: .leading) {
                            
                            Text("Last Name")
                                .font(Font.custom("Karla-Bold", size: 16))
                                .padding(.bottom, 3)
                            
                            ZStack(alignment: .trailing) {
                                
                                TextField(lastName, text: $lastName)
                                    .normalTextInput()
                                    .textContentType(.familyName)
                                    .focused($fieldInFocus, equals: .lastName)
                                    .onChange(of: lastName, perform: { newValue in
                                        
                                        let lastNameIsValid = lastName.count > 2
                                        
                                        if lastNameIsValid {
                                            wrongLastName = false
                                        }
                                        else {
                                            wrongLastName = true
                                        }
                                        
                                        isThereChanges()
                                        
                                    })
                                    .onSubmit {
                                        
                                        if wrongLastName || lastName.isEmpty {
                                            fieldInFocus = .lastName
                                            lastName = ""
                                        }
                                        else {
                                            fieldInFocus = .email
                                        }
                                    }
                                    .onAppear {
                                        lastName = ClastName
                                    }
                                
                                    if !wrongLastName && !lastName.isEmpty {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 11, height: 11)
                                            .foregroundColor(Color("PrimaryColor1"))
                                            .padding(.horizontal, 15)
                                            .onAppear {
                                                lastNameHasChanged = true
                                            }
                                            .onDisappear {
                                                lastNameHasChanged = false
                                            }
                                    }
                            }
                            
                            if wrongLastName {
                                Text("Last Name should be at least three characters long")
                                    .font(Font.custom("Karla-Regular", size: 10))
                                    .foregroundColor(Color.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, -5)
                            }
                            
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField(email, text: $email)
                                .emailTextInput()
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .focused($fieldInFocus, equals: .email)
                                .onChange(of: email, perform: { newValue in
                                    
                                    if self.textFieldValidatorEmail(newValue) {
                                        wrongEmail = false
                                    } else {
                                        wrongEmail = true
                                    }
                                    
                                    isThereChanges()
                                    
                                })
                                .onSubmit {
                                    
                                    if wrongEmail || email.isEmpty {
                                        fieldInFocus = .email
                                        email = ""
                                    } else {
                                        fieldInFocus = .line1
                                    }
                                }
                                .onAppear {
                                    email = Cemail
                                }
                            
                                if !wrongEmail && !email.isEmpty {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 15)
                                        .onAppear {
                                            emailHasChanged = true
                                        }
                                        .onDisappear {
                                            emailHasChanged = false
                                        }
                                }
                        }
                        
                        if wrongEmail {
                            Text("Please enter a valid email address")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, -5)
                        }
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Line 1")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField(line1, text: $line1)
                                .normalTextInput()
                                .textContentType(.streetAddressLine1)
                                .focused($fieldInFocus, equals: .line1)
                                .onChange(of: line1, perform: { newValue in
                                    
                                    if line1.count < 1 {
                                        wrongLine1 = true
                                    } else {
                                        wrongLine1 = false
                                    }
                                    
                                    isThereChanges()
                                    
                                })
                            
                                .onSubmit {
                                    
                                    if wrongLine1 || line1.isEmpty {
                                        fieldInFocus = .line1
                                        line1 = ""
                                    } else {
                                        fieldInFocus = .zipCode
                                        fieldInFocus = .line2
                                    }
                                }
                                .onAppear {
                                    line1 = Cline1
                                }
                            
                                if !wrongLine1 && !line1.isEmpty {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 15)
                                        .onAppear {
                                            line1HasChanged = true
                                        }
                                        .onDisappear {
                                            line1HasChanged = false
                                        }
                                }
                        }
                        
                        if wrongLine1 {
                            Text("Please enter a valid address")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, -5)
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Line 2 (Optional)")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        TextField(line2, text: $line2)
                            .normalTextInput()
                            .textContentType(.streetAddressLine2)
                            .focused($fieldInFocus, equals: .line2)
                            .onChange(of: line2, perform: { newValue in
                                if let currentUserLine2 = currentUserLine2 {
                                    if !line2.isEmpty && line2 != currentUserLine2 {
                                        line2HasChanged = true
                                    }
                                }
                                isThereChanges()
                            })
                            .onSubmit {
                                fieldInFocus = .button
                                fieldInFocus = .city
                            }
                            .onAppear {
                                line2 = Cline2
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("City")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField(city, text: $city)
                                .normalTextInput()
                                .textContentType(.addressCity)
                                .focused($fieldInFocus, equals: .city)
                                .onChange(of: city, perform: { newValue in
                                    
                                    if city.isEmpty {
                                        wrongCity = true
                                    } else {
                                        wrongCity = false
                                    }
                                    
                                    isThereChanges()
                                    
                                })
                                .onSubmit {
                                    if wrongCity || city.isEmpty {
                                        fieldInFocus = .city
                                        city = ""
                                    } else {
                                        fieldInFocus = .stateSelection
                                    }
                                }
                                .onAppear {
                                    city = Ccity
                                }
                            
                                if !wrongCity && !city.isEmpty {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 15)
                                        .onAppear {
                                            cityHasChanged = true
                                        }
                                        .onDisappear {
                                            cityHasChanged = false
                                        }
                                }
                        }
                        
                        if wrongCity {
                            Text("Please enter a valid City")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, -5)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("State")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        statePicker()
                            .tint(Color("HighlightColor2"))
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .focused($fieldInFocus, equals: .stateSelection)
                            .background(Color("HighlightColor1").cornerRadius(8))
                            .onChange(of: stateSelection, perform: { newValue in
                                fieldInFocus = .button
                                fieldInFocus = .zipCode
                                stateHasChanged = true
                                isThereChanges()
                            })
                            .onAppear {
                               stateSelection = CstateSelection
                            }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Zip Code")
                            .font(Font.custom("Karla-Bold", size: 16))
                            .padding(.bottom, 3)
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField(zipCode ,text: $zipCode)
                                .numberTextInput()
                                .keyboardType(.phonePad)
                                .focused($fieldInFocus, equals: .zipCode)
                                .submitLabel(.continue)
                                .onChange(of: zipCode) { newValue in
                                    
                                    if self.validateZipCode(input: newValue) {
                                        fieldInFocus = .button
                                        wrongZipCode = false
//                                        fieldInFocus = .password
                                    } else {
                                        fieldInFocus = .zipCode
                                        wrongZipCode = true
                                    }
                                    
                                    isThereChanges()
                                }
                                .onSubmit {
                                    
                                    if wrongZipCode || zipCode.isEmpty {
                                        fieldInFocus = .zipCode
                                        zipCode = ""
                                    } else {
                                        fieldInFocus = .button
                                    }
                                }
                            
                                .onAppear {
                                    zipCode = CzipCode
                                }
                            
                                if !wrongZipCode && !zipCode.isEmpty {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 15)
                                        .onAppear {
                                            zipCodeHasChanged = true
                                        }
                                        .onDisappear {
                                            zipCodeHasChanged = false
                                        }
                                }
                        }
                        
                        if wrongZipCode {
                            Text("Please enter a valid Zip Code")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, -5)
                        }
                    }
                    
                    Spacer()
                   
                    
                    if isDeliveryButtonPressed && !addressHasChanged {
                        
                        NavigationLink(value: ScreenNavigationValue.payment) {
                            Text("Confirm and Pay")
                                .primaryButton()
                                .padding(.horizontal, -20)
                                .focused($fieldInFocus, equals: .button)
                        }
                        .simultaneousGesture(TapGesture().onEnded({ action in
                            checkoutViewModel.getOrder(
                                items: itemAddedViewModel.itemAdded,
                                total: totalOrder,
                                deliveryOption: true,
                                dropOffOption: dropOffOption,
                                pickUpOption: false,
                                deliveryInstructions: deliveryInstructions,
                                courierTip: courierTip,
                                deliveryFee: deliveryFee,
                                deliverytime: mapAPI.time,
                                deliveryAddress: address,
                                pickUpAddress: "",
                                pickUpTime: Date(),
                                pickUpSpecialRequest: "",
                                nameofOrder: nameofOrder,
                                emailOrder: emailOrder)
                            
                            verifyAddress = false
                            disableButton = false
                            
                            print(checkoutViewModel.order)
                        }))
                       
                        
                    } else {
                        
                        Button {
                            
                            isThereChanges()
                            
                            if addressHasChanged {
                                checkEverything()
                                getWrongFields()
                                save()
                                isThereChanges()
                            }
                            else {
                                verifyAddress = false
                                disableButton = false
                                
                            }
                            
                        } label: {
                            
                            
                            if addressHasChanged {
                                Text("Save").primaryButton()
                                    .padding(.horizontal, -20)
                                    .focused($fieldInFocus, equals: .button)
                            }
                            else {
                                Text("Looks fine").primaryButton()
                                    .padding(.horizontal, -20)
                                    .focused($fieldInFocus, equals: .button)
                            }
                            
                        }
                        
                        
                    }
                }

                .padding(.horizontal, 20)
            
        }
        .padding(.top, 25)
        .background(Color.white)
        
    }
    
    func isThereChanges() {
        
            if firstName == CfirstName &&
                lastName == ClastName &&
                email == Cemail &&
                line1 == Cline1 &&
                line2 == Cline2 &&
                city == Ccity &&
                stateSelection == CstateSelection &&
                zipCode == CzipCode {
                
                addressHasChanged = false
            }
        else {
                addressHasChanged = true
            }
        
        if firstName.isEmpty &&
            lastName.isEmpty &&
            email.isEmpty &&
            line1.isEmpty &&
            line2.isEmpty &&
            city.isEmpty &&
            zipCode.isEmpty {
            addressHasChanged = true
        }
        
    }
    
    func getFirstDirection() {
        
        getComparableVaraibles()
        
        if firstName.isEmpty &&
            lastName.isEmpty &&
            email.isEmpty &&
            line1.isEmpty &&
            line2.isEmpty &&
            city.isEmpty &&
            zipCode.isEmpty {
            
            if isCurrentUserSignedIn {
                address = currentUserCompleteAddress ?? "Chicago"
                mapAPI.getLocation(address: address, delta: 0.1)
            }
            else  {
                address = "Chicago"
                mapAPI.getLocation(address: address, delta: 0.1)
            }
            
        }
        
    }
    
    func checkEverything() {
        
        // checking firstName field
        let firstNameIsValid = firstName.count > 2
        
        if firstNameIsValid {
            wrongFirstName = false
        }
        else {
            firstName = ""
            wrongFirstName = true
        }
        
        // checking lastNameField
        let lastNameIsValid = lastName.count > 2
        
        if lastNameIsValid {
            wrongLastName = false
        }
        else {
            lastName = ""
            wrongLastName = true
        }
        
        // checking email field
        if self.textFieldValidatorEmail(self.email) {
            wrongEmail = false
        } else {
            email = ""
            wrongEmail = true
        }
        
        // checking line1 field
        if line1.count < 1 {
            wrongLine1 = true
        } else {
            wrongLine1 = false
        }
        
        // checking city field
        if city.isEmpty {
            wrongCity = true
        } else {
            wrongCity = false
        }
        
        // checking zipCode field
        if self.validateZipCode(input: self.zipCode) {
            wrongZipCode = false
        } else {
            wrongZipCode = true
        }
        
    }
    
    func getWrongFields() {
        
        if wrongFirstName {
            fieldInFocus = .firstName
        }
        else if wrongLastName {
            fieldInFocus = .lastName
        }
        else if wrongEmail {
            fieldInFocus = .email
        }
        else if wrongLine1 {
            fieldInFocus = .line1
        }
        else if wrongCity {
            fieldInFocus = .city
        }
        else if wrongZipCode {
            fieldInFocus = .zipCode
        }
    }
    
    
    private func statePicker() -> some View {
        
        Picker(
            selection: $stateSelection) {
                ForEach(contentViewModel.statesArray, id: \.self) { state in
                    Text(state.name)
                        .font(Font.custom("Karla-Regular", size: 16))
                        .frame(width: 1000)
                        .lineLimit(20)
                        .tag(state.abbreviation)
                }
            } label: {
                Text("State Picker")
            }
            .pickerStyle(.automatic)
        
    }
    
    func validateZipCode(input: String?) -> Bool {
        guard let input = input else { return false }
        
        return NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-\\s]?\\d{4})?$")
            .evaluate(with: input.uppercased())
    }
    
    
    func save() {

        if isCurrentUserSignedIn {
            if firstNameHasChanged || lastNameHasChanged || line1HasChanged || line2HasChanged ||
                cityHasChanged || stateHasChanged || zipCodeHasChanged || emailHasChanged {
                
                if line2.isEmpty || line2 == "NA" {
                    address = "\(line1), \(city), \(stateSelection) \(zipCode)"
                    CfirstName = firstName
                    ClastName = lastName
                    Cemail = email
                    Cline1 = line1
                    Cline2 = line2
                    Ccity = city
                    CstateSelection = stateSelection
                    CzipCode = zipCode
                } else {
                    address = "\(line1), \(line2), \(city), \(stateSelection) \(zipCode)"
                    CfirstName = firstName
                    ClastName = lastName
                    Cemail = email
                    Cline1 = line1
                    Cline2 = line2
                    Ccity = city
                    CstateSelection = stateSelection
                    CzipCode = zipCode
                }
                
                nameofOrder = "\(firstName.capitalized) \(lastName.capitalized)"
                emailOrder = email
                verifyAddress.toggle()
                mapAPI.getLocation(address: address, delta: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    disableButton = false
                }
            }
        }
        else {
            if !wrongFirstName && !wrongLastName && !wrongEmail &&
                !wrongLine1 && !wrongCity &&
                !wrongZipCode {
                
                if line2.isEmpty || line2 == "NA" {
                    address = "\(line1), \(city), \(stateSelection) \(zipCode)"
                    CfirstName = firstName
                    ClastName = lastName
                    Cemail = email
                    Cline1 = line1
                    Cline2 = line2
                    Ccity = city
                    CstateSelection = stateSelection
                    CzipCode = zipCode
                    
                } else {
                    address = "\(line1), \(line2), \(city), \(stateSelection) \(zipCode)"
                    CfirstName = firstName
                    ClastName = lastName
                    Cemail = email
                    Cline1 = line1
                    Cline2 = line2
                    Ccity = city
                    CstateSelection = stateSelection
                    CzipCode = zipCode
                }
                
                nameofOrder = "\(firstName.capitalized) \(lastName.capitalized)"
                emailOrder = email
                verifyAddress.toggle()
                mapAPI.getLocation(address: address, delta: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    disableButton = false
                }
            }
        }
    }
    
    func getComparableVaraibles() {
        
        if firstName.isEmpty &&
            lastName.isEmpty &&
            email.isEmpty &&
            line1.isEmpty &&
            line2.isEmpty &&
            city.isEmpty &&
            zipCode.isEmpty {
            
            
            if isCurrentUserSignedIn {
                
                CfirstName = currentUserFirstName ?? "First Name"
                ClastName = currentUserLastName ?? "Last Name"
                Cemail = currentUserEmail ?? "email"
                Cline1 = currentUserLine1 ?? "Line 1"
                Cline2 = currentUserLine2 ?? ""
                Ccity = currentUserCity ?? "City"
                CstateSelection = currentUserState ?? "State"
                CzipCode = currentUserZipCode ?? "Zip Code"
                
            } else {
                
                CfirstName = ""
                ClastName = ""
                Cemail = ""
                Cline1 = ""
                Cline2 = ""
                Ccity = ""
                CstateSelection = "IL"
                CzipCode = ""
                
            }
        }
        
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
            .environmentObject(CheckoutViewModel())
    }
}

//struct mapView: UIViewRepresentable {
//
//    @EnvironmentObject var mapAPI: MapAPI
//    @Binding var userLocation: CLLocationCoordinate2D
//    
//
//    func makeCoordinator() -> Coordinator {
//        return mapView.Coordinator()
//    }
//
//    
//    func makeUIView(context: Context) -> MKMapView {
//        
//        let map = MKMapView()
//        
//        let exampleRestaurantLocation = CLLocationCoordinate2D(latitude: 41.884930, longitude: -87.632940)
//
//        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//
//        let region: MKCoordinateRegion = MKCoordinateRegion(center: exampleRestaurantLocation, span: span)
//
//        let sourcePin = MKPointAnnotation()
//        sourcePin.coordinate = exampleRestaurantLocation
//        sourcePin.title = "Little Lemon Example"
//        map.addAnnotation(sourcePin)
//
//        let destinationPin = MKPointAnnotation()
//        destinationPin.coordinate = userLocation
//        destinationPin.title = "My Address"
//        map.addAnnotation(destinationPin)
//
//        map.region = region
//        map.delegate = context.coordinator
//
//        let req = MKDirections.Request()
//        req.source = MKMapItem(placemark: MKPlacemark(coordinate: exampleRestaurantLocation))
//        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
//        
//
//        let directions = MKDirections(request: req)
//
////        let transportType: MKDirectionsTransportType(
//        
//        directions.calculate { (direct, error) in
//
//            if error != nil {
//                print("There was an error: \((error?.localizedDescription)!)")
//                return
//            }
//
//            for route in direct!.routes {
//                
//                mapAPI.time = 0
//                
//                let eta = route.expectedTravelTime // time in seconds
//                mapAPI.time = eta
//                
//                mapAPI.distance = 0
//                
//                let distance = route.distance // distance in meters
//                mapAPI.distance = distance
//            }
//            
//            let polilyne = direct?.routes.first?.polyline
//            
//            map.addOverlay(polilyne!)
//            map.setRegion(MKCoordinateRegion(polilyne!.boundingMapRect), animated: true)
//            map.showAnnotations([sourcePin , destinationPin], animated: true)
//        }
//        
//        return map
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
//
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//
//                let render = MKPolylineRenderer(overlay: overlay)
//            render.strokeColor = .blue
//            render.lineWidth = 3
//
//            return render
//
//        }
//    }
//
//}


    
   
