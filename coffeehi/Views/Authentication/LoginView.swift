//
//  LoginView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

// TODO: Pull out Login and Create Account logic and create AuthView()
struct LoginView: View {
    
    @EnvironmentObject var model: ContentModel
    @Binding var loginMode: Constants.LoginMode
    @State var email: String = ""
    @State var password: String = ""
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
                    
                    // Username text field
                    FormField(value: $email, label: "email", placeholder: "Email", width: g.size.width - 60)
                    
                    // MARK: Password text field
                    VStack(alignment: .leading) {
                        
                        Text("password")
                            .foregroundColor(Color.kellyGreen)
                            .tracking(3)
                        
                        ZStack {
                            
                            Rectangle()
                                .fill(Color.offWhite)
                            
                            SecureField("Password", text: $password)
                                .padding(.leading)
                        }
                        .frame(width: g.size.width - 60, height: 44)
                        .cornerRadius(10)
                        
                        Text("Forgot password?")
                            .foregroundColor(Color.kellyGreen)
                            .underline()
                            .font(.caption)
                            .tracking(1)
                            .padding(.leading)
                    }
                    .padding(.bottom, 30.0)
                    
                    VStack(alignment: .leading, spacing: 25.0) {
                        // MARK: Sign in button
                        Button {
                            
                            // Login user
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                
                                // Check for errors
                                guard error == nil else {
                                    
                                    // Capture error message
                                    errorMessage = error!.localizedDescription
                                    return
                                }
                                
                                // Clear error message
                                self.errorMessage = nil
                                
                                // Get authenticated user's data
                                model.getUserData()
                                
                                // Change the view to FeedView()
                                model.checkLogin()
                            }
                            
                        } label: {
                            
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color.kellyGreen)
                                    .frame(width: g.size.width - 80, height: 44)
                                    .cornerRadius(20)
                                
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .tracking(3)
                            }
                        }
                        
                        // If user taps button, display switches to CreateAccountView()
                        Button {
                            
                            DispatchQueue.main.async {
                                loginMode = Constants.LoginMode.createAccount
                            }
                        } label: {
                            
                            Text("Create An Account")
                                .foregroundColor(Color.kellyGreen)
                                .underline()
                                .font(.caption)
                                .tracking(2)
                                .frame(width: g.size.width - 80)
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

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
