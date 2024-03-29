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
    
    @EnvironmentObject var userController: UserController
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
                            .foregroundColor(Color.titleText)
                            .tracking(8)
                        Image("logo")
                    }
                }
                
                Spacer()
                
                // MARK: New User Form
                VStack(spacing: 10.0) {
                    
                    FormField(value: $name, label: "name", placeholder: "Name", width: g.size.width - 60)
                    
                    FormField(value: $username, label: "username", placeholder: "Username", width: g.size.width - 60)
                    
                    FormField(value: $email, label: "email", placeholder: "Email", width: g.size.width - 60)
                    
                    // Password text field
                    VStack(alignment: .leading) {
                        
                        Text("password")
                            .foregroundColor(Color.kellyGreen)
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color.formField)
                            
                            SecureField("Password", text: $password)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 40.0)
                    
                    // MARK: Sign in button
                    Button {
                        Task {
                            // TODO: Move to UserController
                            
                            do {
                                // Create new account in firebase
                                try await Auth.auth().createUser(withEmail: email, password: password)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            
                            // Reference to current user's id
                            let ref = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid)
                            
                            do {
                                try await ref.setData(["name": name,
                                                       "username": username,
                                                       "posts": [],
                                                       "profile": ["bio": "", "pfp": ""],
                                                       "following": [],
                                                       "followers": []
                                                      ], merge: true)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            // Update the user meta data
                            var user = UserService.shared.user
                            user.name = name
                            
                            // Change the view to logged in view
                            await self.userController.checkLogin()
                        }
                    }
                label: {
                    
                    VStack(spacing: 25.0) {
                        
                        ZStack {
                            
                            ThemeButtonLabel(buttonText: "Create Account", width: g.size.width - 80, tracking: 2)
                        }
                        
                        // If user taps button, display switches to LoginView()
                        Button {
                            
                            DispatchQueue.main.async {
                                loginMode = Constants.LoginMode.login
                            }
                        } label: {
                            
                            Text("Sign In")
                                .foregroundColor(Color.kellyGreen)
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
        .background(Color.background)
    }
    
    struct CreateAccountView_Previews: PreviewProvider {
        static var previews: some View {
            CreateAccountView(loginMode: .constant(Constants.LoginMode.createAccount))
        }
    }
    
}
