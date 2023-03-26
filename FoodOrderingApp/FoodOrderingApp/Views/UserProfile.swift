//
//  UserProfile.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/10/23.
//

import SwiftUI

struct UserProfile: View {
    
    enum UserProfileFields: Hashable {
        case firstName
        case lastName
        case email
        case phoneNumber
        case line1
        case line2
        case city
        case zipCode
        case stateSelection
        case password
        case newPassword
        case confirmPassword
        case offerSelection
        case editButton
        case button
    }
    
    @FocusState private var fieldInFocus: UserProfileFields?
    
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    
    //
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var line1: String = ""
    @State var line2: String = ""
    @State var city: String = ""
    @State var zipCode: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var stateSelection: String = "IL"
    @State var passwordChanges: Bool = true
    @State var specialOffers: Bool = true
    @State var newsletter: Bool = true
    
    // set change activity
    @State var firstNameHasChanged: Bool = false
    @State var lastNameHasChanged: Bool = false
    @State var emailHasChanged: Bool = false
    @State var phoneNumberHasChanged: Bool = false
    @State var line1HasChanged: Bool = false
    @State var line2HasChanged: Bool = false
    @State var cityHasChanged: Bool = false
    @State var stateHasChanged: Bool = false
    @State var zipCodeHasChanged: Bool = false
    @State var passwordHasChanged: Bool = false
    @State var orderStatusNotificationHasChanged: Bool = false
    @State var passwordChangesNotificationHasChanged: Bool = false
    @State var specialOffersNotificationHasChanged: Bool = false
    @State var newsletterNotificationHasChanged: Bool = false

    
    //
    @State var editEnable: Bool = false
    @State var orderStatus: Bool = true
    
    
    // verification of fields
    @State var wrongFirstName: Bool = false
    @State var wrongLastName: Bool = false
    @State var wrongEmail: Bool = false
    @State var wrongPhoneNumber: Bool = false
    @State var wrongLine1: Bool = false
    @State var wrongCity: Bool = false
    @State var wrongZipCode: Bool = false
    @State var wrongPassword: Bool = false
    @State var wrongNewPassword: Bool = false
    @State var wrongConfirmationPassword: Bool = false
    
    @State var changePassword: Bool = false
    @State var activateDeleteAccount: Bool = false
    @State var newPassword: String = ""
    
    
    // App Storage
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @AppStorage("first_name") var currentUserFirstName: String?
    @AppStorage("last_name") var currentUserLastName: String?
    @AppStorage("email_address") var currentUserEmail: String?
    @AppStorage("phone_number") var currentUserPhoneNumber: String?
    @AppStorage("line1_address") var currentUserLine1: String?
    @AppStorage("line2_address") var currentUserLine2: String?
    @AppStorage("city") var currentUserCity: String?
    @AppStorage("state") var currentUserState: String?
    @AppStorage("zip_code") var currentUserZipCode: String?
    @AppStorage("password") var currentUserPassword: String?
    @AppStorage("orderStatusToggle") var isOrderStatusActive: Bool = false
    @AppStorage("passwrodChangesToggle") var isPasswordCahngedActive: Bool = false
    @AppStorage("specialOfferToggle") var isSpecialOfferActive: Bool = false
    @AppStorage("newsletterToggle") var isNewsletterActive: Bool = false
    @AppStorage("is_user_registered") var isThereAnUser: Bool = false
    
