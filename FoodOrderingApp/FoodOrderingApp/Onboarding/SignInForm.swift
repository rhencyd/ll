//
//  SignInForm.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI
import AuthenticationServices

struct SignInForm: View {
    
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                VStack (alignment: .leading, spacing: 5) {
                    Text("Email").formHeaderSection()
                    TextField("", text: $userEmail)
                        .normalTextInput()
                }.padding(.vertical, 5)
                
                VStack (alignment: .leading, spacing: 5) {
                    Text("Pasword").formHeaderSection()
                    TextField("", text: $userPassword)
                        .normalTextInput()
                    
                    Text("Forgot password?")
                        .paragraphText()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onTapGesture {
                            
                        }
                }
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                    Text("OR")
                        .sectionTitle()
                        .padding(.horizontal, 10)
                    Rectangle()
                        .frame(height: 1)
                }.padding(.top, 20)
                    .padding(.horizontal, 20)
                
                HStack {
                    
                    // sign in options (apple, google and facebook)
                    
                    //                    SignInWithAppleButton(
                    //                        .signIn,
                    //                        onRequest: configure,
                    //                        onCompletion: handle
                    //                    )
                    //                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    //                    .frame(height: 45)
                    //                    .padding()
                }
                
                VStack {
                    
                    Button {
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        navigationStateManager.goToHome()

                    } label: {
                        Text("Sign In").primaryButton()
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Order Now").secondaryButton()
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, -20)
                
            }.padding(.horizontal,20)
            
            Spacer()
        }
    }
}

struct SignInForm_Previews: PreviewProvider {
    static var previews: some View {
        SignInForm()
            .environmentObject(NavigationStateManager())
    }
}


extension SignInForm {
    
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handle(_ authResutl: Result<ASAuthorization, Error>) {
        switch authResutl {
        case .success(let auth):
            print(auth)
            switch auth.credential {
            case let appleIdCredential as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredential),
                   let appleUserData = try? JSONEncoder().encode(appleUser){
                    UserDefaults.setValue(appleUserData, forKey: appleUser.userId)
                    
                    print("saved apple id", appleUser)
                }
                
            default:
                print(auth.credential)
            }
        case .failure(let error):
            print(error)
        }
    }
}


struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else { return nil }
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
