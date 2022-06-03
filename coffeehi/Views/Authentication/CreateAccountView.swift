//
//  CreateAccountView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 6/2/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CreateAccountView: View {
    
    @Binding var loginMode: Constants.LoginMode
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var errorMessage: String? = nil
    
        var body: some View {
            
            GeometryReader { g in
                
                VStack {
                    
                    // MARK: Login Form
                    VStack(spacing: 30.0) {
                        
                        // Username text field
                        VStack(alignment: .leading) {
                            
                            Text("username")
                                .foregroundColor(Color(primaryColor.cgColor))
                                .tracking(3)
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                                    .frame(width: g.size.width - 60, height: 44)
                                    .cornerRadius(10)
                                
                                TextField("Email", text: $email)
                                
                                if errorMessage != nil {
                                    Text(errorMessage!)
                                }
                            }
                        }
                        
                        // MARK: Password text field
                        VStack(alignment: .leading) {
                            
                            Text("password")
                                .foregroundColor(Color(UIColor(red: 0.016, green: 0.767, blue: 0.541, alpha: 1).cgColor))
                                .tracking(3)
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                                    .frame(width: g.size.width - 60, height: 44)
                                    .cornerRadius(10)
                                
                                SecureField("Password", text: $password)
                                
                                if errorMessage != nil {
                                    Text(errorMessage!)
                                }
                            }
                            Text("Forgot password?")
                                .foregroundColor(Color(primaryColor.cgColor))
                                .underline()
                                .font(.caption)
                                .tracking(1)
                        }
                        
                        // MARK: Sign in button
                        Button {
                            
                            // Create new account
                            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                                
                                // Check for errors
                                guard error == nil else {
                                    self.errorMessage = error!.localizedDescription
                                    return
                                }
                                
                                // Clear error message
                                self.errorMessage = nil
                                
                                // Save the first name
                                let firebaseUser = Auth.auth().currentUser
                                let db = Firestore.firestore()
                                let ref = db.collection("users").document(firebaseUser!.uid)
                                
                                ref.setData(["name": name], merge: true)
                                
                                // Update the user meta data
                                let user = UserService.shared.user
                                user.name = name
                                
                                // Change the view to logged in view
                    //                                self.model.checkLogin()
                        }
                        } label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color(primaryColor.cgColor))
                                    .frame(width: g.size.width - 80, height: 44)
                                    .cornerRadius(20)
                                
                                Text("sign in")
                                    .foregroundColor(.white)
                                    .tracking(3)
                            }
                            
                            // If user taps "Create an Account" button, display switches to CreateAccountView()
                            Button {
                                
                                DispatchQueue.main.async {
                                    loginMode = Constants.LoginMode.login
                                }
                            } label: {
                                
                                Text("Already have an account? Sign in")
                                    .foregroundColor(Color(primaryColor.cgColor))
                                    .underline()
                                    .font(.headline)
                                    .tracking(2)
                            }
                        }
                    }
                }
            }
            .background(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)))
        }
}

//struct CreateAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAccountView(loginMode: Constants.LoginMode.createAccount)
//    }
//}
