//
//  FeedView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var model:ContentModel
    let user = UserService.shared.user
    
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                PullRefresh(coordinateSpaceName: "pullToRefresh") {
                    model.getRecentPosts()
                }
                
                // Display posts in home feed
                LazyVStack {
                    
                    LogoHeader()
                    
                    let width = g.size.width - 50
                    
                    if user.name != "" {
                        // Loop through post array
                        ForEach(model.posts) {p in
                            
                            PostView(name: p.name, username: p.username, content: p.body, width: width)
                                .padding([.top, .leading, .trailing])
                        }
                    }
                    else {
                        ProgressView()
                            .padding(.vertical, g.size.height / 2)
                    }
                }
                
            }
            .coordinateSpace(name: "pullToRefresh")
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
