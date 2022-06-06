//
//  FeedView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct FeedView: View {
    
    let post = UserService.shared.post
    
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                // Display posts in home feed
                LazyVStack {
                    
                    LogoHeader()
                    
                    let width = g.size.width - 50
                    
                    // Loop through post array
                    ForEach(post) {p in
                        
                        PostView(name: p.name, username: p.username, content: p.body, width: width)
                            .padding([.top, .leading, .trailing])
                    }
                }
            }
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
