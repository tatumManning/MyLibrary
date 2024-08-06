//
//  SignupView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SignupView: View {
    
    @State  var username: String = ""
    @State  var email: String = ""
    @State  var password: String = ""
    @StateObject var credvm = CredentialsViewModel()
    @State  var isUsernameValid : Bool   = true
    @State  var isEmailValid : Bool   = true
    @State  var newAccountCreated : Bool   = false
    @State  var accountNotCreated : Bool   = false
    @State  var isHomeLinkActive : Bool   = false
    @State  var isLoginLinkActive : Bool   = false
    @State  var library = [BookModel]()
    @State  var wishlist = [BookModel]()
    @State  var user : UserModel

    public init () {
        self.username = ""
        self.email = ""
        self.password = ""
        self.isEmailValid = true
        self.isUsernameValid = true
        self.library = [BookModel]()
        self.wishlist = [BookModel]()
        self.user = UserModel(username: "", email: "", password: "", accountID: "")
        
//        , library:[BookModel](), wishlist: [BookModel]()
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Username", text: $username, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if credvm.usernameValidator(username: self.username) {
                            self.isUsernameValid = true
                        } else {
                            self.isUsernameValid = false
                            self.username = ""
                            
                        }
                    }
                })
                
                TextField("Email", text: $email, onEditingChanged: { (isChanged) in
                    if !isChanged {
                        if credvm.textFieldValidatorEmail(self.email) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            self.email = ""
                        }
                    }
                })
                
                SecureField(text: $password, prompt: Text("Password")) {
                    Text("Password")
                }
                Button("Sign up") {
                    if isUsernameValid && isEmailValid {
                        if !credvm.checkForExistingAccount(email: self.email) {
                            user.email = self.email
                            user.username = self.username
                            user.password = self.password
                            if credvm.register(user: user) {
                                newAccountCreated.toggle()
                            } else {
                                accountNotCreated.toggle()
                            }
                           
                        }
                    }
                }
                
            }
            .navigationTitle("Sign Up")
            .alert(isPresented: $accountNotCreated) {
                Alert(
                    title: Text("This account already exists"),
                    message: Text("Please login or try a different email."),
                    dismissButton: .default(Text("Back to Login"), action: {
                        isLoginLinkActive.toggle()
                    })
                    )
                
                }
            .alert(isPresented: $newAccountCreated) {
                Alert(
                    title: Text("Account Created!"),
                    message: Text("Welcome to your personal library!"),
                    dismissButton: .default(Text("Continue to Library"), action: {
                        isHomeLinkActive.toggle()
                    })
                )
            }
            
            if !self.isUsernameValid {
                Text("Username is Not Valid")
                    .font(.callout)
                    .foregroundColor(Color.red)
            }
            
            if !self.isEmailValid {
                Text("Email is Not Valid")
                    .font(.callout)
                    .foregroundColor(Color.red)
            }
            NavigationStack{
                NavigationLink("Back to Login") {
                    OpeningView()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $isHomeLinkActive) {
                HomeView()
            }
            .navigationDestination(isPresented: $isLoginLinkActive) {
                OpeningView()
            }
            
            

        }
    }
    

}

#Preview {
    SignupView()
}
