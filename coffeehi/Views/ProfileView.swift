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
                    
                    Image("friends-coffee")
                        .resizable()
                        .scaledToFill()
                        .frame(width: g.size.width, height: 200)
                        .clipped()
                    
                    ProfileImage(width: 80)
                        .padding(.top, g.size.height / 8)
                        .offset(y: g.size.height / 16)
                    
                }
                .padding(.bottom, 40.0)
                
                
                Text("Sample bio")
                
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
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
