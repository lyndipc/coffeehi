//
//  FeedView.swift
//  coffeehi
//
//  Created by Lyndi Castrejon on 5/17/22.
//

import SwiftUI

let lightGray = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)

struct FeedView: View {
    
//    @Binding var body = Post.body
    
    var body: some View {
        
        GeometryReader { g in
            
            ScrollView {

                LazyVStack(alignment: .center, spacing: 5.0, pinnedViews: [.sectionFooters]) {
                    
                    Section(footer: NavBar()) {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .padding(.top)
                            .padding(.bottom, 5.0)
                            .shadow(color: Color(lightGray), radius: 0.8, x: 5.0, y: 3.0)
                        
                        let width = g.size.width - 50
                        
                        // TODO: Loop through Post data object
                        ForEach(0..<10) {index in
                            
                            PostView(width: width)
                                .padding(.top)
                                .frame(maxHeight: 600)
                        }
                        
                    }
                    .frame(width: g.size.width - 30)
                    
                }
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
