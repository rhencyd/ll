//
//  SignUpForm.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI


struct SignUpForm: View {
    
    
    // FocusState
    
    enum OnboardingFields: Hashable {
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
        case confirmPassword
        case offerSelection
        case registerButton
    }
    
    @FocusState private var fieldInFocus: OnboardingFields?
    
    // onboarding inputs
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
    @State var stateSelection: String = "TX"
    @State var togglesIson: Bool = false
    
    
    @State var wrongFirstName: Bool = false
    @State var wrongLastName: Bool = false
    @State var wrongEmail: Bool = false
    @State var wrongPhoneNumber: Bool = false
    @State var wrongLine1: Bool = false
    @State var wrongCity: Bool = false
    @State var wrongZipCode: Bool = false
    @State var wrongPassword: Bool = false
    @State var wrongConfirmationPassword: Bool = false
    
    
    // app storage
    
    @AppStorage("first_name") var currentUserFirstName: String?
    @AppStorage("last_name") var currentUserLastName: String?
    @AppStorage("email_address") var currentUserEmail: String?
    @AppStorage("line1_address") var currentUserLine1: String?
    @AppStorage("line2_address") var currentUserLine2: String?
    @AppStorage("city") var currentUserCity: String?
    @AppStorage("state") var currentUserState: String?
    @AppStorage("zip_code") var currentUserZipCode: String?
    @AppStorage("complete_address") var currentUserCompleteAddress: String?
    @AppStorage("password") var currentUserPassword: String?
    @AppStorage("phone_number") var currentUserPhoneNumber: String?
    
    @AppStorage("orderStatusToggle") var isOrderStatusActive: Bool = false
    @AppStorage("passwrodChangesToggle") var isPasswordCahngedActive: Bool = false
    @AppStorage("specialOfferToggle") var isSpecialOfferActive: Bool = false
    @AppStorage("newsletterToggle") var isNewsletterActive: Bool = false
    
    
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @AppStorage("is_user_registered") var isThereAnUser: Bool = false
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    
    
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            Section {
                VStack (spacing: 20){
                    HStack (spacing: 10) {
                        
                        VStack {
                            
                            ZStack(alignment: .trailing) {
                                
                                TextField("First Name", text: $firstName)
                                    .normalTextInput()
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
                                    })
                                    .onSubmit {
                                        
                                        if wrongFirstName || firstName.isEmpty {
                                            fieldInFocus = .firstName
                                            firstName = ""
                                        } else {
                                            fieldInFocus = .lastName
                                        }
                                        
                                    }
                                
                                if !wrongFirstName && !firstName.isEmpty {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 10)
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
                        
                        VStack {
                            
                            ZStack(alignment: .trailing) {
                                
                                TextField("Last Name", text: $lastName)
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
                                
                                if !wrongLastName && !lastName.isEmpty {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 10)
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
                        
                    }.padding(.horizontal, 20)
                    
                    VStack {
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField("Email", text: $email)
                                .emailTextInput()
                                .textContentType(.emailAddress)
                                .focused($fieldInFocus, equals: .email)
                                .padding(.horizontal, 20)
                                .autocapitalization(.none)
                                .onChange(of: email, perform: { newValue in
                                    
                                    if self.textFieldValidatorEmail(newValue) {
                                        wrongEmail = false
                                    } else {
                                        wrongEmail = true
                                    }
                                    
                                })
                                .onSubmit {
                                    
                                    if wrongEmail || email.isEmpty {
                                        fieldInFocus = .email
                                        email = ""
                                    } else {
                                        fieldInFocus = .phoneNumber
                                    }
                                }
                            
                            if !wrongEmail && !email.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("PrimaryColor1"))
                                    .padding(.horizontal, 30)
                            }
                        }
                        
                        if wrongEmail {
                            Text("Please enter a valid email address")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.vertical, -5)
                        }
                    }
                    
