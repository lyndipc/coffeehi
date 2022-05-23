//
//  ProfileView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/20/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    VStack {
                        
                        // Edit profile button
                        // TODO: Add conditional rendering based on whether it's user's own profile or not
                        
                        // TODO: Swap sf symbol icon with custom
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(lightGray))
                            .position(CGPoint(x: g.size.width - 50, y: 10))
                        
                        ProfileImage(width: 80, photo: "travis")
                        
                        // User's display name
                        Text("Travis Sims")
                            .bold()
                            .font(.title3)
                        
                        // Username
                        Text("@traviesims")
                            .foregroundColor(.gray)
                        
                        // User bio
                        Text("barista @stonecreekcoffee ~ content creator YT/IG: @traviesims ~ exploring the world")
                            .frame(minHeight: 30, maxHeight: 60)
                            .frame(width: g.size.width - 85)
                            .padding(.top)
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
