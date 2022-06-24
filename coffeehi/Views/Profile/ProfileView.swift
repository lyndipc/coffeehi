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
        
        // TODO: Check if viewing current user or other user's profile
        // TODO: Add followers/following button to view list
        
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    VStack {
                        
                        // Sign out user button
                        Button {
                            model.signOut()
                        } label: {
                            Text("Sign Out")
                        }
                        
                        // Loop through user data model
                        ForEach(model.user) { m in
                            // TODO: Swap sf symbol icon with custom
                            // TODO: Conditionally display edit profile button
                            // Edit profile button
                            Button {
                                
                                editProfileVisible = true
                            } label: {
                                
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.lightGray)
                                    .position(CGPoint(x: g.size.width - 50, y: 10))
                            }
                            .sheet(isPresented: $editProfileVisible) {
                                
                                // Display profile editor
                                EditProfileView(bio: m.bio, pfp: m.pfp, editProfileVisible: $editProfileVisible)
                            }
                            
                            // User pfp
                            ProfileImage(width: 80, photo: "travis")
                            
                            Text(m.name)
                                .bold()
                                .font(.title3)
                            
                            // Username
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                            
                            // Following/Followers Count Button
                            HStack {
                                
                                Button {
                                    // Show who user is following
                                } label: {
                                    
                                    HStack {
                                        Text("50")
                                            .bold()
                                        Text("Following")
                                    }
                                    .foregroundColor(.black)
                                }
                                
                                Button {
                                    // Show user's followers
                                } label: {
                                    
                                    HStack {
                                        Text("25")
                                            .bold()
                                        Text("Followers")
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                            
                            // User bio
                            Text(m.bio)
                                .frame(minHeight: 30, maxHeight: 60)
                                .frame(width: g.size.width - 85)
                                .padding(.bottom, 10.0)
                        }
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
                .onAppear {
                    model.getUserData()
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
