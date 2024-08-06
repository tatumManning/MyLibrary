//
//  WelcomeView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct OpeningView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var isEmailValid : Bool = true
    @StateObject var credvm = CredentialsViewModel()
    //@Binding var user : UserModel
    
    var body: some View {
        NavigationStack {
            Form {
                
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
                
                Button(action: {
                    if self.isEmailValid {
                        
                    }
                }, label: {
                    Text("Login")
                })
            }
                
            Section {
                NavigationLink {
                    SignupView()
                } label: {
                    Text("Sign up")
                }
                
            }
            
            
            .navigationTitle("Welcome!")
            
            if !self.isEmailValid {
                Text("Email is Not Valid")
                    .font(.callout)
                    .foregroundColor(Color.red)
            }
        }
    
    }
}

 
    
//    func textFieldValidatorEmail(_ string: String) -> Bool {
//        if string.count > 100 {
//            return false
//        }
//        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
//        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: string)
//    }


#Preview {
    OpeningView()
}


