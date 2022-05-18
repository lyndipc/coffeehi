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
                
                NavigationBar()
                    .padding(.bottom, 50.0)
                
                LazyVStack(alignment: .center, spacing: 5.0) {
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(lightGray.cgColor))
                            .frame(width: g.size.width - 50, height: 75)
                            .cornerRadius(10)
                            .padding(20.0)
                        
                        // TODO: Add create WritePostBox component here
                    }
                    
                    let width = g.size.width - 50
                    
                    ForEach(0..<10) {index in
                        
                        PostView(width: width)
                            .padding(.top)
                            .frame(maxHeight: 600)
                    }
                }
                .frame(width: g.size.width - 30)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
