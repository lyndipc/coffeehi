//
//  PostView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct PostView: View {
    
    var name: String?
    var username: String?
    var content: String?
    var width: CGFloat?
    
    var body: some View {
        
        VStack(alignment: .leading) {
                
            HStack(spacing: 0.0) {
                    
                // Profile image
                ProfileImage(width: 50.0, photo: "ben")
                    
                // User's name
                Text(name ?? "")
                    .font(.title3)
                    .bold()
            }
            .frame(height: 55)
            
            // TODO: Create conditional --> If image was posted, it will display here
            
            // Post image
            Image("friends-coffee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width, alignment: .center)
                .cornerRadius(5)
                .padding([.top, .bottom], 10.0)
                .padding([.leading, .trailing])
            
            // Post content
            Text(content ?? "")
                .padding([.trailing, .leading, .bottom])
                .font(.body)
                
            // TODO: Add method to determine when to include "Read More" button
            
            EngagementBar()
            .padding([.leading, .trailing, .bottom])
            
            Divider()
                .background(Color.divider)
                .padding([.leading, .trailing])
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { g in
            
            ScrollView {
                
                PostView(width: g.size.width - 30)
                    .frame(maxHeight: 600)
                    .padding(.top)
            }
        }
    }
}
