//
//  CredentialsViewModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI


class CredentialsViewModel: ObservableObject {
    
    @Published var users = [UserModel]()
    
    let db = Firestore.firestore()
    
    func fetchUsers() {
        self.users.removeAll()
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        self.users.append(try document.data(as: UserModel.self))
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
        
//    func fetchUserData(accountID: String, users: [UserModel]) -> UserModel{
//        var userData : UserModel? = nil
//        for user in users {
//            if user.accountID == accountID {
//                userData  = user
//            }
//        }
//        return userData ?? <#default value#>
//    }
        
        
        func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
        
        func register(user: UserModel) -> Bool {
            var newUserCreated : Bool = true
            // Add new user account
            Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                    newUserCreated.toggle()
                } else {
                    // save user to database
                    self.saveNewUser(user: user)
                }
                
            }
            return newUserCreated
            
        }
        
        func saveNewUser(user: UserModel)  {
            
            // Add new User to collection
            if !user.email.isEmpty  || !user.username.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: [
                    "username": user.username,
                    "email": user.email,
                    "password": user.password,
                    "accountID": Auth.auth().currentUser?.uid as Any,
                    "library": NSNull(),
                    "wishlist": NSNull()
                ]) { err in
                    if let err = err {
                        
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                
            }
            
        }
    
    func checkIfNotLoggedIn() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
            //user is not logged in
            return true
        }
        return false
    }
        
        func checkForExistingAccount(email: String) -> Bool {
            
            var isAnAccount = false
            let docRef = db.collection("users").document(email)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    isAnAccount.toggle()
                }
            }
            return isAnAccount
        }
        
        func usernameValidator(username: String) -> Bool {
            
            var isValid = true
            let docRef = db.collection("users").document(username)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    isValid.toggle()
                }
            }
            return isValid
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
        
        func goHome() {
            
        }
        
    }

