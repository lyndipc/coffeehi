//
//  FeedView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var postController: PostController
    let user = UserService.shared.user
    
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView(showsIndicators: false) {
                
                // When user pulls down on screen, refresh posts
                PullRefresh(coordinateSpaceName: "pullToRefresh") {
                    DispatchQueue.main.async {
                        postController.getRecentPosts()
                    }
                }
                
                // Display posts in home feed
                LazyVStack {
                    
                    LogoHeader()
                    
                    let width = g.size.width - 50
                    
                    // Check that user is authenticated
                    if user.name != "" {
                        
                        // Loop through post dictionary
                        ForEach(postController.posts) {p in
                            
                            if !p.draft {
                                PostView(name: p.name, username: p.username, id: p.userId, content: p.body, width: width)
                                    .padding([.top, .leading, .trailing])
                            }
                        }
                    }
                    else {
                        ProgressView()
                            .padding(.vertical, g.size.height / 2)
                    }
                }
                
            }
            .onAppear {
                DispatchQueue.main.async {
                    postController.getRecentPosts()
                }
            }
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(PostController())
    }
}
