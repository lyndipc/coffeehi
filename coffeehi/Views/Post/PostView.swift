//
//  PostView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct PostView: View {
    
    // TODO: Add local post service reference
    
    var width: CGFloat?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Loop through post data to display in FeedView
//            for p in post {
                
            HStack(spacing: 0.0) {
                    
                // MARK: Profile image
                ProfileImage(width: 50.0, photo: "ben")
                    
                // MARK: User's display name
                Text("Ben Thompson")
                    .font(.title3)
                    .bold()
            }
            .frame(height: 55)
            
            // TODO: Create conditional --> If image was posted, it will display here
            
            // MARK: Posted image
            Image("friends-coffee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width, alignment: .center)
                .cornerRadius(5)
                .padding([.top, .bottom], 10.0)
                .padding([.leading, .trailing])
            
            // MARK: Post content
            Text("This is sample post text")
                .padding([.trailing, .leading, .bottom])
                .font(.body)
                
            // TODO: Add method to determine when to include "Read More" button
            
            // MARK: Engagement Bar
            EngagementBar()
            .padding([.leading, .trailing, .bottom])
            
            Divider()
                .background(Color.gray)
                .padding([.leading, .trailing])
                
//            }
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
