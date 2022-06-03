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
    
    @EnvironmentObject var model: ContentModel
    @Binding var loginMode: Constants.LoginMode
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var username: String = ""
    @State var errorMessage: String? = nil
    
    var body: some View {
        
        GeometryReader { g in
            
            VStack(alignment: .center) {
                
                Spacer()
                
                VStack(alignment: .center, spacing: 40.0) {
                    
                    // Logo
                    HStack(spacing: 10.0) {
                        
                        Text("coffeehi")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .tracking(8)
                        Image("logo")
                    }
                }
                
                Spacer()
                
                // MARK: Login Form
                VStack(spacing: 10.0) {
                    
                    // Name text field
                    VStack(alignment: .leading) {
                        
                        Text("name")
                            .foregroundColor(Color(primaryColor.cgColor))
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                            
                            TextField("Name", text: $name)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                    }
                    
                    // Username text field
                    VStack(alignment: .leading) {
                        
                        Text("username")
                            .foregroundColor(Color(primaryColor.cgColor))
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                            
                            TextField("Username", text: $username)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                    }
                    
                    // Email text field
                    VStack(alignment: .leading) {
                        
                        Text("email")
                            .foregroundColor(Color(primaryColor.cgColor))
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                            
                            TextField("Email", text: $email)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                    }
                    
                    // Password text field
                    VStack(alignment: .leading) {
                        
                        Text("password")
                            .foregroundColor(Color(primaryColor.cgColor))
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color(UIColor(red: 229, green: 229, blue: 229, alpha: 0.5)))
                            
                            SecureField("Password", text: $password)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 40.0)
                    
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
                            
                            ref.setData(["name": name,
                                         "username": username
                                        ], merge: true)
                            
                            // Update the user meta data
                            let user = UserService.shared.user
                            user.name = name
                            
                            // Change the view to logged in view
                            self.model.checkLogin()
                        }
                    } label: {
                        
                        VStack(spacing: 25.0) {
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color(primaryColor.cgColor))
                                    .frame(width: g.size.width - 80, height: 44)
                                    .cornerRadius(20)
                                
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .tracking(3)
                            }
                            
                            // If user taps button, display switches to LoginView()
                            Button {
                                
                                DispatchQueue.main.async {
                                    loginMode = Constants.LoginMode.login
                                }
                            } label: {
                                
                                Text("Sign In")
                                    .foregroundColor(Color(primaryColor.cgColor))
                                    .underline()
                                    .font(.caption)
                                    .tracking(2)
                            }
                        }
                    }
                }
                
                if errorMessage != nil {
                    Text(errorMessage!)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.vertical)
                }
                
                Spacer()
            }
            .frame(width: g.size.width)
        }
        .background(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)))
    }
}

//struct CreateAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateAccountView(loginMode: Constants.LoginMode.createAccount)
//    }
//}
