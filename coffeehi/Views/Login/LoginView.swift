//
//  LoginView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var loginMode = Constants.LoginMode.login
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var errorMessage: String? = nil
    
    var body: some View {
        
        GeometryReader { g in
            
            VStack {
                
                VStack(alignment: .center, spacing: 40.0) {
                    
                    HStack(spacing: 10.0) {
                        
                        Text("coffeehi")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .tracking(8)
                        Image("logo")
                    }
                    
                    Text("a place to share a cup of caffeinated magic with some friends")
                        .frame(width: g.size.width / 2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: g.size.width, height: g.size.height / 2.2)
                
                VStack(spacing: 30.0) {
                    
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
                    
                    Button {
                        
                        if loginMode == Constants.LoginMode.login {
                            
                            // Log the user in
                            Auth.auth().signIn(withEmail: email, link: password) { result, error in
                                
                                // Check for errors
                                guard error == nil else {
                                    errorMessage = error!.localizedDescription
                                    return
                                }
                                
                                // Clear error message
                                self.errorMessage = nil
                                
                                // TODO: Fetch the user meta data
//                                model.getUserData()
                                
                                // Change the view to logged in view
//                                model.checkLogin()
                            }
                        }
                        else {
                            
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
                        
                        Text("Create an account")
                            .foregroundColor(Color(primaryColor.cgColor))
                            .underline()
                            .font(.headline)
                            .tracking(2)
                    }
                }
            }
        }
        .background(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)))

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