    var body: some View {
        
        VStack {
            
            if editEnable {
                
                ScrollView {
                    
                    Section {
                        
                        VStack(alignment: .leading) {
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Avatar")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 5)
                                    
                                    HStack(spacing: 20) {
                                        Image("profile-image-placeholder")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(height: 80)
                                        
                                        Button {
                                            
                                        } label: {
                                            Text("Change")
                                                .font(Font.custom("Karla-ExtraBold", size: 16))
                                                .foregroundColor(Color("HighlightColor1"))
                                                .frame(width: 100, height: 50)
                                                .background(Color("PrimaryColor1"))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button {
                                            
                                        } label: {
                                            
                                            Text("Remove")
                                                .font(Font.custom("Karla-ExtraBold", size: 16))
                                                .foregroundColor(Color("SecundaryColor3"))
                                                .frame(width: 100, height: 50)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color("PrimaryColor1").opacity(0.5), lineWidth: 2)
                                                }
                                        }
                                        
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                            }
                            
                            
                            Group {
                                VStack(alignment: .leading) {
                                    
                                    Text("First Name")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor(text: $firstName)
                                            .normalTextInput()
                                            .focused($fieldInFocus, equals: .firstName)
                                            .onChange(of: firstName, perform: { newValue in
                                                
                                                let firstNameIsValid = firstName.count > 2
                                                
                                                if firstNameIsValid {
                                                    wrongFirstName = false
                                                }
                                                else {
                                                    wrongFirstName = true
                                                }
                                                
                                            })
                                            .onSubmit {
                                                
                                                if wrongFirstName {
                                                    fieldInFocus = .firstName
                                                    firstName = ""
                                                } else {
                                                    fieldInFocus = .lastName
                                                }
                                                
                                            }
                                            .onAppear {
                                                firstName = currentUserFirstName ?? "First Name"
                                            }
                                        
                                        if let currentUserFirstName = currentUserFirstName {
                                            if !wrongFirstName && firstName != currentUserFirstName {
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
                                    }
                                    
                                    if wrongFirstName {
                                        Text("First Name should be at least three characters long")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, -5)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                            
                            Group {
                                VStack(alignment: .leading) {
                                    
                                    Text("Last Name")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $lastName)
                                            .normalTextInput()
                                            .focused($fieldInFocus, equals: .lastName)
                                            .onChange(of: lastName, perform: { newValue in
                                                
                                                let lastNameIsValid = lastName.count > 2
                                                
                                                if lastNameIsValid {
                                                    wrongLastName = false
                                                }
                                                else {
                                                    wrongLastName = true
                                                }
                                            })
                                            .onSubmit {
                                                
                                                if wrongLastName {
                                                    fieldInFocus = .lastName
                                                    lastName = ""
                                                }
                                                else {
                                                    fieldInFocus = .email
                                                }
                                            }
                                            .onAppear {
                                                lastName = currentUserLastName ?? "Last Name"
                                            }
                                        
                                        if let currentUserLastName = currentUserLastName {
                                            if !wrongLastName && lastName != currentUserLastName {
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
                                    }
                                    
                                    if wrongLastName {
                                        Text("Last Name should be at least three characters long")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, -5)
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                            }
                            
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Email")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $email)
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
                                                
                                            })
                                            .onSubmit {
                                                
                                                if wrongEmail {
                                                    fieldInFocus = .email
                                                    email = ""
                                                } else {
                                                    fieldInFocus = .phoneNumber
                                                }
                                            }
                                            .onAppear {
                                                email = currentUserEmail ?? "email"
                                            }
                                        
                                        if let currentUserEmail = currentUserEmail {
                                            if !wrongEmail && email != currentUserEmail {
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
                                    }
                                    
                                    if wrongEmail {
                                        Text("Please enter a valid email address")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, -5)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                            
                            Group {
                                VStack(alignment: .leading) {
                                    
                                    Text("Phone Number")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $phoneNumber)
                                            .numberTextInput()
                                            .keyboardType(.phonePad)
                                            .focused($fieldInFocus, equals: .phoneNumber)
                                            .submitLabel(.continue)
                                            .lineLimit(11)
                                            .onChange(of: phoneNumber, perform: { newValue in
                                                
                                                if self.validatePhone(value: newValue) {
                                                    //                                                    fieldInFocus = .city
                                                    wrongPhoneNumber = false
                                                    //                                                    fieldInFocus = .line1
                                                    
                                                }
                                                
                                                else {
                                                    fieldInFocus = .phoneNumber
                                                    wrongPhoneNumber = true
                                                }
                                            })
                                            .onAppear {
                                                phoneNumber = currentUserPhoneNumber ?? "Phone Number"
                                            }
                                        
                                        if let currentUserPhoneNumber = currentUserPhoneNumber {
                                            if !wrongPhoneNumber && phoneNumber != currentUserPhoneNumber {
                                                Image(systemName: "checkmark")
                                                    .resizable()
                                                    .frame(width: 11, height: 11)
                                                    .foregroundColor(Color("PrimaryColor1"))
                                                    .padding(.horizontal, 15)
                                                    .onAppear {
                                                        phoneNumberHasChanged = true
                                                    }
                                                    .onDisappear {
                                                        phoneNumberHasChanged = false
                                                    }
                                            }
                                        }
                                    }
                                    
                                    if wrongPhoneNumber {
                                        Text("Please enter a valid Day Phone")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, -5)
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                    } header: {
                        Text("Personal Information").sectionTitle()
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                    Spacer()
                    
                    
                    
                    Section {
                        
                        VStack(alignment: .leading) {
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Line 1")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $line1)
                                            .normalTextInput()
                                            .focused($fieldInFocus, equals: .line1)
                                            .onChange(of: line1, perform: { newValue in
                                                
                                                if line1.count < 1 {
                                                    wrongLine1 = true
                                                } else {
                                                    wrongLine1 = false
                                                }
                                            })
                                        
                                            .onSubmit {
                                                
                                                if wrongLine1 {
                                                    fieldInFocus = .line1
                                                    line1 = ""
                                                } else {
                                                    fieldInFocus = .line2
                                                }
                                            }
                                            .onAppear {
                                                line1 = currentUserLine1 ?? "Line 1"
                                            }
                                        
                                        if let currentUserLine1 = currentUserLine1 {
                                            if !wrongLine1 && line1 != currentUserLine1 {
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
                                    }
                                    
                                    if wrongLine1 {
                                        Text("Please enter a valid address")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, -5)
                                    }
                                    
                                }
                                .padding(.vertical, 10)
                            }
                            
                            
                            Group {
                                VStack(alignment: .leading) {
                                    Text("Line 2")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    TextEditor (text: $line2)
                                        .normalTextInput()
                                        .focused($fieldInFocus, equals: .line2)
                                        .onChange(of: line2, perform: { newValue in
                                            if let currentUserLine2 = currentUserLine2 {
                                                if !line2.isEmpty && line2 != currentUserLine2 {
                                                    line2HasChanged = true
                                                }
                                            }
                                        })
                                        .onSubmit {
                                            fieldInFocus = .city
                                        }
                                        .onAppear {
                                            line2 = currentUserLine2 ?? ""
                                        }
                                    
                                }
                                .padding(.bottom, 10)
                                
                                
                                VStack(alignment: .leading) {
                                    Text("City")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $city)
                                            .normalTextInput()
                                            .focused($fieldInFocus, equals: .city)
                                            .onChange(of: city, perform: { newValue in
                                                
                                                if city.isEmpty {
                                                    wrongCity = true
                                                } else {
                                                    wrongCity = false
                                                }
                                                
                                            })
                                            .onSubmit {
                                                if wrongCity {
                                                    fieldInFocus = .city
                                                    city = ""
                                                } else {
                                                    fieldInFocus = .stateSelection
                                                }
                                            }
                                            .onAppear {
                                                city = currentUserCity ?? "City"
                                            }
                                        
                                        if let currentUserCity = currentUserCity {
                                            if !wrongCity && city != currentUserCity {
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
                                    }
                                    
                                    if wrongCity {
                                        Text("Please enter a valid City")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, -10)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                            
                            Group {
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
                                            fieldInFocus = .confirmPassword
                                            fieldInFocus = .zipCode
                                            stateHasChanged = true
                                        })
                                        .onAppear {
                                            stateSelection = currentUserState ?? "State"
                                        }
                                    
                                }
                                .padding(.bottom, 10)
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Zip Code")
                                        .font(Font.custom("Karla-Bold", size: 16))
                                        .padding(.bottom, 3)
                                    
                                    ZStack(alignment: .trailing) {
                                        
                                        TextEditor (text: $zipCode)
                                            .numberTextInput()
                                            .keyboardType(.phonePad)
                                            .focused($fieldInFocus, equals: .zipCode)
                                            .submitLabel(.continue)
                                            .onChange(of: zipCode) { newValue in
                                                
                                                if self.validateZipCode(input: newValue) {
                                                    fieldInFocus = .editButton
                                                    wrongZipCode = false
                                                    fieldInFocus = .password
                                                } else {
                                                    fieldInFocus = .zipCode
                                                    wrongZipCode = true
                                                }
                                            }
                                            .onAppear {
                                                zipCode = currentUserZipCode ?? "Zip Code"
                                            }
                                        
                                        if let currentUserZipCode = currentUserZipCode {
                                            if !wrongZipCode && zipCode != currentUserZipCode {
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
                                    }
                                    
                                    if wrongZipCode {
                                        Text("Please enter a valid Zip Code")
                                            .font(Font.custom("Karla-Regular", size: 10))
                                            .foregroundColor(Color.red)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, -5)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                    } header: {
                        Text("Delivery Address").sectionTitle()
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Section {
                        
                        VStack(alignment: .leading) {
                            
                            Group {
                                HStack(spacing: 10){
                                    Image(systemName: orderStatus ? "checkmark.circle.fill" : "circle" )
                                        .resizable()
                                        .foregroundColor(orderStatus ? Color("PrimaryColor1") : Color.black)
                                        .focused($fieldInFocus, equals: .offerSelection)
                                        .frame(width:20, height: 20)
                                        .onTapGesture {
                                            orderStatus.toggle()
                                            orderStatusNotificationHasChanged.toggle()
                                        }
                                    
                                    
                                    Text("Order Statuses").paragraphText()
                                        .onAppear {
                                            orderStatus = isOrderStatusActive
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                
                                
                                HStack(spacing: 10){
                                    Image(systemName: passwordChanges ? "checkmark.circle.fill" : "circle" )
                                        .resizable()
                                        .foregroundColor(passwordChanges ? Color("PrimaryColor1") : Color.black)
                                        .focused($fieldInFocus, equals: .offerSelection)
                                        .frame(width:20, height: 20)
                                        .onTapGesture {
                                            passwordChanges.toggle()
                                            passwordChangesNotificationHasChanged.toggle()
                                        }
                                    
                                    
                                    Text("Password Changes").paragraphText()
                                        .onAppear {
                                            passwordChanges = isPasswordCahngedActive
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                                
                                
                                HStack(spacing: 10){
                                    Image(systemName: specialOffers ? "checkmark.circle.fill" : "circle" )
                                        .resizable()
                                        .foregroundColor(specialOffers ? Color("PrimaryColor1") : Color.black)
                                        .focused($fieldInFocus, equals: .offerSelection)
                                        .frame(width:20, height: 20)
                                        .onTapGesture {
                                            specialOffers.toggle()
                                            specialOffersNotificationHasChanged.toggle()
                                        }
                                    
                                    
                                    Text("Special Offers").paragraphText()
                                        .onAppear {
                                            specialOffers = isSpecialOfferActive
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                                
                                HStack(spacing: 10){
                                    Image(systemName: newsletter ? "checkmark.circle.fill" : "circle" )
                                        .resizable()
                                        .foregroundColor(newsletter ? Color("PrimaryColor1") : Color.black)
                                        .focused($fieldInFocus, equals: .offerSelection)
                                        .frame(width:20, height: 20)
                                        .onTapGesture {
                                            newsletter.toggle()
                                            newsletterNotificationHasChanged.toggle()
                                        }
                                    Text("Newsletter").paragraphText()
                                        .onAppear {
                                            newsletter = isNewsletterActive
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                            }
                            //                            .padding(.bottom, 30)
                            
                            
                            if !changePassword {
                                HStack {
                                    
                                    Button {
                                        editEnable.toggle()
                                    } label: {
                                        Text("Discard Changes")
                                            .font(Font.custom("Karla-Bold", size: 18))
                                            .foregroundColor(Color("SecundaryColor3"))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 45)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color("PrimaryColor1").opacity(0.5), lineWidth: 2)
                                            }
                                    }
                                    
                                    Button {
                                        checkEverything()
                                        getWrongFields()
                                        save()
                                        editEnable.toggle()
                                        
                                        
                                    } label: {
                                        Text("Save Changes")
                                            .font(Font.custom("Karla-Bold", size: 18))
                                            .foregroundColor(Color("HighlightColor1"))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 45)
                                            .background(Color("PrimaryColor1").cornerRadius(16))
                                        //                                            .padding(.horizontal,20)
                                    }
                                    
                                }
                                .padding(.top, 20)
                            }
                            
                           
                            //                            .padding(.horizontal, 10)
                            
                            
                            // Change Password
                            if !changePassword {
                                HStack {
                                    
                                    Spacer()
                                    
                                    Button {
                                        
                                        changePassword = true
                                        fieldInFocus = .button
                                        
                                    } label: {
                                        
                                        ZStack {
                                            
                                            Text("Change Password").underline()
                                                .font(Font.custom("Karla-ExtraBold", size: 16))
                                                .foregroundColor(Color("PrimaryColor1"))
                                                .frame(width: 200, height: 40)
                                            
                                        }
                                        .frame(width: 200, height: 50)
                                        .cornerRadius(10)
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                            
                            Group {
                                if changePassword {
                                    
                                    VStack(alignment: .leading) {
                                        Text("Current Password")
                                            .font(Font.custom("Karla-Bold", size: 16))
                                            .padding(.bottom, 3)
                                        
                                        VStack {
                                            
                                            SecureInputView("Password", text: $password, isCorrect: !wrongPassword)
                                                .font(Font.custom("Karla-Regular", size: 16))
                                                .foregroundColor(Color("HighlightColor2"))
                                                .padding(10)
                                                .background(Color("HighlightColor1").cornerRadius(8))
                                                .disableAutocorrection(true)
                                                .focused($fieldInFocus, equals: .password)
                                                .padding(.bottom, 10)
                                                .onChange(of: password, perform: { newValue in
                                                    
                                                    if currentUserPassword != password || password.isEmpty {
                                                        wrongPassword = true
                                                    } else {
                                                        wrongPassword = false
                                                    }
                                                })
                                                .onSubmit {
                                                    
                                                    if wrongPassword {
                                                        fieldInFocus = .password
                                                        password = ""
                                                    } else {
                                                        fieldInFocus = .editButton
                                                        fieldInFocus = .newPassword
                                                    }
                                                }
                                                .onTapGesture {
                                                    fieldInFocus = .button
                                                    fieldInFocus = .password
                                                }
                                            
                                            
                                            if wrongPassword {
                                                Text("Password doesn't match current password on file")
                                                    .font(Font.custom("Karla-Regular", size: 10))
                                                    .foregroundColor(Color.red)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .padding(.horizontal, 20)
                                                    .padding(.vertical, -10)
                                            }
                                            
                                        }
                                        
                                    }
                                    .padding(.vertical, 10)
                                    
                                    Group {
                                        if password == currentUserPassword {
                                            
                                            VStack(alignment: .leading) {
                                                Text("New Password")
                                                    .font(Font.custom("Karla-Bold", size: 16))
                                                    .padding(.bottom, 3)
                                                
                                                VStack {
                                                    
                                                    SecureInputView("Set your new password", text: $newPassword, isCorrect: !wrongNewPassword)
                                                        .font(Font.custom("Karla-Regular", size: 16))
                                                        .foregroundColor(Color("HighlightColor2"))
                                                        .textContentType(.password)
                                                        .padding(10)
                                                        .background(Color("HighlightColor1").cornerRadius(8))
                                                        .disableAutocorrection(true)
                                                        .focused($fieldInFocus, equals: .newPassword)
                                                        .padding(.bottom, 10)
                                                        .onChange(of: newPassword, perform: { newValue in
                                                            
                                                            if self.isPasswordValid(newValue) {
                                                                wrongNewPassword = false
                                                            } else {
                                                                wrongNewPassword = true
                                                            }
                                                        })
                                                        .onSubmit {
                                                            
                                                            if wrongNewPassword {
                                                                fieldInFocus = .newPassword
                                                                newPassword = ""
                                                            } else {
                                                                fieldInFocus = .editButton
                                                                fieldInFocus = .confirmPassword
                                                            }
                                                        }
                                                    
                                                    if wrongNewPassword {
                                                        Text("Please enter a valid password, see below for password requirements")
                                                            .font(Font.custom("Karla-Regular", size: 10))
                                                            .foregroundColor(Color.red)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.horizontal, 20)
                                                            .padding(.vertical, -10)
                                                    }
                                                    
                                                }
                                                
                                                Text("Password must:\("\n")\("\n")Be at least 8 characters\("\n")Contain at least one uppercase letter\("\n")Contain at least one lowercase letter\("\n")Contain at least one number\("\n")Contain at least one special character:\("\n") !@#$&*")
                                                    .paragraphText()
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.horizontal, 20)
                                            }
                                            .padding(.vertical, 10)
                                            
                                            VStack(alignment: .leading) {
                                                Text("Confirm Password")
                                                    .font(Font.custom("Karla-Bold", size: 16))
                                                    .padding(.bottom, 3)
                                                
                                                VStack {
                                                    
                                                    SecureInputView("Confirm Password", text: $confirmPassword, isCorrect: !wrongConfirmationPassword)
                                                        .font(Font.custom("Karla-Regular", size: 16))
                                                        .foregroundColor(Color("HighlightColor2"))
                                                        .padding(10)
                                                        .background(Color("HighlightColor1").cornerRadius(8))
                                                        .disableAutocorrection(true)
                                                        .focused($fieldInFocus, equals: .confirmPassword)
                                                        .padding(.top, 10)
                                                        .onChange(of: confirmPassword, perform: { newValue in
                                                            
                                                            if confirmPassword != newPassword || confirmPassword.isEmpty {
                                                                wrongConfirmationPassword = true
                                                            } else {
                                                                wrongConfirmationPassword = false
                                                                passwordHasChanged = true
                                                            }
                                                        })
                                                        .onSubmit {
                                                            
                                                            if wrongConfirmationPassword {
                                                                fieldInFocus = .confirmPassword
                                                                confirmPassword = ""
                                                            } else {
                                                                fieldInFocus = .editButton
                                                                fieldInFocus = .offerSelection
                                                            }
                                                            
                                                        }
                                                    
                                                    if wrongConfirmationPassword {
                                                        Text("Please make sure your password matches")
                                                            .font(Font.custom("Karla-Regular", size: 10))
                                                            .foregroundColor(Color.red)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.horizontal, 20)
                                                            .padding(.vertical, -10)
                                                    }
                                                    
                                                    
                                                    
                                                }
                                                
                                            } .padding(.vertical, 10)
                                            
                                        }
                                    }
                                    
                                    HStack {
                                        
                                        Button {
                                            changePassword = false
                                            editEnable.toggle()
                                        } label: {
                                            Text("Discard Changes")
                                                .font(Font.custom("Karla-Bold", size: 18))
                                                .foregroundColor(Color("SecundaryColor3"))
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 45)
                                                .focused($fieldInFocus, equals: .button)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color("PrimaryColor1").opacity(0.5), lineWidth: 2)
                                                }
                                        }
                                        
                                        Button {
                                            checkEverything()
                                            getWrongFields()
                                            save()
                                            editEnable.toggle()
                                            
                                            
                                        } label: {
                                            Text("Save Changes")
                                                .font(Font.custom("Karla-Bold", size: 18))
                                                .foregroundColor(Color("HighlightColor1"))
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 45)
                                                .background(Color("PrimaryColor1").cornerRadius(16))
                                            //                                            .padding(.horizontal,20)
                                        }
                                        
                                    }
                                    .padding(.bottom, 20)
                                    
                                }
                            }
                            
                            
                            HStack(alignment: .center) {
                                
                                Spacer()
                                
                                Button {
                                    activateDeleteAccount.toggle()
                                    
                                } label: {
                                    
                                    Text("Delete account").underline()
                                        .font(Font.custom("Karla-ExtraBold", size: 16))
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .frame(width: 200, height: 40)
                                    
                                }
                                .focused($fieldInFocus, equals: .editButton)
                                .alert(isPresented: $activateDeleteAccount) {
                                    Alert(
                                        title: Text("Are you sure you want to delete your account?"),
                                        message: Text("This action is final and cannot be undone. This will erase all your data from the current device"),
                                        primaryButton: .destructive(
                                            Text("DELETE"),
                                            action: {
                                                resetValues()
                                                //                                    isCurrentUserSignedIn = false
                                                PersistenceController.shared.clear()
                                                navigationStateManager.popToRoot()
                                            }),
                                        secondaryButton: .cancel(Text("Cancel"), action: {
                                            activateDeleteAccount = false
                                        }))
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.top, -20)
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                        
                    } header: {
                        Text("Security and Notifications Preferences").sectionTitle()
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                }.offset(y: -45)
                    .edgesIgnoringSafeArea(.bottom)
                
                .toolbarBackground(.white, for: .navigationBar)
                
                
            }
            
            
            else {
                
                VStack {
                    
                    HStack {
                        Image("profile-image-placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .clipShape(Circle())
                        
                        VStack {
                            Text("Hello!")
                                .font(Font.custom("Karla-ExtraBoldItalic", size: 45))
                                .foregroundColor(Color("SecundaryColor2"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                                Text(currentUserFirstName ?? "Name")
                                    .font(Font.custom("Karla-ExtraBold", size: 30))
                                    .foregroundColor(Color("HighlightColor1"))
    //                                .padding(.trailing , 60)
                                
                        }
                        
                        Spacer()
                        
                    }
                    .frame(height: 200)
                    .background(Color("PrimaryColor1"))
                    
                    VStack(alignment: .leading) {
                        
                        Text("Personal Information").sectionTitle()
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .bottom])
                        
                        VStack(alignment: .leading) {
                            Text("Account Holder")
                                .font(Font.custom("Karla-Bold", size: 16))
                                .padding(.bottom, 1)
                            
                            Text("\(currentUserFirstName ?? "Name") \(currentUserLastName ?? "LastName")").paragraphText()
                            
                            Text("\(currentUserEmail ?? "email@example.com") / \(currentUserPhoneNumber?.convertToInternationalFormat() ?? "(012) 345-5789")").paragraphText()
                        }
                        .padding(.bottom, 30)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Preferred Delivery Address")
                                .font(Font.custom("Karla-Bold", size: 16))
                                .padding(.bottom, 1)
                            
                            Text("\(currentUserLine1 ?? "Line1"), \(currentUserLine2 ?? "")").paragraphText()
                            
                            Text("\(currentUserCity ?? "City"), \(currentUserState ?? "State"), \(currentUserZipCode ?? "ZipCode")").paragraphText()
                        }
                        .padding(.bottom, 30)
                        
                        
                        VStack(alignment: .leading) {
                            
                            Text("Notifications Settings")
                                .font(Font.custom("Karla-Bold", size: 16))
                                .padding(.bottom, 1)
                            
                            HStack(spacing: 10){
                                Image(systemName: isOrderStatusActive ? "checkmark.circle.fill" : "circle" )
                                    .resizable()
                                    .foregroundColor(isOrderStatusActive ? Color("PrimaryColor1") : Color.black)
                                    .frame(width:20, height: 20)
                                
                                Text("Order Statuses").paragraphText()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                            
                            
                            HStack(spacing: 10){
                                Image(systemName: isPasswordCahngedActive ? "checkmark.circle.fill" : "circle" )
                                    .resizable()
                                    .foregroundColor(isPasswordCahngedActive ? Color("PrimaryColor1") : Color.black)
                                    .frame(width:20, height: 20)
                                
                                Text("Password Changes").paragraphText()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            
                            
                            HStack(spacing: 10){
                                Image(systemName: isSpecialOfferActive ? "checkmark.circle.fill" : "circle" )
                                    .resizable()
                                    .foregroundColor(isSpecialOfferActive ? Color("PrimaryColor1") : Color.black)
                                    .frame(width:20, height: 20)
                                
                                Text("Special Offers").paragraphText()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            
                            HStack(spacing: 10){
                                Image(systemName: isNewsletterActive ? "checkmark.circle.fill" : "circle" )
                                    .resizable()
                                    .foregroundColor(isNewsletterActive ? Color("PrimaryColor1") : Color.black)
                                    .frame(width:20, height: 20)
                                
                                Text("Newsletter").paragraphText()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                        }
                        .padding(.bottom, 30)
                        
                        
                    } .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    
                    .toolbarBackground(.hidden, for: .navigationBar)
                    
                }.offset(y: -45)
               
                Button {
                    isCurrentUserSignedIn = false
                    PersistenceController.shared.clear()
                    navigationStateManager.popToRoot()
                    
                } label: {
                    Text("Logout").primaryButton()
                }
                
            }
            
        }
        
        
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text(editEnable ?  "Edit Profile".uppercased() : "Profile".uppercased())
                    .font(Font.custom("Karla-ExtraBold", size: 20))
                    .foregroundColor(
                        editEnable ?
                        Color("PrimaryColor1"):
                            Color("HighlightColor1"))
            }
            
            if !editEnable {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("HighlightColor1"))
                    }
                }
            }
            
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    editEnable.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(
                            editEnable ?
                            Color("PrimaryColor1"):
                                Color("HighlightColor1"))
                }
            }
            
        }
    }
    
    func resetValues() {
        
        isCurrentUserSignedIn = false
        currentUserFirstName = nil
        currentUserLastName = nil
        currentUserEmail = nil
        currentUserPhoneNumber = nil
        currentUserLine1 = nil
        currentUserLine2 = nil
        currentUserCity = nil
        currentUserState = nil
        currentUserZipCode = nil
        currentUserPassword = nil
        isOrderStatusActive = false
        isPasswordCahngedActive = false
        isSpecialOfferActive = false
        isNewsletterActive = false
        isThereAnUser = false
        
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
        
        // checking phoneNumber field
        if self.validatePhone(value: self.phoneNumber) {
            wrongPhoneNumber = false
            
        } else {
            wrongPhoneNumber = true
        }
        
        // checking line1 field
        if line1.count < 1 {
            wrongLine1 = true
        } else {
            wrongLine1 = false
        }
        
        // checking line2 field
        if line2.isEmpty {
            currentUserLine2 = nil
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
        
        // checking password field
        
        if changePassword {
            
            if self.isPasswordValid(self.newPassword) {
                wrongNewPassword = false
            } else {
                newPassword = ""
                wrongNewPassword = true
            }
            
            //checking confirmationPassword
            if confirmPassword != newPassword || confirmPassword.isEmpty {
                wrongConfirmationPassword = true
                confirmPassword = ""
            } else {
                wrongConfirmationPassword = false
            }
            
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
        else if wrongPhoneNumber {
            fieldInFocus = .phoneNumber
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
        else if changePassword {
            if wrongNewPassword {
                fieldInFocus = .newPassword
            }
            else if wrongConfirmationPassword {
                fieldInFocus = .confirmPassword
            }
        }
    }
    
    func save() {
        
        if firstNameHasChanged {
            currentUserFirstName = firstName
        }
        if lastNameHasChanged {
            currentUserLastName = lastName
        }
        if emailHasChanged {
            currentUserEmail = email
        }
        if phoneNumberHasChanged {
            currentUserPhoneNumber = phoneNumber
        }
        if line1HasChanged {
            currentUserLine1 = line1
        }
        if line2.isEmpty || line2 == "NA" {
            currentUserLine2 = nil
        } else {
            currentUserLine2 = line2
        }
        
        if cityHasChanged {
            currentUserCity = city
        }
        if stateHasChanged {
            currentUserState = stateSelection
        }
        if zipCodeHasChanged {
            currentUserZipCode = zipCode
        }
        if passwordHasChanged {
            currentUserPassword = newPassword
        }
        if orderStatusNotificationHasChanged {
            isOrderStatusActive = orderStatus
        }
        if specialOffersNotificationHasChanged {
            isSpecialOfferActive = specialOffers
        }
        if passwordChangesNotificationHasChanged {
            isPasswordCahngedActive = passwordChanges
        }
        if newsletterNotificationHasChanged {
            isNewsletterActive = newsletter
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
    
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    func validateZipCode(input: String?) -> Bool {
        guard let input = input else { return false }
        
        return NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-\\s]?\\d{4})?$")
            .evaluate(with: input.uppercased())
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$")
        return passwordTest.evaluate(with: password)
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
    
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
            .environmentObject(NavigationStateManager())
            .environmentObject(ContentViewModel())
    }
}


