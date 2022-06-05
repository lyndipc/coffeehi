//
//  ProfileView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/20/22.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var editProfileVisible = false
    let user = UserService.shared.user
    
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    VStack {
                        
                        // Edit profile button
                        Button {
                        
                            // Attempt to sign out user
                            do {
                                try Auth.auth().signOut()
                                
                                // Update UI upon sign signout
                                DispatchQueue.main.async {
                                    model.loggedIn = false
                                }
                            }
                            catch {
                                print("Couldn't sign out user")
                                print(error)
                            }
                        } label: {
                            
                            Text("Sign Out")
                        }

                        
                        // TODO: Swap sf symbol icon with custom
                        Button {
                            
                            editProfileVisible = true
                        } label: {
                            
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(lightGray))
                                .position(CGPoint(x: g.size.width - 50, y: 10))
                        }
                        .sheet(isPresented: $editProfileVisible) {
                            
                            // Display profile editor
                            EditProfileView(editProfileVisible: $editProfileVisible)
                        }
                        
                        // User pfp
                        ProfileImage(width: 80, photo: "travis")
                        
                        // User's display name
                        Text(user.name)
                            .bold()
                            .font(.title3)
                        
                        // Username
                        Text("@\(user.username)")
                            .foregroundColor(.gray)
                        
                        // User bio
                        Text(user.bio)
                            .frame(minHeight: 30, maxHeight: 60)
                            .frame(width: g.size.width - 85)
                            .padding(.vertical, 10.0)
                    }
                    
                    Divider()
                    
                    LazyVStack {
                        
                        ForEach(0..<10) {_ in
                            
                            PostView(width: g.size.width - 30)
                                .padding(.top)
                                .frame(maxHeight: 600)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
