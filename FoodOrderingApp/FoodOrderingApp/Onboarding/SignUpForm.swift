//
//  SignUpForm.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsloggedIn"
let kLine1 = "address line 1 key"
let kLine2 = "address line 2 key"
let kCity = "city key"
let kState = "state key"
let kZipCode = "zip code key"
let kPassword = "passworkd key"
let kAcceptOffersAndPromotions = "acept offers key"

struct SignUpForm: View {
    
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
    @State var togglesIson: Bool = false
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @StateObject var contentViewModel: ContentViewModel = ContentViewModel()
    
    
    
    
    var body: some View {
                    
            ScrollView(showsIndicators: true) {
                
                Section {
                    VStack (spacing: 20){
                        HStack (spacing: 10) {
                            
                            TextField("First Name", text: $firstName)
                                .normalTextInput()
                            
                            
                            TextField("Last Name", text: $lastName)
                                .normalTextInput()
                            
                        }.padding(.horizontal, 20)
                        
                        TextField("email", text: $email)
                            .emailTextInput()
                            .padding(.horizontal, 20)
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .numberTextInput()
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 40)
                } header: {
                    Text("Contact Info")
                        .formHeaderSection()
                }
                
                
                
                Section {
                    VStack (spacing: 20){
                        
                        TextField("Line 1", text: $line1)
                            .normalTextInput()
                            .padding(.horizontal, 20)
                        
                        TextField("Line 2", text: $line2)
                            .normalTextInput()
                            .padding(.horizontal, 20)
                        
                        TextField("City", text: $city)
                            .normalTextInput()
                            .padding(.horizontal, 20)
                        
                        HStack (spacing: 10) {
                            statePicker()
                                .tint(Color("HighlightColor2"))
                                .frame(maxWidth: .infinity)
                                .frame(maxHeight: .infinity)
                                .background(Color("HighlightColor1").cornerRadius(8))
                            
                            TextField("Zip Code", text: $zipCode)
                                .numberTextInput()
                            
                        }.padding(.horizontal, 20)
                        
                        
                    }.padding(.bottom, 40)
                    
                } header: {
                    Text("Address")
                        .formHeaderSection()
                    
                }
                
                Section {
                    VStack(spacing: 10) {
                        TextField("Password", text: $password)
                            .normalTextInput()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        
                        Text("Password must:\("\n")\("\n")Be at least 8 characters\("\n")Contain at least one uppercase letter\("\n")Contain at least one lowercase letter\("\n")Contain at least one number\("\n")Contain at least one special character:\("\n") ~!@#$%^&*()_-+=[]{};:,.<")
                            .paragraphText()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        TextField("Confirm Password", text: $confirmPassword)
                            .normalTextInput()
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        
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
                                .frame(width:20, height: 20)
                                .onTapGesture {
                                    togglesIson.toggle()
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
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    navigationStateManager.goToHome()
                   
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phoneNumber.isEmpty && !line1.isEmpty && !city.isEmpty && !zipCode.isEmpty && !stateSelection.isEmpty && !password.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        UserDefaults.standard.set(line1, forKey: kLine1)
                        UserDefaults.standard.set(line2 , forKey: kLine2)
                        UserDefaults.standard.set(city, forKey: kCity)
                        UserDefaults.standard.set(stateSelection, forKey: kState)
                        UserDefaults.standard.set(zipCode, forKey: kZipCode)
                        UserDefaults.standard.set(password, forKey: kPassword)
                    }
                    
                } label: {
                    Text("Register").primaryButton()
                }
                .padding(.top, 20)
                
            }.environmentObject(ContentViewModel())
    }
}


struct SignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        SignUpForm()
            .environmentObject(NavigationStateManager())
    }
}


extension SignUpForm {
    
    private func statePicker() -> some View {
        
        Picker(
            selection: $stateSelection) {
                ForEach(contentViewModel.statesArray, id: \.self) { state in
                    Text(state.name)
                        .lineLimit(8)
                        .tag(state.abbreviation)
                }
            } label: {
                Text("State Picker")
            }
            .pickerStyle(.automatic)
        
    }
}

