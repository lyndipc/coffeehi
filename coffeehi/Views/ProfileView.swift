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
            
            ScrollView {
                
                ZStack {
                    
                    // TODO: Allow user to upload and adjust cover photo
                    Image("cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width: g.size.width, height: 200)
                        .clipped()
                    
                    ProfileImage(width: 80, photo: "travis")
                        .padding(.top, g.size.height / 8)
                        .offset(y: g.size.height / 24)
                    
                    HStack(spacing: 40.0) {
                     
                        // User's display name
                        Text("Travis Sims")
                            .bold()
                            .font(.title3)
                            .offset(x: 10, y: g.size.height / 7)
                        
                        Spacer()
                        
                        // Edit profile button
                        // TODO: Add conditional rendering based on whether it's user's own profile or not
                        Circle()
                            .frame(width: 50)
                           .offset(x: -10, y: g.size.height / 9)
                    }
                    
                }
                .padding(.bottom, 40.0)
                
                VStack(spacing: 20.0) {
                    
                    Text("barista @stonecreekcoffee ~ content creator YT/IG: @traviesims ~ exploring the world")
                        .font(.caption)
                        .frame(minHeight: 30, maxHeight: 60)
                        .frame(width: g.size.width - 85)
                        .padding(.top)
                    
                    Divider()
                    
                    LazyVStack(pinnedViews: [.sectionFooters]) {
                        
                        Section(footer: NavBar()) {
                            
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
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