                    VStack {
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField("Phone Number", text: $phoneNumber)
                                .numberTextInput()
                                .textContentType(.telephoneNumber)
                                .keyboardType(.phonePad)
                                .focused($fieldInFocus, equals: .phoneNumber)
                                .padding(.horizontal, 20)
                                .submitLabel(.continue)
                                .lineLimit(11)
                                .onChange(of: phoneNumber, perform: { newValue in
                                    
                                    if self.validatePhone(value: newValue) {
                                        fieldInFocus = .city
                                        wrongPhoneNumber = false
                                        fieldInFocus = .line1
                                        
                                    }
                                    
                                    else {
                                        fieldInFocus = .phoneNumber
                                        wrongPhoneNumber = true
                                    }
                                })
                                .onSubmit {
                                    
                                    if wrongPassword || password.isEmpty {
                                        fieldInFocus = .password
                                        password = ""
                                    } else {
                                        fieldInFocus = .password
                                    }
                                }
                            
                            if !wrongPhoneNumber && !phoneNumber.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("PrimaryColor1"))
                                    .padding(.horizontal, 30)
                            }
                        }
                        
                        if wrongPhoneNumber {
                            Text("Please enter a valid Day Phone")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.vertical, -5)
                        }
                    }
                }
                .padding(.bottom, 40)
            } header: {
                Text("Contact Info")
                    .formHeaderSection()
            }
            
            Section {
                
                VStack (spacing: 20){
                    
                    VStack {
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField("Line 1", text: $line1)
                                .normalTextInput()
                                .textContentType(.streetAddressLine1)
                                .focused($fieldInFocus, equals: .line1)
                                .padding(.horizontal, 20)
                                .onChange(of: line1, perform: { newValue in
                                    
                                    if line1.count < 1 {
                                        wrongLine1 = true
                                    } else {
                                        wrongLine1 = false
                                    }
                                })
                            
                                .onSubmit {
                                    
                                    if wrongLine1 || line1.isEmpty {
                                        fieldInFocus = .line1
                                        line1 = ""
                                    } else {
                                        fieldInFocus = .line2
                                    }
                                }
                            
                            if !wrongLine1 && !line1.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("PrimaryColor1"))
                                    .padding(.horizontal, 30)
                            }
                        }
                        
                        if wrongLine1 {
                            Text("Please enter a valid address")
                                .font(Font.custom("Karla-Regular", size: 10))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.vertical, -5)
                        }
                        
                    }
                    
                    TextField("Line 2 (optional)", text: $line2)
                        .normalTextInput()
                        .textContentType(.streetAddressLine2)
                        .focused($fieldInFocus, equals: .line2)
                        .padding(.horizontal, 20)
                        .onSubmit {
                            fieldInFocus = .city
                        }
                    
                    
                    ZStack(alignment: .trailing) {
                        
                        TextField("City", text: $city)
                            .normalTextInput()
                            .textContentType(.addressCity)
                            .focused($fieldInFocus, equals: .city)
                            .padding(.horizontal, 20)
                            .onChange(of: city, perform: { newValue in
                                
                                if city.isEmpty {
                                    wrongCity = true
                                } else {
                                    wrongCity = false
                                }
                                
                            })
                            .onSubmit {
                                if wrongCity || city.isEmpty {
                                    fieldInFocus = .city
                                    city = ""
                                } else {
                                    fieldInFocus = .stateSelection
                                }
                            }
                        
                        if !wrongCity && !city.isEmpty {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("PrimaryColor1"))
                                .padding(.horizontal, 30)
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
                    
                    HStack (spacing: 10) {
                        statePicker()
                            .tint(Color("HighlightColor2"))
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .focused($fieldInFocus, equals: .stateSelection)
                            .background(Color("HighlightColor1").cornerRadius(8))
                            .onChange(of: stateSelection, perform: { newValue in
                                fieldInFocus = .confirmPassword
                                fieldInFocus = .zipCode
                            })
                        
                        VStack {
                            
                            ZStack(alignment: .trailing) {
                                
                                TextField("Zip Code", text: $zipCode)
                                    .numberTextInput()
                                    .keyboardType(.phonePad)
                                    .focused($fieldInFocus, equals: .zipCode)
                                    .submitLabel(.continue)
                                    .onChange(of: zipCode) { newValue in
                                        
                                        if self.validateZipCode(input: newValue) {
                                            fieldInFocus = .registerButton
                                            wrongZipCode = false
                                            fieldInFocus = .password
                                        } else {
                                            fieldInFocus = .zipCode
                                            wrongZipCode = true
                                        }
                                    }
                                    .onSubmit {
                                        
                                        if wrongZipCode || zipCode.isEmpty {
                                            fieldInFocus = .zipCode
                                            zipCode = ""
                                        } else {
                                            fieldInFocus = .registerButton
                                            fieldInFocus = .password
                                        }
                                    }
                                
                                if !wrongZipCode && !zipCode.isEmpty {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("PrimaryColor1"))
                                        .padding(.horizontal, 10)
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
                        
                    }.padding(.horizontal, 20)
                    
                    
                }
                .padding(.bottom, 40)
                
            } header: {
                Text("Address")
                    .formHeaderSection()
                
            }
            
            Section {
                VStack(spacing: 10) {
                    
                    VStack {
                        
                        SecureInputView("Password", text: $password, isCorrect: !wrongPassword)
                            .font(Font.custom("Karla-Regular", size: 16))
                            .foregroundColor(Color("HighlightColor2"))
                            .textContentType(.password)
                            .padding(12)
                            .background(Color("HighlightColor1").cornerRadius(8))
                            .disableAutocorrection(true)
                            .focused($fieldInFocus, equals: .password)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                            .onChange(of: password, perform: { newValue in
                                
                                if self.isPasswordValid(newValue) {
                                    wrongPassword = false
                                } else {
                                    wrongPassword = true
                                }
                            })
                            .onSubmit {
                                
                                if wrongPassword || password.isEmpty {
                                    fieldInFocus = .password
                                    password = ""
                                } else {
                                    fieldInFocus = .registerButton
                                    fieldInFocus = .confirmPassword
                                }
                            }
                        
                        if wrongPassword {
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
                    
                    
                    VStack {
                        
                        SecureInputView("Confirm Password", text: $confirmPassword, isCorrect: !wrongConfirmationPassword)
                            .font(Font.custom("Karla-Regular", size: 16))
                            .foregroundColor(Color("HighlightColor2"))
                            .textContentType(.password)
                            .padding(12)
                            .background(Color("HighlightColor1").cornerRadius(8))
                            .disableAutocorrection(true)
                            .focused($fieldInFocus, equals: .confirmPassword)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .onChange(of: confirmPassword, perform: { newValue in
                                
                                if confirmPassword != password || confirmPassword.isEmpty {
                                    wrongConfirmationPassword = true
                                } else {
                                    wrongConfirmationPassword = false
                                }
                            })
                            .onSubmit {
                                
                                if wrongConfirmationPassword {
                                    fieldInFocus = .confirmPassword
                                    confirmPassword = ""
                                } else {
                                    fieldInFocus = .registerButton
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
                    
                    
                    
                }.padding(.bottom,40)
            } header: {
                Text("Account Security")
                    .formHeaderSection()
            }
            
            
            
            Section {
                VStack{
                    HStack(spacing: 10){
                        Image(systemName: togglesIson ? "checkmark.circle.fill" : "circle" )
                            .resizable()
                            .foregroundColor(togglesIson ? Color("PrimaryColor1") : Color.black)
                            .focused($fieldInFocus, equals: .offerSelection)
                            .frame(width:20, height: 20)
                            .onTapGesture {
                                togglesIson.toggle()
                                isOrderStatusActive = true
                                isPasswordCahngedActive = true
                                isSpecialOfferActive = true
                                isNewsletterActive = true
                            }
                        Text("Send me emails to receive exclusive offers and promotions").paragraphText()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    
                    
                    Text("By clicking “Resgister” below, you acknowledge that you have read Little Lemon’s Privacy Policy and agree to Little Lemon’s Terms and Conditions.").paragraphText()
                    
                }.padding(.horizontal,20)
            } header: {
                Text("Offers and Promotions").formHeaderSection()
            }
            
            
            Button {
                
                checkEverything()
                
                getWrongFields()
                
                
                if !wrongFirstName && !wrongLastName && !wrongEmail &&
                    !wrongPhoneNumber && !wrongLine1 && !wrongCity &&
                    !wrongZipCode && !wrongPassword &&
                    !wrongConfirmationPassword && togglesIson
                {
                    
                    // Personal information
                    currentUserFirstName = firstName
                    currentUserLastName = lastName
                    currentUserEmail = email
                    currentUserPhoneNumber = phoneNumber
                    currentUserPassword = password
                    
                    // Address Information
                    currentUserLine1 = line1
                    currentUserLine2 = line2
                    currentUserCity = city
                    currentUserZipCode = zipCode
                    currentUserState = stateSelection
                    
                    if line2.isEmpty || line2 == "NA" {
                        currentUserCompleteAddress = "\(line1), \(city), \(stateSelection) \(zipCode)"
                    } else {
                        currentUserCompleteAddress = "\(line1), \(line2), \(city), \(stateSelection) \(zipCode)"
                    }
                    
                    // app logic
                    isCurrentUserSignedIn = true
                    isThereAnUser = true
                    navigationStateManager.goToHome()
                    
                }
                
            } label: {
                Text("Register").primaryButton()
            }
            .focused($fieldInFocus, equals: .registerButton)
            .padding(.top, 20)
            
        }
        .modifier(AdaptsToSoftwareKeyboard())
        .ignoresSafeArea(.keyboard)
        .environmentObject(ContentViewModel())
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
            line2 = "NA"
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
        if self.isPasswordValid(self.password) {
            wrongPassword = false
        } else {
            password = ""
            wrongPassword = true
        }
        
        //checking confirmationPassword
        if confirmPassword != password || confirmPassword.isEmpty {
            wrongConfirmationPassword = true
            confirmPassword = ""
        } else {
            wrongConfirmationPassword = false
        }
        
        //checking offers and promotions
        if togglesIson == false {
            fieldInFocus = .offerSelection
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
        else if wrongPassword {
            fieldInFocus = .password
        }
        else if wrongConfirmationPassword {
            fieldInFocus = .confirmPassword
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
    
}


struct SignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        SignUpForm()
            .environmentObject(NavigationStateManager())
            .environmentObject(ContentViewModel())
    }
}


extension SignUpForm {
    
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

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    private var isCorretc: Bool
    
    init(_ title: String, text: Binding<String>, isCorrect: Bool) {
        self.title = title
        self._text = text
        self.isCorretc = isCorrect
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)
            
            HStack {
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
                
                if isCorretc && !text.isEmpty {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color("PrimaryColor1"))
                }
                
            }
        }
    }
}
