//
//  PostView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct PostView: View {
    
    var width: CGFloat?
    
    var body: some View {
        
        VStack(alignment: .leading) {
                
            HStack(spacing: 0.0) {
                    
                    // Profile image
                    Image("ben")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding([.leading, .trailing], 10.0)
                    
                    // Name
                    Text("Ben Thompson")
                        .font(.title3)
                        .bold()
                }
                .frame(height: 55)
                
                // TODO: Create conditional --> If image was posted, it will display here
                    
                Image("friends-coffee")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: width, alignment: .center)
                    .cornerRadius(5)
                    .padding([.top, .bottom], 10.0)
                    .padding([.leading, .trailing])
                
                // Post content
                Text("This is sample post text")
                    .padding([.trailing, .leading, .bottom])
                    .font(.body)
                    
                // TODO: Add method to determine when to include "Read More" button
                
                // Engagement Bar
                EngagementBar()
                .padding([.leading, .trailing, .bottom])
                
                Divider()
                    .background(Color.gray)
                    .padding([.leading, .trailing])
            }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
