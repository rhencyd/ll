//
//  SignInForm.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI
import AuthenticationServices

struct SignInForm: View {
    
    enum SigninFields: Hashable {
        case email
        case password
        case button
    }
    
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    
    @State var isPasswordVerified: Bool?
    @State var isEmailVerified: Bool?
    
    @State var isUserVerified: Bool = false
    
    @FocusState private var fieldInFocus: SigninFields?
    
    @State var showAlert: Bool = false
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @AppStorage("email_address") var currentUserEmail: String?
    @AppStorage("password") var currentUserPassword: String?
    @AppStorage("is_user_registered") var isThereAnUser: Bool = false
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    
    // for now this is going to check AppStorage
    
    // demo
    @AppStorage("demo_email") var demoEmail: String = "demo@email.com"
    @AppStorage("demo_password") var demoPassword: String = "Password123*"
    @AppStorage("orderStatusToggle") var isOrderStatusActive: Bool = false
    @AppStorage("passwrodChangesToggle") var isPasswordCahngedActive: Bool = false
    @AppStorage("specialOfferToggle") var isSpecialOfferActive: Bool = false
    @AppStorage("newsletterToggle") var isNewsletterActive: Bool = false
    
    
    var body: some View {
        
        VStack {
            
            VStack (alignment: .leading, spacing: 5) {
                
                Text("Email").formHeaderSection()
                TextField("",text: $userEmail)
                    .emailTextInput()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .focused($fieldInFocus, equals: .email)
                    .onSubmit {
                        if let email = currentUserEmail {
                            if userEmail == email  {
                                isEmailVerified = true
                                fieldInFocus = .password
                            } else {
                                isEmailVerified = false
                                userEmail = ""
                                fieldInFocus = .email
                            }
                        }

                        else {
                            if userEmail == demoEmail  {
                                isEmailVerified = true
                                fieldInFocus = .password
                            } else {
                                isEmailVerified = false
                                userEmail = ""
                                fieldInFocus = .email
                            }
                        }
                    }
                if isEmailVerified == false {
                    Text("Email not found")
                        .font(Font.custom("Karla-Regular", size: 10))
                        .foregroundColor(Color.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.vertical, -5)
                }
                
            }.padding(.bottom, 5)
            
            VStack (alignment: .leading, spacing: 5) {
                
                Text("Pasword").formHeaderSection()
                
                SecureInputView("", text: $userPassword, isCorrect: isPasswordVerified ?? false)
                    .font(Font.custom("Karla-Regular", size: 16))
                    .foregroundColor(Color("HighlightColor2"))
                    .padding(12)
                    .background(Color("HighlightColor1").cornerRadius(8))
                    .disableAutocorrection(true)
                    .focused($fieldInFocus, equals: .password)
                    .onSubmit {
                        if let password = currentUserPassword {
                            if userPassword == password {
                                isPasswordVerified = true
                                fieldInFocus = .button
                            } else {
                                isPasswordVerified = false
                                userPassword = ""
                                fieldInFocus = .password
                            }
                        }
                        else {
                            if userPassword == demoPassword {
                                isPasswordVerified = true
                                fieldInFocus = .button
                            } else {
                                isPasswordVerified = false
                                userPassword = ""
                                fieldInFocus = .password
                            }
                        }
                    }
                
                if isPasswordVerified == false {
                    Text("Password not found")
                        .font(Font.custom("Karla-Regular", size: 10))
                        .foregroundColor(Color.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.vertical, -5)
                }
                
                Text("Forgot password?")
                    .paragraphText()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        
                    }
            }
            
            Spacer()
            
            VStack {
                
                Button {
                    
                    if isThereAnUser || !demoEmail.isEmpty {
                        checkInfo()
                        getWrongFields()
                        
                        if isEmailVerified == true && isPasswordVerified == true {
                            isCurrentUserSignedIn = true
                            
                            if userEmail == demoEmail && userPassword == demoPassword {
                                isOrderStatusActive = true
                                isPasswordCahngedActive = true
                                isSpecialOfferActive = true
                                isNewsletterActive = true
                            }
                        }
                    } else {
                        showAlert.toggle()
                    }
                    
                    
                } label: {
                    Text("Sign In").primaryButton()
                }
                .focused($fieldInFocus, equals: .button)
                
                
                Button {
                    navigationStateManager.guestModeOn.toggle()
                } label: {
                    Text("Order Now").secondaryButton()
                }
                
            }
            
            .padding(.top, 10)
            .padding(.horizontal, -20)
            
        }.padding(.horizontal,20)
        
            .alert(isPresented: $showAlert) {
                Alert(title: Text("We could not find an account registered in this device. Please verify your information or Sign Up with us"))
            }
    }
    
    func checkInfo() {
        
        if userEmail == currentUserEmail || userEmail == demoEmail {
            isEmailVerified = true
        } else {
            isEmailVerified = false
        }
        
        if userPassword == currentUserPassword || userPassword == demoPassword {
            isPasswordVerified = true
        } else {
            isPasswordVerified = false
        }
    }
    
    func getWrongFields() {
        
        if let email = isEmailVerified {
            if !email {
                fieldInFocus = .email
            }
        }
        
        else if let password = isPasswordVerified {
            if !password {
                fieldInFocus = .password
            }
        }
        
    }
    
}

struct SignInForm_Previews: PreviewProvider {
    static var previews: some View {
        SignInForm()
            .environmentObject(NavigationStateManager())
    }
}

